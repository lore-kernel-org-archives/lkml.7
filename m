Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DB9C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 19:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B768206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 19:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391059AbfIPTxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 15:53:06 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:51948 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1732536AbfIPTxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 15:53:06 -0400
Received: (qmail 7108 invoked by uid 2102); 16 Sep 2019 15:53:05 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Sep 2019 15:53:05 -0400
Date:   Mon, 16 Sep 2019 15:53:05 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     syzbot <syzbot+b24d736f18a1541ad550@syzkaller.appspotmail.com>
cc:     andreyknvl@google.com, <balbi@kernel.org>,
        <chunfeng.yun@mediatek.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: INFO: rcu detected stall in dummy_timer
In-Reply-To: <0000000000004fb020059274a5ff@google.com>
Message-ID: <Pine.LNX.4.44L0.1909161551020.1489-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Sep 2019, syzbot wrote:

> syzbot has found a reproducer for the following crash on:
> 
> HEAD commit:    f0df5c1b usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=1146550d600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5c6633fa4ed00be5
> dashboard link: https://syzkaller.appspot.com/bug?extid=b24d736f18a1541ad550
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11203fa5600000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=162cd335600000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+b24d736f18a1541ad550@syzkaller.appspotmail.com
> 
> yurex 3-1:0.101: yurex_interrupt - unknown status received: -71
> yurex 5-1:0.101: yurex_interrupt - unknown status received: -71
> yurex 6-1:0.101: yurex_interrupt - unknown status received: -71

Let's see if preventing blind resubmissions fixes the problem.

Alan Stern

#syz test: https://github.com/google/kasan.git f0df5c1b

 drivers/usb/misc/yurex.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: usb-devel/drivers/usb/misc/yurex.c
===================================================================
--- usb-devel.orig/drivers/usb/misc/yurex.c
+++ usb-devel/drivers/usb/misc/yurex.c
@@ -132,6 +132,7 @@ static void yurex_interrupt(struct urb *
 	switch (status) {
 	case 0: /*success*/
 		break;
+	/* The device is terminated or messed up, give up */
 	case -EOVERFLOW:
 		dev_err(&dev->interface->dev,
 			"%s - overflow with length %d, actual length is %d\n",
@@ -140,12 +141,12 @@ static void yurex_interrupt(struct urb *
 	case -ENOENT:
 	case -ESHUTDOWN:
 	case -EILSEQ:
-		/* The device is terminated, clean up */
+	case -EPROTO:
 		return;
 	default:
 		dev_err(&dev->interface->dev,
 			"%s - unknown status received: %d\n", __func__, status);
-		goto exit;
+		return;
 	}
 
 	/* handle received message */
@@ -177,7 +178,6 @@ static void yurex_interrupt(struct urb *
 		break;
 	}
 
-exit:
 	retval = usb_submit_urb(dev->urb, GFP_ATOMIC);
 	if (retval) {
 		dev_err(&dev->interface->dev, "%s - usb_submit_urb failed: %d\n",

