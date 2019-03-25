Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C77C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BBC520863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729805AbfCYQnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:43:42 -0400
Received: from mga04.intel.com ([192.55.52.120]:17242 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728957AbfCYQnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 12:43:42 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 09:43:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,269,1549958400"; 
   d="scan'208";a="143686285"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Mar 2019 09:43:37 -0700
Date:   Mon, 25 Mar 2019 01:42:26 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "David S. Miller" <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh <linux-sh@vger.kernel.org>, sparclinux@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [RESEND 4/7] mm/gup: Add FOLL_LONGTERM capability to GUP fast
Message-ID: <20190325084225.GC16366@iweiny-DESK2.sc.intel.com>
References: <20190317183438.2057-1-ira.weiny@intel.com>
 <20190317183438.2057-5-ira.weiny@intel.com>
 <CAA9_cmcx-Bqo=CFuSj7Xcap3e5uaAot2reL2T74C47Ut6_KtQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA9_cmcx-Bqo=CFuSj7Xcap3e5uaAot2reL2T74C47Ut6_KtQw@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 03:12:55PM -0700, Dan Williams wrote:
> On Sun, Mar 17, 2019 at 7:36 PM <ira.weiny@intel.com> wrote:
> >
> > From: Ira Weiny <ira.weiny@intel.com>
> >
> > DAX pages were previously unprotected from longterm pins when users
> > called get_user_pages_fast().
> >
> > Use the new FOLL_LONGTERM flag to check for DEVMAP pages and fall
> > back to regular GUP processing if a DEVMAP page is encountered.
> >
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > ---
> >  mm/gup.c | 29 +++++++++++++++++++++++++----
> >  1 file changed, 25 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/gup.c b/mm/gup.c
> > index 0684a9536207..173db0c44678 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -1600,6 +1600,9 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
> >                         goto pte_unmap;
> >
> >                 if (pte_devmap(pte)) {
> > +                       if (unlikely(flags & FOLL_LONGTERM))
> > +                               goto pte_unmap;
> > +
> >                         pgmap = get_dev_pagemap(pte_pfn(pte), pgmap);
> >                         if (unlikely(!pgmap)) {
> >                                 undo_dev_pagemap(nr, nr_start, pages);
> > @@ -1739,8 +1742,11 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
> >         if (!pmd_access_permitted(orig, flags & FOLL_WRITE))
> >                 return 0;
> >
> > -       if (pmd_devmap(orig))
> > +       if (pmd_devmap(orig)) {
> > +               if (unlikely(flags & FOLL_LONGTERM))
> > +                       return 0;
> >                 return __gup_device_huge_pmd(orig, pmdp, addr, end, pages, nr);
> > +       }
> >
> >         refs = 0;
> >         page = pmd_page(orig) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
> > @@ -1777,8 +1783,11 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
> >         if (!pud_access_permitted(orig, flags & FOLL_WRITE))
> >                 return 0;
> >
> > -       if (pud_devmap(orig))
> > +       if (pud_devmap(orig)) {
> > +               if (unlikely(flags & FOLL_LONGTERM))
> > +                       return 0;
> >                 return __gup_device_huge_pud(orig, pudp, addr, end, pages, nr);
> > +       }
> >
> >         refs = 0;
> >         page = pud_page(orig) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
> > @@ -2066,8 +2075,20 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
> >                 start += nr << PAGE_SHIFT;
> >                 pages += nr;
> >
> > -               ret = get_user_pages_unlocked(start, nr_pages - nr, pages,
> > -                                             gup_flags);
> > +               if (gup_flags & FOLL_LONGTERM) {
> > +                       down_read(&current->mm->mmap_sem);
> > +                       ret = __gup_longterm_locked(current, current->mm,
> > +                                                   start, nr_pages - nr,
> > +                                                   pages, NULL, gup_flags);
> > +                       up_read(&current->mm->mmap_sem);
> > +               } else {
> > +                       /*
> > +                        * retain FAULT_FOLL_ALLOW_RETRY optimization if
> > +                        * possible
> > +                        */
> > +                       ret = get_user_pages_unlocked(start, nr_pages - nr,
> > +                                                     pages, gup_flags);
> 
> I couldn't immediately grok why this path needs to branch on
> FOLL_LONGTERM? Won't get_user_pages_unlocked(..., FOLL_LONGTERM) do
> the right thing?

Unfortunately holding the lock is required to support FOLL_LONGTERM (to check
the VMAs) but we don't want to hold the lock to be optimal (specifically allow
FAULT_FOLL_ALLOW_RETRY).  So I'm maintaining the optimization for *_fast users
who do not specify FOLL_LONGTERM.

Another way to do this would have been to define __gup_longterm_unlocked with
the above logic, but that seemed overkill at this point.

Ira

