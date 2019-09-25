Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA75C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 08:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52AF420673
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 08:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rnYUVZzV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634095AbfIYI0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 04:26:30 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54340 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390395AbfIYI03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 04:26:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DRbHerM9iFz/oCn53SFE8k+MUPxbTmaLoiDUNBRlp3M=; b=rnYUVZzVhCIRJFlNBHNU4yQ6c
        nSSiXlUyE8NHe8EwbRiudXxM85s2Eq4Z3XQMo2djwEBzDtmXYif4TXhkMeo0XSfIwO922cPnaDtVr
        MZsO/09KOVCZerABUxo4USdA/fcZaBOU9T0mYy4fg9cfejBFMSsHPk89ubyTemv6Wt8mvil5k4/f4
        6XvSQIaVzp9kEGCWvnlwNlJybmuUc5ZjU3r//pGiX3csY66tRhgpdH4PQBM6MA0NuEeuUYfQALVA7
        pqFLBHD0ZUWcby3aILQ3YAjjx8XKM4mTnavryOTbNNO06Jf8tkYieJ3V8l5hp62jW7niXHip3S7j8
        oe05RdneA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iD2c9-0001dI-7g; Wed, 25 Sep 2019 08:25:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EF4EF302A71;
        Wed, 25 Sep 2019 10:24:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B8CBD203E5080; Wed, 25 Sep 2019 10:25:30 +0200 (CEST)
Date:   Wed, 25 Sep 2019 10:25:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Lance Roy <ldr709@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dave Airlie <airlied@redhat.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Mel Gorman <mgorman@suse.de>, Jan Kara <jack@suse.cz>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Huang Ying <ying.huang@intel.com>,
        Aaron Lu <ziqian.lzq@antfin.com>,
        Omar Sandoval <osandov@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        David Hildenbrand <david@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 3/4] mm: don't expose non-hugetlb page to fast gup
 prematurely
Message-ID: <20190925082530.GD4536@hirez.programming.kicks-ass.net>
References: <20190914070518.112954-1-yuzhao@google.com>
 <20190924232459.214097-1-yuzhao@google.com>
 <20190924232459.214097-3-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924232459.214097-3-yuzhao@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 05:24:58PM -0600, Yu Zhao wrote:
> We don't want to expose a non-hugetlb page to the fast gup running
> on a remote CPU before all local non-atomic ops on the page flags
> are visible first.
> 
> For an anon page that isn't in swap cache, we need to make sure all
> prior non-atomic ops, especially __SetPageSwapBacked() in
> page_add_new_anon_rmap(), are ordered before set_pte_at() to prevent
> the following race:
> 
> 	CPU 1				CPU1
> 	set_pte_at()			get_user_pages_fast()
> 	  page_add_new_anon_rmap()	  gup_pte_range()
> 	  __SetPageSwapBacked()		    SetPageReferenced()
> 
> This demonstrates a non-fatal scenario. Though haven't been directly
> observed, the fatal ones can exist, e.g., PG_lock set by fast gup
> caller and then overwritten by __SetPageSwapBacked().
> 
> For an anon page that is already in swap cache or a file page, we
> don't need smp_wmb() before set_pte_at() because adding to swap or
> file cach serves as a valid write barrier. Using non-atomic ops
> thereafter is a bug, obviously.
> 
> smp_wmb() is added following 11 of total 12 page_add_new_anon_rmap()
> call sites, with the only exception being
> do_huge_pmd_wp_page_fallback() because of an existing smp_wmb().
> 

I'm thinking this patch make stuff rather fragile.. Should we instead
stick the barrier in set_p*d_at() instead? Or rather, make that store a
store-release?


