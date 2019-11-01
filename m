Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B16CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 09:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69B7B20656
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 09:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NcQJUAL0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbfKAJYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 05:24:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57452 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbfKAJYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 05:24:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cK8RDKGLEBSFrlPBnRxYMsLMSEeAec+1Jsjy1sax2wA=; b=NcQJUAL0u7F0uHiPkOCjzAtVh
        uaVCWT7io6zbjwzq6lGBlRbwKu2RVehnFmi5gfhZDqMiillQvsNnI52omCopCGJCGkOWMA3X8UjEd
        v0RdE66Gl0aAZ0F0A0Fz3yPQDZdRWYyyDbooey1P3TTJ+vLKXY+1GSjo4ZVGjsxgBIdb+PfVxY677
        laHKHXvSlxYWe0MuX0sGRIn3CtNeoezYDVMg01Op6TBKHe2C7nQqP33qJ9UiN0BmV2u0P8O+WXTpI
        ofH9OilWeBAnBtYGbwH85Z6Ms63xeFgYhU7SLh/exL49l107cu/McPPFKifzVQWrSs7Sf863xYkvP
        v0R1wZ5cQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iQTA7-0008HP-Qb; Fri, 01 Nov 2019 09:24:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C2B69305E42;
        Fri,  1 Nov 2019 10:23:02 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9A20E26540344; Fri,  1 Nov 2019 10:24:04 +0100 (CET)
Date:   Fri, 1 Nov 2019 10:24:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [RFC 08/10] autonuma, memory tiering: Select hotter pages to
 promote to fast memory node
Message-ID: <20191101092404.GS4131@hirez.programming.kicks-ass.net>
References: <20191101075727.26683-1-ying.huang@intel.com>
 <20191101075727.26683-9-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101075727.26683-9-ying.huang@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2019 at 03:57:25PM +0800, Huang, Ying wrote:
> index 8ec38b11b361..59e2151734ab 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -484,6 +484,11 @@ struct mm_struct {
>  
>  		/* numa_scan_seq prevents two threads setting pte_numa */
>  		int numa_scan_seq;
> +
> +#define NUMA_SCAN_NR_HIST	16
> +		int numa_scan_idx;
> +		unsigned long numa_scan_jiffies[NUMA_SCAN_NR_HIST];
> +		unsigned long numa_scan_starts[NUMA_SCAN_NR_HIST];

Why 16? This is 4 cachelines.

>  #endif
>  		/*
>  		 * An operation with batched TLB flushing is going on. Anything

> +static long numa_hint_fault_latency(struct task_struct *p, unsigned long addr)
> +{
> +	struct mm_struct *mm = p->mm;
> +	unsigned long now = jiffies;
> +	unsigned long start, end;
> +	int i, j;
> +	long latency = 0;
> +
> +	i = READ_ONCE(mm->numa_scan_idx);
> +	i = i ? i - 1 : NUMA_SCAN_NR_HIST - 1;
> +	/*
> +	 * Paired with smp_wmb() in task_numa_work() to check
> +	 * scan range buffer after get current index
> +	 */
> +	smp_rmb();

That wants to be:

	i = smp_load_acquire(&mm->numa_scan_idx)
	i = (i - 1) % NUMA_SCAN_NR_HIST;

(and because NUMA_SCAN_NR_HIST is a power of 2, the compiler will
conveniently make that a bitwise and operation)

And: "DEC %0; AND $15, %0" is so much faster than a branch.

> +	end = READ_ONCE(mm->numa_scan_offset);
> +	start = READ_ONCE(mm->numa_scan_starts[i]);
> +	if (start == end)
> +		end = start + MAX_SCAN_WINDOW * (1UL << 22);
> +	for (j = 0; j < NUMA_SCAN_NR_HIST; j++) {
> +		latency = now - READ_ONCE(mm->numa_scan_jiffies[i]);
> +		start = READ_ONCE(mm->numa_scan_starts[i]);
> +		/* Scan pass the end of address space */
> +		if (end < start)
> +			end = TASK_SIZE;
> +		if (addr >= start && addr < end)
> +			return latency;
> +		end = start;
> +		i = i ? i - 1 : NUMA_SCAN_NR_HIST - 1;

		i = (i - 1) % NUMA_SCAN_NR_HIST;
> +	}
> +	/*
> +	 * The tracking window isn't large enough, approximate to the
> +	 * max latency in the tracking window.
> +	 */
> +	return latency;
> +}

> @@ -2583,6 +2640,19 @@ void task_numa_work(struct callback_head *work)
>  		start = 0;
>  		vma = mm->mmap;
>  	}
> +	idx = mm->numa_scan_idx;
> +	WRITE_ONCE(mm->numa_scan_starts[idx], start);
> +	WRITE_ONCE(mm->numa_scan_jiffies[idx], jiffies);
> +	/*
> +	 * Paired with smp_rmb() in should_numa_migrate_memory() to
> +	 * update scan range buffer index after update the buffer
> +	 * contents.
> +	 */
> +	smp_wmb();
> +	if (idx + 1 >= NUMA_SCAN_NR_HIST)
> +		WRITE_ONCE(mm->numa_scan_idx, 0);
> +	else
> +		WRITE_ONCE(mm->numa_scan_idx, idx + 1);

	smp_store_release(&mm->nums_scan_idx, idx % NUMA_SCAN_NR_HIST);

