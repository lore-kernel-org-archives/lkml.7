Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D582CA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13B2C21872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 16:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571932816;
	bh=CMtWBK9bGXQgrwqfgHwn/rmOpH3VPeTWFKvQSvvYcNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NUryKYKGCSDP36klViqad5ArE8t8l0f/j2u7g/0q3zuSsjXCjvnQCTFxeSoKPpM+1
	 TnhsoJ3/pPZjA9o6kLRi4pD4ySXzGVQYvHbotrVlLiIGbWdoAbOM081CeDlu4Pw4B0
	 wEbnMKDLz6Z5hGJo8vwB1DnVcaY0ycZPE34mt4k0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393960AbfJXQAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 12:00:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389313AbfJXQAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 12:00:14 -0400
Received: from rapoport-lnx (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5AA5220663;
        Thu, 24 Oct 2019 16:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571932813;
        bh=CMtWBK9bGXQgrwqfgHwn/rmOpH3VPeTWFKvQSvvYcNk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WvqVjoRRXrd3JkI1omDW7PBhgmLthVCuqvNSxIoFPGM/xK9FH45m+Tyjn4lxywyFU
         qiSjcoxpNdVSUBYJVn4495qy4G4/bgc1wTkwBDhEUegPwysGw00g1mQIocUJqgzlFv
         mhcI3uQ1aiQgODaNP61ox2Q4KQDVJEXDRjeX2Ocg=
Date:   Thu, 24 Oct 2019 19:00:06 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH 08/12] parisc: use pgtable-nopXd instead of 4level-fixup
Message-ID: <20191024160005.GD12281@rapoport-lnx>
References: <1571822941-29776-1-git-send-email-rppt@kernel.org>
 <1571822941-29776-9-git-send-email-rppt@kernel.org>
 <20191024120208.GA17545@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024120208.GA17545@ls3530.fritz.box>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 02:02:08PM +0200, Helge Deller wrote:
> * Mike Rapoport <rppt@kernel.org>:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> >
> > parisc has two or three levels of page tables and can use appropriate
> > pgtable-nopXd and folding of the upper layers.
> >
> > Replace usage of include/asm-generic/4level-fixup.h and explicit
> > definitions of __PAGETABLE_PxD_FOLDED in parisc with
> > include/asm-generic/pgtable-nopmd.h for two-level configurations and with
> > include/asm-generic/pgtable-nopmd.h for three-lelve configurations and
> > adjust page table manipulation macros and functions accordingly.
> >
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> >  arch/parisc/include/asm/page.h    | 30 +++++++++++++---------
> >  arch/parisc/include/asm/pgalloc.h | 41 +++++++++++-------------------
> >  arch/parisc/include/asm/pgtable.h | 52 +++++++++++++++++++--------------------
> >  arch/parisc/include/asm/tlb.h     |  2 ++
> >  arch/parisc/kernel/cache.c        | 13 ++++++----
> >  arch/parisc/kernel/pci-dma.c      |  9 +++++--
> >  arch/parisc/mm/fixmap.c           | 10 +++++---
> >  7 files changed, 81 insertions(+), 76 deletions(-)
> 
> Mike, thanks for this clean-up!
> 
> Your patch is functional OK. I successfully tested it with a 32-bit
> kernel in qemu, and with a 64-bit kernel on a physical box.
> For 64-bit you missed to adapt the parisc hugetlb code, so maybe you
> can add the patch below to your series?

Sure.
 
> Other than that (and the lexical corrections which other already mentioned):
> Acked-by: Helge Deller <deller@gmx.de>

Thanks!
 
> Thanks!
> Helge
> 
> ----------------
> parisc/hugetlb: use pgtable-nopXd instead of 4level-fixup
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> 
> diff --git a/arch/parisc/mm/hugetlbpage.c b/arch/parisc/mm/hugetlbpage.c
> index d578809e55cf..0e1e212f1c96 100644
> --- a/arch/parisc/mm/hugetlbpage.c
> +++ b/arch/parisc/mm/hugetlbpage.c
> @@ -49,6 +49,7 @@ pte_t *huge_pte_alloc(struct mm_struct *mm,
>  			unsigned long addr, unsigned long sz)
>  {
>  	pgd_t *pgd;
> +	p4d_t *p4d;
>  	pud_t *pud;
>  	pmd_t *pmd;
>  	pte_t *pte = NULL;
> @@ -61,7 +62,8 @@ pte_t *huge_pte_alloc(struct mm_struct *mm,
>  	addr &= HPAGE_MASK;
> 
>  	pgd = pgd_offset(mm, addr);
> -	pud = pud_alloc(mm, pgd, addr);
> +	p4d = p4d_offset(pgd, addr);
> +	pud = pud_alloc(mm, p4d, addr);
>  	if (pud) {
>  		pmd = pmd_alloc(mm, pud, addr);
>  		if (pmd)
> @@ -74,6 +76,7 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
>  		       unsigned long addr, unsigned long sz)
>  {
>  	pgd_t *pgd;
> +	p4d_t *p4d;
>  	pud_t *pud;
>  	pmd_t *pmd;
>  	pte_t *pte = NULL;
> @@ -82,11 +85,14 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
> 
>  	pgd = pgd_offset(mm, addr);
>  	if (!pgd_none(*pgd)) {
> -		pud = pud_offset(pgd, addr);
> -		if (!pud_none(*pud)) {
> -			pmd = pmd_offset(pud, addr);
> -			if (!pmd_none(*pmd))
> -				pte = pte_offset_map(pmd, addr);
> +		p4d = p4d_offset(pgd, addr);
> +		if (!p4d_none(*p4d)) {
> +			pud = pud_offset(p4d, addr);
> +			if (!pud_none(*pud)) {
> +				pmd = pmd_offset(pud, addr);
> +				if (!pmd_none(*pmd))
> +					pte = pte_offset_map(pmd, addr);
> +			}
>  		}
>  	}
>  	return pte;
> 
> 
> 
> 
> 

-- 
Sincerely yours,
Mike.
