Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C3CC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 14:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C8A21783
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 14:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfKMOB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 09:01:29 -0500
Received: from foss.arm.com ([217.140.110.172]:53012 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbfKMOB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 09:01:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01C0B7A7;
        Wed, 13 Nov 2019 06:01:28 -0800 (PST)
Received: from localhost.localdomain (unknown [10.1.196.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D25AA3F6C4;
        Wed, 13 Nov 2019 06:01:26 -0800 (PST)
Subject: Re: [PATCH v2 1/2] arm64: Combine workarounds for speculative AT
 errata
To:     Steven Price <steven.price@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>
References: <20191113114118.2427-1-steven.price@arm.com>
 <20191113114118.2427-2-steven.price@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <173fe989-4692-aa22-05b0-a217b7fd1d89@arm.com>
Date:   Wed, 13 Nov 2019 14:01:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191113114118.2427-2-steven.price@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13/11/2019 11:41, Steven Price wrote:
> Cortex-A57/A72 have a similar errata to Cortex-A76 regarding speculation
> of the AT instruction. Since the workaround for A57/A72 doesn't require
> VHE, the restriction enforcing VHE for A76 can be removed by combining
> the workaround flag for both errata.
> 
> So combine WORKAROUND_1165522 and WORKAROUND_1319367 into
> WORKAROUND_SPECULATIVE_AT. The majority of code is contained within VHE
> or NVHE specific functions, for the cases where the code is shared extra
> checks against has_vhe().
> 
> This also paves the way for adding a similar erratum for Cortex-A55.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>

> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index 4f8187a4fc46..b801f8e832aa 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -744,6 +744,16 @@ static const struct midr_range erratum_1418040_list[] = {
>   };
>   #endif
>   
> +#ifdef CONFIG_ARM64_WORKAROUND_SPECULATIVE_AT
> +static const struct midr_range erratum_speculative_at_list[] = {
> +#ifdef CONFIG_ARM64_ERRATUM_1165522
> +	/* Cortex A76 r0p0 to r2p0 */
> +	MIDR_RANGE(MIDR_CORTEX_A76, 0, 0, 2, 0),
> +#endif
> +	{},
> +};
> +#endif
> +
>   const struct arm64_cpu_capabilities arm64_errata[] = {
>   #ifdef CONFIG_ARM64_WORKAROUND_CLEAN_CACHE
>   	{
> @@ -868,12 +878,11 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
>   		ERRATA_MIDR_RANGE_LIST(erratum_1418040_list),
>   	},
>   #endif
> -#ifdef CONFIG_ARM64_ERRATUM_1165522
> +#ifdef CONFIG_ARM64_WORKAROUND_SPECULATIVE_AT
>   	{
> -		/* Cortex-A76 r0p0 to r2p0 */
>   		.desc = "ARM erratum 1165522",
> -		.capability = ARM64_WORKAROUND_1165522,
> -		ERRATA_MIDR_RANGE(MIDR_CORTEX_A76, 0, 0, 2, 0),
> +		.capability = ARM64_WORKAROUND_SPECULATIVE_AT,
> +		ERRATA_MIDR_RANGE_LIST(erratum_speculative_at_list),
>   	},
>   #endif
>   #ifdef CONFIG_ARM64_ERRATUM_1463225
> @@ -910,7 +919,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
>   #ifdef CONFIG_ARM64_ERRATUM_1319367
>   	{
>   		.desc = "ARM erratum 1319367",
> -		.capability = ARM64_WORKAROUND_1319367,
> +		.capability = ARM64_WORKAROUND_SPECULATIVE_AT,
>   		ERRATA_MIDR_RANGE_LIST(ca57_a72),
>   	},
>   #endif

Have you tested this patch with both the errata CONFIGs turned on ?
Having multiple entries for the same capability should trigger a WARNING at
boot with init_cpu_hwcaps_indirect_list_from_array().
You could simply add the MIDRs to the midr_list and update the description
to include all the Errata numbers.

Suzuki
