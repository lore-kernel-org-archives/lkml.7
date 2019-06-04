Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DDBC28CC6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D6832439E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 14:22:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbfFDOW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 10:22:27 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:49216 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727378AbfFDOW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 10:22:27 -0400
Received: (qmail 3308 invoked by uid 2102); 4 Jun 2019 10:22:26 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Jun 2019 10:22:26 -0400
Date:   Tue, 4 Jun 2019 10:22:26 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Jim Lin <jilin@nvidia.com>
cc:     Greg KH <gregkh@linuxfoundation.org>, <mathias.nyman@intel.com>,
        <kai.heng.feng@canonical.com>, <drinkcat@chromium.org>,
        <Thinh.Nguyen@synopsys.com>, <nsaenzjulienne@suse.de>,
        <jflat@chromium.org>, <malat@debian.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 0/2] usb: xhci: Add Clear_TT_Buffer
In-Reply-To: <e7ccbc27-2ff4-b1b9-aa1b-c77da5e122ca@nvidia.com>
Message-ID: <Pine.LNX.4.44L0.1906041021130.1731-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jun 2019, Jim Lin wrote:

> On 2019年06月03日 20:23, Greg KH wrote:
> > On Mon, Jun 03, 2019 at 06:53:42PM +0800, Jim Lin wrote:
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
> >> Solution is to invoke usb_hub_clear_tt_buffer() to send
> >> Clear_TT_Buffer request to the hub of the device for the following
> >> Set_Interface requests to the device to get ACK successfully.
> >>
> >> The Clear_TT_Buffer request sent to the hub includes the address of
> >> the LS/FS child device in wValue field. usb_hub_clear_tt_buffer()
> >> uses udev->devnum to set the address wValue. This won't work for
> >> devices connected to xHC.
> >>
> >> For other host controllers udev->devnum is the same as the address of
> >> the usb device, chosen and set by usb core. With xHC the controller
> >> hardware assigns the address, and won't be the same as devnum.
> >>
> >> Here we have two patches.
> >> One is to add devaddr in struct usb_device for
> >> usb_hub_clear_tt_buffer() to use.
> >> Another is to invoke usb_hub_clear_tt_buffer() for halt processing.
> > Why did you resend patch series 11?
> Didn't get response in 2 or 3 days.
> Will be more patient next time.
> 
> May I get patch v11 1/2 acked or reviewed by Alan?

Did I not do this already?  Oh well, in any case:

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern

