Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCA0C48BE2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 04:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F01BF21537
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 04:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561004191;
	bh=OTRG5L04oVjCWu42HoeufbsUcW9z1Bazdk0t3gfRMHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bYdGnpPlEIc13U6HWNsi6U8xJlmdSDG+Yof5LPkQvU3fMvD0P46894TC5XnwykDk9
	 3Ur+hA2h8a/CxZql8RtlHUJNvxICFLxajyhdBor7lewoZKI34d9fyTlU3GI85hUJMn
	 lCZqaiQsPkzOTCcHRdlFdnO1JMdYDrO423s9fwt4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbfFTEQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 00:16:29 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33047 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfFTEQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 00:16:28 -0400
Received: by mail-pf1-f194.google.com with SMTP id x15so903647pfq.0;
        Wed, 19 Jun 2019 21:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zyH9dIWlfmNUKOXTFOi3+3dsuAgnXj2LnHyE8VRoTXc=;
        b=HlccYEDLCGdFzCWc2+XXxnlUmoO3pAyGNRqwlxTIzNi6/R1X8imdVc9BrUqQe7kxdf
         wjirXLQPBRskmIKpqzycg3O5Ks6K4WhYfFe2AHnmgHwkhyjQ3O1iikugt6psHm5jvF6C
         xzy8pIOiL1mVmYHXDSZ8qTeRt6Uw2pi6024sfFV2YhUQz3+IHRz2JvX/THa3K/cH1gKl
         tMCqBy1WtvaSQoh7+FtpVwYGUU88Rzuj2sj8k+PGUbqT+q3jfzKgXtyspVWDXCv69Bi6
         2AD2boCNs/jDfYHodWX5ISOCvWMQWCsLkEIV1mujAIOiJ3ET9i45v4Cv2mEu0qyjX23j
         65Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zyH9dIWlfmNUKOXTFOi3+3dsuAgnXj2LnHyE8VRoTXc=;
        b=eDefnp/Fdx4XYVTA4WmI+1OPQmpnQyMJBjPM/oK1UZ2sokBeKCrxjn44/MvmYUnUIM
         6CgxdJfQPO9Uom1/LUi8vkezaSTCsXsiBK6BDIvcubMFWACZS0mv0lv4XxXPPo9TBCkD
         ToFN+u0DYeSIml98PFt9vfItW8Ov1FULopze+cosm3g1ouJR7nA0iJE0uD1b9U+xb4wA
         gHAvsk5JRj43cSosWfTefAdsfPH+diFu83RTngozo6ntWDQe616vxYw9gy01uvKovcqp
         u3W+DPXJhZV9z4zRt/kWgNxgvCMwc62XZqBti1xr2J4Dm46viWMLKA19XtdYklpc/L+2
         PKXA==
X-Gm-Message-State: APjAAAXa941mZW6krzLWPvyadaiWFOtSolKzQm99dpsUX9JpxqIGJztM
        hDHcYQKbGd68UYeGNNcRDLk=
X-Google-Smtp-Source: APXvYqyrXakYf1mOgEwcNtY1GbmgWRkGU/vcHWbzk94WlGzEI7BfgdBAHm4S3UHVri6Jafyu625cLQ==
X-Received: by 2002:a63:1226:: with SMTP id h38mr10879479pgl.196.1561004187871;
        Wed, 19 Jun 2019 21:16:27 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id j64sm30038956pfb.126.2019.06.19.21.16.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 21:16:26 -0700 (PDT)
Date:   Thu, 20 Jun 2019 13:16:20 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, jannh@google.com,
        oleg@redhat.com, christian@brauner.io, oleksandr@redhat.com,
        hdanton@sina.com, lizeb@google.com
Subject: Re: [PATCH v2 4/5] mm: introduce MADV_PAGEOUT
Message-ID: <20190620041620.GB105727@google.com>
References: <20190610111252.239156-1-minchan@kernel.org>
 <20190610111252.239156-5-minchan@kernel.org>
 <20190619132450.GQ2968@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619132450.GQ2968@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 03:24:50PM +0200, Michal Hocko wrote:
> On Mon 10-06-19 20:12:51, Minchan Kim wrote:
> [...]
> > +static int madvise_pageout_pte_range(pmd_t *pmd, unsigned long addr,
> > +				unsigned long end, struct mm_walk *walk)
> 
> Again the same question about a potential code reuse...
> [...]
> > +regular_page:
> > +	tlb_change_page_size(tlb, PAGE_SIZE);
> > +	orig_pte = pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
> > +	flush_tlb_batched_pending(mm);
> > +	arch_enter_lazy_mmu_mode();
> > +	for (; addr < end; pte++, addr += PAGE_SIZE) {
> > +		ptent = *pte;
> > +		if (!pte_present(ptent))
> > +			continue;
> > +
> > +		page = vm_normal_page(vma, addr, ptent);
> > +		if (!page)
> > +			continue;
> > +
> > +		if (isolate_lru_page(page))
> > +			continue;
> > +
> > +		isolated++;
> > +		if (pte_young(ptent)) {
> > +			ptent = ptep_get_and_clear_full(mm, addr, pte,
> > +							tlb->fullmm);
> > +			ptent = pte_mkold(ptent);
> > +			set_pte_at(mm, addr, pte, ptent);
> > +			tlb_remove_tlb_entry(tlb, pte, addr);
> > +		}
> > +		ClearPageReferenced(page);
> > +		test_and_clear_page_young(page);
> > +		list_add(&page->lru, &page_list);
> > +		if (isolated >= SWAP_CLUSTER_MAX) {
> 
> Why do we need SWAP_CLUSTER_MAX batching? Especially when we need ...
> [...]

It aims for preventing early OOM kill since we isolate too many LRU
pages concurrently.

> 
> > +unsigned long reclaim_pages(struct list_head *page_list)
> > +{
> > +	int nid = -1;
> > +	unsigned long nr_reclaimed = 0;
> > +	LIST_HEAD(node_page_list);
> > +	struct reclaim_stat dummy_stat;
> > +	struct scan_control sc = {
> > +		.gfp_mask = GFP_KERNEL,
> > +		.priority = DEF_PRIORITY,
> > +		.may_writepage = 1,
> > +		.may_unmap = 1,
> > +		.may_swap = 1,
> > +	};
> > +
> > +	while (!list_empty(page_list)) {
> > +		struct page *page;
> > +
> > +		page = lru_to_page(page_list);
> > +		if (nid == -1) {
> > +			nid = page_to_nid(page);
> > +			INIT_LIST_HEAD(&node_page_list);
> > +		}
> > +
> > +		if (nid == page_to_nid(page)) {
> > +			list_move(&page->lru, &node_page_list);
> > +			continue;
> > +		}
> > +
> > +		nr_reclaimed += shrink_page_list(&node_page_list,
> > +						NODE_DATA(nid),
> > +						&sc, 0,
> > +						&dummy_stat, false);
> 
> per-node batching in fact. Other than that nothing really jumped at me.
> Except for the shared page cache side channel timing aspect not being
> considered AFAICS. To be more specific. Pushing out a shared page cache
> is possible even now but this interface gives a much easier tool to
> evict shared state and perform all sorts of timing attacks. Unless I am
> missing something we should be doing something similar to mincore and
> ignore shared pages without a writeable access or at least document why
> we do not care.

I'm not sure IIUC side channel attach. As you mentioned, without this syscall,
1. they already can do that simply by memory hogging
2. If we need fix MADV_PAGEOUT, that means we need to fix MADV_DONTNEED, too?
