Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D532C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 11:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D59520663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 11:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576151035;
	bh=qPXUENaXmxO/rCa+6s1+YTi6pnox2/cBw4zCaYCcn+M=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=OgkTCnoLLAsTtbM9nrufmOGbj+f4LLRw/xG8wHDSn3vYH9kFvGyXd6lvZw/k2SX0g
	 BEiEL9EJZWhV/Fb41YbeDkCG4ozNkoi0cywVpl4tHCNbtvGWpnCgzaLBad11L98SAQ
	 Z5v/4caTqmKoRubvcgeyu+2BMAWHMvzRtr53J0kw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbfLLLny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 06:43:54 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:45000 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726492AbfLLLnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 06:43:53 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1ifMsn-0000U9-7R; Thu, 12 Dec 2019 12:43:49 +0100
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH] arm64: Introduce ISAR6 CPU ID register
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 12 Dec 2019 11:43:48 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        <linux-kernel@vger.kernel.org>, Will Deacon <will@kernel.org>,
        <kvmarm@lists.cs.columbia.edu>
In-Reply-To: <1576145663-9909-1-git-send-email-anshuman.khandual@arm.com>
References: <1576145663-9909-1-git-send-email-anshuman.khandual@arm.com>
Message-ID: <bdb9e0149de9d2a5020ddbdd8a4033b3@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, linux-kernel@vger.kernel.org, will@kernel.org, kvmarm@lists.cs.columbia.edu
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-12 10:14, Anshuman Khandual wrote:
> This adds basic building blocks required for ISAR6 CPU ID register 
> which
> identifies support for various instruction implementation on AArch32 
> state.

nit: the register name is ID_ISAR6.

