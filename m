Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D37C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EB1D206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfHSOTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 10:19:46 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:43298 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726028AbfHSOTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 10:19:45 -0400
Received: (qmail 2806 invoked by uid 2102); 19 Aug 2019 10:19:44 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Aug 2019 10:19:44 -0400
Date:   Mon, 19 Aug 2019 10:19:44 -0400 (EDT)
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
In-Reply-To: <ede5f5b6-12c9-9120-7378-48e7cd42de57@ti.com>
Message-ID: <Pine.LNX.4.44L0.1908191017560.1506-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Aug 2019, Roger Quadros wrote:

> On 15/08/2019 17:39, Alan Stern wrote:
> > On Thu, 15 Aug 2019, Roger Quadros wrote:
> > 
> >> Felipe & Alan,
> >>
> >> On 21/07/2019 21:32, Pawel Laszczak wrote:
> >>> This patch introduce new Cadence USBSS DRD driver to linux kernel.
> >>>
> >>> The Cadence USBSS DRD Controller is a highly configurable IP Core which
> >>> can be instantiated as Dual-Role Device (DRD), Peripheral Only and
> >>> Host Only (XHCI)configurations.
> >>>
> >>> The current driver has been validated with FPGA burned. We have support
> >>> for PCIe bus, which is used on FPGA prototyping.
> >>>
> >>> The host side of USBSS-DRD controller is compliance with XHCI
> >>> specification, so it works with standard XHCI Linux driver.
> >>
> >> While testing this driver I encountered the following issue if I do the following.
> >>
> >> 1) USB port is "otg" and nothing connected so it is in IDLE mode to begin with.
> >>    i.e. HCD & UDC not registered.
> >>
> >> 2) Load mass storage gadget with backing medium.
> >>    > modprobe g_mass_storage file=lun stall=0
> >>
> >> [   28.172142] udc-core: couldn't find an available UDC - added [g_mass_storage] to list of pending drivers
> >>
> >> 3) Connect port to PC host

...

> >> [   30.786313] Mass Storage Function, version: 2009/09/11
> >> [   30.791455] LUN: removable file: (no medium)
> >> [   31.039497] lun0: unable to open backing file: 500M.bin

> >> Is opening the backing file from irq_thread_fn the issue here?
> >> If yes, how to resolve this?
> > 
> > I would guess that it probably is related to that.
> > 
> > In any case, the backing filename should be an explicit complete path.  
> > Who knows what the current directory will be when the actual open call
> > takes place?
> 
> This seems to be the case. It works fine with complete path.
> 
> Do we need to care about this in the mass storage gadget or just
> rely on the user to provide the full path?

I think it's okay to rely on the user to provide the full path.

Alan Stern

