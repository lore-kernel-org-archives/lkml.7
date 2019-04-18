Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0622BC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 22:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D890D205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 22:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfDRWEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 18:04:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfDRWEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 18:04:22 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F159830832D8;
        Thu, 18 Apr 2019 22:04:20 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1648D60851;
        Thu, 18 Apr 2019 22:04:17 +0000 (UTC)
Date:   Thu, 18 Apr 2019 18:04:15 -0400
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
Subject: Re: [PATCH v12 05/31] mm: prepare for FAULT_FLAG_SPECULATIVE
Message-ID: <20190418220415.GE11645@redhat.com>
References: <20190416134522.17540-1-ldufour@linux.ibm.com>
 <20190416134522.17540-6-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190416134522.17540-6-ldufour@linux.ibm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 18 Apr 2019 22:04:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 03:44:56PM +0200, Laurent Dufour wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> When speculating faults (without holding mmap_sem) we need to validate
> that the vma against which we loaded pages is still valid when we're
> ready to install the new PTE.
> 
> Therefore, replace the pte_offset_map_lock() calls that (re)take the
> PTL with pte_map_lock() which can fail in case we find the VMA changed
> since we started the fault.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> [Port to 4.12 kernel]
> [Remove the comment about the fault_env structure which has been
>  implemented as the vm_fault structure in the kernel]
> [move pte_map_lock()'s definition upper in the file]
> [move the define of FAULT_FLAG_SPECULATIVE later in the series]
> [review error path in do_swap_page(), do_anonymous_page() and
>  wp_page_copy()]
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>

Reviewed-by: Jérôme Glisse <jglisse@redhat.com>

> ---
>  mm/memory.c | 87 +++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 58 insertions(+), 29 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index c6ddadd9d2b7..fc3698d13cb5 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2073,6 +2073,13 @@ int apply_to_page_range(struct mm_struct *mm, unsigned long addr,
>  }
>  EXPORT_SYMBOL_GPL(apply_to_page_range);
>  
> +static inline bool pte_map_lock(struct vm_fault *vmf)

I am not fan of the name maybe pte_offset_map_lock_if_valid() ? But
that just a taste thing. So feel free to ignore this comment.


> +{
> +	vmf->pte = pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd,
> +				       vmf->address, &vmf->ptl);
> +	return true;
> +}
> +
>  /*
>   * handle_pte_fault chooses page fault handler according to an entry which was
>   * read non-atomically.  Before making any commitment, on those architectures
