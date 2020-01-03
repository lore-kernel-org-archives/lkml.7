Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD041C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 16:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81E9D222C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 16:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgACQfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 11:35:23 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:34910 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727980AbgACQfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 11:35:23 -0500
Received: (qmail 5097 invoked by uid 2102); 3 Jan 2020 11:35:22 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 3 Jan 2020 11:35:22 -0500
Date:   Fri, 3 Jan 2020 11:35:22 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     syzbot <syzbot+10e5f68920f13587ab12@syzkaller.appspotmail.com>
cc:     andreyknvl@google.com, <gregkh@linuxfoundation.org>,
        <gustavo@embeddedor.com>, <ingrassia@epigenesys.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: WARNING in usbhid_raw_request/usb_submit_urb (2)
In-Reply-To: <00000000000043a9a3059ae3c8ef@google.com>
Message-ID: <Pine.LNX.4.44L0.2001031133050.1560-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Dec 2019, syzbot wrote:

> syzbot has found a reproducer for the following crash on:
> 
> HEAD commit:    ecdf2214 usb: gadget: add raw-gadget interface
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=17416885e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b06a019075333661
> dashboard link: https://syzkaller.appspot.com/bug?extid=10e5f68920f13587ab12
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13598885e00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+10e5f68920f13587ab12@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> usb 1-1: BOGUS urb xfer, pipe 2 != type 2
> WARNING: CPU: 0 PID: 2388 at drivers/usb/core/urb.c:478  
> usb_submit_urb+0x1188/0x13b0 drivers/usb/core/urb.c:478

That's a strange diagnostic.  Let's see what's really going on.

Alan Stern

#syz test: https://github.com/google/kasan.git ecdf2214

Index: usb-devel/drivers/usb/core/urb.c
===================================================================
--- usb-devel.orig/drivers/usb/core/urb.c
+++ usb-devel/drivers/usb/core/urb.c
@@ -204,10 +204,14 @@ int usb_urb_ep_type_check(const struct u
 	const struct usb_host_endpoint *ep;
 
 	ep = usb_pipe_endpoint(urb->dev, urb->pipe);
-	if (!ep)
+	if (!ep) {
+		dev_info(&urb->dev->dev, "Pipe 0x%x, no ep\n", urb->pipe);
 		return -EINVAL;
-	if (usb_pipetype(urb->pipe) != pipetypes[usb_endpoint_type(&ep->desc)])
+	}
+	if (usb_pipetype(urb->pipe) != pipetypes[usb_endpoint_type(&ep->desc)]) {
+		dev_info(&urb->dev->dev, "Pipe/ep type mismatch\n");
 		return -EINVAL;
+	}
 	return 0;
 }
 EXPORT_SYMBOL_GPL(usb_urb_ep_type_check);

