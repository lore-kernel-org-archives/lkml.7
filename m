Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C13C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 292E721582
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfLROVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:21:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9784 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726856AbfLROVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 09:21:49 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBIEJiGE143828
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 09:21:47 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wyncx91qu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 09:21:47 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 18 Dec 2019 14:21:45 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 18 Dec 2019 14:21:43 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBIEKxCe48759240
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Dec 2019 14:20:59 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A07E55204F;
        Wed, 18 Dec 2019 14:21:42 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.207.105])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id DBE435204E;
        Wed, 18 Dec 2019 14:21:41 +0000 (GMT)
Date:   Wed, 18 Dec 2019 16:21:40 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Mike Rapoport <rppt@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ia64: add support for folded p4d page tables
References: <20191218093820.17967-1-rppt@kernel.org>
 <20191218135939.GD28111@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218135939.GD28111@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19121814-0020-0000-0000-00000399887C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121814-0021-0000-0000-000021F0AB9E
Message-Id: <20191218142139.GA1454@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-18_04:2019-12-17,2019-12-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=2
 impostorscore=0 mlxlogscore=999 spamscore=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912180118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 02:59:39PM +0100, Michal Hocko wrote:
> On Wed 18-12-19 11:38:20, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > Implement primitives necessary for the 4th level folding, add walks of p4d
> > level where appropriate, remove usage of __ARCH_USE_5LEVEL_HACK and replace
> > 5level-fixup.h with pgtable-nop4d.h
> 
> Why do we need that? I thought that IA64 is essentially a dead
> architecture. Is this fixing something?

