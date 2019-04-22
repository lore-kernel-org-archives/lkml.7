Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8247C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88727204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731307AbfDVTwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:52:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44843 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729054AbfDVTwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:52:09 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7B6E959468;
        Mon, 22 Apr 2019 19:52:07 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D9AA5183E2;
        Mon, 22 Apr 2019 19:51:59 +0000 (UTC)
Date:   Mon, 22 Apr 2019 15:51:58 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Laurent Dufour <ldufour@linux.ibm.com>
Cc:     akpm@linux-foundation.org, mhocko@kernel.org, peterz@infradead.org,
        kirill@shutemov.name, ak@linux.intel.com, dave@stgolabs.net,
        jack@suse.cz, Matthew Wilcox <willy@infradead.org>,
        aneesh.kumar@linux.ibm.com, benh@kernel.crashing.org,
        mpe@ellerman.id.au, paulus@samba.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, hpa@zytor.com,
        Will Deacon <will.deacon@arm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        sergey.senozhatsky.work@gmail.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        kemi.wang@intel.com, Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Rientjes <rientjes@google.com>,
        Ganesh Mahendran <opensource.ganesh@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Punit Agrawal <punitagrawal@gmail.com>,
        vinayak menon <vinayakm.list@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        zhong jiang <zhongjiang@huawei.com>,
        Haiyan Song <haiyanx.song@intel.com>,
        Balbir Singh <bsingharora@gmail.com>, sj38.park@gmail.com,
        Michel Lespinasse <walken@google.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        haren@linux.vnet.ibm.com, npiggin@gmail.com,
        paulmck@linux.vnet.ibm.com, Tim Chen <tim.c.chen@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v12 11/31] mm: protect mremap() against SPF hanlder
Message-ID: <20190422195157.GB14666@redhat.com>
References: <20190416134522.17540-1-ldufour@linux.ibm.com>
 <20190416134522.17540-12-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190416134522.17540-12-ldufour@linux.ibm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Mon, 22 Apr 2019 19:52:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 03:45:02PM +0200, Laurent Dufour wrote:
> If a thread is remapping an area while another one is faulting on the
> destination area, the SPF handler may fetch the vma from the RB tree before
> the pte has been moved by the other thread. This means that the moved ptes
> will overwrite those create by the page fault handler leading to page
> leaked.
> 
> 	CPU 1				CPU2
> 	enter mremap()
> 	unmap the dest area
> 	copy_vma()			Enter speculative page fault handler
> 	   >> at this time the dest area is present in the RB tree
> 					fetch the vma matching dest area
> 					create a pte as the VMA matched
> 					Exit the SPF handler
> 					<data written in the new page>
> 	move_ptes()
> 	  > it is assumed that the dest area is empty,
>  	  > the move ptes overwrite the page mapped by the CPU2.
> 
> To prevent that, when the VMA matching the dest area is extended or created
> by copy_vma(), it should be marked as non available to the SPF handler.
> The usual way to so is to rely on vm_write_begin()/end().
> This is already in __vma_adjust() called by copy_vma() (through
> vma_merge()). But __vma_adjust() is calling vm_write_end() before returning
> which create a window for another thread.
> This patch adds a new parameter to vma_merge() which is passed down to
> vma_adjust().
> The assumption is that copy_vma() is returning a vma which should be
> released by calling vm_raw_write_end() by the callee once the ptes have
> been moved.
> 
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>

Reviewed-by: Jérôme Glisse <jglisse@redhat.com>

Small comment about a comment below but can be fix as a fixup
patch nothing earth shattering.

