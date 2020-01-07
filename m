Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C054DC282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 19:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A023220715
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 19:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbgAGTJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 14:09:58 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:48114 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728617AbgAGTJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 14:09:58 -0500
Received: (qmail 7431 invoked by uid 2102); 7 Jan 2020 14:09:57 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 Jan 2020 14:09:57 -0500
Date:   Tue, 7 Jan 2020 14:09:57 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Andrey Konovalov <andreyknvl@google.com>
cc:     syzbot <syzbot+10e5f68920f13587ab12@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        <ingrassia@epigenesys.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: WARNING in usbhid_raw_request/usb_submit_urb (2)
In-Reply-To: <CAAeHK+z5sY=CpPhO0QZGE_o1Bo8XA4PG4NT=mprO=9=Rg+1kkQ@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.2001071407350.1567-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jan 2020, Andrey Konovalov wrote:

> On Fri, Jan 3, 2020 at 6:01 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Fri, 3 Jan 2020, syzbot wrote:
> >
> > > Hello,
> > >
> > > syzbot has tested the proposed patch and the reproducer did not trigger
> > > crash:
> > >
> > > Reported-and-tested-by:
> > > syzbot+10e5f68920f13587ab12@syzkaller.appspotmail.com
> > >
> > > Tested on:
> > >
> > > commit:         ecdf2214 usb: gadget: add raw-gadget interface
> > > git tree:       https://github.com/google/kasan.git
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=b06a019075333661
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=10e5f68920f13587ab12
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > patch:          https://syzkaller.appspot.com/x/patch.diff?x=177f06e1e00000
> > >
> > > Note: testing is done by a robot and is best-effort only.
> >
> > Andrey:
> >
> > Clearly something strange is going on here.  First, the patch should
> > not have changed the behavior; all it did was add some log messages.
> > Second, I don't see how the warning could have been triggered at all --
> > it seems to be complaining that 2 != 2.
> 
> Hi Alan,
> 
> It looks like some kind of race in involved here.
> 
> There are a few indications of that: 1. there's no C reproducer
> generated for this crash (usually happens because of timing
> differences when executing syz repro vs C repro), 2. syz repro has
> threaded, collide and repeat flags turned on (which means it gets
> executed many times with some syscalls scheduled asynchronously).
> 
> This also explains the weirdness around the 2 != 2 check being failed.
> First the comparison failed, then another thread updated one of the
> numbers being compared, and then the printk statement got executed.

Okay, that's kind of what I thought.

> > Does the reproducer really work?
> 
> Yes, it worked for syzbot at the very least. It looks like your patch
> introduced some delays which made the bug untriggerable by the same
> reproducer. Since this is a race it might be quite difficult to
> reproduce this manually (due to timing differences caused by a
> different environment setup) as well unfortunately.
> 
> Perhaps giving a less invasive patch (that minimizes timing changes
> introduced to the code that is suspected of being racy) to syzbot
> could be used to debug this.

Maybe this patch will work better.  The timing change in the critical 
path should be extremely small.

Alan Stern

#syz test: https://github.com/google/kasan.git ecdf2214

Index: usb-devel/drivers/usb/core/urb.c
===================================================================
--- usb-devel.orig/drivers/usb/core/urb.c
+++ usb-devel/drivers/usb/core/urb.c
@@ -205,7 +205,7 @@ int usb_urb_ep_type_check(const struct u
 
 	ep = usb_pipe_endpoint(urb->dev, urb->pipe);
 	if (!ep)
-		return -EINVAL;
+		return -EBADF;
 	if (usb_pipetype(urb->pipe) != pipetypes[usb_endpoint_type(&ep->desc)])
 		return -EINVAL;
 	return 0;
@@ -356,6 +356,7 @@ int usb_submit_urb(struct urb *urb, gfp_
 	struct usb_host_endpoint	*ep;
 	int				is_out;
 	unsigned int			allowed;
+	int				c;
 
 	if (!urb || !urb->complete)
 		return -EINVAL;
@@ -474,9 +475,10 @@ int usb_submit_urb(struct urb *urb, gfp_
 	 */
 
 	/* Check that the pipe's type matches the endpoint's type */
-	if (usb_urb_ep_type_check(urb))
-		dev_WARN(&dev->dev, "BOGUS urb xfer, pipe %x != type %x\n",
-			usb_pipetype(urb->pipe), pipetypes[xfertype]);
+	c = usb_urb_ep_type_check(urb);
+	if (c)
+		dev_WARN(&dev->dev, "BOGUS urb xfer %d, pipe %x != type %x\n",
+			c, usb_pipetype(urb->pipe), pipetypes[xfertype]);
 
 	/* Check against a simple/standard policy */
 	allowed = (URB_NO_TRANSFER_DMA_MAP | URB_NO_INTERRUPT | URB_DIR_MASK |


