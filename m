Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1C5C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 14:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B8212087F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 14:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfEGO3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 10:29:34 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:51752 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726353AbfEGO3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 10:29:34 -0400
Received: (qmail 1841 invoked by uid 2102); 7 May 2019 10:29:33 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 May 2019 10:29:33 -0400
Date:   Tue, 7 May 2019 10:29:33 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
cc:     Jim Lin <jilin@nvidia.com>, <gregkh@linuxfoundation.org>,
        <mathias.nyman@intel.com>, <hminas@synopsys.com>,
        <kai.heng.feng@canonical.com>, <drinkcat@chromium.org>,
        <prime.zeng@hisilicon.com>, <malat@debian.org>,
        <nsaenzjulienne@suse.de>, <jflat@chromium.org>,
        <linus.walleij@linaro.org>, <clabbe@baylibre.com>,
        <colin.king@canonical.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/1] usb: xhci: Add Clear_TT_Buffer
In-Reply-To: <9ea9fd3e-cf1a-9015-6d21-377c2fd41e66@linux.intel.com>
Message-ID: <Pine.LNX.4.44L0.1905071022140.1632-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 May 2019, Mathias Nyman wrote:

> On 6.5.2019 17.57, Alan Stern wrote:
> > On Mon, 6 May 2019, Jim Lin wrote:
> > 
> >> USB 2.0 specification chapter 11.17.5 says "as part of endpoint halt
> >> processing for full-/low-speed endpoints connected via a TT, the host
> >> software must use the Clear_TT_Buffer request to the TT to ensure
> >> that the buffer is not in the busy state".
> >>
> >> In our case, a full-speed speaker (ConferenceCam) is behind a high-
> >> speed hub (ConferenceCam Connect), sometimes once we get STALL on a
> >> request we may continue to get STALL with the folllowing requests,
> >> like Set_Interface.
> >>
> >> Here we add Clear_TT_Buffer for the following Set_Interface requests
> >> to get ACK successfully.
> >>
> >> Originally usb_hub_clear_tt_buffer uses urb->dev->devnum as device
> >> address while sending Clear_TT_Buffer command, but this doesn't work
> >> for XHCI.
> > 
> > Why doesn't it work for xHCI?  Clear-TT-Buffer is part of the USB 2.0
> > spec; it should work exactly the same for xHCI as for a USB-2.0 host
> > controller.
> > 
> > Alan Stern
> > 
> 
> For other host controllers udev->devnum is the same as the address of the
> usb device, chosen and set by usb core.
> 
> With xHC the controller hardware assigns the address, and won't be the same as
> devnum.
> 
> The Clear-TT-Buffer request sent to the hub includes the address of the LS/FS
> child device in wValue field. usb_hub_clear_tt_buffer() uses udev->devnum to set the
> address wValue. This won't work for devices connected to xHC

I see.  Thanks for the explanation; it makes sense now.  The patch
description should explain this too.

Wouldn't it be better to add a field containing the device address to
struct usb_device?  And also export it, either in sysfs or debugfs?  
It seems like the kind of thing that might be important for debugging.  
If we did this then the usb_hub_clear_tt_buffer API wouldn't need to be
changed.

Alan Stern

