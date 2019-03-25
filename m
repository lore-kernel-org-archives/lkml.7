Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5F7C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 461C920863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JnAr0PRj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729845AbfCYQrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:47:17 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41543 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729095AbfCYQrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 12:47:16 -0400
Received: by mail-qt1-f193.google.com with SMTP id w30so11069321qta.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 09:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aW91dn9nuPfOXD4t7dRzfb0dMVTbNhA56lMZa1MF4+k=;
        b=JnAr0PRjqUbU63OKfPbizP+KqQ3+NBp3Hl9xEGo+e0G3nrDd2HGKgCPDVvAtgDDGgq
         2KqoA2jx2HYsmwe0GjaGFLziEseA4OyTXFW2tSuxSlIej8IyT2qvfN0dQbNRQisxqgjv
         YyjWs4or4Fb+acXC3N1tVR1kd3hrkJmWqdorNYmhoaj/k41Isg08w6zsZvRJANzGWc/A
         EJ647jSN/xbRcwr26WHD7ybePy8t3s7A4gLWDx47XPWQwWwNd0vcZuvCEmzRsRVkB2ae
         vIuQxoFE06doqkYM87BYQF+Q/Y/tCVL0HxbvDGkDI49yextuAdRbm4bB0Z5jwF0TR+zK
         Xgkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aW91dn9nuPfOXD4t7dRzfb0dMVTbNhA56lMZa1MF4+k=;
        b=aFbbJ390RsqRGgJwuvw7eIl5FThN0b7mJDlSv7Ko976lzeYTqYy6Ay6Qr7WSBgkytj
         5ZvJwGWgRhNeAlsOw2XClX7CcVBF2M1rf04dDrrwt3T+RK+6b+SiRhE1Xqh9n0kE+Dgx
         u2nTHKaa6/XcgrX0LVQE/UtKEdq8RCHYpRji0k6Li9Y4jJ+ZlKk7bdv5eIpPfhVBZCkq
         h7IuE3vvWJ3XZHIh8uFVpTjFolkCaiGLzhx8KMuZ41LYyLOSngarfsFpjakLxkewNm1/
         wP69VScnT/07dknh4udsjf6E79jGN3NPBzDE7AYIBQJ+AmaXwVAy0jR9CrER1I7qLRSh
         v9zA==
X-Gm-Message-State: APjAAAWHlw6z4uKXLp8dqLHsU+A6mAE0/jV+VU8xBuMlTvCL6cl+f5T0
        LqvHltzaOKyyiUpsE9Cj6ME7kA==
X-Google-Smtp-Source: APXvYqzOo9mFR4RSXVRCnnLwhZ0gTiLUKzXoKvrAWJbTVN22MCNVY7LjLthjFhx1EBSjcGadXts77A==
X-Received: by 2002:aed:3562:: with SMTP id b31mr22334515qte.154.1553532435230;
        Mon, 25 Mar 2019 09:47:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-49-251.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.49.251])
        by smtp.gmail.com with ESMTPSA id u18sm9956618qka.25.2019.03.25.09.47.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 09:47:14 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1h8Skj-0005QU-Qs; Mon, 25 Mar 2019 13:47:13 -0300
Date:   Mon, 25 Mar 2019 13:47:13 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20190325164713.GC9949@ziepe.ca>
References: <20190317183438.2057-1-ira.weiny@intel.com>
 <20190317183438.2057-5-ira.weiny@intel.com>
 <CAA9_cmcx-Bqo=CFuSj7Xcap3e5uaAot2reL2T74C47Ut6_KtQw@mail.gmail.com>
 <20190325084225.GC16366@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325084225.GC16366@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 01:42:26AM -0700, Ira Weiny wrote:
