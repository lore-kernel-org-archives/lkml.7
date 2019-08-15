Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A34C3A59C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 14:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66CC120644
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 14:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733032AbfHOOjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 10:39:19 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:58000 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1730084AbfHOOjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 10:39:19 -0400
Received: (qmail 2256 invoked by uid 2102); 15 Aug 2019 10:39:17 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 15 Aug 2019 10:39:17 -0400
Date:   Thu, 15 Aug 2019 10:39:17 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Roger Quadros <rogerq@ti.com>
cc:     Pawel Laszczak <pawell@cadence.com>,
        <felipe.balbi@linux.intel.com>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jbergsagel@ti.com>, <nsekhar@ti.com>, <nm@ti.com>,
        <sureshp@cadence.com>, <jpawar@cadence.com>, <kurahul@cadence.com>,
        <aniljoy@cadence.com>
Subject: Re: [PATCH v10 0/6] Introduced new Cadence USBSS DRD Driver.
In-Reply-To: <9f54d3d5-da99-327b-631e-fad1329dcde4@ti.com>
Message-ID: <Pine.LNX.4.44L0.1908151037120.1664-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Aug 2019, Roger Quadros wrote:

> Felipe & Alan,
> 
> On 21/07/2019 21:32, Pawel Laszczak wrote:
> > This patch introduce new Cadence USBSS DRD driver to linux kernel.
> > 
> > The Cadence USBSS DRD Controller is a highly configurable IP Core which
> > can be instantiated as Dual-Role Device (DRD), Peripheral Only and
> > Host Only (XHCI)configurations.
> > 
> > The current driver has been validated with FPGA burned. We have support
> > for PCIe bus, which is used on FPGA prototyping.
> > 
> > The host side of USBSS-DRD controller is compliance with XHCI
> > specification, so it works with standard XHCI Linux driver.
> 
> While testing this driver I encountered the following issue if I do the following.
> 
> 1) USB port is "otg" and nothing connected so it is in IDLE mode to begin with.
>    i.e. HCD & UDC not registered.
> 
> 2) Load mass storage gadget with backing medium.
>    > modprobe g_mass_storage file=lun stall=0
> 
> [   28.172142] udc-core: couldn't find an available UDC - added [g_mass_storage] to list of pending drivers
> 
> 3) Connect port to PC host
> 
> [   30.564767] cdns-usb3 6000000.usb: Initialized  ep0 support:  
> [   30.570591] cdns-usb3 6000000.usb: Initialized  ep1out support: BULK, INT ISO
> [   30.577713] cdns-usb3 6000000.usb: Initialized  ep2out support: BULK, INT ISO
> [   30.584835] cdns-usb3 6000000.usb: Initialized  ep3out support: BULK, INT ISO
> [   30.591957] cdns-usb3 6000000.usb: Initialized  ep4out support: BULK, INT ISO
> [   30.599078] cdns-usb3 6000000.usb: Initialized  ep5out support: BULK, INT ISO
> [   30.606199] cdns-usb3 6000000.usb: Initialized  ep6out support: BULK, INT ISO
> [   30.613320] cdns-usb3 6000000.usb: Initialized  ep7out support: BULK, INT ISO
> [   30.620441] cdns-usb3 6000000.usb: Initialized  ep8out support: BULK, INT ISO
> [   30.627562] cdns-usb3 6000000.usb: Initialized  ep9out support: BULK, INT ISO
> [   30.634684] cdns-usb3 6000000.usb: Initialized  ep10out support: BULK, INT ISO
> [   30.641893] cdns-usb3 6000000.usb: Initialized  ep11out support: BULK, INT ISO
> [   30.649100] cdns-usb3 6000000.usb: Initialized  ep12out support: BULK, INT ISO
> [   30.656309] cdns-usb3 6000000.usb: Initialized  ep13out support: BULK, INT ISO
> [   30.663516] cdns-usb3 6000000.usb: Initialized  ep14out support: BULK, INT ISO
> [   30.670724] cdns-usb3 6000000.usb: Initialized  ep15out support: BULK, INT ISO
> [   30.677935] cdns-usb3 6000000.usb: Initialized  ep1in support: BULK, INT ISO
> [   30.684979] cdns-usb3 6000000.usb: Initialized  ep2in support: BULK, INT ISO
> [   30.692020] cdns-usb3 6000000.usb: Initialized  ep3in support: BULK, INT ISO
> [   30.699057] cdns-usb3 6000000.usb: Initialized  ep4in support: BULK, INT ISO
> [   30.706097] cdns-usb3 6000000.usb: Initialized  ep5in support: BULK, INT ISO
> [   30.713135] cdns-usb3 6000000.usb: Initialized  ep6in support: BULK, INT ISO
> [   30.720175] cdns-usb3 6000000.usb: Initialized  ep7in support: BULK, INT ISO
> [   30.727213] cdns-usb3 6000000.usb: Initialized  ep8in support: BULK, INT ISO
> [   30.734252] cdns-usb3 6000000.usb: Initialized  ep9in support: BULK, INT ISO
> [   30.741289] cdns-usb3 6000000.usb: Initialized  ep10in support: BULK, INT ISO
> [   30.748414] cdns-usb3 6000000.usb: Initialized  ep11in support: BULK, INT ISO
> [   30.755536] cdns-usb3 6000000.usb: Initialized  ep12in support: BULK, INT ISO
> [   30.762661] cdns-usb3 6000000.usb: Initialized  ep13in support: BULK, INT ISO
> [   30.769785] cdns-usb3 6000000.usb: Initialized  ep14in support: BULK, INT ISO
> [   30.776910] cdns-usb3 6000000.usb: Initialized  ep15in support: BULK, INT ISO
> [   30.786313] Mass Storage Function, version: 2009/09/11
> [   30.791455] LUN: removable file: (no medium)
> [   31.039497] lun0: unable to open backing file: 500M.bin
> [   31.158689] g_mass_storage 6000000.usb: failed to start g_mass_storage: -2
> [   31.165606] cdns-usb3 6000000.usb: Failed to register USB device controller
> [   31.172585] cdns-usb3 6000000.usb: set 2 has failed, back to 0
> 
> Now, -2 is ENOENT i.e.	/* No such file or directory */
> The file is present so that's not the real issue.
> 
> The call trace to fsg_lun_open is below
> 
> [   30.952877]  fsg_lun_open+0x24/0x42c [usb_f_mass_storage]
> [   30.958259]  fsg_common_create_lun+0xc8/0x2b8 [usb_f_mass_storage]
> [   30.964422]  fsg_common_create_luns+0xa4/0x104 [usb_f_mass_storage]
> [   30.970670]  msg_bind+0xd8/0x1e0 [g_mass_storage]
> [   30.975360]  composite_bind+0x7c/0x180 [libcomposite]
> [   30.980396]  udc_bind_to_driver+0x68/0x110 [udc_core]
> [   30.985432]  check_pending_gadget_drivers+0x74/0xd8 [udc_core]
> [   30.991247]  usb_add_gadget_udc_release+0x180/0x1e8 [udc_core]
> [   30.997062]  usb_add_gadget_udc+0x10/0x18 [udc_core]
> [   31.002010]  __cdns3_gadget_init+0x3a0/0x628 [cdns3]
> [   31.006959]  cdns3_role_start+0x6c/0xd0 [cdns3]
> [   31.011473]  cdns3_hw_role_switch+0x80/0xe8 [cdns3]
> [   31.016336]  cdns3_drd_thread_irq+0x10/0x20 [cdns3]
> [   31.021197]  irq_thread_fn+0x28/0x78
> [   31.024757]  irq_thread+0x124/0x1b8
> [   31.028233]  kthread+0x124/0x128
> [   31.031447]  ret_from_fork+0x10/0x18
> 
> Is opening the backing file from irq_thread_fn the issue here?
> If yes, how to resolve this?

I would guess that it probably is related to that.

In any case, the backing filename should be an explicit complete path.  
Who knows what the current directory will be when the actual open call
takes place?

Alan Stern

