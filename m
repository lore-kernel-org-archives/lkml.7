Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FA5C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 06:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FB6C2084F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 06:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731861AbfCAG7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 01:59:09 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58694 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbfCAG7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 01:59:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B08BEBD;
        Thu, 28 Feb 2019 22:59:07 -0800 (PST)
Received: from [172.20.0.134] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E2D93F5C1;
        Thu, 28 Feb 2019 22:59:06 -0800 (PST)
Subject: Re: [PATCH v5 07/10] arm64: add sysfs vulnerability show for spectre
 v2
To:     Jeremy Linton <jeremy.linton@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, marc.zyngier@arm.com,
        suzuki.poulose@arm.com, Dave.Martin@arm.com,
        shankerd@codeaurora.org, julien.thierry@arm.com,
        mlangsdo@redhat.com, stefan.wahren@i2e.com,
        linux-kernel@vger.kernel.org
References: <20190227010544.597579-1-jeremy.linton@arm.com>
 <20190227010544.597579-8-jeremy.linton@arm.com>
From:   Andre Przywara <andre.przywara@arm.com>
Message-ID: <f8c39149-58e7-e277-7bca-098ff3d4c391@foss.arm.com>
Date:   Fri, 1 Mar 2019 00:59:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190227010544.597579-8-jeremy.linton@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/26/19 7:05 PM, Jeremy Linton wrote:
> Add code to track whether all the cores in the machine are
> vulnerable, and whether all the vulnerable cores have been
> mitigated.
> 
> Once we have that information we can add the sysfs stub and
> provide an accurate view of what is known about the machine.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>   arch/arm64/kernel/cpu_errata.c | 28 +++++++++++++++++++++++++++-
>   1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index a27e1ee750e1..0f6e8f5d67bc 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -513,6 +513,10 @@ cpu_enable_cache_maint_trap(const struct arm64_cpu_capabilities *__unused)
>   	.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,			\
>   	CAP_MIDR_RANGE_LIST(midr_list)
>   
> +/* Track overall mitigation state. We are only mitigated if all cores are ok */
> +static bool __hardenbp_enab = true;
> +static bool __spectrev2_safe = true;
> +
>   /*
>    * List of CPUs that do not need any Spectre-v2 mitigation at all.
>    */
> @@ -523,6 +527,10 @@ static const struct midr_range spectre_v2_safe_list[] = {
>   	{ /* sentinel */ }
>   };
>   
> +/*
> + * Track overall bp hardening for all heterogeneous cores in the machine.
> + * We are only considered "safe" if all booted cores are known safe.
> + */
>   static bool __maybe_unused
>   check_branch_predictor(const struct arm64_cpu_capabilities *entry, int scope)
>   {
> @@ -544,19 +552,25 @@ check_branch_predictor(const struct arm64_cpu_capabilities *entry, int scope)
>   	if (!need_wa)
>   		return false;
>   
> +	__spectrev2_safe = false;
> +
>   	if (!IS_ENABLED(CONFIG_HARDEN_BRANCH_PREDICTOR)) {
>   		pr_warn_once("spectrev2 mitigation disabled by configuration\n");
> +		__hardenbp_enab = false;
>   		return false;
>   	}
>   
>   	/* forced off */
>   	if (__nospectre_v2) {
>   		pr_info_once("spectrev2 mitigation disabled by command line option\n");
> +		__hardenbp_enab = false;
>   		return false;
>   	}
>   
> -	if (need_wa < 0)
> +	if (need_wa < 0) {
>   		pr_warn_once("ARM_SMCCC_ARCH_WORKAROUND_1 missing from firmware\n");
> +		__hardenbp_enab = false;
> +	}
>   
>   	return (need_wa > 0);
>   }
> @@ -779,3 +793,15 @@ ssize_t cpu_show_spectre_v1(struct device *dev, struct device_attribute *attr,
>   {
>   	return sprintf(buf, "Mitigation: __user pointer sanitization\n");
>   }
> +
> +ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr,
> +		char *buf)

w/s issue

Anyway:
Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre.

> +{
> +	if (__spectrev2_safe)
> +		return sprintf(buf, "Not affected\n");
> +
> +	if (__hardenbp_enab)
> +		return sprintf(buf, "Mitigation: Branch predictor hardening\n");
> +
> +	return sprintf(buf, "Vulnerable\n");
> +}
> 
