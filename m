Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F41FC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 10:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10957208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 10:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfE1KnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 06:43:16 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54796 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726334AbfE1KnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 06:43:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18D7A341;
        Tue, 28 May 2019 03:43:15 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 652ED3F59C;
        Tue, 28 May 2019 03:43:13 -0700 (PDT)
Subject: Re: [PATCH] arm64: mm: make CONFIG_ZONE_DMA32 configurable
To:     Miles Chen <miles.chen@mediatek.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, wsd_upstream@mediatek.com
References: <1558973315-19655-1-git-send-email-miles.chen@mediatek.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <814b9bd0-38de-4b8d-92b3-d663931d90bf@arm.com>
Date:   Tue, 28 May 2019 11:43:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1558973315-19655-1-git-send-email-miles.chen@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/05/2019 17:08, Miles Chen wrote:
> This change makes CONFIG_ZONE_DMA32 defuly y and allows users
> to overwrite it.
> 
> For the SoCs that do not need CONFIG_ZONE_DMA32, this is the
> first step to manage all available memory by a single
> zone(normal zone) to reduce the overhead of multiple zones.
> 
> The change also fixes a build error when CONFIG_NUMA=y and
> CONFIG_ZONE_DMA32=n.
> 
> arch/arm64/mm/init.c:195:17: error: use of undeclared identifier 'ZONE_DMA32'
>                  max_zone_pfns[ZONE_DMA32] = PFN_DOWN(max_zone_dma_phys());
> 
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> ---
>   arch/arm64/Kconfig   | 3 ++-
>   arch/arm64/mm/init.c | 2 ++
>   2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 76f6e4765f49..9d20a736d1d1 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -260,7 +260,8 @@ config GENERIC_CALIBRATE_DELAY
>   	def_bool y
>   
>   config ZONE_DMA32
> -	def_bool y
> +	bool "Support DMA32 zone"

This probably warrants an "if EMBEDDED" or "if EXPERT", since turning it 
off produces a kernel which won't work at all on certain systems (I've 
played around with this before...)

> +	default y
>   
>   config HAVE_GENERIC_GUP
>   	def_bool y
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index d2adffb81b5d..96829ce21f99 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -191,8 +191,10 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
>   {
>   	unsigned long max_zone_pfns[MAX_NR_ZONES]  = {0};
>   
> +#ifdef CONFIG_ZONE_DMA32
>   	if (IS_ENABLED(CONFIG_ZONE_DMA32))

There's no point keeping the IS_ENABLED() check when it's entirely 
redundant with the #ifdefs.

Robin.

>   		max_zone_pfns[ZONE_DMA32] = PFN_DOWN(max_zone_dma_phys());
> +#endif
>   	max_zone_pfns[ZONE_NORMAL] = max;
>   
>   	free_area_init_nodes(max_zone_pfns);
> 
