Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F06C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 06:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B24E206B8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 06:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731103AbfCAG6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 01:58:52 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58654 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbfCAG6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 01:58:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B1B7EBD;
        Thu, 28 Feb 2019 22:58:51 -0800 (PST)
Received: from [172.20.0.134] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7097B3F5C1;
        Thu, 28 Feb 2019 22:58:50 -0800 (PST)
Subject: Re: [PATCH v5 06/10] arm64: Always enable spectrev2 vulnerability
 detection
To:     Jeremy Linton <jeremy.linton@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, marc.zyngier@arm.com,
        suzuki.poulose@arm.com, Dave.Martin@arm.com,
        shankerd@codeaurora.org, julien.thierry@arm.com,
        mlangsdo@redhat.com, stefan.wahren@i2e.com,
        linux-kernel@vger.kernel.org
References: <20190227010544.597579-1-jeremy.linton@arm.com>
 <20190227010544.597579-7-jeremy.linton@arm.com>
From:   Andre Przywara <andre.przywara@arm.com>
Message-ID: <0fce2637-ca61-778f-8cf0-a28183758b52@foss.arm.com>
Date:   Fri, 1 Mar 2019 00:58:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190227010544.597579-7-jeremy.linton@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/26/19 7:05 PM, Jeremy Linton wrote:
> The sysfs patches need to display machine vulnerability
> status regardless of kernel config. Prepare for that
> by breaking out the vulnerability/mitigation detection
> code from the logic which implements the mitigation.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>   arch/arm64/kernel/cpu_errata.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index 77f021e78a28..a27e1ee750e1 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -109,12 +109,12 @@ cpu_enable_trap_ctr_access(const struct arm64_cpu_capabilities *__unused)
>   
>   atomic_t arm64_el2_vector_last_slot = ATOMIC_INIT(-1);
>   
> -#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
>   #include <asm/mmu_context.h>
>   #include <asm/cacheflush.h>
>   
>   DEFINE_PER_CPU_READ_MOSTLY(struct bp_hardening_data, bp_hardening_data);
>   
> +

extra empty line

Apart from that picky and unimportant nit it looks alright and compiles 
with and without CONFIG_HARDEN_BRANCH_PREDICTOR being defined.

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre.

>   #ifdef CONFIG_KVM_INDIRECT_VECTORS
>   extern char __smccc_workaround_1_smc_start[];
>   extern char __smccc_workaround_1_smc_end[];
> @@ -270,11 +270,11 @@ static int detect_harden_bp_fw(void)
>   	    ((midr & MIDR_CPU_MODEL_MASK) == MIDR_QCOM_FALKOR_V1))
>   		cb = qcom_link_stack_sanitization;
>   
> -	install_bp_hardening_cb(cb, smccc_start, smccc_end);
> +	if (IS_ENABLED(CONFIG_HARDEN_BRANCH_PREDICTOR))
> +		install_bp_hardening_cb(cb, smccc_start, smccc_end);
>   
>   	return 1;
>   }
> -#endif	/* CONFIG_HARDEN_BRANCH_PREDICTOR */
>   
>   #ifdef CONFIG_ARM64_SSBD
>   DEFINE_PER_CPU_READ_MOSTLY(u64, arm64_ssbd_callback_required);
> @@ -513,7 +513,6 @@ cpu_enable_cache_maint_trap(const struct arm64_cpu_capabilities *__unused)
>   	.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,			\
>   	CAP_MIDR_RANGE_LIST(midr_list)
>   
> -#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
>   /*
>    * List of CPUs that do not need any Spectre-v2 mitigation at all.
>    */
> @@ -545,6 +544,11 @@ check_branch_predictor(const struct arm64_cpu_capabilities *entry, int scope)
>   	if (!need_wa)
>   		return false;
>   
> +	if (!IS_ENABLED(CONFIG_HARDEN_BRANCH_PREDICTOR)) {
> +		pr_warn_once("spectrev2 mitigation disabled by configuration\n");
> +		return false;
> +	}
> +
>   	/* forced off */
>   	if (__nospectre_v2) {
>   		pr_info_once("spectrev2 mitigation disabled by command line option\n");
> @@ -557,8 +561,6 @@ check_branch_predictor(const struct arm64_cpu_capabilities *entry, int scope)
>   	return (need_wa > 0);
>   }
>   
> -#endif
> -
>   #ifdef CONFIG_HARDEN_EL2_VECTORS
>   
>   static const struct midr_range arm64_harden_el2_vectors[] = {
> @@ -732,13 +734,11 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
>   		ERRATA_MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
>   	},
>   #endif
> -#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
>   	{
>   		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
>   		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
>   		.matches = check_branch_predictor,
>   	},
> -#endif
>   #ifdef CONFIG_HARDEN_EL2_VECTORS
>   	{
>   		.desc = "EL2 vector hardening",
> 
