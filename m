Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEA1C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 00:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B281921920
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 00:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b6M8s8Kx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbfJBAAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 20:00:54 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40802 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfJBAAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 20:00:53 -0400
Received: by mail-io1-f68.google.com with SMTP id h144so52642487iof.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 17:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HRoUIDj1r8i/Ij0NQgXqYrayFN5Nee0d4B0FhL1c8iQ=;
        b=b6M8s8KxOjS1ZmfLWDD0K48VF/aZb0ck5PqQp7kbunEnIyg1qZfxy72WXGFkyKgEyT
         gYsqU6v2omDpvO+/qRugfjZYkDaQ5t8d/H/KfvynvAC8Cw7GnqghCQlt5C7Js9iUOldL
         emkC1mCIHUCdJJ8MWTqSCx1L+nlhkXY3APJlw5iaFWb62RdEn2UNrcccDJMn2FAGLGE4
         +XjonTJiBJWD8NvkqgoqIwA9PTVo/G4wkgQ12i6p9cNezDFNc1fIL913kFFct+zxw+QT
         raSk6QdQUD3flDuBkqofdEJhyJ6CHBO1SAhCfT3EuzLjDNwlbMIFvFN8gX7D5nzjzhwP
         aeIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HRoUIDj1r8i/Ij0NQgXqYrayFN5Nee0d4B0FhL1c8iQ=;
        b=qqn26hmkAeVyuFmBWz5QIDSyPCJrUamKTmwM0Zl5FBFDWb21ZyovJ1chOk7CLSM7L/
         VcekTGyrtB9vZEnpZ8t78Up0ygTBkONJPXfbe6W2u74Pn4HW8uSLPaDEs2UVEpeyNDfQ
         3/HLFPmiOwjxpOog/JpnS5wNVvH+950Suc80uYBxqDRyNjhveulxOgvgL3g3+ySEdzmw
         /z04U/eepXlgNd8anJ6ny09sILyF4hK0bhMGV+Roahu25rNp0HH3sO5GFwA8urMplLnG
         OdoQ+hCbN1Mt54DgigLpDAqIJhVp2ZNyau+9pF27Q/CRrkbz6PIj5BxMBpb5yIPiDRJH
         FA1A==
X-Gm-Message-State: APjAAAURk+D6aL/JlKPtKcBrLu2fpGLy079mpGlAeVX6/zqF7ufsjPdO
        4kU8SE1QRPMteGp3K1g7fF2HLg==
X-Google-Smtp-Source: APXvYqzEkD7xquRTtDPw329fI8Jif2fv/j8emc8DGNLITQydAzaOFYo8NZx2LF9UYnO8CSBm8J/ebg==
X-Received: by 2002:a92:8988:: with SMTP id w8mr882693ilk.86.1569974452245;
        Tue, 01 Oct 2019 17:00:52 -0700 (PDT)
Received: from google.com ([2620:15c:183:0:9f3b:444a:4649:ca05])
        by smtp.gmail.com with ESMTPSA id r138sm7936092iod.59.2019.10.01.17.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 17:00:51 -0700 (PDT)
Date:   Tue, 1 Oct 2019 18:00:46 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     John Hubbard <jhubbard@nvidia.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20191002000046.GA60764@google.com>
References: <20190914070518.112954-1-yuzhao@google.com>
 <20190924232459.214097-1-yuzhao@google.com>
 <20190924232459.214097-3-yuzhao@google.com>
 <20190925082530.GD4536@hirez.programming.kicks-ass.net>
 <20190925222654.GA180125@google.com>
 <20190926102036.od2wamdx2s7uznvq@box>
 <9465df76-0229-1b44-5646-5cced1bc1718@nvidia.com>
 <20190927050648.GA92494@google.com>
 <712513fe-f064-c965-d165-80d43cfc606f@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <712513fe-f064-c965-d165-80d43cfc606f@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 03:31:51PM -0700, John Hubbard wrote:
