Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81450C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 10:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E6A920872
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 10:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="nl0EgOZE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfIZKUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 06:20:37 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34697 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfIZKUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 06:20:36 -0400
Received: by mail-ed1-f65.google.com with SMTP id p10so1486948edq.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 03:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uodT1tvqiLXKIQ9l11hzMNokMAMRHRuaFSCfPW/0x+Q=;
        b=nl0EgOZEmR/2eDBMsHsl1NkGuQqHpVQuP2oxBd/PHOy5geDmP+pCLMBvqgGT3FYSVS
         yGJ2TidbyOpmM3KEpZEF3PE4uT/ixFGFlRZvg9sTEyOrTvcmy02ygNBSbd9NbCy9Pctj
         56jpjuDDpMU/Vtk6NoH8haCnOB7+figVhUk0HlUOBVqYXQAr2yyC8XnyuUl0iK8sscQL
         X6LiwY9/fBFJeP4QIMELcDOJO395MwOlR0nJj230a3nAxPckAD+pfVSM7UJ4NxgAWebh
         eGRo37sLOjdvFU6fmtH4He30tvvqRv5BMDt9dB9sXumgfoMfFgDFF6Kkhjm/+fO1W1KH
         NKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uodT1tvqiLXKIQ9l11hzMNokMAMRHRuaFSCfPW/0x+Q=;
        b=CiCM/PLtLWWEagRo4JGKrEZfqFLgO1uSQ8kf8n2QgijtCj9mJELzMhEOcYhve1y54x
         kseYT/PmWhGqOzgU25SQqTNKcrhjw8lPcWYkxssUhDNRo/zGLT+iY+ZHLp94OC4TOEu3
         8pvOZJ1VKHz4WkMKhTkF/X7VO7BxpqwVA9wFIT7XQg/W8sYgs+SXtxda3vstS66mavZM
         eMiUWoHtREbyHsCHsb1loftlnpwPh1lTWzlivsSZPU4twd5wDNOGSdt1hJICHiuMoooQ
         L06mDwhocMwXDRXNdmNHHVpmDZ/jFnHIpJF4HkFzeb2yiSQJS+Mj8e30UtpYnSFDsPpv
         WIPg==
X-Gm-Message-State: APjAAAW6iTdOwggorBaejmMntxSvONpJHXmKonKV8ORxxxAneP5OUHaZ
        FWKG/nBoZvjPXCP1RgImswtVjQ==
X-Google-Smtp-Source: APXvYqzT/xeF8LftFGtdXRpxzSQcoKhuuXTF4UkNJxXgidDWnzF/Jo1kQ/JnCn8qAHoQ+s6dHxlGug==
X-Received: by 2002:a17:906:c72d:: with SMTP id fj13mr2421561ejb.36.1569493234452;
        Thu, 26 Sep 2019 03:20:34 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id fx25sm181773ejb.19.2019.09.26.03.20.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 03:20:33 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 3D9931004E0; Thu, 26 Sep 2019 13:20:36 +0300 (+03)
Date:   Thu, 26 Sep 2019 13:20:36 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
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
Message-ID: <20190926102036.od2wamdx2s7uznvq@box>
References: <20190914070518.112954-1-yuzhao@google.com>
 <20190924232459.214097-1-yuzhao@google.com>
 <20190924232459.214097-3-yuzhao@google.com>
 <20190925082530.GD4536@hirez.programming.kicks-ass.net>
 <20190925222654.GA180125@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925222654.GA180125@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 04:26:54PM -0600, Yu Zhao wrote:
> On Wed, Sep 25, 2019 at 10:25:30AM +0200, Peter Zijlstra wrote:
> > On Tue, Sep 24, 2019 at 05:24:58PM -0600, Yu Zhao wrote:
> > > We don't want to expose a non-hugetlb page to the fast gup running
> > > on a remote CPU before all local non-atomic ops on the page flags
> > > are visible first.
> > > 
> > > For an anon page that isn't in swap cache, we need to make sure all
> > > prior non-atomic ops, especially __SetPageSwapBacked() in
> > > page_add_new_anon_rmap(), are ordered before set_pte_at() to prevent
> > > the following race:
> > > 
> > > 	CPU 1				CPU1
> > > 	set_pte_at()			get_user_pages_fast()
> > > 	  page_add_new_anon_rmap()	  gup_pte_range()
> > > 	  __SetPageSwapBacked()		    SetPageReferenced()
> > > 
> > > This demonstrates a non-fatal scenario. Though haven't been directly
> > > observed, the fatal ones can exist, e.g., PG_lock set by fast gup
> > > caller and then overwritten by __SetPageSwapBacked().
> > > 
> > > For an anon page that is already in swap cache or a file page, we
> > > don't need smp_wmb() before set_pte_at() because adding to swap or
> > > file cach serves as a valid write barrier. Using non-atomic ops
> > > thereafter is a bug, obviously.
> > > 
> > > smp_wmb() is added following 11 of total 12 page_add_new_anon_rmap()
> > > call sites, with the only exception being
> > > do_huge_pmd_wp_page_fallback() because of an existing smp_wmb().
> > > 
> > 
> > I'm thinking this patch make stuff rather fragile.. Should we instead
> > stick the barrier in set_p*d_at() instead? Or rather, make that store a
> > store-release?
> 
> I prefer it this way too, but I suspected the majority would be
> concerned with the performance implications, especially those
> looping set_pte_at()s in mm/huge_memory.c.

We can rename current set_pte_at() to __set_pte_at() or something and
leave it in places where barrier is not needed. The new set_pte_at()( will
be used in the rest of the places with the barrier inside.

BTW, have you looked at other levels of page table hierarchy. Do we have
the same issue for PMD/PUD/... pages?

-- 
 Kirill A. Shutemov
