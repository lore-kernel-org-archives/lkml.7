Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5084AC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 13:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3494320727
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 13:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfKNNXh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 08:23:37 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57469 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfKNNXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 08:23:36 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mol@pengutronix.de>)
        id 1iVF5v-0005VS-Fn; Thu, 14 Nov 2019 14:23:31 +0100
Received: from mol by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mol@pengutronix.de>)
        id 1iVF5u-0003tK-Fh; Thu, 14 Nov 2019 14:23:30 +0100
Date:   Thu, 14 Nov 2019 14:23:30 +0100
From:   Michael Olbrich <m.olbrich@pengutronix.de>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Peter Chen <peter.chen@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: gadget: composite: split spinlock to avoid recursion
Message-ID: <20191114132330.iw4ucbfaxofi6cfy@pengutronix.de>
Mail-Followup-To: Alan Stern <stern@rowland.harvard.edu>,
        Peter Chen <peter.chen@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20191113063414.GA30608@b29397-desktop>
 <Pine.LNX.4.44L0.1911131021460.1558-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <Pine.LNX.4.44L0.1911131021460.1558-100000@iolanthe.rowland.org>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 14:17:51 up 129 days, 19:28, 139 users,  load average: 0.05, 0.13,
 0.13
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mol@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 10:36:25AM -0500, Alan Stern wrote:
> On Wed, 13 Nov 2019, Peter Chen wrote:
> > On 19-11-12 10:33:18, Michael Olbrich wrote:
> > > 'delayed_status' and 'deactivations' are used completely independent but
> > > they share the same spinlock. This can result in spinlock recursion:
> > > 
> > > BUG: spinlock recursion on CPU#1, uvc-gadget/322
> > >  lock: 0xffffffc0570364e0, .magic: dead4ead, .owner: uvc-gadget/322, .owner_cpu: 1
> > > CPU: 1 PID: 322 Comm: uvc-gadget Tainted: G         C O      5.3.0-20190916-1+ #55
> > > Hardware name: XXXXX (DT)
> > > Call trace:
> > >  dump_backtrace+0x0/0x178
> > >  show_stack+0x24/0x30
> > >  dump_stack+0xc0/0x104
> > >  spin_dump+0x90/0xa0
> > >  do_raw_spin_lock+0xd8/0x108
> > >  _raw_spin_lock_irqsave+0x40/0x50
> > >  composite_disconnect+0x2c/0x80
> > >  usb_gadget_disconnect+0x84/0x150
> > >  usb_gadget_deactivate+0x64/0x120
> > >  usb_function_deactivate+0x70/0x80
> > >  uvc_function_disconnect+0x20/0x58
> > >  uvc_v4l2_release+0x34/0x90
> > >  v4l2_release+0xbc/0xf0
> > >  __fput+0xb0/0x218
> > >  ____fput+0x20/0x30
> > >  task_work_run+0xa0/0xd0
> > >  do_notify_resume+0x2f4/0x340
> > >  work_pending+0x8/0x14
> > > 
> > > Fix this by using separate spinlocks.
> > 
> > This issue may be introduced by 0a55187a1ec8c ("USB: gadget core: Issue
> > ->disconnect() callback from usb_gadget_disconnect()"), which adds
> > gadget's disconnect at usb_gadget_disconnect. Add Alan, if he is Ok
> > with your patch, you may cc to stable tree.
> 
> I wasn't aware of the dual usage of that lock in the composite core 
> (and 0a55187a1ec8c touches only the gadget core, not composite.c).
> 
> In any case, I don't have a good feel for how the locking is supposed 
> to work in the composite core.  This is really something Felipe should 
> look at.
> 
> Would a better fix be to change usb_function_deactivate() so that it
> doesn't hold the lock while calling usb_gadget_deactivate()?  Maybe
> increment cdev->deactivations unconditionally before dropping the lock
> (for mutual exclusion) and then decrement it again if the call fails?

Hmm, I think, that would mean that usb_gadget_activate() may be called
while usb_gadget_deactivate() is still running right? That's not
acceptable, is it?

Anyways. Something else is needed because executing usb_gadget_deactivate()
under the spinlock has another problem. It's hard to reproduce, but we've
seen this one:

BUG: scheduling while atomic: pipewire/260/0x00000002
Modules linked in: allegro(C) regmap_mmio v4l2_mem2mem xlnx_vcu st1232 uio_pdrv_genirq
Preemption disabled at: [<ffffff801061dc40>] usb_function_deactivate+0x30/0x80
CPU: 1 PID: 260 Comm: pipewire Tainted: G         C O 5.3.0-20191112-1 #2
Hardware name: Wolfvision ZynqMP PF4 (DT)
Call trace:
 dump_backtrace+0x0/0x178
 show_stack+0x24/0x30
 dump_stack+0xc0/0x104
 __schedule_bug+0xb0/0xc0
 __schedule+0x354/0x4d8
 schedule+0x44/0xd8
 schedule_timeout+0x1b4/0x380
 wait_for_common+0xc0/0x188
 wait_for_completion_timeout+0x2c/0x38
 dwc3_gadget_pullup+0x90/0xb0
 usb_gadget_disconnect+0x38/0x150
 usb_gadget_deactivate+0x64/0x120
 usb_function_deactivate+0x70/0x80
 uvc_function_disconnect+0x20/0x58
 uvc_v4l2_release+0x34/0x90
 v4l2_release+0xbc/0xf0
 __fput+0x90/0x208
 ____fput+0x20/0x30
 task_work_run+0x98/0xb8
 do_notify_resume+0x2f4/0x340
 work_pending+0x8/0x14
dwc3 fe200000.usb: timed out waiting for SETUP phase

Or maybe it's incorrect for dwc3_gadget_pullup() to sleep?

Regards,
Michael

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
