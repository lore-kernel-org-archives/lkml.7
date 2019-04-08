Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E15C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE0422148E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfDHP6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:58:54 -0400
Received: from foss.arm.com ([217.140.101.70]:50884 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726373AbfDHP6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 11:58:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CAFF015AB;
        Mon,  8 Apr 2019 08:58:53 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 099633F557;
        Mon,  8 Apr 2019 08:58:51 -0700 (PDT)
Date:   Mon, 8 Apr 2019 16:58:49 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Russell King <linux@arm.linux.org.uk>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH 1/7] ARM: vdso: Remove dependency with the arch_timer
 driver internals
Message-ID: <20190408155849.GM6139@lakrids.cambridge.arm.com>
References: <20190408154907.223536-1-marc.zyngier@arm.com>
 <20190408154907.223536-2-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408154907.223536-2-marc.zyngier@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 04:49:01PM +0100, Marc Zyngier wrote:
> THe VDSO code uses the kernel helper that was originally designed

Nit: s/THe/The/

> to abstract the access between 32 and 64bit systems. It worked so
> far because this function is declared as 'inline'.
> 
> As we're about to revamp that part of the code, the VDSO would
> break. Let's fix it by doing what should have been done from
> the start, a proper system register access.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/include/asm/cp15.h   | 2 ++
>  arch/arm/vdso/vgettimeofday.c | 5 +++--
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/include/asm/cp15.h b/arch/arm/include/asm/cp15.h
> index 07e27f212dc7..d2453e2d3f1f 100644
> --- a/arch/arm/include/asm/cp15.h
> +++ b/arch/arm/include/asm/cp15.h
> @@ -68,6 +68,8 @@
>  #define BPIALL				__ACCESS_CP15(c7, 0, c5, 6)
>  #define ICIALLU				__ACCESS_CP15(c7, 0, c5, 0)
>  
> +#define CNTVCT				__ACCESS_CP15_64(1, c14)

This encoding looks right to me per ARM DDI 0406C.d section B4.1.34. The
rest also looks sound, so with that typo fixed:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> +
>  extern unsigned long cr_alignment;	/* defined in entry-armv.S */
>  
>  static inline unsigned long get_cr(void)
> diff --git a/arch/arm/vdso/vgettimeofday.c b/arch/arm/vdso/vgettimeofday.c
> index a9dd619c6c29..7bdbf5d5c47d 100644
> --- a/arch/arm/vdso/vgettimeofday.c
> +++ b/arch/arm/vdso/vgettimeofday.c
> @@ -18,9 +18,9 @@
>  #include <linux/compiler.h>
>  #include <linux/hrtimer.h>
>  #include <linux/time.h>
> -#include <asm/arch_timer.h>
>  #include <asm/barrier.h>
>  #include <asm/bug.h>
> +#include <asm/cp15.h>
>  #include <asm/page.h>
>  #include <asm/unistd.h>
>  #include <asm/vdso_datapage.h>
> @@ -123,7 +123,8 @@ static notrace u64 get_ns(struct vdso_data *vdata)
>  	u64 cycle_now;
>  	u64 nsec;
>  
> -	cycle_now = arch_counter_get_cntvct();
> +	isb();
> +	cycle_now = read_sysreg(CNTVCT);
>  
>  	cycle_delta = (cycle_now - vdata->cs_cycle_last) & vdata->cs_mask;
>  
> -- 
> 2.20.1
> 
