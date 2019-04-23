Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA6AC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A678521738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbfDWP2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 11:28:52 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:58256 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727305AbfDWP2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 11:28:52 -0400
Received: (qmail 5111 invoked by uid 2102); 23 Apr 2019 11:28:50 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 23 Apr 2019 11:28:50 -0400
Date:   Tue, 23 Apr 2019 11:28:50 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Andrey Konovalov <andreyknvl@google.com>
cc:     syzbot <syzbot+2eb9121678bdb36e6d57@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>, <rafael@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: general protection fault in __dev_printk
In-Reply-To: <CAAeHK+zUiv+CSip7OwrQ6FKxwE_+Wh0LTmGW86ipQ5QkaAOT8w@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1904231126500.1461-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Apr 2019, Andrey Konovalov wrote:

> > This original bug report included a "USB disconnect" line, as shown
> > above.  The newer results, for runs with my patches added, do not.  At
> > least, if such a line was present, it didn't show up in the console
> > output files -- the most recent one contains nothing but repeats of
> > that "yurex_interrupt - unknown status received: -71" line, although
> > for devices on multiple buses.
> >
> > Is there any way to get more information about what's happening, such
> > as a complete kernel log?
> 
> It should be possible to provide the full log for the result of the
> "syz test" command. I'll talk to Dmitry about this when he's back from
> vacation next week.
> 
> > And perhaps to run the test with just a
> > single dummy-hcd bus instead of 6?
> 
> Hm, it might be possible to implement overriding of syz-execprog flags
> and provide them via "syz test". It's not implemented right now
> though.
> 
> Running the reproducer manually is the most flexible way to make
> changes to the way it's ran or to make changes to the environment. In
> this case I haven't managed to reproduce the hang manually though :(
> 
> I see two ways to deal with this right now:
> 
> 1. Submit your fix (it fixes the original issue for me) and wait until
> it gets into the usb-fuzzer tree. Then maybe syzbot will report the
> hang and provide a better reproducer.
> 
> 2. Change the testing patch to also suppress those "yurex_interrupt -
> unknown status received: -71" messages and rerun the "syz test"
> command. Hopefully then syzbot will provide the full kernel log.

That's a great suggestion!  Here's the next attempt.

Alan Stern


#syz test: https://github.com/google/kasan.git usb-fuzzer

--- a/drivers/usb/misc/yurex.c
+++ b/drivers/usb/misc/yurex.c
@@ -143,8 +143,10 @@ static void yurex_interrupt(struct urb *
 		/* The device is terminated, clean up */
 		return;
 	default:
+#if 0
 		dev_err(&dev->interface->dev,
 			"%s - unknown status received: %d\n", __func__, status);
+#endif
 		goto exit;
 	}
 
@@ -178,6 +180,10 @@ static void yurex_interrupt(struct urb *
 	}
 
 exit:
+	if (!usb_get_intfdata(dev->interface)) {
+		dev_info(&dev->interface->dev, "%s unbound\n", __func__);
+		return;
+	}
 	retval = usb_submit_urb(dev->urb, GFP_ATOMIC);
 	if (retval) {
 		dev_err(&dev->interface->dev, "%s - usb_submit_urb failed: %d\n",
@@ -309,11 +315,15 @@ static void yurex_disconnect(struct usb_
 
 	dev = usb_get_intfdata(interface);
 	usb_set_intfdata(interface, NULL);
+	dev_info(&interface->dev, "%s\n", __func__);
 
 	/* give back our minor */
 	usb_deregister_dev(interface, &yurex_class);
 
 	/* prevent more I/O from starting */
+	dev_info(&interface->dev, "Before poison\n");
+	usb_poison_urb(dev->urb);
+	dev_info(&interface->dev, "After poison\n");
 	mutex_lock(&dev->io_mutex);
 	dev->interface = NULL;
 	mutex_unlock(&dev->io_mutex);