> On 9/26/19 10:06 PM, Yu Zhao wrote:
> > On Thu, Sep 26, 2019 at 08:26:46PM -0700, John Hubbard wrote:
> >> On 9/26/19 3:20 AM, Kirill A. Shutemov wrote:
> >>> On Wed, Sep 25, 2019 at 04:26:54PM -0600, Yu Zhao wrote:
> >>>> On Wed, Sep 25, 2019 at 10:25:30AM +0200, Peter Zijlstra wrote:
> >>>>> On Tue, Sep 24, 2019 at 05:24:58PM -0600, Yu Zhao wrote:
> >> ...
> >>>>> I'm thinking this patch make stuff rather fragile.. Should we instead
> >>>>> stick the barrier in set_p*d_at() instead? Or rather, make that store a
> >>>>> store-release?
> >>>>
> >>>> I prefer it this way too, but I suspected the majority would be
> >>>> concerned with the performance implications, especially those
> >>>> looping set_pte_at()s in mm/huge_memory.c.
> >>>
> >>> We can rename current set_pte_at() to __set_pte_at() or something and
> >>> leave it in places where barrier is not needed. The new set_pte_at()( will
> >>> be used in the rest of the places with the barrier inside.
> >>
> >> +1, sounds nice. I was unhappy about the wide-ranging changes that would have
> >> to be maintained. So this seems much better.
> > 
> > Just to be clear that doing so will add unnecessary barriers to one
> > of the two paths that share set_pte_at().
> 
> Good point, maybe there's a better place to do it...
> 
> 
> > 
> >>> BTW, have you looked at other levels of page table hierarchy. Do we have
> >>> the same issue for PMD/PUD/... pages?
> >>>
> >>
> >> Along the lines of "what other memory barriers might be missing for
> >> get_user_pages_fast(), I'm also concerned that the synchronization between
> >> get_user_pages_fast() and freeing the page tables might be technically broken,
> >> due to missing memory barriers on the get_user_pages_fast() side. Details:
> >>
> >> gup_fast() disables interrupts, but I think it also needs some sort of
> >> memory barrier(s), in order to prevent reads of the page table (gup_pgd_range,
> >> etc) from speculatively happening before the interrupts are disabled. 
> > 
> > I was under impression switching back from interrupt context is a
> > full barrier (otherwise wouldn't we be vulnerable to some side
> > channel attacks?), so the reader side wouldn't need explicit rmb.
> > 
> 
> Documentation/memory-barriers.txt points out:
> 
> INTERRUPT DISABLING FUNCTIONS
> -----------------------------
> 
> Functions that disable interrupts (ACQUIRE equivalent) and enable interrupts
> (RELEASE equivalent) will act as compiler barriers only.  So if memory or I/O
> barriers are required in such a situation, they must be provided from some
> other means.
> 
> btw, I'm really sorry I missed your responses over the last 3 or 4 days.
> I just tracked down something in our email system that was sometimes
> moving some emails to spam (just few enough to escape immediate attention, argghh!).
> I think I killed it off for good now. I wasn't ignoring you. :)

Thanks, John. I agree with all you said, including the irq disabling
function not being a sufficient smp_rmb().

I was hoping somebody could clarify whether ipi handlers used by tlb
flush are sufficient to prevent CPU 1 from seeing any stale data from
freed page tables on all supported archs.

	CPU 1			CPU 2

				flush remote tlb by ipi
				wait for the ipi hanlder
	<ipi handler>
				free page table
	disable irq
	walk page table
	enable irq

I think they should because otherwise tlb flush wouldn't work if CPU 1
still sees stale data from the freed page table, unless there is a
really strange CPU cache design I'm not aware of.

Quoting comments from x86 ipi handler flush_tlb_func_common():
 * read active_mm's tlb_gen.  We don't need any explicit barriers
 * because all x86 flush operations are serializing and the
 * atomic64_read operation won't be reordered by the compiler.

For ppc64 ipi hander radix__flush_tlb_range(), there is an "eieio"
instruction:
  https://www.ibm.com/support/knowledgecenter/en/ssw_aix_72/assembler/idalangref_eieio_instrs.html
I'm not sure why it's not "sync" -- I'd guess something implicitly
works as "sync" already (or it's a bug).

I didn't find an ipi handler for tlb flush on arm64. There should be
one, otherwise fast gup on arm64 would be broken. Mark?
