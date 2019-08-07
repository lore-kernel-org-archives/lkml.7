Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F26C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 10:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E821421E6A
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 10:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbfHGKxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 06:53:11 -0400
Received: from foss.arm.com ([217.140.110.172]:46520 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbfHGKxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 06:53:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49F7828;
        Wed,  7 Aug 2019 03:53:10 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7942A3F575;
        Wed,  7 Aug 2019 03:53:09 -0700 (PDT)
Date:   Wed, 7 Aug 2019 11:53:07 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Qian Cai <cai@lca.pw>
Cc:     will@kernel.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64/cache: fix -Woverride-init compiler warnings
Message-ID: <20190807105307.GB54191@lakrids.cambridge.arm.com>
References: <20190806193434.965-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806193434.965-1-cai@lca.pw>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 03:34:34PM -0400, Qian Cai wrote:
> The commit 155433cb365e ("arm64: cache: Remove support for ASID-tagged
> VIVT I-caches") introduced some compiation warnings from GCC (and
> Clang),
> 
> arch/arm64/kernel/cpuinfo.c:38:26: warning: initialized field
> overwritten [-Woverride-init]
>  [ICACHE_POLICY_VIPT]  = "VIPT",
>                          ^~~~~~
> arch/arm64/kernel/cpuinfo.c:38:26: note: (near initialization for
> 'icache_policy_str[2]')
> arch/arm64/kernel/cpuinfo.c:39:26: warning: initialized field
> overwritten [-Woverride-init]
>  [ICACHE_POLICY_PIPT]  = "PIPT",
>                          ^~~~~~
> arch/arm64/kernel/cpuinfo.c:39:26: note: (near initialization for
> 'icache_policy_str[3]')
> arch/arm64/kernel/cpuinfo.c:40:27: warning: initialized field
> overwritten [-Woverride-init]
>  [ICACHE_POLICY_VPIPT]  = "VPIPT",
>                           ^~~~~~~
> arch/arm64/kernel/cpuinfo.c:40:27: note: (near initialization for
> 'icache_policy_str[0]')
> 
> because it initializes icache_policy_str[0 ... 3] twice. Since the array
> is only used in cpuinfo_detect_icache_policy(), fix it by initializing
> a specific field there just before using.
> 
> Fixes: 155433cb365e ("arm64: cache: Remove support for ASID-tagged VIVT I-caches")
> Signed-off-by: Qian Cai <cai@lca.pw>

Rather than trying to "fix" correct code like this (and making it harder
to read), could you instead look into where/whether the warning is
actually useful?

I had a look at an arm64 defconfig, where I see:

[mark@lakrids:~/src/linux]% grep override-init err.log | grep -o '^[^[:space:]:]\+' | sort | uniq -c | sort -rn
    434 arch/arm64/kernel/sys32.c			// all benign
    291 arch/arm64/kernel/sys.c				// all benign
     48 ./arch/arm64/include/asm/perf_event.h		// all benign
     37 arch/arm64/kernel/traps.c			// all benign
     21 arch/arm64/kvm/handle_exit.c			// all benign
     12 drivers/ata/ahci.h				// all benign
      6 arch/arm64/kernel/perf_event.c			// all benign
      4 kernel/time/hrtimer.c				// all benign
      3 arch/arm64/kernel/cpuinfo.c			// all benign
      2 drivers/pinctrl/tegra/pinctrl-tegra194.c	// unclear to me
      1 ./include/linux/blkdev.h			// all benign
      1 drivers/gpu/drm/sun4i/sun4i_drv.c		// all benign
      1 drivers/ata/sata_sil24.c			// all benign
      1 ./arch/arm64/include/asm/mmu.h			// all benign

... so that's 862 warnings where at least 860 are unhelpful (and I
suspect those last two are also fine, but I haven't untangled the set of
macros).

Given that, what's the point in enabling this warning? It forces us to
write worse code that's harder to maintain, and it doesn't spot anything
useful.

> ---
> 
> v2: Initialize a specific field in cpuinfo_detect_icache_policy().
> 
>  arch/arm64/kernel/cpuinfo.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
> index 876055e37352..a0c495a3f4fd 100644
> --- a/arch/arm64/kernel/cpuinfo.c
> +++ b/arch/arm64/kernel/cpuinfo.c
> @@ -34,10 +34,7 @@ DEFINE_PER_CPU(struct cpuinfo_arm64, cpu_data);
>  static struct cpuinfo_arm64 boot_cpu_data;
>  
>  static char *icache_policy_str[] = {
> -	[0 ... ICACHE_POLICY_PIPT]	= "RESERVED/UNKNOWN",
> -	[ICACHE_POLICY_VIPT]		= "VIPT",
> -	[ICACHE_POLICY_PIPT]		= "PIPT",
> -	[ICACHE_POLICY_VPIPT]		= "VPIPT",
> +	[0 ... ICACHE_POLICY_PIPT]	= "RESERVED/UNKNOWN"
>  };
>  
>  unsigned long __icache_flags;
> @@ -310,13 +307,16 @@ static void cpuinfo_detect_icache_policy(struct cpuinfo_arm64 *info)
>  
>  	switch (l1ip) {
>  	case ICACHE_POLICY_PIPT:
> +		icache_policy_str[ICACHE_POLICY_PIPT] = "PIPT";
>  		break;
>  	case ICACHE_POLICY_VPIPT:
> +		icache_policy_str[ICACHE_POLICY_VPIPT] = "VPIPT";
>  		set_bit(ICACHEF_VPIPT, &__icache_flags);
>  		break;
>  	default:
>  		/* Fallthrough */
>  	case ICACHE_POLICY_VIPT:
> +		icache_policy_str[ICACHE_POLICY_VIPT] = "VIPT";
>  		/* Assume aliasing */
>  		set_bit(ICACHEF_ALIASING, &__icache_flags);

NAK to this. Please leave this code as-is.

Thanks,
Mark.

>  	}
> -- 
> 2.20.1 (Apple Git-117)
> 
