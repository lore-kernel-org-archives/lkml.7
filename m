Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF98C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB7B20859
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 20:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbfDVUc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 16:32:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40452 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727190AbfDVUcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 16:32:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 27DE43092654;
        Mon, 22 Apr 2019 20:32:24 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CBEE05D6A6;
        Mon, 22 Apr 2019 20:32:19 +0000 (UTC)
Date:   Mon, 22 Apr 2019 16:32:18 -0400
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
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        Vinayak Menon <vinmenon@codeaurora.org>
Subject: Re: [PATCH v12 18/31] mm: protect against PTE changes done by
 dup_mmap()
Message-ID: <20190422203217.GI14666@redhat.com>
References: <20190416134522.17540-1-ldufour@linux.ibm.com>
 <20190416134522.17540-19-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190416134522.17540-19-ldufour@linux.ibm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 22 Apr 2019 20:32:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 03:45:09PM +0200, Laurent Dufour wrote:
> Vinayak Menon and Ganesh Mahendran reported that the following scenario may
> lead to thread being blocked due to data corruption:
> 
>     CPU 1                   CPU 2                    CPU 3
>     Process 1,              Process 1,               Process 1,
>     Thread A                Thread B                 Thread C
> 
>     while (1) {             while (1) {              while(1) {
>     pthread_mutex_lock(l)   pthread_mutex_lock(l)    fork
>     pthread_mutex_unlock(l) pthread_mutex_unlock(l)  }
>     }                       }
> 
> In the details this happens because :
> 
>     CPU 1                CPU 2                       CPU 3
>     fork()
>     copy_pte_range()
>       set PTE rdonly
>     got to next VMA...
>      .                   PTE is seen rdonly          PTE still writable
>      .                   thread is writing to page
>      .                   -> page fault
>      .                     copy the page             Thread writes to page
>      .                      .                        -> no page fault
>      .                     update the PTE
>      .                     flush TLB for that PTE
>    flush TLB                                        PTE are now rdonly

Should the fork be on CPU3 to be consistant with the top thing (just to
make it easier to read and go from one to the other as thread can move
from one CPU to another).

> 
> So the write done by the CPU 3 is interfering with the page copy operation
> done by CPU 2, leading to the data corruption.
> 
> To avoid this we mark all the VMA involved in the COW mechanism as changing
> by calling vm_write_begin(). This ensures that the speculative page fault
> handler will not try to handle a fault on these pages.
> The marker is set until the TLB is flushed, ensuring that all the CPUs will
> now see the PTE as not writable.
> Once the TLB is flush, the marker is removed by calling vm_write_end().
> 
> The variable last is used to keep tracked of the latest VMA marked to
> handle the error path where part of the VMA may have been marked.
> 
> Since multiple VMA from the same mm may have the sequence count increased
> during this process, the use of the vm_raw_write_begin/end() is required to
> avoid lockdep false warning messages.
> 
> Reported-by: Ganesh Mahendran <opensource.ganesh@gmail.com>
> Reported-by: Vinayak Menon <vinmenon@codeaurora.org>
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>

A minor comment (see below)

Reviewed-by: Jérome Glisse <jglisse@redhat.com>

> ---
>  kernel/fork.c | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index f8dae021c2e5..2992d2c95256 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -462,7 +462,7 @@ EXPORT_SYMBOL(free_task);
>  static __latent_entropy int dup_mmap(struct mm_struct *mm,
>  					struct mm_struct *oldmm)
>  {
> -	struct vm_area_struct *mpnt, *tmp, *prev, **pprev;
> +	struct vm_area_struct *mpnt, *tmp, *prev, **pprev, *last = NULL;
>  	struct rb_node **rb_link, *rb_parent;
>  	int retval;
>  	unsigned long charge;
> @@ -581,8 +581,18 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>  		rb_parent = &tmp->vm_rb;
>  
>  		mm->map_count++;
> -		if (!(tmp->vm_flags & VM_WIPEONFORK))
> +		if (!(tmp->vm_flags & VM_WIPEONFORK)) {
> +			if (IS_ENABLED(CONFIG_SPECULATIVE_PAGE_FAULT)) {
> +				/*
> +				 * Mark this VMA as changing to prevent the
> +				 * speculative page fault hanlder to process
> +				 * it until the TLB are flushed below.
> +				 */
> +				last = mpnt;
> +				vm_raw_write_begin(mpnt);
> +			}
>  			retval = copy_page_range(mm, oldmm, mpnt);
> +		}
>  
>  		if (tmp->vm_ops && tmp->vm_ops->open)
>  			tmp->vm_ops->open(tmp);
> @@ -595,6 +605,22 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>  out:
>  	up_write(&mm->mmap_sem);
>  	flush_tlb_mm(oldmm);
> +
> +	if (IS_ENABLED(CONFIG_SPECULATIVE_PAGE_FAULT)) {

You do not need to check for CONFIG_SPECULATIVE_PAGE_FAULT as last
will always be NULL if it is not enabled but maybe the compiler will
miss the optimization opportunity if you only have the for() loop
below.

> +		/*
> +		 * Since the TLB has been flush, we can safely unmark the
> +		 * copied VMAs and allows the speculative page fault handler to
> +		 * process them again.
> +		 * Walk back the VMA list from the last marked VMA.
> +		 */
> +		for (; last; last = last->vm_prev) {
> +			if (last->vm_flags & VM_DONTCOPY)
> +				continue;
> +			if (!(last->vm_flags & VM_WIPEONFORK))
> +				vm_raw_write_end(last);
> +		}
> +	}
> +
>  	up_write(&oldmm->mmap_sem);
>  	dup_userfaultfd_complete(&uf);
>  fail_uprobe_end:
> -- 
> 2.21.0
> 
