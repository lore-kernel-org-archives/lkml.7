Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2962C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEA7E20868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbfDPPom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:44:42 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:42922 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726860AbfDPPom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:44:42 -0400
Received: (qmail 7409 invoked by uid 2102); 16 Apr 2019 11:44:41 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Apr 2019 11:44:41 -0400
Date:   Tue, 16 Apr 2019 11:44:41 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Andrey Konovalov <andreyknvl@google.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <gustavo@embeddedor.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzbot <syzbot+d919b0f29d7b5a4994b9@syzkaller.appspotmail.com>
Subject: Re: INFO: task hung in usb_kill_urb
In-Reply-To: <CAAeHK+wDEOpkuh0+OmPra3Yu8ri-8As82CyZ-1KyYC62AJkj1Q@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1904161132370.1605-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Apr 2019, Andrey Konovalov wrote:

> On Mon, Apr 15, 2019 at 8:06 PM Alan Stern <stern@rowland.harvard.edu> wrote:

> > > > It looks like something is stuck waiting for usb_kill_urb() to finish.
> > > > But what happened before that?
> > >
> > > This crash is somewhat special. It happens quite often during USB
> > > fuzzing, but at the same time it's a hang, which makes it a bit harder
> > > debug. I initially thought that is somehow related to my custom USB
> > > fuzzing kernel patches, but then I saw that someone else hit this
> > > issue while doing USB fuzzing in a completely different way that
> > > doesn't require kernel modifications. So it might be an actual issue
> > > in the kernel.
> > >
> > > The full console output is provided by the syzbot, but I guess it's
> > > not very useful in this case. I've just made sure that this issue is
> > > manually reproducible, so we can easily retest it with debug patches
> > > (syzbot should be also able to do that via the syz test command). Or
> > > is there a way to turn on some verbose mode to see some USB debug
> > > messages?
> >
> > If I were doing this manually, I would run the following commands after
> > loading the dummy-hcd driver but before starting the main test
> > (requires CONFIG_USB_MON; you can skip the modprobe if
> > CONFIG_USB_MON=y):
> >
> >         modprobe usbmon
> >         cat /sys/kernel/debug/usb/usbmon/Nu >/tmp/mon.out &
> >
> > where N is the USB bus number corresponding to the dummy-hcd bus.
> > Then after the test hangs, on another VT kill the "cat" process and
> > examine the contents of /tmp/mon.out.
> >
> > Maybe you can do the equivalent with syzkaller?  If necessary, you can
> > start the "cat" before loading dummy-hcd and specify a bus number of 0.
> > That will capture data for all the USB buses, including the dummy-hcd
> > bus when it gets added (I think -- I haven't actually tried it).
> 
> Right now the best way to do this is to run the reproducer manually.
> I've attached the resulting mon.out and syslog.

Okay, it looks like the system is getting stuck on the very first URB.  
Let's add some more traditional debugging and see what shows up.  This 
test won't require any manual intervention.

Alan Stern


#syz test: https://github.com/google/kasan.git usb-fuzzer

--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -992,6 +992,7 @@ static int dummy_udc_start(struct usb_ga
 	dum->driver = driver;
 	dum->ints_enabled = 1;
 	spin_unlock_irq(&dum->lock);
+	dev_info(udc_dev(dum), "%s\n", __func__);
 
 	return 0;
 }
@@ -1001,6 +1002,7 @@ static int dummy_udc_stop(struct usb_gad
 	struct dummy_hcd	*dum_hcd = gadget_to_dummy_hcd(g);
 	struct dummy		*dum = dum_hcd->dum;
 
+	dev_info(udc_dev(dum), "%s\n", __func__);
 	spin_lock_irq(&dum->lock);
 	dum->ints_enabled = 0;
 	stop_activity(dum);
@@ -1277,6 +1279,8 @@ static int dummy_urb_enqueue(
 	} else if (unlikely(dum_hcd->udev != urb->dev))
 		dev_err(dummy_dev(dum_hcd), "usb_device address has changed!\n");
 
+	dev_info(dummy_dev(dum_hcd), "enqueue URB %p len %u\n", urb,
+			urb->transfer_buffer_length);
 	list_add_tail(&urbp->urbp_list, &dum_hcd->urbp_list);
 	urb->hcpriv = urbp;
 	if (!dum_hcd->next_frame_urbp)
@@ -1306,8 +1310,10 @@ static int dummy_urb_dequeue(struct usb_
 
 	rc = usb_hcd_check_unlink_urb(hcd, urb, status);
 	if (!rc && dum_hcd->rh_state != DUMMY_RH_RUNNING &&
-			!list_empty(&dum_hcd->urbp_list))
+			!list_empty(&dum_hcd->urbp_list)) {
+		dev_info(dummy_dev(dum_hcd), "dequeue URB %p\n", urb);
 		mod_timer(&dum_hcd->timer, jiffies);
+	}
 
 	spin_unlock_irqrestore(&dum_hcd->dum->lock, flags);
 	return rc;
@@ -1827,8 +1833,10 @@ restart:
 			continue;
 
 		/* Used up this frame's bandwidth? */
-		if (total <= 0)
+		if (total <= 0) {
+			dev_info(dummy_dev(dum_hcd), "total exceeded\n");
 			break;
+		}
 
 		/* find the gadget's ep for this request (if configured) */
 		address = usb_pipeendpoint (urb->pipe);
@@ -1965,6 +1973,7 @@ return_urb:
 
 		usb_hcd_unlink_urb_from_ep(dummy_hcd_to_hcd(dum_hcd), urb);
 		spin_unlock(&dum->lock);
+		dev_info(dummy_dev(dum_hcd), "giveback URB %p\n", urb);
 		usb_hcd_giveback_urb(dummy_hcd_to_hcd(dum_hcd), urb, status);
 		spin_lock(&dum->lock);
 
@@ -2329,7 +2338,7 @@ static int dummy_bus_suspend(struct usb_
 {
 	struct dummy_hcd *dum_hcd = hcd_to_dummy_hcd(hcd);
 
-	dev_dbg(&hcd->self.root_hub->dev, "%s\n", __func__);
+	dev_info(&hcd->self.root_hub->dev, "%s\n", __func__);
 
 	spin_lock_irq(&dum_hcd->dum->lock);
 	dum_hcd->rh_state = DUMMY_RH_SUSPENDED;
@@ -2344,7 +2353,7 @@ static int dummy_bus_resume(struct usb_h
 	struct dummy_hcd *dum_hcd = hcd_to_dummy_hcd(hcd);
 	int rc = 0;
 
-	dev_dbg(&hcd->self.root_hub->dev, "%s\n", __func__);
+	dev_info(&hcd->self.root_hub->dev, "%s\n", __func__);
 
 	spin_lock_irq(&dum_hcd->dum->lock);
 	if (!HCD_HW_ACCESSIBLE(hcd)) {
@@ -2431,6 +2440,7 @@ static DEVICE_ATTR_RO(urbs);
 
 static int dummy_start_ss(struct dummy_hcd *dum_hcd)
 {
+	dev_info(dummy_dev(dum_hcd), "%s\n", __func__);
 	timer_setup(&dum_hcd->timer, dummy_timer, 0);
 	dum_hcd->rh_state = DUMMY_RH_RUNNING;
 	dum_hcd->stream_en_ep = 0;
@@ -2459,6 +2469,7 @@ static int dummy_start(struct usb_hcd *h
 	if (!usb_hcd_is_primary_hcd(hcd))
 		return dummy_start_ss(dum_hcd);
 
+	dev_info(dummy_dev(dum_hcd), "%s\n", __func__);
 	spin_lock_init(&dum_hcd->dum->lock);
 	timer_setup(&dum_hcd->timer, dummy_timer, 0);
 	dum_hcd->rh_state = DUMMY_RH_RUNNING;


