Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF1BC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 09:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA88521922
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 09:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbfHGJYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 05:24:35 -0400
Received: from foss.arm.com ([217.140.110.172]:45404 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726529AbfHGJYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 05:24:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1090A28;
        Wed,  7 Aug 2019 02:24:32 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 437B43F575;
        Wed,  7 Aug 2019 02:24:30 -0700 (PDT)
Date:   Wed, 7 Aug 2019 10:24:28 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Jia He <justin.he@arm.com>, Mark Rutland <mark.rutland@arm.com>,
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
Message-ID: <20190807092427.GB63492@arrakis.emea.arm.com>
References: <20190807045851.10772-1-justin.he@arm.com>
 <20190807090929.zsiupxyqop75uzkn@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807090929.zsiupxyqop75uzkn@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 10:09:29AM +0100, Will Deacon wrote:
> On Wed, Aug 07, 2019 at 12:58:51PM +0800, Jia He wrote:
> > diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> > index 5fdcfe237338..e09760ece844 100644
> > --- a/arch/arm64/include/asm/pgtable.h
> > +++ b/arch/arm64/include/asm/pgtable.h
> > @@ -209,7 +209,7 @@ static inline pmd_t pmd_mkcont(pmd_t pmd)
> >  
> >  static inline pte_t pte_mkdevmap(pte_t pte)
> >  {
> > -	return set_pte_bit(pte, __pgprot(PTE_DEVMAP));
> > +	return set_pte_bit(pte, __pgprot(PTE_DEVMAP | PTE_SPECIAL));
> >  }
> >  
> >  static inline void set_pte(pte_t *ptep, pte_t pte)
> > @@ -396,7 +396,10 @@ static inline int pmd_protnone(pmd_t pmd)
> >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >  #define pmd_devmap(pmd)		pte_devmap(pmd_pte(pmd))
> >  #endif
> > -#define pmd_mkdevmap(pmd)	pte_pmd(pte_mkdevmap(pmd_pte(pmd)))
> > +static inline pmd_t pmd_mkdevmap(pmd_t pmd)
> > +{
> > +	return pte_pmd(set_pte_bit(pmd_pte(pmd), __pgprot(PTE_DEVMAP)));
> > +}
> >  
> >  #define __pmd_to_phys(pmd)	__pte_to_phys(pmd_pte(pmd))
> >  #define __phys_to_pmd_val(phys)	__phys_to_pte_val(phys)
> 
> Acked-by: Will Deacon <will@kernel.org>
> 
> I think Catalin can take this as a fix, although the commit message should
> probably be trimmed down a bit to remove the two call traces etc.

I'll queue this for -rc4 and sort out the commit message. Thanks.

-- 
Catalin