This is a part of a generic cleanup of page table manipulations. The goal
is to remove __ARCH_USE_5LEVEL_HACK, asm-generic/5level-fixup.h,
asm-generic/pgtable-nop4d-hack.h and the related code from the kernel.
 
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> >  arch/ia64/include/asm/pgalloc.h |  4 ++--
> >  arch/ia64/include/asm/pgtable.h | 17 ++++++++---------
> >  arch/ia64/mm/fault.c            |  7 ++++++-
> >  arch/ia64/mm/hugetlbpage.c      | 18 ++++++++++++------
> >  arch/ia64/mm/init.c             | 28 ++++++++++++++++++++++++----
> >  5 files changed, 52 insertions(+), 22 deletions(-)
> > 
> > diff --git a/arch/ia64/include/asm/pgalloc.h b/arch/ia64/include/asm/pgalloc.h
> > index f4c491044882..2a3050345099 100644
> > --- a/arch/ia64/include/asm/pgalloc.h
> > +++ b/arch/ia64/include/asm/pgalloc.h
> > @@ -36,9 +36,9 @@ static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
> >  
> >  #if CONFIG_PGTABLE_LEVELS == 4
> >  static inline void
> > -pgd_populate(struct mm_struct *mm, pgd_t * pgd_entry, pud_t * pud)
> > +p4d_populate(struct mm_struct *mm, p4d_t * p4d_entry, pud_t * pud)
> >  {
> > -	pgd_val(*pgd_entry) = __pa(pud);
> > +	p4d_val(*p4d_entry) = __pa(pud);
> >  }
> >  
> >  static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
> > diff --git a/arch/ia64/include/asm/pgtable.h b/arch/ia64/include/asm/pgtable.h
> > index d602e7c622db..c87f789bc914 100644
> > --- a/arch/ia64/include/asm/pgtable.h
> > +++ b/arch/ia64/include/asm/pgtable.h
> > @@ -283,12 +283,12 @@ extern unsigned long VMALLOC_END;
> >  #define pud_page(pud)			virt_to_page((pud_val(pud) + PAGE_OFFSET))
> >  
> >  #if CONFIG_PGTABLE_LEVELS == 4
> > -#define pgd_none(pgd)			(!pgd_val(pgd))
> > -#define pgd_bad(pgd)			(!ia64_phys_addr_valid(pgd_val(pgd)))
> > -#define pgd_present(pgd)		(pgd_val(pgd) != 0UL)
> > -#define pgd_clear(pgdp)			(pgd_val(*(pgdp)) = 0UL)
> > -#define pgd_page_vaddr(pgd)		((unsigned long) __va(pgd_val(pgd) & _PFN_MASK))
> > -#define pgd_page(pgd)			virt_to_page((pgd_val(pgd) + PAGE_OFFSET))
> > +#define p4d_none(p4d)			(!p4d_val(p4d))
> > +#define p4d_bad(p4d)			(!ia64_phys_addr_valid(p4d_val(p4d)))
> > +#define p4d_present(p4d)		(p4d_val(p4d) != 0UL)
> > +#define p4d_clear(p4dp)			(p4d_val(*(p4dp)) = 0UL)
> > +#define p4d_page_vaddr(p4d)		((unsigned long) __va(p4d_val(p4d) & _PFN_MASK))
> > +#define p4d_page(p4d)			virt_to_page((p4d_val(p4d) + PAGE_OFFSET))
> >  #endif
> >  
> >  /*
> > @@ -388,7 +388,7 @@ pgd_offset (const struct mm_struct *mm, unsigned long address)
> >  #if CONFIG_PGTABLE_LEVELS == 4
> >  /* Find an entry in the second-level page table.. */
> >  #define pud_offset(dir,addr) \
> > -	((pud_t *) pgd_page_vaddr(*(dir)) + (((addr) >> PUD_SHIFT) & (PTRS_PER_PUD - 1)))
> > +	((pud_t *) p4d_page_vaddr(*(dir)) + (((addr) >> PUD_SHIFT) & (PTRS_PER_PUD - 1)))
> >  #endif
> >  
> >  /* Find an entry in the third-level page table.. */
> > @@ -582,10 +582,9 @@ extern struct page *zero_page_memmap_ptr;
> >  
> >  
> >  #if CONFIG_PGTABLE_LEVELS == 3
> > -#define __ARCH_USE_5LEVEL_HACK
> >  #include <asm-generic/pgtable-nopud.h>
> >  #endif
> > -#include <asm-generic/5level-fixup.h>
> > +#include <asm-generic/pgtable-nop4d.h>
> >  #include <asm-generic/pgtable.h>
> >  
> >  #endif /* _ASM_IA64_PGTABLE_H */
> > diff --git a/arch/ia64/mm/fault.c b/arch/ia64/mm/fault.c
> > index c2f299fe9e04..ec994135cb74 100644
> > --- a/arch/ia64/mm/fault.c
> > +++ b/arch/ia64/mm/fault.c
> > @@ -29,6 +29,7 @@ static int
> >  mapped_kernel_page_is_present (unsigned long address)
> >  {
> >  	pgd_t *pgd;
> > +	p4d_t *p4d;
> >  	pud_t *pud;
> >  	pmd_t *pmd;
> >  	pte_t *ptep, pte;
> > @@ -37,7 +38,11 @@ mapped_kernel_page_is_present (unsigned long address)
> >  	if (pgd_none(*pgd) || pgd_bad(*pgd))
> >  		return 0;
> >  
> > -	pud = pud_offset(pgd, address);
> > +	p4d = p4d_offset(pgd, address);
> > +	if (p4d_none(*p4d) || p4d_bad(*p4d))
> > +		return 0;
> > +
> > +	pud = pud_offset(p4d, address);
> >  	if (pud_none(*pud) || pud_bad(*pud))
> >  		return 0;
> >  
> > diff --git a/arch/ia64/mm/hugetlbpage.c b/arch/ia64/mm/hugetlbpage.c
> > index d16e419fd712..32352a73df0c 100644
> > --- a/arch/ia64/mm/hugetlbpage.c
> > +++ b/arch/ia64/mm/hugetlbpage.c
> > @@ -30,12 +30,14 @@ huge_pte_alloc(struct mm_struct *mm, unsigned long addr, unsigned long sz)
> >  {
> >  	unsigned long taddr = htlbpage_to_page(addr);
> >  	pgd_t *pgd;
> > +	p4d_t *p4d;
> >  	pud_t *pud;
> >  	pmd_t *pmd;
> >  	pte_t *pte = NULL;
> >  
> >  	pgd = pgd_offset(mm, taddr);
> > -	pud = pud_alloc(mm, pgd, taddr);
> > +	p4d = p4d_offset(pgd, taddr);
> > +	pud = pud_alloc(mm, p4d, taddr);
> >  	if (pud) {
> >  		pmd = pmd_alloc(mm, pud, taddr);
> >  		if (pmd)
> > @@ -49,17 +51,21 @@ huge_pte_offset (struct mm_struct *mm, unsigned long addr, unsigned long sz)
> >  {
> >  	unsigned long taddr = htlbpage_to_page(addr);
> >  	pgd_t *pgd;
> > +	p4d_t *p4d;
> >  	pud_t *pud;
> >  	pmd_t *pmd;
> >  	pte_t *pte = NULL;
> >  
> >  	pgd = pgd_offset(mm, taddr);
> >  	if (pgd_present(*pgd)) {
> > -		pud = pud_offset(pgd, taddr);
> > -		if (pud_present(*pud)) {
> > -			pmd = pmd_offset(pud, taddr);
> > -			if (pmd_present(*pmd))
> > -				pte = pte_offset_map(pmd, taddr);
> > +		p4d = p4d_offset(pgd, addr);
> > +		if (p4d_present(*p4d)) {
> > +			pud = pud_offset(p4d, taddr);
> > +			if (pud_present(*pud)) {
> > +				pmd = pmd_offset(pud, taddr);
> > +				if (pmd_present(*pmd))
> > +					pte = pte_offset_map(pmd, taddr);
> > +			}
> >  		}
> >  	}
> >  
> > diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
> > index 58fd67068bac..bcdc78e97e6e 100644
> > --- a/arch/ia64/mm/init.c
> > +++ b/arch/ia64/mm/init.c
> > @@ -208,6 +208,7 @@ static struct page * __init
> >  put_kernel_page (struct page *page, unsigned long address, pgprot_t pgprot)
> >  {
> >  	pgd_t *pgd;
> > +	p4d_t *p4d;
> >  	pud_t *pud;
> >  	pmd_t *pmd;
> >  	pte_t *pte;
> > @@ -215,7 +216,10 @@ put_kernel_page (struct page *page, unsigned long address, pgprot_t pgprot)
> >  	pgd = pgd_offset_k(address);		/* note: this is NOT pgd_offset()! */
> >  
> >  	{
> > -		pud = pud_alloc(&init_mm, pgd, address);
> > +		p4d = p4d_alloc(&init_mm, pgd, address);
> > +		if (!p4d)
> > +			goto out;
> > +		pud = pud_alloc(&init_mm, p4d, address);
> >  		if (!pud)
> >  			goto out;
> >  		pmd = pmd_alloc(&init_mm, pud, address);
> > @@ -382,6 +386,7 @@ int vmemmap_find_next_valid_pfn(int node, int i)
> >  
> >  	do {
> >  		pgd_t *pgd;
> > +		p4d_t *p4d;
> >  		pud_t *pud;
> >  		pmd_t *pmd;
> >  		pte_t *pte;
> > @@ -392,7 +397,13 @@ int vmemmap_find_next_valid_pfn(int node, int i)
> >  			continue;
> >  		}
> >  
> > -		pud = pud_offset(pgd, end_address);
> > +		p4d = p4d_offset(pgd, end_address);
> > +		if (p4d_none(*p4d)) {
> > +			end_address += P4D_SIZE;
> > +			continue;
> > +		}
> > +
> > +		pud = pud_offset(p4d, end_address);
> >  		if (pud_none(*pud)) {
> >  			end_address += PUD_SIZE;
> >  			continue;
> > @@ -430,6 +441,7 @@ int __init create_mem_map_page_table(u64 start, u64 end, void *arg)
> >  	struct page *map_start, *map_end;
> >  	int node;
> >  	pgd_t *pgd;
> > +	p4d_t *p4d;
> >  	pud_t *pud;
> >  	pmd_t *pmd;
> >  	pte_t *pte;
> > @@ -444,12 +456,20 @@ int __init create_mem_map_page_table(u64 start, u64 end, void *arg)
> >  	for (address = start_page; address < end_page; address += PAGE_SIZE) {
> >  		pgd = pgd_offset_k(address);
> >  		if (pgd_none(*pgd)) {
> > +			p4d = memblock_alloc_node(PAGE_SIZE, PAGE_SIZE, node);
> > +			if (!p4d)
> > +				goto err_alloc;
> > +			pgd_populate(&init_mm, pgd, p4d);
> > +		}
> > +		p4d = p4d_offset(pgd, address);
> > +
> > +		if (p4d_none(*p4d)) {
> >  			pud = memblock_alloc_node(PAGE_SIZE, PAGE_SIZE, node);
> >  			if (!pud)
> >  				goto err_alloc;
> > -			pgd_populate(&init_mm, pgd, pud);
> > +			p4d_populate(&init_mm, p4d, pud);
> >  		}
> > -		pud = pud_offset(pgd, address);
> > +		pud = pud_offset(p4d, address);
> >  
> >  		if (pud_none(*pud)) {
> >  			pmd = memblock_alloc_node(PAGE_SIZE, PAGE_SIZE, node);
> > -- 
> > 2.24.0
> > 
> 
> -- 
> Michal Hocko
> SUSE Labs

-- 
Sincerely yours,
Mike.

