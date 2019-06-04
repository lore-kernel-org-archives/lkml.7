Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146F9C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 10:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCDE3245E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 10:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfFDKfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 06:35:17 -0400
Received: from foss.arm.com ([217.140.101.70]:39978 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726877AbfFDKfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 06:35:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6032980D;
        Tue,  4 Jun 2019 03:35:16 -0700 (PDT)
Received: from [10.37.8.2] (unknown [10.37.8.2])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A3E1A3F246;
        Tue,  4 Jun 2019 03:35:13 -0700 (PDT)
Subject: Re: [PATCH v5 3/3] arm64/fpsimd: Don't disable softirq when touching
 FPSIMD/SVE state
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     ard.biesheuvel@linaro.org, julien.thierry@arm.com,
        marc.zyngier@arm.com, Dave.Martin@arm.com, suzuki.poulose@arm.com,
        will.deacon@arm.com, christoffer.dall@arm.com,
        linux-kernel@vger.kernel.org, james.morse@arm.com,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
References: <20190521172139.21277-1-julien.grall@arm.com>
 <20190521172139.21277-4-julien.grall@arm.com>
 <20190603162534.GF63283@arrakis.emea.arm.com>
 <20190603212104.mhz7vvj7afb2p3yr@mbp>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <5c159919-d220-f8dc-d609-b1b1b2844d4b@arm.com>
Date:   Tue, 4 Jun 2019 11:35:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190603212104.mhz7vvj7afb2p3yr@mbp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

On 6/3/19 10:21 PM, Catalin Marinas wrote:
> On Mon, Jun 03, 2019 at 05:25:34PM +0100, Catalin Marinas wrote:
>> On Tue, May 21, 2019 at 06:21:39PM +0100, Julien Grall wrote:
>>> Since a softirq is supposed to check may_use_simd() anyway before
>>> attempting to use FPSIMD/SVE, there is limited reason to keep softirq
>>> disabled when touching the FPSIMD/SVE context. Instead, we can simply
>>> disable preemption and mark the FPSIMD/SVE context as in use by setting
>>> CPU's fpsimd_context_busy flag.
>> [...]
>>> +static void get_cpu_fpsimd_context(void)
>>> +{
>>> +	preempt_disable();
>>> +	__get_cpu_fpsimd_context();
>>> +}
>>
>> Is there anything that prevents a softirq being invoked between
>> preempt_disable() and __get_cpu_fpsimd_context()?
> 
> Actually, it shouldn't matter as the softirq finishes using the fpsimd
> before the thread is resumed.

If the softirqs is handled in a thread (i.e ksoftirqd), then 
preempt_disable() will prevent them to run.

For softirq running on return from interrupt context, they will finish 
before using fpsimd before the thread is resumed.

Softirq running after __get_cpu_fpsimd_context() is called will not be 
able to use FPSIMD (may_use_simd() returns false).

Cheers,

-- 
Julien Grall