>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: James Morse <james.morse@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: kvmarm@lists.cs.columbia.edu
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/arm64/include/asm/cpu.h    | 1 +
>  arch/arm64/include/asm/sysreg.h | 9 +++++++++
>  arch/arm64/kernel/cpufeature.c  | 7 ++++++-
>  arch/arm64/kernel/cpuinfo.c     | 1 +
>  arch/arm64/kvm/sys_regs.c       | 2 +-
>  5 files changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/include/asm/cpu.h 
> b/arch/arm64/include/asm/cpu.h
> index d72d995..b4a4053 100644
> --- a/arch/arm64/include/asm/cpu.h
> +++ b/arch/arm64/include/asm/cpu.h
> @@ -39,6 +39,7 @@ struct cpuinfo_arm64 {
>  	u32		reg_id_isar3;
>  	u32		reg_id_isar4;
>  	u32		reg_id_isar5;
> +	u32		reg_id_isar6;
>  	u32		reg_id_mmfr0;
>  	u32		reg_id_mmfr1;
>  	u32		reg_id_mmfr2;
> diff --git a/arch/arm64/include/asm/sysreg.h
> b/arch/arm64/include/asm/sysreg.h
> index 6db3a9b..4fd3327 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -146,6 +146,7 @@
>  #define SYS_ID_ISAR4_EL1		sys_reg(3, 0, 0, 2, 4)
>  #define SYS_ID_ISAR5_EL1		sys_reg(3, 0, 0, 2, 5)
>  #define SYS_ID_MMFR4_EL1		sys_reg(3, 0, 0, 2, 6)
> +#define SYS_ID_ISAR6_EL1		sys_reg(3, 0, 0, 2, 7)
>
>  #define SYS_MVFR0_EL1			sys_reg(3, 0, 0, 3, 0)
>  #define SYS_MVFR1_EL1			sys_reg(3, 0, 0, 3, 1)
> @@ -683,6 +684,14 @@
>  #define ID_ISAR5_AES_SHIFT		4
>  #define ID_ISAR5_SEVL_SHIFT		0
>
> +#define ID_ISAR6_JSCVT_SHIFT		0
> +#define ID_ISAR6_DP_SHIFT		4
> +#define ID_ISAR6_FHM_SHIFT		8
> +#define ID_ISAR6_SB_SHIFT		12
> +#define ID_ISAR6_SPECRES_SHIFT		16
> +#define ID_ISAR6_BF16_SHIFT		20
> +#define ID_ISAR6_I8MM_SHIFT		24

I couldn't find the last two items in the E.a revision of the ARMv8 
ARM.
I guess they are for post 8.5 revisions of the architecture?

> +
>  #define MVFR0_FPROUND_SHIFT		28
>  #define MVFR0_FPSHVEC_SHIFT		24
>  #define MVFR0_FPSQRT_SHIFT		20
> diff --git a/arch/arm64/kernel/cpufeature.c 
> b/arch/arm64/kernel/cpufeature.c
> index f344cea..3b9ac8b 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -346,7 +346,7 @@ static const struct arm64_ftr_bits ftr_zcr[] = {
>   * Common ftr bits for a 32bit register with all hidden, strict
>   * attributes, with 4bit feature fields and a default safe value of
>   * 0. Covers the following 32bit registers:
> - * id_isar[0-4], id_mmfr[1-3], id_pfr1, mvfr[0-1]
> + * id_isar[0-4, 6], id_mmfr[1-3], id_pfr1, mvfr[0-1]
>   */
>  static const struct arm64_ftr_bits ftr_generic_32bits[] = {
>  	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 28, 4, 0),
> @@ -399,6 +399,7 @@ static const struct __ftr_reg_entry {
>  	ARM64_FTR_REG(SYS_ID_ISAR4_EL1, ftr_generic_32bits),
>  	ARM64_FTR_REG(SYS_ID_ISAR5_EL1, ftr_id_isar5),
>  	ARM64_FTR_REG(SYS_ID_MMFR4_EL1, ftr_id_mmfr4),
> +	ARM64_FTR_REG(SYS_ID_ISAR6_EL1, ftr_generic_32bits),
>
>  	/* Op1 = 0, CRn = 0, CRm = 3 */
>  	ARM64_FTR_REG(SYS_MVFR0_EL1, ftr_generic_32bits),
> @@ -603,6 +604,7 @@ void __init init_cpu_features(struct 
> cpuinfo_arm64 *info)
>  		init_cpu_ftr_reg(SYS_ID_ISAR3_EL1, info->reg_id_isar3);
>  		init_cpu_ftr_reg(SYS_ID_ISAR4_EL1, info->reg_id_isar4);
>  		init_cpu_ftr_reg(SYS_ID_ISAR5_EL1, info->reg_id_isar5);
> +		init_cpu_ftr_reg(SYS_ID_ISAR6_EL1, info->reg_id_isar6);
>  		init_cpu_ftr_reg(SYS_ID_MMFR0_EL1, info->reg_id_mmfr0);
>  		init_cpu_ftr_reg(SYS_ID_MMFR1_EL1, info->reg_id_mmfr1);
>  		init_cpu_ftr_reg(SYS_ID_MMFR2_EL1, info->reg_id_mmfr2);
> @@ -756,6 +758,8 @@ void update_cpu_features(int cpu,
>  					info->reg_id_isar4, boot->reg_id_isar4);
>  		taint |= check_update_ftr_reg(SYS_ID_ISAR5_EL1, cpu,
>  					info->reg_id_isar5, boot->reg_id_isar5);
> +		taint |= check_update_ftr_reg(SYS_ID_ISAR6_EL1, cpu,
> +					info->reg_id_isar6, boot->reg_id_isar6);
>
>  		/*
>  		 * Regardless of the value of the AuxReg field, the AIFSR, ADFSR, 
> and
> @@ -834,6 +838,7 @@ static u64 __read_sysreg_by_encoding(u32 sys_id)
>  	read_sysreg_case(SYS_ID_ISAR3_EL1);
>  	read_sysreg_case(SYS_ID_ISAR4_EL1);
>  	read_sysreg_case(SYS_ID_ISAR5_EL1);
> +	read_sysreg_case(SYS_ID_ISAR6_EL1);
>  	read_sysreg_case(SYS_MVFR0_EL1);
>  	read_sysreg_case(SYS_MVFR1_EL1);
>  	read_sysreg_case(SYS_MVFR2_EL1);
> diff --git a/arch/arm64/kernel/cpuinfo.c 
> b/arch/arm64/kernel/cpuinfo.c
> index 10121f5..6005d38 100644
> --- a/arch/arm64/kernel/cpuinfo.c
> +++ b/arch/arm64/kernel/cpuinfo.c
> @@ -362,6 +362,7 @@ static void __cpuinfo_store_cpu(struct
> cpuinfo_arm64 *info)
>  		info->reg_id_isar3 = read_cpuid(ID_ISAR3_EL1);
>  		info->reg_id_isar4 = read_cpuid(ID_ISAR4_EL1);
>  		info->reg_id_isar5 = read_cpuid(ID_ISAR5_EL1);
> +		info->reg_id_isar6 = read_cpuid(ID_ISAR6_EL1);
>  		info->reg_id_mmfr0 = read_cpuid(ID_MMFR0_EL1);
>  		info->reg_id_mmfr1 = read_cpuid(ID_MMFR1_EL1);
>  		info->reg_id_mmfr2 = read_cpuid(ID_MMFR2_EL1);
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 7dadd24..a6b8ca1 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -1424,7 +1424,7 @@ static const struct sys_reg_desc 
> sys_reg_descs[] = {
>  	ID_SANITISED(ID_ISAR4_EL1),
>  	ID_SANITISED(ID_ISAR5_EL1),
>  	ID_SANITISED(ID_MMFR4_EL1),
> -	ID_UNALLOCATED(2,7),
> +	ID_SANITISED(ID_ISAR6_EL1),
>
>  	/* CRm=3 */
>  	ID_SANITISED(MVFR0_EL1),

Otherwise,

Acked-by: Marc Zyngier <maz@kernel.org>

         M.
-- 
Jazz is not dead. It just smells funny...
