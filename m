Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C97C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 09:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 170172073F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 09:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564393581;
	bh=b+tI6bHDOwG6E+/q3x1v00SGmcoiUnOU93dUmX8r/cA=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=z6x9Vi19TY86mtPB9ulStpeaNuiXEDMDYPoeSGqKO9b5svmutobafUR3m61zi44AE
	 LKxYdI40gmgzD1O2nfTsEPCxAmIXtS/ZvhOnsCUenQwmcnR/6I2yhKEf61nJzLGvEU
	 BfLgl9ycYgbSobM8I9QzCAtgVxfJ3Wm/by6rr9UM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfG2JqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 05:46:19 -0400
Received: from foss.arm.com ([217.140.110.172]:40846 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbfG2JqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 05:46:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D7B8152D;
        Mon, 29 Jul 2019 02:46:18 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF3FB3F694;
        Mon, 29 Jul 2019 02:46:17 -0700 (PDT)
Subject: Re: [PATCH] KVM: arm64: mark expected switch fall-through
To:     Matteo Croce <mcroce@redhat.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
References: <20190728225311.5414-1-mcroce@redhat.com>
From:   Marc Zyngier <maz@kernel.org>
Organization: Approximate
Message-ID: <e14529dd-a517-afcb-24f3-198dc8ebb364@kernel.org>
Date:   Mon, 29 Jul 2019 10:46:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190728225311.5414-1-mcroce@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2019 23:53, Matteo Croce wrote:
> Mark switch cases where we are expecting to fall through,
> fixes the following warning:
> 
> In file included from ./arch/arm64/include/asm/kvm_emulate.h:19,
>                  from arch/arm64/kvm/regmap.c:13:
> arch/arm64/kvm/regmap.c: In function ‘vcpu_write_spsr32’:
> ./arch/arm64/include/asm/kvm_hyp.h:31:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    asm volatile(ALTERNATIVE(__msr_s(r##nvh, "%x0"), \
>    ^~~
> ./arch/arm64/include/asm/kvm_hyp.h:46:31: note: in expansion of macro ‘write_sysreg_elx’
>  #define write_sysreg_el1(v,r) write_sysreg_elx(v, r, _EL1, _EL12)
>                                ^~~~~~~~~~~~~~~~
> arch/arm64/kvm/regmap.c:180:3: note: in expansion of macro ‘write_sysreg_el1’
>    write_sysreg_el1(v, SYS_SPSR);
>    ^~~~~~~~~~~~~~~~
> arch/arm64/kvm/regmap.c:181:2: note: here
>   case KVM_SPSR_ABT:
>   ^~~~
> In file included from ./arch/arm64/include/asm/cputype.h:132,
>                  from ./arch/arm64/include/asm/cache.h:8,
>                  from ./include/linux/cache.h:6,
>                  from ./include/linux/printk.h:9,
>                  from ./include/linux/kernel.h:15,
>                  from ./include/asm-generic/bug.h:18,
>                  from ./arch/arm64/include/asm/bug.h:26,
>                  from ./include/linux/bug.h:5,
>                  from ./include/linux/mmdebug.h:5,
>                  from ./include/linux/mm.h:9,
>                  from arch/arm64/kvm/regmap.c:11:
> ./arch/arm64/include/asm/sysreg.h:837:2: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   asm volatile("msr " __stringify(r) ", %x0"  \
>   ^~~
> arch/arm64/kvm/regmap.c:182:3: note: in expansion of macro ‘write_sysreg’
>    write_sysreg(v, spsr_abt);
>    ^~~~~~~~~~~~
> arch/arm64/kvm/regmap.c:183:2: note: here
>   case KVM_SPSR_UND:
>   ^~~~
> In file included from ./arch/arm64/include/asm/cputype.h:132,
>                  from ./arch/arm64/include/asm/cache.h:8,
>                  from ./include/linux/cache.h:6,
>                  from ./include/linux/printk.h:9,
>                  from ./include/linux/kernel.h:15,
>                  from ./include/asm-generic/bug.h:18,
>                  from ./arch/arm64/include/asm/bug.h:26,
>                  from ./include/linux/bug.h:5,
>                  from ./include/linux/mmdebug.h:5,
>                  from ./include/linux/mm.h:9,
>                  from arch/arm64/kvm/regmap.c:11:
> ./arch/arm64/include/asm/sysreg.h:837:2: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   asm volatile("msr " __stringify(r) ", %x0"  \
>   ^~~
> arch/arm64/kvm/regmap.c:184:3: note: in expansion of macro ‘write_sysreg’
>    write_sysreg(v, spsr_und);
>    ^~~~~~~~~~~~
> arch/arm64/kvm/regmap.c:185:2: note: here
>   case KVM_SPSR_IRQ:
>   ^~~~
> In file included from ./arch/arm64/include/asm/cputype.h:132,
>                  from ./arch/arm64/include/asm/cache.h:8,
>                  from ./include/linux/cache.h:6,
>                  from ./include/linux/printk.h:9,
>                  from ./include/linux/kernel.h:15,
>                  from ./include/asm-generic/bug.h:18,
>                  from ./arch/arm64/include/asm/bug.h:26,
>                  from ./include/linux/bug.h:5,
>                  from ./include/linux/mmdebug.h:5,
>                  from ./include/linux/mm.h:9,
>                  from arch/arm64/kvm/regmap.c:11:
> ./arch/arm64/include/asm/sysreg.h:837:2: warning: this statement may fall through [-Wimplicit-fallthrough=]
>   asm volatile("msr " __stringify(r) ", %x0"  \
>   ^~~
> arch/arm64/kvm/regmap.c:186:3: note: in expansion of macro ‘write_sysreg’
>    write_sysreg(v, spsr_irq);
>    ^~~~~~~~~~~~
> arch/arm64/kvm/regmap.c:187:2: note: here
>   case KVM_SPSR_FIQ:
>   ^~~~
> 
> Signed-off-by: Matteo Croce <mcroce@redhat.com>
> ---
>  arch/arm64/kvm/regmap.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/kvm/regmap.c b/arch/arm64/kvm/regmap.c
> index 0d60e4f0af66..b376b2fdbf51 100644
> --- a/arch/arm64/kvm/regmap.c
> +++ b/arch/arm64/kvm/regmap.c
> @@ -178,12 +178,16 @@ void vcpu_write_spsr32(struct kvm_vcpu *vcpu, unsigned long v)
>  	switch (spsr_idx) {
>  	case KVM_SPSR_SVC:
>  		write_sysreg_el1(v, SYS_SPSR);
> +		/* fallthrough */
>  	case KVM_SPSR_ABT:
>  		write_sysreg(v, spsr_abt);
> +		/* fallthrough */
>  	case KVM_SPSR_UND:
>  		write_sysreg(v, spsr_und);
> +		/* fallthrough */
>  	case KVM_SPSR_IRQ:
>  		write_sysreg(v, spsr_irq);
> +		/* fallthrough */
>  	case KVM_SPSR_FIQ:
>  		write_sysreg(v, spsr_fiq);
>  	}
> 

That's absolutely the *WRONG* fix. Please see [1] for the real thing.

Thanks,

	M.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git/commit/?id=3d584a3c85d6fe2cf878f220d4ad7145e7f89218
-- 
Jazz is not dead, it just smells funny...
