Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D75C282E3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81439206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfDYMho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:37:44 -0400
Received: from foss.arm.com ([217.140.101.70]:42884 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbfDYMho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:37:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C93D015A2;
        Thu, 25 Apr 2019 05:37:43 -0700 (PDT)
Received: from [10.1.196.50] (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E82EB3F5C1;
        Thu, 25 Apr 2019 05:37:41 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] arch/arm64: fpsimd: Introduce
 fpsimd_save_and_flush_cpu_state() and use it
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ard.biesheuvel@linaro.org, julien.thierry@arm.com,
        marc.zyngier@arm.com, catalin.marinas@arm.com,
        suzuki.poulose@arm.com, will.deacon@arm.com,
        christoffer.dall@arm.com, james.morse@arm.com
References: <20190423135719.11306-1-julien.grall@arm.com>
 <20190423135719.11306-3-julien.grall@arm.com>
 <20190424131719.GS3567@e103592.cambridge.arm.com>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <97a49fad-380b-4494-9722-03857441ffe5@arm.com>
Date:   Thu, 25 Apr 2019 13:37:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424131719.GS3567@e103592.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On 24/04/2019 14:17, Dave Martin wrote:
> On Tue, Apr 23, 2019 at 02:57:18PM +0100, Julien Grall wrote:
>> tent-Length: 4295
>> Lines: 128
>>
>> The only external user of fpsimd_save() and fpsimd_flush_cpu_state() is
>> the KVM FPSIMD code.
>>
>> A following patch will introduce a mechanism to acquire owernship of the
>> FPSIMD/SVE context for performing context management operations. Rather
>> than having to export the new helpers to get/put the context, we can just
>> introduce a new function to combine fpsimd_save() and
>> fpsimd_flush_cpu_state().
>>
>> This has also the advantage to remove any external call of fpsimd_save()
>> and fpsimd_flush_cpu_state(), so they can be turned static.
>>
>> Lastly, the new function can also be used in the PM notifier.
>>
>> Signed-off-by: Julien Grall <julien.grall@arm.com>
>>
>> ---
>>      kernel_neon_begin() does not use fpsimd_save_and_flush_cpu_state()
>>      because the next patch will modify the function to also grab the
>>      FPSIMD/SVE context.
>>
>>      Changes in v3:
>>          - Rework the commit message
>>          - Move the prototype of fpsimd_save_and_flush_cpu_state()
>>          further down in the header
>>          - Remove comment in kvm_arch_vcpu_put_fp()
>>
>>      Changes in v2:
>>          - Patch added
>> ---
>>   arch/arm64/include/asm/fpsimd.h |  5 ++---
>>   arch/arm64/kernel/fpsimd.c      | 17 +++++++++++++----
>>   arch/arm64/kvm/fpsimd.c         |  4 +---
>>   3 files changed, 16 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
>> index b73d12fcc7f9..c311d36ecffe 100644
>> --- a/arch/arm64/include/asm/fpsimd.h
>> +++ b/arch/arm64/include/asm/fpsimd.h
>> @@ -48,8 +48,6 @@ struct task_struct;
>>   extern void fpsimd_save_state(struct user_fpsimd_state *state);
>>   extern void fpsimd_load_state(struct user_fpsimd_state *state);
>>   
>> -extern void fpsimd_save(void);
>> -
>>   extern void fpsimd_thread_switch(struct task_struct *next);
>>   extern void fpsimd_flush_thread(void);
>>   
>> @@ -63,7 +61,8 @@ extern void fpsimd_bind_state_to_cpu(struct user_fpsimd_state *state,
>>   				     void *sve_state, unsigned int sve_vl);
>>   
>>   extern void fpsimd_flush_task_state(struct task_struct *target);
>> -extern void fpsimd_flush_cpu_state(void);
>> +
>> +extern void fpsimd_save_and_flush_cpu_state(void);
> 
> Nit: You could drop this blank line: these are all "state maintenance"
> operations, roughly speaking.
> 
> But don't bother unless you respin for some other reason.

It looks like I will need to make some changes in patch #3. So I will remove the 
line at the same time.

> 
> [...]
> 
> With or without that,
> 
> Reviewed-by: Dave Martin <Dave.Martin@arm.com>

Thank you!

Cheers,

-- 
Julien Grall
