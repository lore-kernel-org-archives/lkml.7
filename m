Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A54C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 06:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE4552084F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 06:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbfCAG6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 01:58:23 -0500
Received: from foss.arm.com ([217.140.101.70]:58620 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfCAG6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 01:58:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DEF36EBD;
        Thu, 28 Feb 2019 22:58:22 -0800 (PST)
Received: from [172.20.0.134] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D7653F5C1;
        Thu, 28 Feb 2019 22:58:21 -0800 (PST)
Subject: Re: [PATCH v5 05/10] arm64: Use firmware to detect CPUs that are not
 affected by Spectre-v2
To:     Jeremy Linton <jeremy.linton@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, marc.zyngier@arm.com,
        suzuki.poulose@arm.com, Dave.Martin@arm.com,
        shankerd@codeaurora.org, julien.thierry@arm.com,
        mlangsdo@redhat.com, stefan.wahren@i2e.com,
        linux-kernel@vger.kernel.org
References: <20190227010544.597579-1-jeremy.linton@arm.com>
 <20190227010544.597579-6-jeremy.linton@arm.com>
From:   Andre Przywara <andre.przywara@arm.com>
Message-ID: <e1df235f-bcdd-62f0-7b2f-e396df6d9bae@foss.arm.com>
Date:   Fri, 1 Mar 2019 00:58:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190227010544.597579-6-jeremy.linton@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/26/19 7:05 PM, Jeremy Linton wrote:
> From: Marc Zyngier <marc.zyngier@arm.com>
> 
> The SMCCC ARCH_WORKAROUND_1 service can indicate that although the
> firmware knows about the Spectre-v2 mitigation, this particular
> CPU is not vulnerable, and it is thus not necessary to call
> the firmware on this CPU.
> 
> Let's use this information to our benefit.

Yes, that matches the firmware interface description.

> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre.

> ---
>   arch/arm64/kernel/cpu_errata.c | 32 +++++++++++++++++++++++---------
>   1 file changed, 23 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index c8972255b365..77f021e78a28 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -230,22 +230,36 @@ static int detect_harden_bp_fw(void)
>   	case PSCI_CONDUIT_HVC:
>   		arm_smccc_1_1_hvc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
>   				  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
> -		if ((int)res.a0 < 0)
> +		switch ((int)res.a0) {
> +		case 1:
> +			/* Firmware says we're just fine */
> +			return 0;
> +		case 0:
> +			cb = call_hvc_arch_workaround_1;
> +			/* This is a guest, no need to patch KVM vectors */
> +			smccc_start = NULL;
> +			smccc_end = NULL;
> +			break;
> +		default:
>   			return -1;
> -		cb = call_hvc_arch_workaround_1;
> -		/* This is a guest, no need to patch KVM vectors */
> -		smccc_start = NULL;
> -		smccc_end = NULL;
> +		}
>   		break;
>   
>   	case PSCI_CONDUIT_SMC:
>   		arm_smccc_1_1_smc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
>   				  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
> -		if ((int)res.a0 < 0)
> +		switch ((int)res.a0) {
> +		case 1:
> +			/* Firmware says we're just fine */
> +			return 0;
> +		case 0:
> +			cb = call_smc_arch_workaround_1;
> +			smccc_start = __smccc_workaround_1_smc_start;
> +			smccc_end = __smccc_workaround_1_smc_end;
> +			break;
> +		default:
>   			return -1;
> -		cb = call_smc_arch_workaround_1;
> -		smccc_start = __smccc_workaround_1_smc_start;
> -		smccc_end = __smccc_workaround_1_smc_end;
> +		}
>   		break;
>   
>   	default:
> 
