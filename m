Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3A1C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 21:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D3220811
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 21:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730118AbfDVVgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 17:36:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34166 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727386AbfDVVgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 17:36:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5F1213092650;
        Mon, 22 Apr 2019 21:36:21 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 94B225D9D4;
        Mon, 22 Apr 2019 21:36:13 +0000 (UTC)
Date:   Mon, 22 Apr 2019 17:36:11 -0400
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
Subject: Re: [PATCH v12 23/31] mm: don't do swap readahead during speculative
 page fault
Message-ID: <20190422213611.GN14666@redhat.com>
References: <20190416134522.17540-1-ldufour@linux.ibm.com>
 <20190416134522.17540-24-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190416134522.17540-24-ldufour@linux.ibm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 22 Apr 2019 21:36:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 03:45:14PM +0200, Laurent Dufour wrote:
> Vinayak Menon faced a panic because one thread was page faulting a page in
> swap, while another one was mprotecting a part of the VMA leading to a VMA
> split.
> This raise a panic in swap_vma_readahead() because the VMA's boundaries
> were not more matching the faulting address.
> 
> To avoid this, if the page is not found in the swap, the speculative page
> fault is aborted to retry a regular page fault.
> 
> Reported-by: Vinayak Menon <vinmenon@codeaurora.org>
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>

Reviewed-by: Jérôme Glisse <jglisse@redhat.com>

Note that you should also skip non swap entry in do_swap_page() when doing
speculative page fault at very least you need to is_device_private_entry()
case.

But this should either be part of patch 22 or another patch to fix swap
case.

> ---
>  mm/memory.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 6e6bf61c0e5c..1991da97e2db 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2900,6 +2900,17 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  				lru_cache_add_anon(page);
>  				swap_readpage(page, true);
>  			}
> +		} else if (vmf->flags & FAULT_FLAG_SPECULATIVE) {
> +			/*
> +			 * Don't try readahead during a speculative page fault
> +			 * as the VMA's boundaries may change in our back.
> +			 * If the page is not in the swap cache and synchronous
> +			 * read is disabled, fall back to the regular page
> +			 * fault mechanism.
> +			 */
> +			delayacct_clear_flag(DELAYACCT_PF_SWAPIN);
> +			ret = VM_FAULT_RETRY;
> +			goto out;
>  		} else {
>  			page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
>  						vmf);
> -- 
> 2.21.0
> 
