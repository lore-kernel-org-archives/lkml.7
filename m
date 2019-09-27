Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05697C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 12:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA486207FF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 12:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569587587;
	bh=k59e7iwhEetiDfExX0rhAQBUKqwevSIHgYPVLXA9sZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SNxhFF38wqAOyBP/L4Ul7wy5kZt3eQA1dOF4V1jg3+rDYAv86J666VjjgBTBPv5kz
	 vKmgLKmpr0uQb21v0l8QWQ3/VeHSOFtpVJkX+EqBaocPCuV3j/gVNWzZIYK/MEotPg
	 toL8ZtG8osFcUfPvJyaNXzK+7XiPfTvUCoZtT8uU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfI0MdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 08:33:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:48736 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726087AbfI0MdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 08:33:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6D43BB13E;
        Fri, 27 Sep 2019 12:33:01 +0000 (UTC)
Date:   Fri, 27 Sep 2019 14:33:00 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Yu Zhao <yuzhao@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <20190927123056.GE26848@dhcp22.suse.cz>
References: <20190914070518.112954-1-yuzhao@google.com>
 <20190924232459.214097-1-yuzhao@google.com>
 <20190924232459.214097-3-yuzhao@google.com>
 <20190925082530.GD4536@hirez.programming.kicks-ass.net>
 <20190925222654.GA180125@google.com>
 <20190926102036.od2wamdx2s7uznvq@box>
 <9465df76-0229-1b44-5646-5cced1bc1718@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9465df76-0229-1b44-5646-5cced1bc1718@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 26-09-19 20:26:46, John Hubbard wrote:
> On 9/26/19 3:20 AM, Kirill A. Shutemov wrote:
> > BTW, have you looked at other levels of page table hierarchy. Do we have
> > the same issue for PMD/PUD/... pages?
> > 
> 
> Along the lines of "what other memory barriers might be missing for
> get_user_pages_fast(), I'm also concerned that the synchronization between
> get_user_pages_fast() and freeing the page tables might be technically broken,
> due to missing memory barriers on the get_user_pages_fast() side. Details:
> 
> gup_fast() disables interrupts, but I think it also needs some sort of
> memory barrier(s), in order to prevent reads of the page table (gup_pgd_range,
> etc) from speculatively happening before the interrupts are disabled. 

Could you be more specific about the race scenario please? I thought
that the unmap path will be serialized by the pte lock.
-- 
Michal Hocko
SUSE Labs
