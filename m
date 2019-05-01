Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9E0C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 11:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A60D321743
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 11:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfEALCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 07:02:15 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58092 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbfEALCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 07:02:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDA5780D;
        Wed,  1 May 2019 04:02:14 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3AC263F719;
        Wed,  1 May 2019 04:02:12 -0700 (PDT)
Subject: Re: [PATCH] arm64: Demote boot and shutdown messages to pr_debug
To:     Mark Rutland <mark.rutland@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        rmk+kernel@armlinux.org.uk, Sudeep Holla <sudeep.holla@arm.com>,
        Suzuki K Poulose <Suzuki.Poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Steve Capper <steve.capper@arm.com>
References: <20190430223835.23513-1-f.fainelli@gmail.com>
 <20190501104733.GB11740@lakrids.cambridge.arm.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <61e61f14-c991-179f-66a9-a98dcee6c10b@arm.com>
Date:   Wed, 1 May 2019 12:02:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190501104733.GB11740@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/05/2019 11:47, Mark Rutland wrote:
> On Tue, Apr 30, 2019 at 03:38:31PM -0700, Florian Fainelli wrote:
>> Similar to commits c68b0274fb3cf ("ARM: reduce "Booted secondary
>> processor" message to debug level") and 035e787543de7 ("ARM: 8644/1: Reduce "CPU:
>> shutdown" message to debug level"), demote the secondary_start_kernel()
>> and __cpu_die() messages from info, respectively notice to debug. While
>> we are at it, also do this for cpu_psci_cpu_kill() which is redundant
>> with __cpu_die().
>>
>> This helps improve the amount of possible hotplug cycles by around +50%
>> on ARCH_BRCMSTB.
> 
> Could you elaborate on why that matters?

Yeah, in general if you have a slow serial console then removing all the 
prints from the kernel makes lots of things much faster, but that's not 
necessarily a good argument for doing so. If that's a problem that 
really concerns users then I'd have to ask why they aren't using a 
stricter loglevel or a different console to begin with.

> e.g. is this just for testing, or does this matter in some shutdown or
> hibernate scenario?
> 
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>   arch/arm64/kernel/psci.c | 2 +-
>>   arch/arm64/kernel/smp.c  | 4 ++--
>>   2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
>> index 8cdaf25e99cd..a78581046c80 100644
>> --- a/arch/arm64/kernel/psci.c
>> +++ b/arch/arm64/kernel/psci.c
>> @@ -96,7 +96,7 @@ static int cpu_psci_cpu_kill(unsigned int cpu)
>>   	for (i = 0; i < 10; i++) {
>>   		err = psci_ops.affinity_info(cpu_logical_map(cpu), 0);
>>   		if (err == PSCI_0_2_AFFINITY_LEVEL_OFF) {
>> -			pr_info("CPU%d killed.\n", cpu);
>> +			pr_debug("CPU%d killed.\n", cpu);
>>   			return 0;
>>   		}
>>   
>> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
>> index 824de7038967..71fd2b5a3f0e 100644
>> --- a/arch/arm64/kernel/smp.c
>> +++ b/arch/arm64/kernel/smp.c
>> @@ -259,7 +259,7 @@ asmlinkage notrace void secondary_start_kernel(void)
>>   	 * the CPU migration code to notice that the CPU is online
>>   	 * before we continue.
>>   	 */
>> -	pr_info("CPU%u: Booted secondary processor 0x%010lx [0x%08x]\n",
>> +	pr_debug("CPU%u: Booted secondary processor 0x%010lx [0x%08x]\n",
>>   					 cpu, (unsigned long)mpidr,
>>   					 read_cpuid_id());
> 
> I generally agree that we don't need to be verbose, and demoting these
> to debug is fine, but it's a shame that these won't be accessible in
> defconfig.
> 
> I wonder if we should enable DYNAMIC_DEBUG so that we can turn these on
> from the kernel command line, or if we should have something like a
> verbose_hotplug option specifically for these messages.

We've had DYNAMIC_DEBUG=y in defconfig for a while already :/

Robin.

> 
> Thanks,
> Mark.
> 
>>   	update_cpu_boot_status(CPU_BOOT_SUCCESS);
>> @@ -348,7 +348,7 @@ void __cpu_die(unsigned int cpu)
>>   		pr_crit("CPU%u: cpu didn't die\n", cpu);
>>   		return;
>>   	}
>> -	pr_notice("CPU%u: shutdown\n", cpu);
>> +	pr_debug("CPU%u: shutdown\n", cpu);
>>   
>>   	/*
>>   	 * Now that the dying CPU is beyond the point of no return w.r.t.
>> -- 
>> 2.17.1
>>
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
