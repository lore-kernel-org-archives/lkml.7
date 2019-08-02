Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9319C0650F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 23:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DFBD20657
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 23:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390016AbfHBXqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 19:46:19 -0400
Received: from foss.arm.com ([217.140.110.172]:57908 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726976AbfHBXqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 19:46:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A9441570;
        Fri,  2 Aug 2019 16:46:18 -0700 (PDT)
Received: from [192.168.1.123] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F3E23F694;
        Fri,  2 Aug 2019 16:46:16 -0700 (PDT)
Subject: Re: [PATCH] arm64/prefetch: fix a -Wtype-limits warning
To:     Qian Cai <cai@lca.pw>, will@kernel.org, catalin.marinas@arm.com
Cc:     rrichter@cavium.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <1564780084-29591-1-git-send-email-cai@lca.pw>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <bf6c2590-6914-ea29-f973-ad6da084e942@arm.com>
Date:   Sat, 3 Aug 2019 00:46:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1564780084-29591-1-git-send-email-cai@lca.pw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-08-02 10:08 pm, Qian Cai wrote:
> The commit d5370f754875 ("arm64: prefetch: add alternative pattern for
> CPUs without a prefetcher") introduced MIDR_IS_CPU_MODEL_RANGE() to be
> used in has_no_hw_prefetch() with rv_min=0 which generates a compilation
> warning from GCC,
> 
> In file included from ./arch/arm64/include/asm/cache.h:8,
>                   from ./include/linux/cache.h:6,
>                   from ./include/linux/printk.h:9,
>                   from ./include/linux/kernel.h:15,
>                   from ./include/linux/cpumask.h:10,
>                   from arch/arm64/kernel/cpufeature.c:11:
> arch/arm64/kernel/cpufeature.c: In function 'has_no_hw_prefetch':
> ./arch/arm64/include/asm/cputype.h:59:26: warning: comparison of
> unsigned expression >= 0 is always true [-Wtype-limits]
>    _model == (model) && rv >= (rv_min) && rv <= (rv_max);  \
>                            ^~
> arch/arm64/kernel/cpufeature.c:889:9: note: in expansion of macro
> 'MIDR_IS_CPU_MODEL_RANGE'
>    return MIDR_IS_CPU_MODEL_RANGE(midr, MIDR_THUNDERX,
>           ^~~~~~~~~~~~~~~~~~~~~~~
> 
> Fix it by making rv_min=1.

With what justification? Are you suggesting revision 0 variant 0 of this 
CPU has suddenly grown a prefetcher? Or that arbitrarily perturbing 
bounds until a warning shuts up is a fine development strategy, because 
a quiet build for people who like turning on random extra warnings is 
more important than correct functionality?

Robin.

> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>   arch/arm64/kernel/cpufeature.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index f29f36a65175..7d15cf6d62c1 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -883,7 +883,7 @@ static bool has_no_hw_prefetch(const struct arm64_cpu_capabilities *entry, int _
>   
>   	/* Cavium ThunderX pass 1.x and 2.x */
>   	return MIDR_IS_CPU_MODEL_RANGE(midr, MIDR_THUNDERX,
> -		MIDR_CPU_VAR_REV(0, 0),
> +		MIDR_CPU_VAR_REV(0, 1),
>   		MIDR_CPU_VAR_REV(1, MIDR_REVISION_MASK));
>   }
>   
> 
