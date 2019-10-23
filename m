Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399D6CA9EB7
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0951520640
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571832804;
	bh=q0HB093G8YTHpPgkMrbu29RHoKgtWViq73a6cQtM7Hw=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=16LrXliIcoH03o75hsUtueUO+Vn8eGKGXcS1Ye6Nye0x4P1Ch3ZLx75ACx5dvS2Zs
	 R8+qfOCreMAIymfR/+5MzhCByUc0IO6oLqxA1TfzL+Cflt/dUhn6q4udQccL9qaLwI
	 CU1spbPWcma5jUsQebiXpWtkvO6mw1NRYNqxRYXs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391226AbfJWMNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 08:13:23 -0400
Received: from inca-roads.misterjones.org ([213.251.177.50]:49339 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726925AbfJWMNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:13:22 -0400
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iNFVq-0001TZ-BF; Wed, 23 Oct 2019 14:13:14 +0200
To:     "liwei (GF)" <liwei391@huawei.com>
Subject: Re: [PATCH v3 1/2] arm64: Relax =?UTF-8?Q?ICC=5FPMR=5FEL=31=20acc?=  =?UTF-8?Q?esses=20when=20ICC=5FCTLR=5FEL=31=2EPMHE=20is=20clear?=
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 23 Oct 2019 13:13:14 +0100
From:   Marc Zyngier <maz@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        <huawei.libin@huawei.com>, <guohanjun@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <ad164b94-06af-ffe7-b8ff-317b4078b1a5@huawei.com>
References: <20191002090613.14236-1-maz@kernel.org>
 <20191002090613.14236-2-maz@kernel.org>
 <ad164b94-06af-ffe7-b8ff-317b4078b1a5@huawei.com>
Message-ID: <4ed2ed389a81cc0ec6f3150ce38517a5@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: liwei391@huawei.com, will@kernel.org, catalin.marinas@arm.com, suzuki.poulose@arm.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, huawei.libin@huawei.com, guohanjun@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei,

On 2019-10-23 09:38, liwei (GF) wrote:
> Hi Marc,
>
> On 2019/10/2 17:06, Marc Zyngier wrote:
>> The GICv3 architecture specification is incredibly misleading when 
>> it
>> comes to PMR and the requirement for a DSB. It turns out that this 
>> DSB
>> is only required if the CPU interface sends an Upstream Control
>> message to the redistributor in order to update the RD's view of 
>> PMR.
>>
>> This message is only sent when ICC_CTLR_EL1.PMHE is set, which isn't
>> the case in Linux. It can still be set from EL3, so some special 
>> care
>> is required. But the upshot is that in the (hopefuly large) majority
>> of the cases, we can drop the DSB altogether.
>>
>> This relies on a new static key being set if the boot CPU has PMHE
>> set. The drawback is that this static key has to be exported to
>> modules.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: James Morse <james.morse@arm.com>
>> Cc: Julien Thierry <julien.thierry.kdev@gmail.com>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> ---
>>  arch/arm64/include/asm/barrier.h   | 12 ++++++++++++
>>  arch/arm64/include/asm/daifflags.h |  3 ++-
>>  arch/arm64/include/asm/irqflags.h  | 19 ++++++++++---------
>>  arch/arm64/include/asm/kvm_host.h  |  3 +--
>>  arch/arm64/kernel/entry.S          |  6 ++++--
>>  arch/arm64/kvm/hyp/switch.c        |  4 ++--
>>  drivers/irqchip/irq-gic-v3.c       | 20 ++++++++++++++++++++
>>  include/linux/irqchip/arm-gic-v3.h |  2 ++
>>  8 files changed, 53 insertions(+), 16 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/barrier.h 
>> b/arch/arm64/include/asm/barrier.h
>> index e0e2b1946f42..7d9cc5ec4971 100644
>> --- a/arch/arm64/include/asm/barrier.h
>> +++ b/arch/arm64/include/asm/barrier.h
>> @@ -29,6 +29,18 @@
>>  						 SB_BARRIER_INSN"nop\n",	\
>>  						 ARM64_HAS_SB))
>>
>> +#ifdef CONFIG_ARM64_PSEUDO_NMI
>> +#define pmr_sync()						\
>> +	do {							\
>> +		extern struct static_key_false gic_pmr_sync;	\
>> +								\
>> +		if (static_branch_unlikely(&gic_pmr_sync))	\
>> +			dsb(sy);				\
>> +	} while(0)
>> +#else
>> +#define pmr_sync()	do {} while (0)
>> +#endif
>> +
>
> Thank you for solving this problem, it helps a lot indeed.
>
> The pmr_sync() will call dsb(sy) when ARM64_PSEUDO_NMI=y and
> gic_pmr_sync=force,
> but if pseudo nmi is not enabled through boot option, it just take 
> one more
> redundant calling than before at the following two place.
>
> I think change dsb(sy) to
> +                       asm volatile(ALTERNATIVE("nop", "dsb sy",     
>  \
> +                               ARM64_HAS_IRQ_PRIO_MASKING)     \
> +                               : : : "memory");                \
> may be more appropriate.

I'm not sure I understand what you mean. The static key defaults to 
false,
so if pseudo_nmi is not enabled, this dsb(sy) is simply never executed.

Am I missing something obvious?

Thanks,

         M.

>
> Thanks,
> Wei
>
>>
>> @@ -34,14 +35,14 @@ static inline void arch_local_irq_enable(void)
>>  	}
>>
>>  	asm volatile(ALTERNATIVE(
>> -		"msr	daifclr, #2		// arch_local_irq_enable\n"
>> -		"nop",
>> -		__msr_s(SYS_ICC_PMR_EL1, "%0")
>> -		"dsb	sy",
>> +		"msr	daifclr, #2		// arch_local_irq_enable",
>> +		__msr_s(SYS_ICC_PMR_EL1, "%0"),
>>  		ARM64_HAS_IRQ_PRIO_MASKING)
>>  		:
>>  		: "r" ((unsigned long) GIC_PRIO_IRQON)
>>  		: "memory");
>> +
>> +	pmr_sync();
>>  }
>>
>>  static inline void arch_local_irq_disable(void)
>> @@ -116,14 +117,14 @@ static inline unsigned long 
>> arch_local_irq_save(void)
>>  static inline void arch_local_irq_restore(unsigned long flags)
>>  {
>>  	asm volatile(ALTERNATIVE(
>> -			"msr	daif, %0\n"
>> -			"nop",
>> -			__msr_s(SYS_ICC_PMR_EL1, "%0")
>> -			"dsb	sy",
>> -			ARM64_HAS_IRQ_PRIO_MASKING)
>> +		"msr	daif, %0",
>> +		__msr_s(SYS_ICC_PMR_EL1, "%0"),
>> +		ARM64_HAS_IRQ_PRIO_MASKING)
>>  		:
>>  		: "r" (flags)
>>  		: "memory");
>> +
>> +	pmr_sync();
>>  }
>>

-- 
Jazz is not dead. It just smells funny...
