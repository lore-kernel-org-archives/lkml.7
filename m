Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98398C48BE8
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 06:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E45E208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 06:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QaG2tg0Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfFXGKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 02:10:14 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40318 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbfFXGKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 02:10:14 -0400
Received: by mail-io1-f67.google.com with SMTP id n5so295098ioc.7
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2019 23:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4j6NnH/rtjW7YqPJZlJgQIQOVFVwz7hkEl28tcCpX/c=;
        b=QaG2tg0YYgd5+P5YRlDvLPsQpP7pDaSmqOTCFDcG7/rcTc53ymw2VqKN97slpnV64h
         Z0qRqTGndfOy26HG/tWXys9SYkoqbC/kD6scoZi8KsC2l3+OsH6QsMKNsERmRMR0PDlM
         NCls1WOiUY+TnzK1tWtORWC0o/KQlxMxSoR4va5E58FzkSBpUkmE8HWQZ0/Zb3ZcfTSn
         mSaid68PFqvYlQA3Fnblkgdug64w3pgL4eb3n3Di+vyEQM9/Ab7C/9Jip9LxDovl67NG
         S5t16MOLFqYUMTdA5h1HYzdKbBrk8BRvQa+OW1Z8gIH+DIPrutdgXyVI2/6HHWDy+kos
         tJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4j6NnH/rtjW7YqPJZlJgQIQOVFVwz7hkEl28tcCpX/c=;
        b=NRfJJeQGvm7Y8JpdsLgW4iDRe8HLFW2K4w0gW3F6oz7EcC/i427Ji9MmyFuC3CqLTP
         BXXa0R8nLxB3kvDifMq/4llxkaAfSfkgxlMRYgK2wgoDWkJriDm4DPWw1QwdStMnX1Hn
         jBGgJXTefepo09FLt5dPuuA6UDIGWr7s/lj3kVjJcOUd/KC00UFX/P2Fe2egy0r6PmGA
         BbOEtb5ZJ3huX4yf69tC8dXeM/3VH3L12BezDCQfSkrEaQftfy147ovF1DCcm+qnTfOL
         yu6Lf6Qqa3UJW3pbqVLru5tlrSmRt4KOtDWSygeAw07MY9r+W2FHHadxnMhoxNRVw8vT
         aboA==
X-Gm-Message-State: APjAAAXhJFxanyPSjKommSIpFXhGx17Rq468FtHPan4Juj+ms88uUZjF
        sJA9JFvUNmclb5jEuT4xESxtQa3b1+WOdVCP1A==
X-Google-Smtp-Source: APXvYqz4l/aitSGXlKJujrJxoiu8kzosNa/t0hrpf2ai9RzW0CH9f/kJvMBczKvXomO4NEdlo8XLXdUnhSubabN7hoI=
X-Received: by 2002:a02:a384:: with SMTP id y4mr124829515jak.77.1561356613275;
 Sun, 23 Jun 2019 23:10:13 -0700 (PDT)
MIME-Version: 1.0
References: <1561350068-8966-1-git-send-email-kernelfans@gmail.com> <216a335d-f7c6-26ad-2ac1-427c8a73ca2f@arm.com>
In-Reply-To: <216a335d-f7c6-26ad-2ac1-427c8a73ca2f@arm.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Mon, 24 Jun 2019 14:10:02 +0800
Message-ID: <CAFgQCTs14R5P7RpCTMwLCMJrGgPzbTGp4tvxCJA0kFgD8_y==g@mail.gmail.com>
Subject: Re: [PATCH] mm/hugetlb: allow gigantic page allocation to migrate
 away smaller huge page
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, Mike Kravetz <mike.kravetz@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 1:16 PM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
>
> On 06/24/2019 09:51 AM, Pingfan Liu wrote:
> > The current pfn_range_valid_gigantic() rejects the pud huge page allocation
> > if there is a pmd huge page inside the candidate range.
> >
> > But pud huge resource is more rare, which should align on 1GB on x86. It is
> > worth to allow migrating away pmd huge page to make room for a pud huge
> > page.
> >
> > The same logic is applied to pgd and pud huge pages.
>
> The huge page in the range can either be a THP or HugeTLB and migrating them has
> different costs and chances of success. THP migration will involve splitting if
> THP migration is not enabled and all related TLB related costs. Are you sure
> that a PUD HugeTLB allocation really should go through these ? Is there any
PUD hugetlb has already driven out PMD thp in current. This patch just
want to make PUD hugetlb survives PMD hugetlb.

> guarantee that after migration of multiple PMD sized THP/HugeTLB pages on the
> given range, the allocation request for PUD will succeed ?
The migration is complicated, but as my understanding, if there is no
gup pin in the range and there is enough memory including swap, then
it will success.
>
> >
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: Mike Kravetz <mike.kravetz@oracle.com>
> > Cc: Oscar Salvador <osalvador@suse.de>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  mm/hugetlb.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index ac843d3..02d1978 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1081,7 +1081,11 @@ static bool pfn_range_valid_gigantic(struct zone *z,
> >                       unsigned long start_pfn, unsigned long nr_pages)
> >  {
> >       unsigned long i, end_pfn = start_pfn + nr_pages;
> > -     struct page *page;
> > +     struct page *page = pfn_to_page(start_pfn);
> > +
> > +     if (PageHuge(page))
> > +             if (compound_order(compound_head(page)) >= nr_pages)
> > +                     return false;
> >
> >       for (i = start_pfn; i < end_pfn; i++) {
> >               if (!pfn_valid(i))
> > @@ -1098,8 +1102,6 @@ static bool pfn_range_valid_gigantic(struct zone *z,
> >               if (page_count(page) > 0)
> >                       return false;
> >
> > -             if (PageHuge(page))
> > -                     return false;
> >       }
> >
> >       return true;
> >
>
> So except in the case where there is a bigger huge page in the range this will
> attempt migrating everything on the way. As mentioned before if it all this is
> a good idea, it needs to differentiate between HugeTLB and THP and also take
> into account costs of migrations and chance of subsequence allocation attempt
> into account.
Sorry, but I think this logic is only for hugetlb. The caller
alloc_gigantic_page() is only used inside mm/hugetlb.c, not by
huge_memory.c.

Thanks,
  Pingfan
