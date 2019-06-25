Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CC5C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 21:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B714E20663
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 21:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXuFXVi6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfFYVCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 17:02:06 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35051 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfFYVCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 17:02:06 -0400
Received: by mail-pg1-f193.google.com with SMTP id s27so52999pgl.2;
        Tue, 25 Jun 2019 14:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=793hX21onYxPim3s0acooI0U3fxL6frgDB3Bl1198VI=;
        b=MXuFXVi6fhIxk907/vWNDNYg5Bk975lj83+GVeFsAkvQZ9/dRmNMPNrGnn5e7aHCbF
         or0QJttTrIGHMfH/2dV1v1Vy3RPvlWDyarBWB0vy7JBzeo2flKU0TxlgfR9Q20Lztijk
         HQ+v4rFfed75hOwi8Sn+YBBu5NxKIc5UlaJmwh0bo/ROGaBKjT6/0Fb4Ud8JDnkzzHp8
         EWadSCPLbUPHAlZ4NfkHc9eMJ96fMcQ8NKE2QW09J66RvE9GfBVSbMhGbKVZpVVG8OLQ
         8jOrk3iCxLmFrNBjFUM6xlox6J5WftC0QjCpdXcuyH/dipkL+tZ+ZhzA55v+7MRmeuF5
         fwUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=793hX21onYxPim3s0acooI0U3fxL6frgDB3Bl1198VI=;
        b=VHIrs5brKwnpzaA/o6rgffIZ01aKy7/PXkw9gsX6DdGwo8QZMJcgtNoX4QpCMiNYuJ
         od+H4yQZ0rx2a7W3odiS/UUrPBb/Rra8bDxmZaQ/35qaCHXXTlPMAHYQx7q6Vxw+nGQx
         XAKTqtyF7pz3Uczpcj9IJXdOj39xIhahUTQh981FhT2hwWmm3IZ4Ss4amKprLfOc7m8F
         /6k13VKp+pcv+Gdf3Jcqiqgmd5zJSe0e0uDMGitTFvFbIWvQICp8gnG1VDG2cVW+CN5G
         CNFKKOtqxRcp+TKtjLNsCTAspPHLIrb2+ZJohiuB8CnlbE7poaV8kWUYjCjXCPb0yXSv
         DfoQ==
X-Gm-Message-State: APjAAAXesW2+ywu2AR+TPmYfz/x5G6P8XDukQP7q0IrbtEuDQSjuZtC9
        drz2BxupalS5onZOLwCq3zU=
X-Google-Smtp-Source: APXvYqx6cSD3q36naHciSVSmKXHTCIskuGlU9u/TTqOZsrD1JEa4dVV9v8VXWsn4CpFC/PST9eUYWQ==
X-Received: by 2002:a17:90a:db08:: with SMTP id g8mr853612pjv.39.1561496086723;
        Tue, 25 Jun 2019 13:54:46 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j23sm16701617pgb.63.2019.06.25.13.54.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 13:54:46 -0700 (PDT)
Date:   Tue, 25 Jun 2019 13:54:45 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Fredrik Noring <noring@nocrew.org>
Cc:     Christoph Hellwig <hch@lst.de>, laurentiu.tudor@nxp.com,
        stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, marex@denx.de, leoyang.li@nxp.com,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        JuergenUrban@gmx.de
Subject: Re: [PATCH 2/2] usb: host: Fix excessive alignment restriction for
 local memory allocations
Message-ID: <20190625205445.GB7449@roeck-us.net>
References: <20190613134033.GA2489@sx9>
 <bdfd2178-9e3c-dc15-6aa1-ec1f1fbcb191@roeck-us.net>
 <20190613153414.GA909@sx9>
 <3f2164cd-7655-b7cc-ec57-d8751886728c@roeck-us.net>
 <20190614142816.GA2574@sx9>
 <20190624063515.GA3296@lst.de>
 <20190624125916.GA2516@sx9>
 <20190625060000.GA28986@lst.de>
 <20190625150558.GA2560@sx9>
 <20190625150823.GB2560@sx9>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625150823.GB2560@sx9>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 05:08:23PM +0200, Fredrik Noring wrote:
