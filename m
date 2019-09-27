Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B662AC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 03:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8298820835
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 03:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="WW+FlArb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbfI0D0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 23:26:54 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:13757 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfI0D0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 23:26:54 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d8d817f0001>; Thu, 26 Sep 2019 20:26:55 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 26 Sep 2019 20:26:47 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 26 Sep 2019 20:26:47 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 27 Sep
 2019 03:26:47 +0000
Received: from [10.110.48.28] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 27 Sep
 2019 03:26:46 +0000
Subject: Re: [PATCH v3 3/4] mm: don't expose non-hugetlb page to fast gup
 prematurely
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Yu Zhao <yuzhao@google.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        "Matthew Wilcox" <willy@infradead.org>,
        Lance Roy <ldr709@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dave Airlie <airlied@redhat.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        "Souptick Joarder" <jrdr.linux@gmail.com>,
        Mel Gorman <mgorman@suse.de>, Jan Kara <jack@suse.cz>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Huang Ying <ying.huang@intel.com>,
        Aaron Lu <ziqian.lzq@antfin.com>,
        Omar Sandoval <osandov@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Vineeth Remanan Pillai" <vpillai@digitalocean.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Joel Fernandes" <joel@joelfernandes.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        David Hildenbrand <david@redhat.com>,
        "Juergen Gross" <jgross@suse.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20190914070518.112954-1-yuzhao@google.com>
 <20190924232459.214097-1-yuzhao@google.com>
 <20190924232459.214097-3-yuzhao@google.com>
 <20190925082530.GD4536@hirez.programming.kicks-ass.net>
 <20190925222654.GA180125@google.com> <20190926102036.od2wamdx2s7uznvq@box>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <9465df76-0229-1b44-5646-5cced1bc1718@nvidia.com>
Date:   Thu, 26 Sep 2019 20:26:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190926102036.od2wamdx2s7uznvq@box>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1569554815; bh=egY5mIbbgd+J+vpq6C8JC/J36FKgzWr8RvesXNv+VsM=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=WW+FlArb73GYdf9P+k5qe1WUQ2YY2IxWdxWfI0cc7UlrRPaP1Czs+ecK0HKxxc2NU
         mDE1LTO9Y6oW/z2Lypzne4wjnM+VjmGZbmDKL4hNqz4u/yJn4j9lIcVyoLX6fw+mPc
         al6KRFBmzunBJsK524j8PraPpqFomZ9Kf/48AsQwWGY9LfBUaXQTUrjYNyRe6sD3c1
         N00QGzJFKlhk9BL227Mo80xPhMN56SnaXTDNbd+hPV5eb2LObkB0RT2Zo/DmhF5t32
         PrbrVBSGMbV6hbumdHAmTq0bD+xJw2sCCyy0pNDB9ioFIwqUuUYw/+MoOo1zjJQDUr
         Rbol2eQn2LDWQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/19 3:20 AM, Kirill A. Shutemov wrote:
> On Wed, Sep 25, 2019 at 04:26:54PM -0600, Yu Zhao wrote:
>> On Wed, Sep 25, 2019 at 10:25:30AM +0200, Peter Zijlstra wrote:
>>> On Tue, Sep 24, 2019 at 05:24:58PM -0600, Yu Zhao wrote:
...
>>> I'm thinking this patch make stuff rather fragile.. Should we instead
>>> stick the barrier in set_p*d_at() instead? Or rather, make that store a
>>> store-release?
>>
>> I prefer it this way too, but I suspected the majority would be
>> concerned with the performance implications, especially those
>> looping set_pte_at()s in mm/huge_memory.c.
> 
> We can rename current set_pte_at() to __set_pte_at() or something and
> leave it in places where barrier is not needed. The new set_pte_at()( will
> be used in the rest of the places with the barrier inside.

+1, sounds nice. I was unhappy about the wide-ranging changes that would have
to be maintained. So this seems much better.

> 
> BTW, have you looked at other levels of page table hierarchy. Do we have
> the same issue for PMD/PUD/... pages?
> 

Along the lines of "what other memory barriers might be missing for
get_user_pages_fast(), I'm also concerned that the synchronization between
get_user_pages_fast() and freeing the page tables might be technically broken,
due to missing memory barriers on the get_user_pages_fast() side. Details:

gup_fast() disables interrupts, but I think it also needs some sort of
memory barrier(s), in order to prevent reads of the page table (gup_pgd_range,
etc) from speculatively happening before the interrupts are disabled. 

Leonardo Bras's recent patchset brought this to my attention. Here, he's
recommending adding atomic counting inc/dec before and after the gup_fast()
irq disable/enable points:

   https://lore.kernel.org/r/20190920195047.7703-4-leonardo@linux.ibm.com

...and that lead to noticing a general lack of barriers there.

thanks,
-- 
John Hubbard
NVIDIA
