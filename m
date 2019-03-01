Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5596C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 07:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E022084F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 07:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbfCAHCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 02:02:12 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58752 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbfCAHCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 02:02:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2772AEBD;
        Thu, 28 Feb 2019 23:02:11 -0800 (PST)
Received: from [172.20.0.134] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CE8A3F5C1;
        Thu, 28 Feb 2019 23:02:10 -0800 (PST)
Subject: Re: [PATCH v5 09/10] arm64: add sysfs vulnerability show for
 speculative store bypass
To:     Jeremy Linton <jeremy.linton@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, marc.zyngier@arm.com,
        suzuki.poulose@arm.com, Dave.Martin@arm.com,
        shankerd@codeaurora.org, julien.thierry@arm.com,
        mlangsdo@redhat.com, stefan.wahren@i2e.com,
        linux-kernel@vger.kernel.org
References: <20190227010544.597579-1-jeremy.linton@arm.com>
 <20190227010544.597579-10-jeremy.linton@arm.com>
From:   Andre Przywara <andre.przywara@arm.com>
Message-ID: <04eb2b5d-3754-0e39-3c6e-54b45741da83@foss.arm.com>
Date:   Fri, 1 Mar 2019 01:02:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190227010544.597579-10-jeremy.linton@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/26/19 7:05 PM, Jeremy Linton wrote:
> Return status based on ssbd_state and the arm64 SSBS feature. If
> the mitigation is disabled, or the firmware isn't responding then
> return the expected machine state based on a new blacklist of known
> vulnerable cores.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>   arch/arm64/kernel/cpu_errata.c | 43 ++++++++++++++++++++++++++++++++++
>   1 file changed, 43 insertions(+)
> 
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index 5f5611d17dc1..e1b03f643799 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -279,6 +279,7 @@ static int detect_harden_bp_fw(void)
>   DEFINE_PER_CPU_READ_MOSTLY(u64, arm64_ssbd_callback_required);
>   
>   int ssbd_state __read_mostly = ARM64_SSBD_KERNEL;
> +static bool __ssb_safe = true;
>   
>   static const struct ssbd_options {
>   	const char	*str;
> @@ -387,6 +388,9 @@ static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities *entry,
>   
>   	WARN_ON(scope != SCOPE_LOCAL_CPU || preemptible());
>   
> +	if (is_midr_in_range_list(read_cpuid_id(), entry->midr_range_list))
> +		__ssb_safe = false;

Is that the only place where we set it to false?
What about if firmware reports that (at least one core) is vulnerable?

> +
>   	if (this_cpu_has_cap(ARM64_SSBS)) {
>   		required = false;
>   		goto out_printmsg;
> @@ -420,6 +424,7 @@ static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities *entry,
>   		ssbd_state = ARM64_SSBD_UNKNOWN;
>   		return false;
>   
> +	/* machines with mixed mitigation requirements must not return this */
>   	case SMCCC_RET_NOT_REQUIRED:
>   		pr_info_once("%s mitigation not required\n", entry->desc);
>   		ssbd_state = ARM64_SSBD_MITIGATED;
> @@ -475,6 +480,16 @@ static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities *entry,
>   	return required;
>   }
>   
> +/* known vulnerable cores */
> +static const struct midr_range arm64_ssb_cpus[] = {
> +	MIDR_ALL_VERSIONS(MIDR_CORTEX_A57),
> +	MIDR_ALL_VERSIONS(MIDR_CORTEX_A72),
> +	MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
> +	MIDR_ALL_VERSIONS(MIDR_CORTEX_A75),
> +	MIDR_ALL_VERSIONS(MIDR_CORTEX_A76),
> +	{},
> +};
> +
>   static void __maybe_unused
>   cpu_enable_cache_maint_trap(const struct arm64_cpu_capabilities *__unused)
>   {
> @@ -770,6 +785,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
>   		.capability = ARM64_SSBD,
>   		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
>   		.matches = has_ssbd_mitigation,
> +		.midr_range_list = arm64_ssb_cpus,
>   	},
>   #ifdef CONFIG_ARM64_ERRATUM_1188873
>   	{
> @@ -808,3 +824,30 @@ ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr,
>   
>   	return sprintf(buf, "Vulnerable\n");
>   }
> +
> +ssize_t cpu_show_spec_store_bypass(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	/*
> +	 *  Two assumptions: First, ssbd_state reflects the worse case
> +	 *  for hetrogenous machines, and that if SSBS is supported its

                 heterogeneous

Cheers,
Andre.

> +	 *  supported by all cores.
> +	 */
> +	switch (ssbd_state) {
> +	case ARM64_SSBD_MITIGATED:
> +		return sprintf(buf, "Not affected\n");
> +
> +	case ARM64_SSBD_KERNEL:
> +	case ARM64_SSBD_FORCE_ENABLE:
> +		if (cpus_have_cap(ARM64_SSBS))
> +			return sprintf(buf, "Not affected\n");
> +		if (IS_ENABLED(CONFIG_ARM64_SSBD))
> +			return sprintf(buf,
> +			    "Mitigation: Speculative Store Bypass disabled\n");
> +	}
> +
> +	if (__ssb_safe)
> +		return sprintf(buf, "Not affected\n");
> +
> +	return sprintf(buf, "Vulnerable\n");
> +}
> 
