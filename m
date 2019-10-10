Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168B8C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 14:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD946206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 14:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jZArptxn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfJJORj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 10:17:39 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60470 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfJJORj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 10:17:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GcmjLamblsipJndFqQX14RI3sseXb9QldwoaQXNfrwU=; b=jZArptxnJb9aguyp+Bm/QAHddW
        FhkxIt+eNF4qHM0fj3A84H2nylCEnN2ar1r46N8q3dTAismqMC3SrYJ8mZAl09ti3przbGXN+KWDV
        5Jc00/+dJR8TWDHN2nAPdX4CB3Gc8C4cbb4hAi1f97setrjypfIwolGGJGZJTd14gsHdVEGL2Rjpj
        xVJ+EqQLtqNPcY3oj9gw+WWAYT+Qln8mURjmbXjhmkI0YDtBrDkeYf44iGF6dRF7ApLeMrZFgLVhT
        2bC+jRedDDvTlgGg6OL4/04iwlFbQXXGErRV9icjB4qkYPTRSN4/XUboesCpmnvtFnvkaDHYsPoLt
        Xwi0dmtA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIZFe-0008Mt-6X; Thu, 10 Oct 2019 14:17:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0469E301224;
        Thu, 10 Oct 2019 16:16:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3CF99202BC5A6; Thu, 10 Oct 2019 16:17:08 +0200 (CEST)
Date:   Thu, 10 Oct 2019 16:17:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas =?iso-8859-1?Q?Hellstr=F6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        torvalds@linux-foundation.org, kirill@shutemov.name,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>
Subject: Re: [PATCH v5 4/8] mm: Add write-protect and clean utilities for
 address space ranges
Message-ID: <20191010141708.GV2311@hirez.programming.kicks-ass.net>
References: <20191010124314.40067-1-thomas_os@shipmail.org>
 <20191010124314.40067-5-thomas_os@shipmail.org>
 <20191010130542.GP2328@hirez.programming.kicks-ass.net>
 <45cf5965-bd63-3574-d8c2-abbd6c4960d5@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45cf5965-bd63-3574-d8c2-abbd6c4960d5@shipmail.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 03:24:47PM +0200, Thomas Hellström (VMware) wrote:
> On 10/10/19 3:05 PM, Peter Zijlstra wrote:
> > On Thu, Oct 10, 2019 at 02:43:10PM +0200, Thomas Hellström (VMware) wrote:

> > > +/**
> > > + * wp_shared_mapping_range - Write-protect all ptes in an address space range
> > > + * @mapping: The address_space we want to write protect
> > > + * @first_index: The first page offset in the range
> > > + * @nr: Number of incremental page offsets to cover
> > > + *
> > > + * Note: This function currently skips transhuge page-table entries, since
> > > + * it's intended for dirty-tracking on the PTE level. It will warn on
> > > + * encountering transhuge write-enabled entries, though, and can easily be
> > > + * extended to handle them as well.
> > > + *
> > > + * Return: The number of ptes actually write-protected. Note that
> > > + * already write-protected ptes are not counted.
> > > + */
> > > +unsigned long wp_shared_mapping_range(struct address_space *mapping,
> > > +				      pgoff_t first_index, pgoff_t nr)
> > > +{
> > > +	struct wp_walk wpwalk = { .total = 0 };
> > > +
> > > +	i_mmap_lock_read(mapping);
> > > +	WARN_ON(walk_page_mapping(mapping, first_index, nr, &wp_walk_ops,
> > > +				  &wpwalk));
> > > +	i_mmap_unlock_read(mapping);
> > > +
> > > +	return wpwalk.total;
> > > +}

> > That's a read lock, this means there's concurrency to self. What happens
> > if someone does two concurrent wp_shared_mapping_range() on the same
> > mapping?
> > 
> > The thing is, because of pte_wrprotect() the iteration that starts last
> > will see a smaller pte_write range, if it completes first and does
> > flush_tlb_range(), it will only flush a partial range.
> > 
> > This is exactly what {inc,dec}_tlb_flush_pending() is for, but you're
> > not using mm_tlb_flush_nested() to detect the situation and do a bigger
> > flush.
> > 
> > Or if you're not needing that, then I'm missing why.
> 
> Good catch. Thanks,
> 
> Yes the read lock is not intended to protect against concurrent users but to
> protect the vmas from disappearing under us. Since it fundamentally makes no
> sense having two concurrent threads picking up dirty ptes on the same
> address_space range we have an external range-based lock to protect against
> that.

Nothing mandates/verifies the function you expose is used exclusively.
Therefore you cannot make assumptions on that range lock your user has.

> However, that external lock doesn't protect other code  from concurrently
> modifying ptes and having the mm's  tlb_flush_pending increased, so I guess
> we unconditionally need to test for that and do a full range flush if
> necessary?

Yes, something like:

	if (mm_tlb_flush_nested(mm))
		flush_tlb_range(walk->vma, walk->vma->vm_start, walk->vma->vm_end);
	else  if (wpwalk->tlbflush_end > wpwalk->tlbflush_start)
		flush_tlb_range(walk->vma, wpwalk->tlbflush_start, wpwalk->tlbflush_end);


