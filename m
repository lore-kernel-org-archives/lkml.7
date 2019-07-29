Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BEBCC76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 23:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2F9A2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 23:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbfG2XnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 19:43:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43308 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729671AbfG2XnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 19:43:20 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 953C7BDF9;
        Mon, 29 Jul 2019 23:43:19 +0000 (UTC)
Received: from redhat.com (ovpn-112-31.rdu2.redhat.com [10.10.112.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F0455D6A0;
        Mon, 29 Jul 2019 23:43:16 +0000 (UTC)
Date:   Mon, 29 Jul 2019 19:43:12 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] mm: turn migrate_vma upside down
Message-ID: <20190729234312.GB7171@redhat.com>
References: <20190729142843.22320-1-hch@lst.de>
 <20190729142843.22320-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729142843.22320-2-hch@lst.de>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 29 Jul 2019 23:43:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 05:28:35PM +0300, Christoph Hellwig wrote:
> There isn't any good reason to pass callbacks to migrate_vma.  Instead
> we can just export the three steps done by this function to drivers and
> let them sequence the operation without callbacks.  This removes a lot
> of boilerplate code as-is, and will allow the drivers to drastically
> improve code flow and error handling further on.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>


I haven't finished review, especialy the nouveau code, i will look
into this once i get back. In the meantime below are few corrections.

> ---
>  Documentation/vm/hmm.rst               |  55 +-----
>  drivers/gpu/drm/nouveau/nouveau_dmem.c | 122 +++++++------
>  include/linux/migrate.h                | 118 ++----------
>  mm/migrate.c                           | 242 +++++++++++--------------
>  4 files changed, 193 insertions(+), 344 deletions(-)
> 

[...]

> diff --git a/mm/migrate.c b/mm/migrate.c
> index 8992741f10aa..dc4e60a496f2 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2118,16 +2118,6 @@ int migrate_misplaced_transhuge_page(struct mm_struct *mm,
>  #endif /* CONFIG_NUMA */
>  
>  #if defined(CONFIG_MIGRATE_VMA_HELPER)
> -struct migrate_vma {
> -	struct vm_area_struct	*vma;
> -	unsigned long		*dst;
> -	unsigned long		*src;
> -	unsigned long		cpages;
> -	unsigned long		npages;
> -	unsigned long		start;
> -	unsigned long		end;
> -};
> -
>  static int migrate_vma_collect_hole(unsigned long start,
>  				    unsigned long end,
>  				    struct mm_walk *walk)
> @@ -2578,6 +2568,108 @@ static void migrate_vma_unmap(struct migrate_vma *migrate)
>  	}
>  }
>  
> +/**
> + * migrate_vma_setup() - prepare to migrate a range of memory
> + * @args: contains the vma, start, and and pfns arrays for the migration
> + *
> + * Returns: negative errno on failures, 0 when 0 or more pages were migrated
> + * without an error.
> + *
> + * Prepare to migrate a range of memory virtual address range by collecting all
> + * the pages backing each virtual address in the range, saving them inside the
> + * src array.  Then lock those pages and unmap them. Once the pages are locked
> + * and unmapped, check whether each page is pinned or not.  Pages that aren't
> + * pinned have the MIGRATE_PFN_MIGRATE flag set (by this function) in the
> + * corresponding src array entry.  Then restores any pages that are pinned, by
> + * remapping and unlocking those pages.
> + *
> + * The caller should then allocate destination memory and copy source memory to
> + * it for all those entries (ie with MIGRATE_PFN_VALID and MIGRATE_PFN_MIGRATE
> + * flag set).  Once these are allocated and copied, the caller must update each
> + * corresponding entry in the dst array with the pfn value of the destination
> + * page and with the MIGRATE_PFN_VALID and MIGRATE_PFN_LOCKED flags set
> + * (destination pages must have their struct pages locked, via lock_page()).
> + *
> + * Note that the caller does not have to migrate all the pages that are marked
> + * with MIGRATE_PFN_MIGRATE flag in src array unless this is a migration from
> + * device memory to system memory.  If the caller cannot migrate a device page
> + * back to system memory, then it must return VM_FAULT_SIGBUS, which will
> + * might have severe consequences for the userspace process, so it should best

      ^s/might//                                                      ^s/should best/must/

> + * be avoided if possible.
                 ^s/if possible//

Maybe adding something about failing only on unrecoverable device error. The
only reason we allow failure for migration here is because GPU devices can
go into bad state (GPU lockup) and when that happens the GPU memory might be
corrupted (power to GPU memory might be cut by GPU driver to recover the
GPU).

So failing migration back to main memory is only a last resort event.


> + *
> + * For empty entries inside CPU page table (pte_none() or pmd_none() is true) we
> + * do set MIGRATE_PFN_MIGRATE flag inside the corresponding source array thus
> + * allowing the caller to allocate device memory for those unback virtual
> + * address.  For this the caller simply havs to allocate device memory and
                                           ^ haves

