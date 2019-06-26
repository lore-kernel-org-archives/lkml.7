Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4F2C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 09:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 624AD2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 09:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fpo0sQeA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfFZJU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 05:20:58 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38397 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfFZJU5 (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 05:20:57 -0400
Received: by mail-io1-f67.google.com with SMTP id j6so1777875ioa.5
        for <Linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 02:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yWLGrl/2egjAr2UjDXCO9Iz9KQ93uoAPVQBnf/rPQpU=;
        b=Fpo0sQeA3/Tgp0c/1mafklMBLg6jSyrxQxe44Ed9S6n7lVvYDoV6L06pna8ZEAMUts
         K8Ixtm2yL/rwJ4iPi3IiPnZip8oHbXYXGNbVK6OkLNtHlqCDku3E8sJT/Mr4jrGyDtxg
         T44cN0rry6IaATkchMQQrmB6MnA7mJmWfPnQoLHmV1QqbUc8TdNkw9/VhKJ1MVv3ElSf
         EXifh0SKHi4+edEQtq0strFRMNchuRQ98XpQxm/WDySH51CVXBZSew8F3GZJ9skiPNTo
         JOcvF6HYHnoUGuGVsjyMkWfclzUoPNJGMla7zXbGutkg/NvJU8+5HMgNu7Fn0Q333oaO
         j2zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yWLGrl/2egjAr2UjDXCO9Iz9KQ93uoAPVQBnf/rPQpU=;
        b=bjOzR2O8713qjc+2cOQ/xLkmB2zOPGxU+Vqybp7X0HgtZ/wV4032y8AVRm400Gwqs0
         nAXqB/BSE2yCVhEE3y9X29D++8Du5jS/3UVh3VrJN4q94ULFvxr3Yn7Q0+A5COCNbWCd
         0xej//Vw2CJEYsJJ2A2DiyWXC7QZ8XDK8aypZY7R1ll/yehO/VKSEycft2QORPPmafUR
         Wkt8A4/U4mZtUymboxzOl0V/RgfKanL4hfo4b6rPwjB6iFcihAiGy7gMOmvZocdp096y
         x9F8y3Dor3FXr4MpU8vyCbqkmQCoRuD2rNtP/1ryMCwl2BtsYUcqxk296sdckfiGsLg7
         an3g==
X-Gm-Message-State: APjAAAWSfnY8a9U1KpPwBKhcqKbwGKfwRENzRl6ZAw3v+6vh3TU1g87G
        Nt0mHjmlm+dXwqnygvmq6XrZYpVadfb8jTmdvQ==
X-Google-Smtp-Source: APXvYqy6U2utBeNKdNTf32j/0dK1Qo8sVgZz8kHlz7QzVIdIazEytRzIlyZ/6EwmqGioWHrlm9s/W32c0UHdayas8ko=
X-Received: by 2002:a6b:4107:: with SMTP id n7mr3493139ioa.12.1561540856871;
 Wed, 26 Jun 2019 02:20:56 -0700 (PDT)
MIME-Version: 1.0
References: <1561471999-6688-1-git-send-email-kernelfans@gmail.com> <20190625175144.GA13219@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20190625175144.GA13219@iweiny-DESK2.sc.intel.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Wed, 26 Jun 2019 17:20:44 +0800
Message-ID: <CAFgQCTt4SN8EfbqV2ZhK_SEeQOsGFgNW5zTjc7JUkcCNNspuaQ@mail.gmail.com>
Subject: Re: [PATCHv3] mm/gup: speed up check_and_migrate_cma_pages() on huge page
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Hubbard <jhubbard@nvidia.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        LKML <Linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 1:51 AM Ira Weiny <ira.weiny@intel.com> wrote:
>
> On Tue, Jun 25, 2019 at 10:13:19PM +0800, Pingfan Liu wrote:
> > Both hugetlb and thp locate on the same migration type of pageblock, since
> > they are allocated from a free_list[]. Based on this fact, it is enough to
> > check on a single subpage to decide the migration type of the whole huge
> > page. By this way, it saves (2M/4K - 1) times loop for pmd_huge on x86,
> > similar on other archs.
> >
> > Furthermore, when executing isolate_huge_page(), it avoid taking global
> > hugetlb_lock many times, and meanless remove/add to the local link list
> > cma_page_list.
> >
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: Mike Rapoport <rppt@linux.ibm.com>
> > Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Keith Busch <keith.busch@intel.com>
> > Cc: Mike Kravetz <mike.kravetz@oracle.com>
> > Cc: Linux-kernel@vger.kernel.org
> > ---
> > v2 -> v3: fix page order to size convertion
> >
> >  mm/gup.c | 19 ++++++++++++-------
> >  1 file changed, 12 insertions(+), 7 deletions(-)
> >
> > diff --git a/mm/gup.c b/mm/gup.c
> > index ddde097..03cc1f4 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -1342,19 +1342,22 @@ static long check_and_migrate_cma_pages(struct task_struct *tsk,
> >       LIST_HEAD(cma_page_list);
> >
> >  check_again:
> > -     for (i = 0; i < nr_pages; i++) {
> > +     for (i = 0; i < nr_pages;) {
> > +
> > +             struct page *head = compound_head(pages[i]);
> > +             long step = 1;
> > +
> > +             if (PageCompound(head))
> > +                     step = 1 << compound_order(head) - (pages[i] - head);
>
> Check your precedence here.
>
>         step = (1 << compound_order(head)) - (pages[i] - head);
OK.

Thanks,
Pingfan
