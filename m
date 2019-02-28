Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D093C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E7D82070B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732551AbfB1SZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:25:51 -0500
Received: from foss.arm.com ([217.140.101.70]:52606 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbfB1SZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 13:25:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E93E7EBD;
        Thu, 28 Feb 2019 10:25:49 -0800 (PST)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE48E3F5C1;
        Thu, 28 Feb 2019 10:25:47 -0800 (PST)
Subject: Re: [PATCH v5 01/10] arm64: Provide a command line to disable
 spectre_v2 mitigation
To:     catalin.marinas@arm.com
Cc:     jeremy.linton@arm.com, linux-arm-kernel@lists.infradead.org,
        will.deacon@arm.com, marc.zyngier@arm.com, dave.martin@arm.com,
        shankerd@codeaurora.org, julien.thierry@arm.com,
        mlangsdo@redhat.com, stefan.wahren@i2e.com, andre.przywara@arm.com,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org
References: <20190227010544.597579-1-jeremy.linton@arm.com>
 <20190227010544.597579-2-jeremy.linton@arm.com>
 <a0524741-e17a-a4b1-9d7c-3d001b2b581f@arm.com>
 <20190228182126.GA252518@arrakis.emea.arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <4ff13b4d-217e-38aa-c474-a0f357b1ccfb@arm.com>
Date:   Thu, 28 Feb 2019 18:25:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190228182126.GA252518@arrakis.emea.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/02/2019 18:21, Catalin Marinas wrote:
> On Thu, Feb 28, 2019 at 06:14:34PM +0000, Suzuki K Poulose wrote:
>> On 27/02/2019 01:05, Jeremy Linton wrote:
>>> There are various reasons, including bencmarking, to disable spectrev2
>>> mitigation on a machine. Provide a command-line to do so.
>>>
>>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>>> Cc: Jonathan Corbet <corbet@lwn.net>
>>> Cc: linux-doc@vger.kernel.org
>>
>>
>>> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
>>> index 9950bb0cbd52..d2b2c69d31bb 100644
>>> --- a/arch/arm64/kernel/cpu_errata.c
>>> +++ b/arch/arm64/kernel/cpu_errata.c
>>> @@ -220,6 +220,14 @@ static void qcom_link_stack_sanitization(void)
>>>    		     : "=&r" (tmp));
>>>    }
>>> +static bool __nospectre_v2;
>>> +static int __init parse_nospectre_v2(char *str)
>>> +{
>>> +	__nospectre_v2 = true;
>>> +	return 0;
>>> +}
>>> +early_param("nospectre_v2", parse_nospectre_v2);
>>> +
>>>    static void
>>>    enable_smccc_arch_workaround_1(const struct arm64_cpu_capabilities *entry)
>>>    {
>>> @@ -231,6 +239,11 @@ enable_smccc_arch_workaround_1(const struct arm64_cpu_capabilities *entry)
>>>    	if (!entry->matches(entry, SCOPE_LOCAL_CPU))
>>>    		return;
>>> +	if (__nospectre_v2) {
>>> +		pr_info_once("spectrev2 mitigation disabled by command line option\n");
>>> +		return;
>>> +	}
>>> +
>>
>> Could we not disable the "cap" altogether instead, rather than disabling the
>> work around ? Or do we need that information ?
> 
> There are a few ideas here but I think we settled on always reporting in
> sysfs even if the mitigation is disabled in .config. So I guess we need
> the "cap" around for the reporting part.
> 

Thanks Catalin.

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

