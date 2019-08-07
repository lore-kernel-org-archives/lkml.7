Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41049C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 09:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 137D82231F
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 09:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565168978;
	bh=XQaexSKpB8mjQkX9j2g2RC9xp05Rscu1DqTDQY3MAQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xhHJuPe+KUTgZ+HXJ8nlsObBSd/Da6d/8WQ5H8OuIvmNmo2WpRfak0fpyOLKx3LBu
	 vlRtPwI8EFyi1OG72q7XTEwFpa8gbVePjExiJndHceNVRHFTFb2Wd0P0QZBjVy7EhM
	 eKoGDfsRw8Ylaq6I3UjhVCYjQdhI0mMVGflZq+ME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbfHGJJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 05:09:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:34616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbfHGJJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 05:09:36 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E123621923;
        Wed,  7 Aug 2019 09:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565168975;
        bh=XQaexSKpB8mjQkX9j2g2RC9xp05Rscu1DqTDQY3MAQ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=paLu/T8/g5s29vdIji8xgfdeM6HRb3Plfvlozu0Sp2+Nov9i8Xb7jUQd6hEbec2SI
         /8EEfcBFw9uoVcqjnxQa/qWawtSvSNBtU03i2qObDLVs2h2mmHaufhGwGA5Cn2vUPG
         gWq+cBpa+fo539mrgFOn6BubxfBT7fkaE54UQcGI=
Date:   Wed, 7 Aug 2019 10:09:29 +0100
From:   Will Deacon <will@kernel.org>
To:     Jia He <justin.he@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Punit Agrawal <punitagrawal@gmail.com>, Qian Cai <cai@lca.pw>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>,
        Alex Van Brunt <avanbrunt@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: mm: add missing PTE_SPECIAL in pte_mkdevmap on
 arm64
Message-ID: <20190807090929.zsiupxyqop75uzkn@willie-the-truck>
References: <20190807045851.10772-1-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807045851.10772-1-justin.he@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 12:58:51PM +0800, Jia He wrote:
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 5fdcfe237338..e09760ece844 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -209,7 +209,7 @@ static inline pmd_t pmd_mkcont(pmd_t pmd)
>  
>  static inline pte_t pte_mkdevmap(pte_t pte)
>  {
> -	return set_pte_bit(pte, __pgprot(PTE_DEVMAP));
> +	return set_pte_bit(pte, __pgprot(PTE_DEVMAP | PTE_SPECIAL));
>  }
>  
>  static inline void set_pte(pte_t *ptep, pte_t pte)
> @@ -396,7 +396,10 @@ static inline int pmd_protnone(pmd_t pmd)
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  #define pmd_devmap(pmd)		pte_devmap(pmd_pte(pmd))
>  #endif
> -#define pmd_mkdevmap(pmd)	pte_pmd(pte_mkdevmap(pmd_pte(pmd)))
> +static inline pmd_t pmd_mkdevmap(pmd_t pmd)
> +{
> +	return pte_pmd(set_pte_bit(pmd_pte(pmd), __pgprot(PTE_DEVMAP)));
> +}
>  
>  #define __pmd_to_phys(pmd)	__pte_to_phys(pmd_pte(pmd))
>  #define __phys_to_pmd_val(phys)	__phys_to_pte_val(phys)

Acked-by: Will Deacon <will@kernel.org>

I think Catalin can take this as a fix, although the commit message should
probably be trimmed down a bit to remove the two call traces etc.

Will