> ---
>  include/linux/mm.h | 24 ++++++++++++++++-----
>  mm/mmap.c          | 53 +++++++++++++++++++++++++++++++++++-----------
>  mm/mremap.c        | 13 ++++++++++++
>  3 files changed, 73 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 906b9e06f18e..5d45b7d8718d 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2343,18 +2343,32 @@ void anon_vma_interval_tree_verify(struct anon_vma_chain *node);
>  
>  /* mmap.c */
>  extern int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin);
> +
>  extern int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
>  	unsigned long end, pgoff_t pgoff, struct vm_area_struct *insert,
> -	struct vm_area_struct *expand);
> +	struct vm_area_struct *expand, bool keep_locked);
> +
>  static inline int vma_adjust(struct vm_area_struct *vma, unsigned long start,
>  	unsigned long end, pgoff_t pgoff, struct vm_area_struct *insert)
>  {
> -	return __vma_adjust(vma, start, end, pgoff, insert, NULL);
> +	return __vma_adjust(vma, start, end, pgoff, insert, NULL, false);
>  }
> -extern struct vm_area_struct *vma_merge(struct mm_struct *,
> +
> +extern struct vm_area_struct *__vma_merge(struct mm_struct *mm,
> +	struct vm_area_struct *prev, unsigned long addr, unsigned long end,
> +	unsigned long vm_flags, struct anon_vma *anon, struct file *file,
> +	pgoff_t pgoff, struct mempolicy *mpol,
> +	struct vm_userfaultfd_ctx uff, bool keep_locked);
> +
> +static inline struct vm_area_struct *vma_merge(struct mm_struct *mm,
>  	struct vm_area_struct *prev, unsigned long addr, unsigned long end,
> -	unsigned long vm_flags, struct anon_vma *, struct file *, pgoff_t,
> -	struct mempolicy *, struct vm_userfaultfd_ctx);
> +	unsigned long vm_flags, struct anon_vma *anon, struct file *file,
> +	pgoff_t off, struct mempolicy *pol, struct vm_userfaultfd_ctx uff)
> +{
> +	return __vma_merge(mm, prev, addr, end, vm_flags, anon, file, off,
> +			   pol, uff, false);
> +}
> +
>  extern struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *);
>  extern int __split_vma(struct mm_struct *, struct vm_area_struct *,
>  	unsigned long addr, int new_below);
> diff --git a/mm/mmap.c b/mm/mmap.c
> index b77ec0149249..13460b38b0fb 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -714,7 +714,7 @@ static inline void __vma_unlink_prev(struct mm_struct *mm,
>   */
>  int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
>  	unsigned long end, pgoff_t pgoff, struct vm_area_struct *insert,
> -	struct vm_area_struct *expand)
> +	struct vm_area_struct *expand, bool keep_locked)
>  {
>  	struct mm_struct *mm = vma->vm_mm;
>  	struct vm_area_struct *next = vma->vm_next, *orig_vma = vma;
> @@ -830,8 +830,12 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
>  
>  			importer->anon_vma = exporter->anon_vma;
>  			error = anon_vma_clone(importer, exporter);
> -			if (error)
> +			if (error) {
> +				if (next && next != vma)
> +					vm_raw_write_end(next);
> +				vm_raw_write_end(vma);
>  				return error;
> +			}
>  		}
>  	}
>  again:
> @@ -1025,7 +1029,8 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
>  
>  	if (next && next != vma)
>  		vm_raw_write_end(next);
> -	vm_raw_write_end(vma);
> +	if (!keep_locked)
> +		vm_raw_write_end(vma);
>  
>  	validate_mm(mm);
>  
> @@ -1161,12 +1166,13 @@ can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
>   * parameter) may establish ptes with the wrong permissions of NNNN
>   * instead of the right permissions of XXXX.
>   */
> -struct vm_area_struct *vma_merge(struct mm_struct *mm,
> +struct vm_area_struct *__vma_merge(struct mm_struct *mm,
>  			struct vm_area_struct *prev, unsigned long addr,
>  			unsigned long end, unsigned long vm_flags,
>  			struct anon_vma *anon_vma, struct file *file,
>  			pgoff_t pgoff, struct mempolicy *policy,
> -			struct vm_userfaultfd_ctx vm_userfaultfd_ctx)
> +			struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
> +			bool keep_locked)
>  {
>  	pgoff_t pglen = (end - addr) >> PAGE_SHIFT;
>  	struct vm_area_struct *area, *next;
> @@ -1214,10 +1220,11 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm,
>  							/* cases 1, 6 */
>  			err = __vma_adjust(prev, prev->vm_start,
>  					 next->vm_end, prev->vm_pgoff, NULL,
> -					 prev);
> +					 prev, keep_locked);
>  		} else					/* cases 2, 5, 7 */
>  			err = __vma_adjust(prev, prev->vm_start,
> -					 end, prev->vm_pgoff, NULL, prev);
> +					   end, prev->vm_pgoff, NULL, prev,
> +					   keep_locked);
>  		if (err)
>  			return NULL;
>  		khugepaged_enter_vma_merge(prev, vm_flags);
> @@ -1234,10 +1241,12 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm,
>  					     vm_userfaultfd_ctx)) {
>  		if (prev && addr < prev->vm_end)	/* case 4 */
>  			err = __vma_adjust(prev, prev->vm_start,
> -					 addr, prev->vm_pgoff, NULL, next);
> +					 addr, prev->vm_pgoff, NULL, next,
> +					 keep_locked);
>  		else {					/* cases 3, 8 */
>  			err = __vma_adjust(area, addr, next->vm_end,
> -					 next->vm_pgoff - pglen, NULL, next);
> +					 next->vm_pgoff - pglen, NULL, next,
> +					 keep_locked);
>  			/*
>  			 * In case 3 area is already equal to next and
>  			 * this is a noop, but in case 8 "area" has
> @@ -3259,9 +3268,20 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
>  
>  	if (find_vma_links(mm, addr, addr + len, &prev, &rb_link, &rb_parent))
>  		return NULL;	/* should never get here */
> -	new_vma = vma_merge(mm, prev, addr, addr + len, vma->vm_flags,
> -			    vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
> -			    vma->vm_userfaultfd_ctx);
> +
> +	/* There is 3 cases to manage here in
> +	 *     AAAA            AAAA              AAAA              AAAA
> +	 * PPPP....      PPPP......NNNN      PPPP....NNNN      PP........NN
> +	 * PPPPPPPP(A)   PPPP..NNNNNNNN(B)   PPPPPPPPPPPP(1)       NULL
> +	 *                                   PPPPPPPPNNNN(2)
> +	 *                                   PPPPNNNNNNNN(3)
> +	 *
> +	 * new_vma == prev in case A,1,2
> +	 * new_vma == next in case B,3
> +	 */
> +	new_vma = __vma_merge(mm, prev, addr, addr + len, vma->vm_flags,
> +			      vma->anon_vma, vma->vm_file, pgoff,
> +			      vma_policy(vma), vma->vm_userfaultfd_ctx, true);
>  	if (new_vma) {
>  		/*
>  		 * Source vma may have been merged into new_vma
> @@ -3299,6 +3319,15 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
>  			get_file(new_vma->vm_file);
>  		if (new_vma->vm_ops && new_vma->vm_ops->open)
>  			new_vma->vm_ops->open(new_vma);
> +		/*
> +		 * As the VMA is linked right now, it may be hit by the
> +		 * speculative page fault handler. But we don't want it to
> +		 * to start mapping page in this area until the caller has
> +		 * potentially move the pte from the moved VMA. To prevent
> +		 * that we protect it right now, and let the caller unprotect
> +		 * it once the move is done.
> +		 */

It would be better to say:
		/*
		 * Block speculative page fault on the new VMA before "linking" it as
		 * as once it is linked then it may be hit by speculative page fault.
		 * But we don't want it to start mapping page in this area until the
		 * caller has potentially move the pte from the moved VMA. To prevent
		 * that we protect it before linking and let the caller unprotect it
		 * once the move is done.
		 */
  

> +		vm_raw_write_begin(new_vma);
>  		vma_link(mm, new_vma, prev, rb_link, rb_parent);
>  		*need_rmap_locks = false;
>  	}
> diff --git a/mm/mremap.c b/mm/mremap.c
> index fc241d23cd97..ae5c3379586e 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -357,6 +357,14 @@ static unsigned long move_vma(struct vm_area_struct *vma,
>  	if (!new_vma)
>  		return -ENOMEM;
>  
> +	/* new_vma is returned protected by copy_vma, to prevent speculative
> +	 * page fault to be done in the destination area before we move the pte.
> +	 * Now, we must also protect the source VMA since we don't want pages
> +	 * to be mapped in our back while we are copying the PTEs.
> +	 */
> +	if (vma != new_vma)
> +		vm_raw_write_begin(vma);
> +
>  	moved_len = move_page_tables(vma, old_addr, new_vma, new_addr, old_len,
>  				     need_rmap_locks);
>  	if (moved_len < old_len) {
> @@ -373,6 +381,8 @@ static unsigned long move_vma(struct vm_area_struct *vma,
>  		 */
>  		move_page_tables(new_vma, new_addr, vma, old_addr, moved_len,
>  				 true);
> +		if (vma != new_vma)
> +			vm_raw_write_end(vma);
>  		vma = new_vma;
>  		old_len = new_len;
>  		old_addr = new_addr;
> @@ -381,7 +391,10 @@ static unsigned long move_vma(struct vm_area_struct *vma,
>  		mremap_userfaultfd_prep(new_vma, uf);
>  		arch_remap(mm, old_addr, old_addr + old_len,
>  			   new_addr, new_addr + new_len);
> +		if (vma != new_vma)
> +			vm_raw_write_end(vma);
>  	}
> +	vm_raw_write_end(new_vma);
>  
>  	/* Conceal VM_ACCOUNT so old reservation is not undone */
>  	if (vm_flags & VM_ACCOUNT) {
> -- 
> 2.21.0
> 