> On Fri, Mar 22, 2019 at 03:12:55PM -0700, Dan Williams wrote:
> > On Sun, Mar 17, 2019 at 7:36 PM <ira.weiny@intel.com> wrote:
> > >
> > > From: Ira Weiny <ira.weiny@intel.com>
> > >
> > > DAX pages were previously unprotected from longterm pins when users
> > > called get_user_pages_fast().
> > >
> > > Use the new FOLL_LONGTERM flag to check for DEVMAP pages and fall
> > > back to regular GUP processing if a DEVMAP page is encountered.
> > >
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > >  mm/gup.c | 29 +++++++++++++++++++++++++----
> > >  1 file changed, 25 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/mm/gup.c b/mm/gup.c
> > > index 0684a9536207..173db0c44678 100644
> > > +++ b/mm/gup.c
> > > @@ -1600,6 +1600,9 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
> > >                         goto pte_unmap;
> > >
> > >                 if (pte_devmap(pte)) {
> > > +                       if (unlikely(flags & FOLL_LONGTERM))
> > > +                               goto pte_unmap;
> > > +
> > >                         pgmap = get_dev_pagemap(pte_pfn(pte), pgmap);
> > >                         if (unlikely(!pgmap)) {
> > >                                 undo_dev_pagemap(nr, nr_start, pages);
> > > @@ -1739,8 +1742,11 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
> > >         if (!pmd_access_permitted(orig, flags & FOLL_WRITE))
> > >                 return 0;
> > >
> > > -       if (pmd_devmap(orig))
> > > +       if (pmd_devmap(orig)) {
> > > +               if (unlikely(flags & FOLL_LONGTERM))
> > > +                       return 0;
> > >                 return __gup_device_huge_pmd(orig, pmdp, addr, end, pages, nr);
> > > +       }
> > >
> > >         refs = 0;
> > >         page = pmd_page(orig) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
> > > @@ -1777,8 +1783,11 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
> > >         if (!pud_access_permitted(orig, flags & FOLL_WRITE))
> > >                 return 0;
> > >
> > > -       if (pud_devmap(orig))
> > > +       if (pud_devmap(orig)) {
> > > +               if (unlikely(flags & FOLL_LONGTERM))
> > > +                       return 0;
> > >                 return __gup_device_huge_pud(orig, pudp, addr, end, pages, nr);
> > > +       }
> > >
> > >         refs = 0;
> > >         page = pud_page(orig) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
> > > @@ -2066,8 +2075,20 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
> > >                 start += nr << PAGE_SHIFT;
> > >                 pages += nr;
> > >
> > > -               ret = get_user_pages_unlocked(start, nr_pages - nr, pages,
> > > -                                             gup_flags);
> > > +               if (gup_flags & FOLL_LONGTERM) {
> > > +                       down_read(&current->mm->mmap_sem);
> > > +                       ret = __gup_longterm_locked(current, current->mm,
> > > +                                                   start, nr_pages - nr,
> > > +                                                   pages, NULL, gup_flags);
> > > +                       up_read(&current->mm->mmap_sem);
> > > +               } else {
> > > +                       /*
> > > +                        * retain FAULT_FOLL_ALLOW_RETRY optimization if
> > > +                        * possible
> > > +                        */
> > > +                       ret = get_user_pages_unlocked(start, nr_pages - nr,
> > > +                                                     pages, gup_flags);
> > 
> > I couldn't immediately grok why this path needs to branch on
> > FOLL_LONGTERM? Won't get_user_pages_unlocked(..., FOLL_LONGTERM) do
> > the right thing?
> 
> Unfortunately holding the lock is required to support FOLL_LONGTERM (to check
> the VMAs) but we don't want to hold the lock to be optimal (specifically allow
> FAULT_FOLL_ALLOW_RETRY).  So I'm maintaining the optimization for *_fast users
> who do not specify FOLL_LONGTERM.
> 
> Another way to do this would have been to define __gup_longterm_unlocked with
> the above logic, but that seemed overkill at this point.

get_user_pages_unlocked() is an exported symbol, shouldn't it work
with the FOLL_LONGTERM flag?

I think it should even though we have no user..

Otherwise the GUP API just gets more confusing.

Jason
