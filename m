Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44634CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2039A21D81
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390478AbfJWIiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 04:38:51 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2433 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389913AbfJWIiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 04:38:51 -0400
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id C961B789A126E53FB2EE;
        Wed, 23 Oct 2019 16:38:49 +0800 (CST)
Received: from dggeme754-chm.china.huawei.com (10.3.19.100) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 23 Oct 2019 16:38:49 +0800
Received: from [127.0.0.1] (10.184.212.80) by dggeme754-chm.china.huawei.com
 (10.3.19.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 23
 Oct 2019 16:38:48 +0800
From:   "liwei (GF)" <liwei391@huawei.com>
Subject: Re: [PATCH v3 1/2] arm64: Relax ICC_PMR_EL1 accesses when
 ICC_CTLR_EL1.PMHE is clear
To:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>
CC:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        <huawei.libin@huawei.com>, <guohanjun@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20191002090613.14236-1-maz@kernel.org>
 <20191002090613.14236-2-maz@kernel.org>
Message-ID: <ad164b94-06af-ffe7-b8ff-317b4078b1a5@huawei.com>
Date:   Wed, 23 Oct 2019 16:38:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191002090613.14236-2-maz@kernel.org>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.212.80]
X-ClientProxiedBy: dggeme712-chm.china.huawei.com (10.1.199.108) To
 dggeme754-chm.china.huawei.com (10.3.19.100)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 2019/10/2 17:06, Marc Zyngier wrote:
> The GICv3 architecture specification is incredibly misleading when it
> comes to PMR and the requirement for a DSB. It turns out that this DSB
> is only required if the CPU interface sends an Upstream Control
> message to the redistributor in order to update the RD's view of PMR.
> 
> This message is only sent when ICC_CTLR_EL1.PMHE is set, which isn't
> the case in Linux. It can still be set from EL3, so some special care
> is required. But the upshot is that in the (hopefuly large) majority
> of the cases, we can drop the DSB altogether.
> 
> This relies on a new static key being set if the boot CPU has PMHE
> set. The drawback is that this static key has to be exported to
> modules.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: James Morse <james.morse@arm.com>
> Cc: Julien Thierry <julien.thierry.kdev@gmail.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/include/asm/barrier.h   | 12 ++++++++++++
>  arch/arm64/include/asm/daifflags.h |  3 ++-
>  arch/arm64/include/asm/irqflags.h  | 19 ++++++++++---------
>  arch/arm64/include/asm/kvm_host.h  |  3 +--
>  arch/arm64/kernel/entry.S          |  6 ++++--
>  arch/arm64/kvm/hyp/switch.c        |  4 ++--
>  drivers/irqchip/irq-gic-v3.c       | 20 ++++++++++++++++++++
>  include/linux/irqchip/arm-gic-v3.h |  2 ++
>  8 files changed, 53 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
> index e0e2b1946f42..7d9cc5ec4971 100644
> --- a/arch/arm64/include/asm/barrier.h
> +++ b/arch/arm64/include/asm/barrier.h
> @@ -29,6 +29,18 @@
>  						 SB_BARRIER_INSN"nop\n",	\
>  						 ARM64_HAS_SB))
>  
> +#ifdef CONFIG_ARM64_PSEUDO_NMI
> +#define pmr_sync()						\
> +	do {							\
> +		extern struct static_key_false gic_pmr_sync;	\
> +								\
> +		if (static_branch_unlikely(&gic_pmr_sync))	\
> +			dsb(sy);				\
> +	} while(0)
> +#else
> +#define pmr_sync()	do {} while (0)
> +#endif
> +

Thank you for solving this problem, it helps a lot indeed.

The pmr_sync() will call dsb(sy) when ARM64_PSEUDO_NMI=y and gic_pmr_sync=force,
but if pseudo nmi is not enabled through boot option, it just take one more
redundant calling than before at the following two place.

I think change dsb(sy) to
+                       asm volatile(ALTERNATIVE("nop", "dsb sy",       \
+                               ARM64_HAS_IRQ_PRIO_MASKING)     \
+                               : : : "memory");                \
may be more appropriate.

Thanks,
Wei

>  
> @@ -34,14 +35,14 @@ static inline void arch_local_irq_enable(void)
>  	}
>  
>  	asm volatile(ALTERNATIVE(
> -		"msr	daifclr, #2		// arch_local_irq_enable\n"
> -		"nop",
> -		__msr_s(SYS_ICC_PMR_EL1, "%0")
> -		"dsb	sy",
> +		"msr	daifclr, #2		// arch_local_irq_enable",
> +		__msr_s(SYS_ICC_PMR_EL1, "%0"),
>  		ARM64_HAS_IRQ_PRIO_MASKING)
>  		:
>  		: "r" ((unsigned long) GIC_PRIO_IRQON)
>  		: "memory");
> +
> +	pmr_sync();
>  }
>  
>  static inline void arch_local_irq_disable(void)
> @@ -116,14 +117,14 @@ static inline unsigned long arch_local_irq_save(void)
>  static inline void arch_local_irq_restore(unsigned long flags)
>  {
>  	asm volatile(ALTERNATIVE(
> -			"msr	daif, %0\n"
> -			"nop",
> -			__msr_s(SYS_ICC_PMR_EL1, "%0")
> -			"dsb	sy",
> -			ARM64_HAS_IRQ_PRIO_MASKING)
> +		"msr	daif, %0",
> +		__msr_s(SYS_ICC_PMR_EL1, "%0"),
> +		ARM64_HAS_IRQ_PRIO_MASKING)
>  		:
>  		: "r" (flags)
>  		: "memory");
> +
> +	pmr_sync();
>  }
>  

