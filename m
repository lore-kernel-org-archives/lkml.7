Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325CCC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF34527D9D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559564587;
	bh=JUpzLa7o+gjfbaXzaqNHUDC0SKjhj6jOWbWu5myQmaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=s7ZeZ3+aeH3S7oWqF4tVeWk6Y8y6thur8n6c0mPPx9FMHDa13C2r3Ud8hbsYwFFE5
	 Z/Hdrfm16e8gW882nYCiG200X9pWkSnmeR5vgubcNvbxyfnerOMSa/sNuVPMyAXF9V
	 9VCYBu5CfumO2WW1OwRZo/lxIv6cQ7p1m6cyCu5A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfFCMXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 08:23:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:57156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbfFCMXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 08:23:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED3CB27D77;
        Mon,  3 Jun 2019 12:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559564585;
        bh=JUpzLa7o+gjfbaXzaqNHUDC0SKjhj6jOWbWu5myQmaM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XfYhRn1JfzWsBVGa/xKOV1EHw5Uj9YPVbOaWR2lXReNjVmjYIF4M1POmpIHGA2N7s
         U/IBHx+WvGwzHhciZPN+t+eaxXGgVuhXGLnN9cxghHVyaIuAnmW+9hcb7fhYdYT2ID
         P/0Eg328GEnIMRAnDqyVWj8CaFbtebMLfLREdqo8=
Date:   Mon, 3 Jun 2019 14:23:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jim Lin <jilin@nvidia.com>
Cc:     mathias.nyman@intel.com, stern@rowland.harvard.edu,
        kai.heng.feng@canonical.com, drinkcat@chromium.org,
        Thinh.Nguyen@synopsys.com, nsaenzjulienne@suse.de,
        jflat@chromium.org, malat@debian.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 0/2] usb: xhci: Add Clear_TT_Buffer
Message-ID: <20190603122303.GA16267@kroah.com>
References: <1559559224-9845-1-git-send-email-jilin@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559559224-9845-1-git-send-email-jilin@nvidia.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 06:53:42PM +0800, Jim Lin wrote:
> USB 2.0 specification chapter 11.17.5 says "as part of endpoint halt
> processing for full-/low-speed endpoints connected via a TT, the host
> software must use the Clear_TT_Buffer request to the TT to ensure
> that the buffer is not in the busy state".
> 
> In our case, a full-speed speaker (ConferenceCam) is behind a high-
> speed hub (ConferenceCam Connect), sometimes once we get STALL on a
> request we may continue to get STALL with the folllowing requests,
> like Set_Interface.
> 
> Solution is to invoke usb_hub_clear_tt_buffer() to send
> Clear_TT_Buffer request to the hub of the device for the following
> Set_Interface requests to the device to get ACK successfully.
> 
> The Clear_TT_Buffer request sent to the hub includes the address of
> the LS/FS child device in wValue field. usb_hub_clear_tt_buffer()
> uses udev->devnum to set the address wValue. This won't work for
> devices connected to xHC.
> 
> For other host controllers udev->devnum is the same as the address of
> the usb device, chosen and set by usb core. With xHC the controller
> hardware assigns the address, and won't be the same as devnum.
> 
> Here we have two patches.
> One is to add devaddr in struct usb_device for
> usb_hub_clear_tt_buffer() to use.
> Another is to invoke usb_hub_clear_tt_buffer() for halt processing.

Why did you resend patch series 11?

> Signed-off-by: Jim Lin <jilin@nvidia.com>

There is nothing to sign off on a 0/X patch :)

thanks,

greg k-h
