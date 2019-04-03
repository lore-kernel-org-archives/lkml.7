Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2FDC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4747A206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfDCQuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:50:13 -0400
Received: from foss.arm.com ([217.140.101.70]:44852 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbfDCQuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:50:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7233F80D;
        Wed,  3 Apr 2019 09:50:12 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 399D63F68F;
        Wed,  3 Apr 2019 09:50:10 -0700 (PDT)
Date:   Wed, 3 Apr 2019 17:50:05 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        marc.zyngier@arm.com, suzuki.poulose@arm.com, Dave.Martin@arm.com,
        shankerd@codeaurora.org, julien.thierry@arm.com,
        mlangsdo@redhat.com, stefan.wahren@i2e.com, Andre.Przywara@arm.com,
        linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH v6 09/10] arm64: add sysfs vulnerability show for
 speculative store bypass
Message-ID: <20190403165005.GA17500@fuggles.cambridge.arm.com>
References: <20190321230557.45107-1-jeremy.linton@arm.com>
 <20190321230557.45107-10-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321230557.45107-10-jeremy.linton@arm.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeremy,

On Thu, Mar 21, 2019 at 06:05:56PM -0500, Jeremy Linton wrote:
> Return status based on ssbd_state and the arm64 SSBS feature. If
> the mitigation is disabled, or the firmware isn't responding then
> return the expected machine state based on a new blacklist of known
> vulnerable cores.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  arch/arm64/kernel/cpu_errata.c | 44 ++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index 6958dcdabf7d..172ffbabd597 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -278,6 +278,7 @@ static int detect_harden_bp_fw(void)
>  DEFINE_PER_CPU_READ_MOSTLY(u64, arm64_ssbd_callback_required);
>  
>  int ssbd_state __read_mostly = ARM64_SSBD_KERNEL;
> +static bool __ssb_safe = true;
>  
>  static const struct ssbd_options {
>  	const char	*str;
> @@ -386,6 +387,9 @@ static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities *entry,
>  
>  	WARN_ON(scope != SCOPE_LOCAL_CPU || preemptible());
>  
> +	if (is_midr_in_range_list(read_cpuid_id(), entry->midr_range_list))
> +		__ssb_safe = false;
> +

Does this mean that we assume that CPUs not present in our table are not
affected by speculative store bypass? I don't think that's a good
assumption, because we don't necessary have knowledge about partner or
future CPU implementations, so I think any CPU lists really have to be
whitelists like they are for the other vulnerabilities.

>  	if (this_cpu_has_cap(ARM64_SSBS)) {
>  		required = false;
>  		goto out_printmsg;
> @@ -419,12 +423,14 @@ static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities *entry,
>  		ssbd_state = ARM64_SSBD_UNKNOWN;
>  		return false;
>  
> +	/* machines with mixed mitigation requirements must not return this */
>  	case SMCCC_RET_NOT_REQUIRED:
>  		pr_info_once("%s mitigation not required\n", entry->desc);
>  		ssbd_state = ARM64_SSBD_MITIGATED;
>  		return false;
>  
>  	case SMCCC_RET_SUCCESS:
> +		__ssb_safe = false;
>  		required = true;
>  		break;
>  
> @@ -474,6 +480,16 @@ static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities *entry,
>  	return required;
>  }
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
>  static void __maybe_unused
>  cpu_enable_cache_maint_trap(const struct arm64_cpu_capabilities *__unused)
>  {
> @@ -769,6 +785,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
>  		.capability = ARM64_SSBD,
>  		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
>  		.matches = has_ssbd_mitigation,
> +		.midr_range_list = arm64_ssb_cpus,
>  	},
>  #ifdef CONFIG_ARM64_ERRATUM_1188873
>  	{
> @@ -807,3 +824,30 @@ ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr,
>  
>  	return sprintf(buf, "Vulnerable\n");
>  }
> +
> +ssize_t cpu_show_spec_store_bypass(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	/*
> +	 *  Two assumptions: First, ssbd_state reflects the worse case
> +	 *  for heterogeneous machines, and that if SSBS is supported its
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

x86 has a message about the prctl(), which we also support.

Will
