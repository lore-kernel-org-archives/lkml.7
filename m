Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14721C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 22:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE9B2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 22:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RjuYzY0N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbfIYW1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 18:27:01 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:33396 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfIYW1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 18:27:00 -0400
Received: by mail-io1-f67.google.com with SMTP id z19so1239101ior.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 15:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fm80X3RKbE4ptbvOr+D6078MZ2RjBl28nL5ykuuTQLs=;
        b=RjuYzY0NFN5UQbOo85Gxnrd6/tMuvsnauNcqjc8V/Add6MpPa7GHJKPE92tzVaI6a+
         OVwszkmyOLMSkFBO5fIGLxoabJ8uMu4klb/S0gVNKF0bJKt64NI4eKEIGrHcoIQFWc7Q
         sT3pP8+Sz8pNMYPbK/OP5DBXslYaqhJG8K2YaB0nwL3+DTjjWC+c5T1R5Do3Hxeyz4oS
         kfCdC0cdVNIkrADIjhEGBY2afz92KHgixzovi2hWrtKvCgozpbYIMQMakVcX5R7hjK/J
         83k4dR0D6+q0Nx5W+d1BlP0musvEnJ21aL5oBJA/wIpbi/2VWZzjifEZMieY7A5xIlYI
         /ENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fm80X3RKbE4ptbvOr+D6078MZ2RjBl28nL5ykuuTQLs=;
        b=c6XDOsnD3M2kgOjh/Fv/tQU+ZuGOrMFDDTBMTYA872VcMBFGAimmPBDxljW2YDUS7l
         KsBvWe+ElpTO5q8ZKLsUJuKsFhGL1iEhrjDZooHYCi3lqbQwCiQo5J8tuNuPStNSUnq3
         a/mU6+D37lZKOug0aXTp40Jr8oFbJ9E4YmPm/Y99G290/TnT1hPn3wcrd/3losgakWug
         vp9twi0swtBQIw+KI8CtK/E8ucys7pBkBEeNzGQ1WzIhvAytByfoC4SIxfZKDy48fsoH
         JuBHNqkDQ4Teih3srfArvZ3lyout+Rs8jnEVVLhVvrifZ1AvXratAFcHCRtDkduOJj4i
         6Org==
X-Gm-Message-State: APjAAAX34qHqySPXY5wJPN2UtZRHnGunsizbnsn21t04uMfkyI5Bfp1I
        ehQFUkkCWdBjkEM3lMEHQo2UDQ==
X-Google-Smtp-Source: APXvYqy9YqEdsNZhvxrBH4jGn3loHdLKjcvrLSAnBK/MTULbkW6TJqewZ9kD3D5YoQPSrFMpUB4tNA==
X-Received: by 2002:a5e:8218:: with SMTP id l24mr354085iom.56.1569450419680;
        Wed, 25 Sep 2019 15:26:59 -0700 (PDT)
Received: from google.com ([2620:15c:183:0:9f3b:444a:4649:ca05])
        by smtp.gmail.com with ESMTPSA id w7sm33392iob.17.2019.09.25.15.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 15:26:59 -0700 (PDT)
Date:   Wed, 25 Sep 2019 16:26:54 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20190925222654.GA180125@google.com>
References: <20190914070518.112954-1-yuzhao@google.com>
 <20190924232459.214097-1-yuzhao@google.com>
 <20190924232459.214097-3-yuzhao@google.com>
 <20190925082530.GD4536@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925082530.GD4536@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 10:25:30AM +0200, Peter Zijlstra wrote:
> On Tue, Sep 24, 2019 at 05:24:58PM -0600, Yu Zhao wrote:
> > We don't want to expose a non-hugetlb page to the fast gup running
> > on a remote CPU before all local non-atomic ops on the page flags
> > are visible first.
> > 
> > For an anon page that isn't in swap cache, we need to make sure all
> > prior non-atomic ops, especially __SetPageSwapBacked() in
> > page_add_new_anon_rmap(), are ordered before set_pte_at() to prevent
> > the following race:
> > 
> > 	CPU 1				CPU1
> > 	set_pte_at()			get_user_pages_fast()
> > 	  page_add_new_anon_rmap()	  gup_pte_range()
> > 	  __SetPageSwapBacked()		    SetPageReferenced()
> > 
> > This demonstrates a non-fatal scenario. Though haven't been directly
> > observed, the fatal ones can exist, e.g., PG_lock set by fast gup
> > caller and then overwritten by __SetPageSwapBacked().
> > 
> > For an anon page that is already in swap cache or a file page, we
> > don't need smp_wmb() before set_pte_at() because adding to swap or
> > file cach serves as a valid write barrier. Using non-atomic ops
> > thereafter is a bug, obviously.
> > 
> > smp_wmb() is added following 11 of total 12 page_add_new_anon_rmap()
> > call sites, with the only exception being
> > do_huge_pmd_wp_page_fallback() because of an existing smp_wmb().
> > 
> 
> I'm thinking this patch make stuff rather fragile.. Should we instead
> stick the barrier in set_p*d_at() instead? Or rather, make that store a
> store-release?

I prefer it this way too, but I suspected the majority would be
concerned with the performance implications, especially those
looping set_pte_at()s in mm/huge_memory.c.

If we have a consensus that smp_wmb() would be better off wrapped
together with set_p*d_at() in a macro, I'd be glad to make the change.

And it seems to me applying smp_store_release() would have to happen
in each arch, which might be just as fragile.