> The PAGE_SHIFT alignment restriction to devm_gen_pool_create() quickly
> exhaust local memory because most allocations are much smaller than
> PAGE_SIZE. This causes USB device failures such as
> 
> 	usb 1-2.1: reset full-speed USB device number 4 using sm501-usb
> 	sd 1:0:0:0: [sda] tag#0 UNKNOWN(0x2003) Result: hostbyte=0x03 driverbyte=0x00
> 	sd 1:0:0:0: [sda] tag#0 CDB: opcode=0x28 28 00 00 00 08 7c 00 00 f0 00
> 	print_req_error: I/O error, dev sda, sector 2172 flags 80700
> 
> when trying to boot from the SM501 USB controller on SH4 with QEMU.
> 
> Align allocations as required but not necessarily much more than that.
> The HCCA, TD and ED structures align with 256, 32 and 16 byte memory
> boundaries, as specified by the Open HCI[1]. The min_alloc_order argument
> to devm_gen_pool_create is now somewhat arbitrarily set to 4 (16 bytes).
> Perhaps it could be somewhat lower for general buffer allocations.
> 
> Reference:
> 
> [1] "Open Host Controller Interface Specification for USB",
>     release 1.0a, Compaq, Microsoft, National Semiconductor, 1999,
>     pp. 16, 19, 33.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Fredrik Noring <noring@nocrew.org>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/usb/core/hcd.c      | 2 +-
>  drivers/usb/host/ohci-hcd.c | 4 ++--
>  drivers/usb/host/ohci-mem.c | 6 ++++--
>  3 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index b2362303d32f..48483fa71854 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -3014,7 +3014,7 @@ int usb_hcd_setup_local_mem(struct usb_hcd *hcd, phys_addr_t phys_addr,
>  	int err;
>  	void __iomem *local_mem;
>  
> -	hcd->localmem_pool = devm_gen_pool_create(hcd->self.sysdev, PAGE_SHIFT,
> +	hcd->localmem_pool = devm_gen_pool_create(hcd->self.sysdev, 4,
>  						  dev_to_node(hcd->self.sysdev),
>  						  dev_name(hcd->self.sysdev));
>  	if (IS_ERR(hcd->localmem_pool))
> diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
> index 5801858d867e..b457fdaff297 100644
> --- a/drivers/usb/host/ohci-hcd.c
> +++ b/drivers/usb/host/ohci-hcd.c
> @@ -507,9 +507,9 @@ static int ohci_init (struct ohci_hcd *ohci)
>  	ohci->prev_frame_no = IO_WATCHDOG_OFF;
>  
>  	if (hcd->localmem_pool)
> -		ohci->hcca = gen_pool_dma_alloc(hcd->localmem_pool,
> +		ohci->hcca = gen_pool_dma_alloc_align(hcd->localmem_pool,
>  						sizeof(*ohci->hcca),
> -						&ohci->hcca_dma);
> +						&ohci->hcca_dma, 256);
>  	else
>  		ohci->hcca = dma_alloc_coherent(hcd->self.controller,
>  						sizeof(*ohci->hcca),
> diff --git a/drivers/usb/host/ohci-mem.c b/drivers/usb/host/ohci-mem.c
> index 4afe27cc7e46..1425335c6baf 100644
> --- a/drivers/usb/host/ohci-mem.c
> +++ b/drivers/usb/host/ohci-mem.c
> @@ -94,7 +94,8 @@ td_alloc (struct ohci_hcd *hc, gfp_t mem_flags)
>  	struct usb_hcd	*hcd = ohci_to_hcd(hc);
>  
>  	if (hcd->localmem_pool)
> -		td = gen_pool_dma_zalloc(hcd->localmem_pool, sizeof(*td), &dma);
> +		td = gen_pool_dma_zalloc_align(hcd->localmem_pool,
> +				sizeof(*td), &dma, 32);
>  	else
>  		td = dma_pool_zalloc(hc->td_cache, mem_flags, &dma);
>  	if (td) {
> @@ -137,7 +138,8 @@ ed_alloc (struct ohci_hcd *hc, gfp_t mem_flags)
>  	struct usb_hcd	*hcd = ohci_to_hcd(hc);
>  
>  	if (hcd->localmem_pool)
> -		ed = gen_pool_dma_zalloc(hcd->localmem_pool, sizeof(*ed), &dma);
> +		ed = gen_pool_dma_zalloc_align(hcd->localmem_pool,
> +				sizeof(*ed), &dma, 16);
>  	else
>  		ed = dma_pool_zalloc(hc->ed_cache, mem_flags, &dma);
>  	if (ed) {
> -- 
> 2.21.0
> 
