Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC570C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B0FD21924
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 13:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="dQomqrk7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbfDPNoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 09:44:13 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54140 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbfDPNoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 09:44:12 -0400
Received: from zn.tnic (p200300EC2F0D690030B3A6530520175E.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:6900:30b3:a653:520:175e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2A89E1EC0513;
        Tue, 16 Apr 2019 15:44:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555422251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=k8jSzi26TZd33y2UzBr8fQ17nAh5EkUJ6jyNpWvDjyY=;
        b=dQomqrk7TVzy86S96JXlkc6UlMvcgxm9V9qN+Jdd5K2gjCF2Yn7eddVQUlFAQqDblqt9cF
        uuhRTgDyIKUY1FlQW1E7qqBujpVt3GsJhBQ4AcpEW/EI04DghKqsabZ7rj1YTEeHqCk6m0
        V3sQPLP9TokttOo6Uc5TD6bdamEYk48=
Date:   Tue, 16 Apr 2019 15:44:07 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 3/6] x86/MCE/AMD: Don't cache block addresses on SMCA
 systems
Message-ID: <20190416134407.GF31772@zn.tnic>
References: <20190411201743.43195-1-Yazen.Ghannam@amd.com>
 <20190411201743.43195-4-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190411201743.43195-4-Yazen.Ghannam@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 08:18:02PM +0000, Ghannam, Yazen wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> On legacy systems, the addresses of the MCA_MISC* registers need to be
> recursively discovered based on a Block Pointer field in the registers.
> 
> On Scalable MCA systems, the register space is fixed, and particular
> addresses can be derived by regular offsets for bank and register type.
> This fixed address space includes the MCA_MISC* registers.
> 
> MCA_MISC0 is always available for each MCA bank. MCA_MISC1 through
> MCA_MISC4 are considered available if MCA_MISC0[BlkPtr]=1.
> 
> Cache the value of MCA_MISC0[BlkPtr] for each bank and per CPU. This
> needs to be done only during init. The values should be saved per CPU
> to accommodate heterogeneous SMCA systems.
> 
> Redo smca_get_block_address() to directly return the block addresses.
> Use the cached Block Pointer value to decide if the MCA_MISC1-4
> addresses should be returned.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
> Link:
> https://lkml.kernel.org/r/20190408141205.12376-4-Yazen.Ghannam@amd.com
> 
> v1->v2:
> * No change.
> 
>  arch/x86/kernel/cpu/mce/amd.c | 71 +++++++++++++++++------------------
>  1 file changed, 35 insertions(+), 36 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
> index e64de5149e50..f0644b59848d 100644
> --- a/arch/x86/kernel/cpu/mce/amd.c
> +++ b/arch/x86/kernel/cpu/mce/amd.c
> @@ -101,11 +101,6 @@ static struct smca_bank_name smca_names[] = {
>  	[SMCA_PCIE]	= { "pcie",		"PCI Express Unit" },
>  };
>  
> -static u32 smca_bank_addrs[MAX_NR_BANKS][NR_BLOCKS] __ro_after_init =
> -{
> -	[0 ... MAX_NR_BANKS - 1] = { [0 ... NR_BLOCKS - 1] = -1 }
> -};
> -
>  static const char *smca_get_name(enum smca_bank_types t)
>  {
>  	if (t >= N_SMCA_BANK_TYPES)
> @@ -198,6 +193,7 @@ static char buf_mcatype[MAX_MCATYPE_NAME_LEN];
>  
>  static DEFINE_PER_CPU(struct threshold_bank **, threshold_banks);
>  static DEFINE_PER_CPU(unsigned int, bank_map);	/* see which banks are on */
> +static DEFINE_PER_CPU(u32, smca_blkptr_map); /* see which banks use BlkPtr */

smca_misc_banks_map I guess. BlkPtr means something only to you, PPR
writers and me. And a couple others... :-)

>  static void amd_threshold_interrupt(void);
>  static void amd_deferred_error_interrupt(void);
> @@ -208,6 +204,28 @@ static void default_deferred_error_interrupt(void)
>  }
>  void (*deferred_error_int_vector)(void) = default_deferred_error_interrupt;
>  
> +static void smca_set_blkptr_map(unsigned int bank, unsigned int cpu)

Accordingly...

> +{
> +	u32 low, high;
> +
> +	/*
> +	 * For SMCA enabled processors, BLKPTR field of the first MISC register
> +	 * (MCx_MISC0) indicates presence of additional MISC regs set (MISC1-4).
> +	 */
> +	if (rdmsr_safe(MSR_AMD64_SMCA_MCx_CONFIG(bank), &low, &high))
> +		return;
> +
> +	if (!(low & MCI_CONFIG_MCAX))
> +		return;
> +
> +	if (rdmsr_safe(MSR_AMD64_SMCA_MCx_MISC(bank), &low, &high))
> +		return;
> +
> +	if (low & MASK_BLKPTR_LO)
> +		per_cpu(smca_blkptr_map, cpu) |= 1 << bank;

BIT(bank)

> +
> +}
> +
>  static void smca_configure(unsigned int bank, unsigned int cpu)
>  {
>  	unsigned int i, hwid_mcatype;
> @@ -245,6 +263,8 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
>  		wrmsr(smca_config, low, high);
>  	}
>  
> +	smca_set_blkptr_map(bank, cpu);
> +
>  	/* Return early if this bank was already initialized. */
>  	if (smca_banks[bank].hwid)
>  		return;
> @@ -455,42 +475,21 @@ static void deferred_error_interrupt_enable(struct cpuinfo_x86 *c)
>  	wrmsr(MSR_CU_DEF_ERR, low, high);
>  }
>  
> -static u32 smca_get_block_address(unsigned int bank, unsigned int block)
> +static u32 smca_get_block_address(unsigned int bank, unsigned int block,
> +				  unsigned int cpu)
>  {
> -	u32 low, high;
> -	u32 addr = 0;
> -
> -	if (smca_get_bank_type(bank) == SMCA_RESERVED)
> -		return addr;
> -
>  	if (!block)
>  		return MSR_AMD64_SMCA_MCx_MISC(bank);
>  
> -	/* Check our cache first: */
> -	if (smca_bank_addrs[bank][block] != -1)
> -		return smca_bank_addrs[bank][block];
> -
> -	/*
> -	 * For SMCA enabled processors, BLKPTR field of the first MISC register
> -	 * (MCx_MISC0) indicates presence of additional MISC regs set (MISC1-4).
> -	 */
> -	if (rdmsr_safe(MSR_AMD64_SMCA_MCx_CONFIG(bank), &low, &high))
> -		goto out;
> -
> -	if (!(low & MCI_CONFIG_MCAX))
> -		goto out;
> -
> -	if (!rdmsr_safe(MSR_AMD64_SMCA_MCx_MISC(bank), &low, &high) &&
> -	    (low & MASK_BLKPTR_LO))
> -		addr = MSR_AMD64_SMCA_MCx_MISCy(bank, block - 1);
> +	if (!(per_cpu(smca_blkptr_map, cpu) & (1 << bank)))

BIT(bank)

> +		return 0;
>  
> -out:
> -	smca_bank_addrs[bank][block] = addr;
> -	return addr;
> +	return MSR_AMD64_SMCA_MCx_MISCy(bank, block - 1);
>  }

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
