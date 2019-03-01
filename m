Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8561C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 06:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FBD42186A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 06:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfCAGy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 01:54:29 -0500
Received: from foss.arm.com ([217.140.101.70]:58474 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbfCAGy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 01:54:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EFDCEBD;
        Thu, 28 Feb 2019 22:54:28 -0800 (PST)
Received: from [172.20.0.134] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A8A23F5C1;
        Thu, 28 Feb 2019 22:54:27 -0800 (PST)
Subject: Re: [PATCH v5 01/10] arm64: Provide a command line to disable
 spectre_v2 mitigation
To:     Jeremy Linton <jeremy.linton@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, marc.zyngier@arm.com,
        suzuki.poulose@arm.com, Dave.Martin@arm.com,
        shankerd@codeaurora.org, julien.thierry@arm.com,
        mlangsdo@redhat.com, stefan.wahren@i2e.com,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
References: <20190227010544.597579-1-jeremy.linton@arm.com>
 <20190227010544.597579-2-jeremy.linton@arm.com>
From:   Andre Przywara <andre.przywara@arm.com>
Message-ID: <c993f3c5-a2c1-98c8-7b63-2c7b22aeeb23@foss.arm.com>
Date:   Fri, 1 Mar 2019 00:54:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190227010544.597579-2-jeremy.linton@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/26/19 7:05 PM, Jeremy Linton wrote:
> There are various reasons, including bencmarking, to disable spectrev2
> mitigation on a machine. Provide a command-line to do so.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre.

> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>   Documentation/admin-guide/kernel-parameters.txt |  8 ++++----
>   arch/arm64/kernel/cpu_errata.c                  | 13 +++++++++++++
>   2 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 858b6c0b9a15..4d4d6a9537ae 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2842,10 +2842,10 @@
>   			check bypass). With this option data leaks are possible
>   			in the system.
>   
> -	nospectre_v2	[X86,PPC_FSL_BOOK3E] Disable all mitigations for the Spectre variant 2
> -			(indirect branch prediction) vulnerability. System may
> -			allow data leaks with this option, which is equivalent
> -			to spectre_v2=off.
> +	nospectre_v2	[X86,PPC_FSL_BOOK3E,ARM64] Disable all mitigations for
> +			the Spectre variant 2 (indirect branch prediction)
> +			vulnerability. System may allow data leaks with this
> +			option.
>   
>   	nospec_store_bypass_disable
>   			[HW] Disable all mitigations for the Speculative Store Bypass vulnerability
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index 9950bb0cbd52..d2b2c69d31bb 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -220,6 +220,14 @@ static void qcom_link_stack_sanitization(void)
>   		     : "=&r" (tmp));
>   }
>   
> +static bool __nospectre_v2;
> +static int __init parse_nospectre_v2(char *str)
> +{
> +	__nospectre_v2 = true;
> +	return 0;
> +}
> +early_param("nospectre_v2", parse_nospectre_v2);
> +
>   static void
>   enable_smccc_arch_workaround_1(const struct arm64_cpu_capabilities *entry)
>   {
> @@ -231,6 +239,11 @@ enable_smccc_arch_workaround_1(const struct arm64_cpu_capabilities *entry)
>   	if (!entry->matches(entry, SCOPE_LOCAL_CPU))
>   		return;
>   
> +	if (__nospectre_v2) {
> +		pr_info_once("spectrev2 mitigation disabled by command line option\n");
> +		return;
> +	}
> +
>   	if (psci_ops.smccc_version == SMCCC_VERSION_1_0)
>   		return;
>   
> 
