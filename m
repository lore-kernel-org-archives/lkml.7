Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E04DC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 05:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03AFD2083D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 05:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUFFpEiZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfFXFeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 01:34:14 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38740 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfFXFeN (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 01:34:13 -0400
Received: by mail-io1-f65.google.com with SMTP id j6so621058ioa.5
        for <Linux-kernel@vger.kernel.org>; Sun, 23 Jun 2019 22:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O2cgsn++49XRi6aE7UftxVDux3g2be02ob/0XO5leII=;
        b=ZUFFpEiZaiVkP2DAtpPpJdLBcrNKA9cH3iGexIP4qVSiH3s6Ph/+nWoAXjtSgV9qiW
         S/MqeWZ9lJiuxTnnse2zwppjjSxvd3MZ5gaEkBq0Tx7sdpZTHNvhXGyGkbivSn5EM3sV
         PmjzgK+pPR5F9iFCIgp57SC3UeZnajMu3j+oSl9qBRl/CRWKRfBHD1/X7yZzlo+xRHiS
         NQfxE8K9kmG+aXIWTyCV5fT596GsAP1qtw0aA8yQxmRpz62O3/dGBaIaPU2UkltRgLps
         9zHkuW3F1UTYS/SwcLCPFPZ0RyJSsAscHyqm7+EpI5MgrgH1QWjEaNtValTV8+BsywOp
         EO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O2cgsn++49XRi6aE7UftxVDux3g2be02ob/0XO5leII=;
        b=XxjPyvu9NAKMq4F59DmWBihi1goR4jtWDLOmtBFgkXDJXUb1PKw76rdzsaH7IRAhOG
         5rjIH1CDqjN9DatU6r7wH65KGJJ4bQ8U0bjd1OJ1bGzP+2WpPqmFDLvr3rQiWzk9LeoA
         JVh1VBEKkk5iBkYkgaqr8Y02gMJ2iPHUXxpz2JB/J6wiA564MdSk7fp4IyK39K/ILrcp
         hemBGs3xVwbbjy8GBFZkjgwdX57ydJZoGsXTe+jqrcWzPYSeVMtguwdfoUoBUQ1EiCha
         B3Cfjh57a5NRODg2BIPTGuXntqhmz50L2kwsT/Ekw2APPKMRZDMri250D7WuvOboRQ3X
         Y3pw==
X-Gm-Message-State: APjAAAWjJOYPMcE1/tWWgeG0nmCSWkYy+jXETd4By93Pb6a6ekwIJ89e
        92f3MycwigMxxAe8GmCtTjWeV2573XVzhm8D/A==
X-Google-Smtp-Source: APXvYqynPgam6/QO7kIucj+Eumv9i5hEjlNV7F+IsO6RFskEeRxPzshmmWIaqYh3bloHYgPhntoq1CMNEHeCCrXrmCY=
X-Received: by 2002:a02:a384:: with SMTP id y4mr124692536jak.77.1561354452881;
 Sun, 23 Jun 2019 22:34:12 -0700 (PDT)
MIME-Version: 1.0
References: <1561349561-8302-1-git-send-email-kernelfans@gmail.com>
 <20190624044305.GA30102@iweiny-DESK2.sc.intel.com> <CAFgQCTuMVdrjkiQ5H3xUuME16g-xNUFXtvU1p+=P4-pujXcSAA@mail.gmail.com>
In-Reply-To: <CAFgQCTuMVdrjkiQ5H3xUuME16g-xNUFXtvU1p+=P4-pujXcSAA@mail.gmail.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Mon, 24 Jun 2019 13:34:01 +0800
Message-ID: <CAFgQCTshH=FsJbdf49wD=fgJzvbEqzEW--F3oon1aLc64r=u7w@mail.gmail.com>
Subject: Re: [PATCHv2] mm/gup: speed up check_and_migrate_cma_pages() on huge page
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

On Mon, Jun 24, 2019 at 1:32 PM Pingfan Liu <kernelfans@gmail.com> wrote:
>
> On Mon, Jun 24, 2019 at 12:43 PM Ira Weiny <ira.weiny@intel.com> wrote:
> >
> > On Mon, Jun 24, 2019 at 12:12:41PM +0800, Pingfan Liu wrote:
> > > Both hugetlb and thp locate on the same migration type of pageblock, since
> > > they are allocated from a free_list[]. Based on this fact, it is enough to
> > > check on a single subpage to decide the migration type of the whole huge
> > > page. By this way, it saves (2M/4K - 1) times loop for pmd_huge on x86,
> > > similar on other archs.
> > >
> > > Furthermore, when executing isolate_huge_page(), it avoid taking global
> > > hugetlb_lock many times, and meanless remove/add to the local link list
> > > cma_page_list.
> > >
> > > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Ira Weiny <ira.weiny@intel.com>
> > > Cc: Mike Rapoport <rppt@linux.ibm.com>
> > > Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: John Hubbard <jhubbard@nvidia.com>
> > > Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> > > Cc: Christoph Hellwig <hch@lst.de>
> > > Cc: Keith Busch <keith.busch@intel.com>
> > > Cc: Mike Kravetz <mike.kravetz@oracle.com>
> > > Cc: Linux-kernel@vger.kernel.org
> > > ---
> > >  mm/gup.c | 19 ++++++++++++-------
> > >  1 file changed, 12 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/mm/gup.c b/mm/gup.c
> > > index ddde097..544f5de 100644
> > > --- a/mm/gup.c
> > > +++ b/mm/gup.c
> > > @@ -1342,19 +1342,22 @@ static long check_and_migrate_cma_pages(struct task_struct *tsk,
> > >       LIST_HEAD(cma_page_list);
> > >
> > >  check_again:
> > > -     for (i = 0; i < nr_pages; i++) {
> > > +     for (i = 0; i < nr_pages;) {
> > > +
> > > +             struct page *head = compound_head(pages[i]);
> > > +             long step = 1;
> > > +
> > > +             if (PageCompound(head))
> > > +                     step = compound_order(head) - (pages[i] - head);
> >
> > Sorry if I missed this last time.  compound_order() is not correct here.
> For thp, prep_transhuge_page()->prep_compound_page()->set_compound_order().
> For smaller hugetlb,
> prep_new_huge_page()->prep_compound_page()->set_compound_order().
> For gigantic page, prep_compound_gigantic_page()->set_compound_order().
>
> Do I miss anything?
>
Oh, got it. It should be 1<<compound_order(head)
> Thanks,
>   Pingfan
> [...]
