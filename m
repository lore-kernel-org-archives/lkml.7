Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088B9C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEBF7204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731392AbfDVTxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:53:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34836 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729892AbfDVTxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:53:11 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 669C7CA1DF;
        Mon, 22 Apr 2019 19:53:09 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BA92F10816BC;
        Mon, 22 Apr 2019 19:53:05 +0000 (UTC)
Date:   Mon, 22 Apr 2019 15:53:04 -0400
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
Subject: Re: [PATCH v12 12/31] mm: protect SPF handler against anon_vma
 changes
Message-ID: <20190422195303.GC14666@redhat.com>
References: <20190416134522.17540-1-ldufour@linux.ibm.com>
 <20190416134522.17540-13-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190416134522.17540-13-ldufour@linux.ibm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 22 Apr 2019 19:53:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 03:45:03PM +0200, Laurent Dufour wrote:
> The speculative page fault handler must be protected against anon_vma
> changes. This is because page_add_new_anon_rmap() is called during the
> speculative path.
> 
> In addition, don't try speculative page fault if the VMA don't have an
> anon_vma structure allocated because its allocation should be
> protected by the mmap_sem.
> 
> In __vma_adjust() when importer->anon_vma is set, there is no need to
> protect against speculative page faults since speculative page fault
> is aborted if the vma->anon_vma is not set.
> 
> When calling page_add_new_anon_rmap() vma->anon_vma is necessarily
> valid since we checked for it when locking the pte and the anon_vma is
> removed once the pte is unlocked. So even if the speculative page
> fault handler is running concurrently with do_unmap(), as the pte is
> locked in unmap_region() - through unmap_vmas() - and the anon_vma
> unlinked later, because we check for the vma sequence counter which is
> updated in unmap_page_range() before locking the pte, and then in
> free_pgtables() so when locking the pte the change will be detected.
> 
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>

Reviewed-by: Jérôme Glisse <jglisse@redhat.com>

> ---
>  mm/memory.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 423fa8ea0569..2cf7b6185daa 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -377,7 +377,9 @@ void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  		 * Hide vma from rmap and truncate_pagecache before freeing
>  		 * pgtables
>  		 */
> +		vm_write_begin(vma);
>  		unlink_anon_vmas(vma);
> +		vm_write_end(vma);
>  		unlink_file_vma(vma);
>  
>  		if (is_vm_hugetlb_page(vma)) {
> @@ -391,7 +393,9 @@ void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  			       && !is_vm_hugetlb_page(next)) {
>  				vma = next;
>  				next = vma->vm_next;
> +				vm_write_begin(vma);
>  				unlink_anon_vmas(vma);
> +				vm_write_end(vma);
>  				unlink_file_vma(vma);
>  			}
>  			free_pgd_range(tlb, addr, vma->vm_end,
> -- 
> 2.21.0
> 
