Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F9FCA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 22:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51C0B2085B
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 22:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hZXZMeFo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfKAWJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 18:09:56 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:44248 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfKAWJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 18:09:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UZ+SaEOWnCzvDrxTX6AG9Wwn8agTsJsGJeEc8woNULI=; b=hZXZMeFoazQYFUDfoHWbz7LR6
        e61UZAeW9hl9TUo9DCf/pKzC8+hPb+F9EhM79CLzrW/Ev1L/hGh1JFwto8ECXGOCFwe9PVsMzKh55
        KCldn3SwmblmCgp8M7n25aBYgxnykz6yzgoJDybAVe474AsmaL23jpZGL3eCfN/6623iv634ES8Rw
        tYmHo3BdXtu+QabHkNtAYIXPWJeWYfVnOzmJA5Z0z0GAWMyXF065AXwdmiI7smdNbgaSpCJSGfYDe
        3RHxJTfpBBLpupHAvfKzGBy9vMGchkwt3thhvw0vJRJtYoGicwMP0FiWOetF78qSo0YMegNQDQQx6
        FVYky62hg==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:58018)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iQf71-0007UG-3j; Fri, 01 Nov 2019 22:09:43 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iQf6x-0007vG-Dj; Fri, 01 Nov 2019 22:09:39 +0000
Date:   Fri, 1 Nov 2019 22:09:39 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Stefan Agner <stefan@agner.ch>
Cc:     ndesaulniers@google.com, nico@fluxnic.net, rfranz@marvell.com,
        linus.walleij@linaro.org, ard.biesheuvel@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] ARM: use APSR_nzcv instead of r15 as mrc operand
Message-ID: <20191101220939.GK25745@shell.armlinux.org.uk>
References: <472f8bd1f000f45343cc0c66a26380fe4b532147.1572644664.git.stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <472f8bd1f000f45343cc0c66a26380fe4b532147.1572644664.git.stefan@agner.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2019 at 10:47:58PM +0100, Stefan Agner wrote:
> LLVM's integrated assembler does not accept r15 as mrc operand.
>   arch/arm/boot/compressed/head.S:1267:16: error: operand must be a register in range [r0, r14] or apsr_nzcv
>   1: mrc p15, 0, r15, c7, c14, 3 @ test,clean,invalidate D cache
>                  ^
> 
> Use APSR_nzcv instead of r15. The GNU assembler supports this
> syntax since binutils 2.21 [0].
> 
> [0] https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=commit;h=db472d6ff0f438a21b357249a9b48e4b74498076
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Looks fine, please put it in the patch system; however, please note
that I've been tweaking the patch system over the last week (mainly
with the database, which has impacted almost everything) so there
may be issues that I've not yet found...

Thanks.

> ---
>  arch/arm/boot/compressed/head.S | 2 +-
>  arch/arm/mm/proc-arm1026.S      | 4 ++--
>  arch/arm/mm/proc-arm926.S       | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
> index 15ecad944847..ead21e5f2b80 100644
> --- a/arch/arm/boot/compressed/head.S
> +++ b/arch/arm/boot/compressed/head.S
> @@ -1273,7 +1273,7 @@ iflush:
>  __armv5tej_mmu_cache_flush:
>  		tst	r4, #1
>  		movne	pc, lr
> -1:		mrc	p15, 0, r15, c7, c14, 3	@ test,clean,invalidate D cache
> +1:		mrc	p15, 0, APSR_nzcv, c7, c14, 3	@ test,clean,invalidate D cache
>  		bne	1b
>  		mcr	p15, 0, r0, c7, c5, 0	@ flush I cache
>  		mcr	p15, 0, r0, c7, c10, 4	@ drain WB
> diff --git a/arch/arm/mm/proc-arm1026.S b/arch/arm/mm/proc-arm1026.S
> index 10e21012380b..0bdf25a95b10 100644
> --- a/arch/arm/mm/proc-arm1026.S
> +++ b/arch/arm/mm/proc-arm1026.S
> @@ -138,7 +138,7 @@ ENTRY(arm1026_flush_kern_cache_all)
>  	mov	ip, #0
>  __flush_whole_cache:
>  #ifndef CONFIG_CPU_DCACHE_DISABLE
> -1:	mrc	p15, 0, r15, c7, c14, 3		@ test, clean, invalidate
> +1:	mrc	p15, 0, APSR_nzcv, c7, c14, 3		@ test, clean, invalidate
>  	bne	1b
>  #endif
>  	tst	r2, #VM_EXEC
> @@ -363,7 +363,7 @@ ENTRY(cpu_arm1026_switch_mm)
>  #ifdef CONFIG_MMU
>  	mov	r1, #0
>  #ifndef CONFIG_CPU_DCACHE_DISABLE
> -1:	mrc	p15, 0, r15, c7, c14, 3		@ test, clean, invalidate
> +1:	mrc	p15, 0, APSR_nzcv, c7, c14, 3		@ test, clean, invalidate
>  	bne	1b
>  #endif
>  #ifndef CONFIG_CPU_ICACHE_DISABLE
> diff --git a/arch/arm/mm/proc-arm926.S b/arch/arm/mm/proc-arm926.S
> index 3188ab2bac61..1ba253c2bce1 100644
> --- a/arch/arm/mm/proc-arm926.S
> +++ b/arch/arm/mm/proc-arm926.S
> @@ -131,7 +131,7 @@ __flush_whole_cache:
>  #ifdef CONFIG_CPU_DCACHE_WRITETHROUGH
>  	mcr	p15, 0, ip, c7, c6, 0		@ invalidate D cache
>  #else
> -1:	mrc	p15, 0, r15, c7, c14, 3 	@ test,clean,invalidate
> +1:	mrc	p15, 0, APSR_nzcv, c7, c14, 3 	@ test,clean,invalidate
>  	bne	1b
>  #endif
>  	tst	r2, #VM_EXEC
> @@ -358,7 +358,7 @@ ENTRY(cpu_arm926_switch_mm)
>  	mcr	p15, 0, ip, c7, c6, 0		@ invalidate D cache
>  #else
>  @ && 'Clean & Invalidate whole DCache'
> -1:	mrc	p15, 0, r15, c7, c14, 3 	@ test,clean,invalidate
> +1:	mrc	p15, 0, APSR_nzcv, c7, c14, 3 	@ test,clean,invalidate
>  	bne	1b
>  #endif
>  	mcr	p15, 0, ip, c7, c5, 0		@ invalidate I cache
> -- 
> 2.23.0
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
