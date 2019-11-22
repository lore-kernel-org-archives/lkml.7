Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903EAC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 00:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 609DC206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 00:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="lDIFDmcB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfKVAX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 19:23:26 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:36096 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfKVAXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 19:23:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=o7hbwuPirwuuz0Y/+39p2Uj5Rp0ENQjemwmV/bfiS70=; b=lDIFDmcB6YuQuSGSZlFob0XEu
        OhD474Hwuwm4BhvW39/sq97d2A4scUWTlIgruSePYHHLwXTuvZd9/Q20du1X8udEiazjEEIqAUIWF
        Ir3W3OqWGvDVGQuJGVzMMS9QvGdJeCJBEURWMFWoIRXJr89V0FnZOv5Fa4HiHRPT1MZPxq470Pz9W
        z5ULDYDLKDSWnIOfRhi5FYvorVItrtOwGT8cxcze5eJnY61upZfjtjtUWo4mHYCgXKtaL3NLOx1Sn
        Ytk+lSYp6UglSzuJ8T0FIybi3aks+UMtn/vFO/bX4FlWtUHHxWicL/seNL8s7AagS6b9LXVAjpFlG
        iRmWpUnlQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42882)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iXwj5-0001as-MI; Fri, 22 Nov 2019 00:23:07 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iXwiw-0003Br-8q; Fri, 22 Nov 2019 00:22:58 +0000
Date:   Fri, 22 Nov 2019 00:22:58 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     jmorris@namei.org, sashal@kernel.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, steve.capper@arm.com,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com, mark.rutland@arm.com,
        tglx@linutronix.de, gregkh@linuxfoundation.org,
        allison@lohutok.net, info@metux.net, alexios.zavras@intel.com,
        sstabellini@kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, stefan@agner.ch, yamada.masahiro@socionext.com,
        xen-devel@lists.xenproject.org
Subject: Re: [PATCH 1/3] arm/arm64/xen: use C inlines for privcmd_call
Message-ID: <20191122002258.GD25745@shell.armlinux.org.uk>
References: <20191121184805.414758-1-pasha.tatashin@soleen.com>
 <20191121184805.414758-2-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121184805.414758-2-pasha.tatashin@soleen.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 01:48:03PM -0500, Pavel Tatashin wrote:
> privcmd_call requires to enable access to userspace for the
> duration of the hypercall.
> 
> Currently, this is done via assembly macros. Change it to C
> inlines instead.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> ---
>  arch/arm/include/asm/assembler.h |  2 +-
>  arch/arm/include/asm/uaccess.h   | 32 ++++++++++++++++++++++++++------
>  arch/arm/xen/enlighten.c         |  2 +-
>  arch/arm/xen/hypercall.S         | 15 ++-------------
>  arch/arm64/xen/hypercall.S       | 19 ++-----------------
>  include/xen/arm/hypercall.h      | 23 ++++++++++++++++++++---
>  6 files changed, 52 insertions(+), 41 deletions(-)
> 
> diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
> index 99929122dad7..8e9262a0f016 100644
> --- a/arch/arm/include/asm/assembler.h
> +++ b/arch/arm/include/asm/assembler.h
> @@ -480,7 +480,7 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
>  	.macro	uaccess_disable, tmp, isb=1
>  #ifdef CONFIG_CPU_SW_DOMAIN_PAN
>  	/*
> -	 * Whenever we re-enter userspace, the domains should always be
> +	 * Whenever we re-enter kernel, the domains should always be
>  	 * set appropriately.
>  	 */
>  	mov	\tmp, #DACR_UACCESS_DISABLE
> diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
> index 98c6b91be4a8..79d4efa3eb62 100644
> --- a/arch/arm/include/asm/uaccess.h
> +++ b/arch/arm/include/asm/uaccess.h
> @@ -16,6 +16,23 @@
>  
>  #include <asm/extable.h>
>  
> +#ifdef CONFIG_CPU_SW_DOMAIN_PAN
> +static __always_inline void uaccess_enable(void)
> +{
> +	unsigned long val = DACR_UACCESS_ENABLE;
> +
> +	asm volatile("mcr p15, 0, %0, c3, c0, 0" : : "r" (val));
> +	isb();
> +}
> +
> +static __always_inline void uaccess_disable(void)
> +{
> +	unsigned long val = DACR_UACCESS_ENABLE;
> +
> +	asm volatile("mcr p15, 0, %0, c3, c0, 0" : : "r" (val));
> +	isb();
> +}

Rather than inventing these, why not use uaccess_save_and_enable()..
uaccess_restore() around the Xen call?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
