Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CC8C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 23:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9366920679
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 23:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbfG2Xaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 19:30:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46312 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbfG2Xav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 19:30:51 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 72E2E5AFF8;
        Mon, 29 Jul 2019 23:30:51 +0000 (UTC)
Received: from redhat.com (ovpn-112-31.rdu2.redhat.com [10.10.112.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 58E1C19C58;
        Mon, 29 Jul 2019 23:30:48 +0000 (UTC)
Date:   Mon, 29 Jul 2019 19:30:44 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/9] mm: remove the MIGRATE_PFN_WRITE flag
Message-ID: <20190729233044.GA7171@redhat.com>
References: <20190729142843.22320-1-hch@lst.de>
 <20190729142843.22320-10-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190729142843.22320-10-hch@lst.de>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 29 Jul 2019 23:30:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 05:28:43PM +0300, Christoph Hellwig wrote:
> The MIGRATE_PFN_WRITE is only used locally in migrate_vma_collect_pmd,
> where it can be replaced with a simple boolean local variable.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

NAK that flag is useful, for instance a anonymous vma might have
some of its page read only even if the vma has write permission.

It seems that the code in nouveau is wrong (probably lost that
in various rebase/rework) as this flag should be use to decide
wether to map the device memory with write permission or not.

I am traveling right now, i will investigate what happened to
nouveau code.

Cheers,
Jérôme

> ---
>  include/linux/migrate.h | 1 -
>  mm/migrate.c            | 9 +++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index 8b46cfdb1a0e..ba74ef5a7702 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -165,7 +165,6 @@ static inline int migrate_misplaced_transhuge_page(struct mm_struct *mm,
>  #define MIGRATE_PFN_VALID	(1UL << 0)
>  #define MIGRATE_PFN_MIGRATE	(1UL << 1)
>  #define MIGRATE_PFN_LOCKED	(1UL << 2)
> -#define MIGRATE_PFN_WRITE	(1UL << 3)
>  #define MIGRATE_PFN_SHIFT	6
>  
>  static inline struct page *migrate_pfn_to_page(unsigned long mpfn)
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 74735256e260..724f92dcc31b 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2212,6 +2212,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>  		unsigned long mpfn, pfn;
>  		struct page *page;
>  		swp_entry_t entry;
> +		bool writable = false;
>  		pte_t pte;
>  
>  		pte = *ptep;
> @@ -2240,7 +2241,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>  			mpfn = migrate_pfn(page_to_pfn(page)) |
>  					MIGRATE_PFN_MIGRATE;
>  			if (is_write_device_private_entry(entry))
> -				mpfn |= MIGRATE_PFN_WRITE;
> +				writable = true;
>  		} else {
>  			if (is_zero_pfn(pfn)) {
>  				mpfn = MIGRATE_PFN_MIGRATE;
> @@ -2250,7 +2251,8 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>  			}
>  			page = vm_normal_page(migrate->vma, addr, pte);
>  			mpfn = migrate_pfn(pfn) | MIGRATE_PFN_MIGRATE;
> -			mpfn |= pte_write(pte) ? MIGRATE_PFN_WRITE : 0;
> +			if (pte_write(pte))
> +				writable = true;
>  		}
>  
>  		/* FIXME support THP */
> @@ -2284,8 +2286,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>  			ptep_get_and_clear(mm, addr, ptep);
>  
>  			/* Setup special migration page table entry */
> -			entry = make_migration_entry(page, mpfn &
> -						     MIGRATE_PFN_WRITE);
> +			entry = make_migration_entry(page, writable);
>  			swp_pte = swp_entry_to_pte(entry);
>  			if (pte_soft_dirty(pte))
>  				swp_pte = pte_swp_mksoft_dirty(swp_pte);
> -- 
> 2.20.1
> 
