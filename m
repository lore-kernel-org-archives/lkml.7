Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E79CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 18:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD6502166E
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 18:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440172AbfJXS6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 14:58:46 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:59876 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S2390034AbfJXS6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 14:58:45 -0400
Received: (qmail 5995 invoked by uid 2102); 24 Oct 2019 14:58:44 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Oct 2019 14:58:44 -0400
Date:   Thu, 24 Oct 2019 14:58:44 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     syzbot <syzbot+8ab8bf161038a8768553@syzkaller.appspotmail.com>
cc:     Jacky.Cao@sony.com, <andreyknvl@google.com>, <balbi@kernel.org>,
        <chunfeng.yun@mediatek.com>, <gregkh@linuxfoundation.org>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: divide error in dummy_timer
In-Reply-To: <000000000000f6d5ed0595abe964@google.com>
Message-ID: <Pine.LNX.4.44L0.1910241419210.1318-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Oct 2019, syzbot wrote:

> Hello,
> 
> syzbot has tested the proposed patch but the reproducer still triggered  
> crash:
> divide error in dummy_timer

> Tested on:
> 
> commit:         22be26f7 usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git
> console output: https://syzkaller.appspot.com/x/log.txt?x=17b3e44ce00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5fe29bc39eff9627
> dashboard link: https://syzkaller.appspot.com/bug?extid=8ab8bf161038a8768553
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=15ea0a97600000

Okay, this error has a couple of different aspects.  In particular, we
don't want endpoints to have maxpacket = 0 on either the host side or
the gadget side.  (Note that it _is_ possible for the two sides to
disagree about the maxpacket value, because the gadget driver can in
theory provide different endpoint descriptors to the UDC driver and to
the host.)

So yes, the core should check the value in the endpoint descriptor, but 
also we have to watch out for invalid values coming from userspace 
gadget drivers.  And not just in dummy-hcd; all UDCs are vulnerable.

So let's try the patch below to handle the gadget side of things.

Alan Stern

#syz test: https://github.com/google/kasan.git 22be26f7

 drivers/usb/gadget/udc/core.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

Index: usb-devel/drivers/usb/gadget/udc/core.c
===================================================================
--- usb-devel.orig/drivers/usb/gadget/udc/core.c
+++ usb-devel/drivers/usb/gadget/udc/core.c
@@ -98,6 +98,17 @@ int usb_ep_enable(struct usb_ep *ep)
 	if (ep->enabled)
 		goto out;
 
+	/* UDC drivers can't handle endpoints with maxpacket size 0 */
+	if (usb_endpoint_maxp(ep->desc) == 0) {
+		/*
+		 * We should log an error message here, but we can't call
+		 * dev_err() because there's no way to find the gadget
+		 * given only ep.
+		 */
+		ret = -EINVAL;
+		goto out;
+	}
+
 	ret = ep->ops->enable(ep, ep->desc);
 	if (ret)
 		goto out;

