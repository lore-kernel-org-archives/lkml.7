Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFA5C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7036206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfDZPGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:06:06 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43860 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbfDZPGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:06:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F74980D;
        Fri, 26 Apr 2019 08:06:05 -0700 (PDT)
Received: from [10.1.196.50] (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD28C3F5C1;
        Fri, 26 Apr 2019 08:06:03 -0700 (PDT)
Subject: Re: [PATCH v4 3/3] arm64/fpsimd: Don't disable softirq when touching
 FPSIMD/SVE state
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ard.biesheuvel@linaro.org, julien.thierry@arm.com,
        marc.zyngier@arm.com, catalin.marinas@arm.com,
        suzuki.poulose@arm.com, will.deacon@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com
References: <20190426143740.31973-1-julien.grall@arm.com>
 <20190426143740.31973-4-julien.grall@arm.com>
 <20190426145232.GK3567@e103592.cambridge.arm.com>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <322340c7-0c97-76f8-8ab8-875040b4459c@arm.com>
Date:   Fri, 26 Apr 2019 16:06:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190426145232.GK3567@e103592.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26/04/2019 15:52, Dave Martin wrote:
> On Fri, Apr 26, 2019 at 03:37:40PM +0100, Julien Grall wrote:
>> When the kernel is compiled with CONFIG_KERNEL_MODE_NEON, some part of
>> the kernel may be able to use FPSIMD/SVE. This is for instance the case
>> for crypto code.
>>
>> Any use of FPSIMD/SVE in the kernel are clearly marked by using the
>> function kernel_neon_{begin, end}. Furthermore, this can only be used
>> when may_use_simd() returns true.
>>
>> The current implementation of may_use_simd() allows softirq to use
>> FPSIMD/SVE unless it is currently in use (i.e kernel_neon_busy is true).
>> When in use, softirqs usually fall back to a software method.
>>
>> At the moment, as a softirq may use FPSIMD/SVE, softirqs are disabled
>> when touching the FPSIMD/SVE context. This has the drawback to disable
>> all softirqs even if they are not using FPSIMD/SVE.
>>
>> Since a softirq is supposed to check may_use_simd() anyway before
>> attempting to use FPSIMD/SVE, there is limited reason to keep softirq
>> disabled when touching the FPSIMD/SVE context. Instead, we can simply
>> disable preemption and mark the FPSIMD/SVE context as in use by setting
>> CPU's kernel_neon_busy flag.
> 
> fpsimd_context_busy?

Yes.

> 
>> Two new helpers {get, put}_cpu_fpsimd_context is introduced to mark the
>> area using FPSIMD/SVE context and uses them in replacement of
> 
> Paragraph mangled during edit?

Possibly, I will update it.

> 
> -> "are introduced ... and they are used to replace ..."
> 
>> local_bh_{disable, enable}. The functions kernel_neon_{begin, end} are
>> also re-implemented to use the new helpers.
>>
>> Additionally, double-underscored versions of the helpers are provided to
>> be used in function called with interrupt masked. They are used for
>> sanity and also help to mark place where the FPSIMD context can be
>> manipulate freely.
> 
> For the benefit of other readers, this should be more explicit.  Also,
> the distinction between the normal and __ helpers is that the latter
> can be caller with preemption disabled.
> 
> To clarify the impact, we can say something like
> 
> "These are only relevant on paths where irqs are disabled anyway, so
> they are not needed for correctness in the current code. Let's use them
> anyway though: this marks the critical sections clearly and will help
> to avoid mistakes during future maintenance."

How about the following commit message?

     arm64/fpsimd: Don't disable softirq when touching FPSIMD/SVE state

     When the kernel is compiled with CONFIG_KERNEL_MODE_NEON, some part of
     the kernel may be able to use FPSIMD/SVE. This is for instance the case
     for crypto code.

     Any use of FPSIMD/SVE in the kernel are clearly marked by using the
     function kernel_neon_{begin, end}. Furthermore, this can only be used
     when may_use_simd() returns true.

     The current implementation of may_use_simd() allows softirq to use
     FPSIMD/SVE unless it is currently in use (i.e kernel_neon_busy is true).
     When in use, softirqs usually fall back to a software method.

     At the moment, as a softirq may use FPSIMD/SVE, softirqs are disabled
     when touching the FPSIMD/SVE context. This has the drawback to disable
     all softirqs even if they are not using FPSIMD/SVE.

     Since a softirq is supposed to check may_use_simd() anyway before
     attempting to use FPSIMD/SVE, there is limited reason to keep softirq
     disabled when touching the FPSIMD/SVE context. Instead, we can simply
     disable preemption and mark the FPSIMD/SVE context as in use by setting
     CPU's fpsimd_context_busy flag.

     Two new helpers {get, put}_cpu_fpsimd_context are introduced to mark
     the area using FPSIMD/SVE context and they are used to replace
     local_bh_{disable, enable}. The functions kernel_neon_{begin, end} are
     also re-implemented to use the new helpers.

     Additionally, double-underscored versions of the helpers are provided to
     called when preemption is already disabled. These are only relevant on
     paths where irqs are disabled anyway, so they are not needed for
     correctness in the current code. Let's use them anyway though: this
     marks critical sections clearly and will help to avoid mistakes during
     future maintenance.

     The change has been benchmarked on Linux 5.1-rc4 with defconfig.

     On Juno2:
         * hackbench 100 process 1000 (10 times)
         * .7% quicker

     On ThunderX 2:
         * hackbench 1000 process 1000 (20 times)
         * 3.4% quicker

> 
> [...]
> 
> (Sorry to nitpick)

That's fine, I should have be more careful when rework the commit message.

Cheers,

-- 
Julien Grall
