Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6961C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 11:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FC3421734
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 11:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559129019;
	bh=McAELd9X83y5uf1BerOqhmU3UNbPRNL3esrqC1Crr/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EYuJ/zvj2edH9cpRzcxsk1nMlvauAk9c9298b1HpCPlxIkhfwOsKoFVyphQjjU72/
	 dsKiMd68rHkLcoLVFBcrPpl3TkTtTVFqVLVyw6Eyuh9haMblMYfvdOghz8HfoxlVZI
	 9CPVhuYdp3/pNE4X9OOHVd/OrUjrIGFumsFVSSts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfE2LXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 07:23:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:60974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbfE2LXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 07:23:36 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F18B920B1F;
        Wed, 29 May 2019 11:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559129015;
        bh=McAELd9X83y5uf1BerOqhmU3UNbPRNL3esrqC1Crr/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OM5NOuMbLNjTabGDh5c1RGgC+P8hNBmHsNvToIku8DC8bSi6hSWaVyNWDlgLes/Ih
         3JBZygq8VnCDIV5HJOPoBDXFGEyWlp7a8XaNpgmuixo13REHhNauwNkUzxgA5hwOCY
         QandglykZUmcAfpw4V6peTXTNmo3hyrHmTWY3xKk=
Date:   Wed, 29 May 2019 04:23:34 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     "hch@lst.de" <hch@lst.de>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "marex@denx.de" <marex@denx.de>, Leo Li <leoyang.li@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "noring@nocrew.org" <noring@nocrew.org>,
        "JuergenUrban@gmx.de" <JuergenUrban@gmx.de>
Subject: Re: [PATCH v7 2/5] USB: use genalloc for USB HCs with local memory
Message-ID: <20190529112334.GA11368@kroah.com>
References: <20190529102843.13174-1-laurentiu.tudor@nxp.com>
 <20190529102843.13174-3-laurentiu.tudor@nxp.com>
 <20190529103838.GC7383@kroah.com>
 <34a83e74-4c85-cf9f-54c3-b69b0dcb628e@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34a83e74-4c85-cf9f-54c3-b69b0dcb628e@nxp.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 11:15:54AM +0000, Laurentiu Tudor wrote:
> 
> 
> On 29.05.2019 13:38, Greg KH wrote:
> > On Wed, May 29, 2019 at 01:28:40PM +0300, laurentiu.tudor@nxp.com wrote:
> >> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> >>
> >> For HCs that have local memory, replace the current DMA API usage
> >> with a genalloc generic allocator to manage the mappings for these
> >> devices. To help users, introduce a new HCD API,
> >> usb_hcd_setup_local_mem() that will setup up the genalloc backing
> >> up the device local memory. It will be used in subsequent patches.
> >> This is in preparation for dropping the existing "coherent" dma
> >> mem declaration APIs. Current implementation was relying on a short
> >> circuit in the DMA API that in the end, was acting as an allocator
> >> for these type of devices.
> >> For sh arch to compile GENERIC_ALLOCATOR needs to be selected in
> >> Kconfig.
> >>
> >> For context, see thread here: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org%2Flkml%2F2019%2F4%2F22%2F357&amp;data=02%7C01%7Claurentiu.tudor%40nxp.com%7Cade28e1f322c4502cd4808d6e421d0ba%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636947231220264072&amp;sdata=xvmzDztMbeD9GwlcAfx7bBoxhARWgB3vmQkqiE81Lbg%3D&amp;reserved=0
> >>
> >> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> >> Signed-off-by: Fredrik Noring <noring@nocrew.org>
> >> Tested-by: Fredrik Noring <noring@nocrew.org>
> >> Reported-by: kbuild test robot <lkp@intel.com>
> >> ---
> >>   drivers/usb/Kconfig         |  1 +
> >>   drivers/usb/core/buffer.c   |  9 +++++++++
> >>   drivers/usb/core/hcd.c      | 36 ++++++++++++++++++++++++++++++++++++
> >>   drivers/usb/host/ohci-hcd.c | 23 ++++++++++++++++++-----
> >>   drivers/usb/host/ohci-mem.c | 35 +++++++++++++++++++++++++++++++----
> >>   drivers/usb/host/ohci.h     |  2 ++
> >>   include/linux/usb/hcd.h     |  5 +++++
> >>   7 files changed, 102 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
> >> index e4b27413f528..389c57d8eba7 100644
> >> --- a/drivers/usb/Kconfig
> >> +++ b/drivers/usb/Kconfig
> >> @@ -45,6 +45,7 @@ config USB_ARCH_HAS_HCD
> >>   config USB
> >>   	tristate "Support for Host-side USB"
> >>   	depends on USB_ARCH_HAS_HCD
> >> +	select GENERIC_ALLOCATOR
> > 
> > Are there any arches that does not have GENERIC_ALLOCATOR?  I don't want
> > to suddenly cut off a bunch of working systems from having USB support.
> > 
> 
> lkp report mentions only sh, but even if there are others, I think that 
> now having the explicit select should cover them, right?

As long as GENERIC_ALLOCATOR works on all arches, yes, that's fine, but
please verify that this is the case.

thanks,

greg k-h
