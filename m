Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D1CC28CC6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF6E324AF8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUMxlDW8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfFDHZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 03:25:06 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34483 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfFDHZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 03:25:06 -0400
Received: by mail-io1-f67.google.com with SMTP id k8so16555991iot.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 00:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/1V/guL5iAuFPzWbu/J5qn2zrr3eBIKvgYB5FT90pHk=;
        b=FUMxlDW8cb4jgkfWiO5VPMAL16GJ8wbtKN8sWb6IyMltJRS7oag9E+ZyEmy7EMM1Pf
         TRJrWvzLM48XnFw9C/Ve1YK1Ro502Vv7oyMbW8RlUfZagKdCnYHjyOseCduxGZn5BlMG
         MfXtVkAiWKnumHu+WM7xisNiDuJTu9/JtxA+nW5XR3m6FI/upiv26yfqFmYUEZiwr0cd
         NdiYtm/gYxshs3FPpMY+lT6/UmdfBcT63nBFiD3qDJuJ10ZP1yTeBtBKHtDXGjLEdywN
         KKMKVgwJ6xs0CllzBenJWsa+SMtOjpJH3W08ON3VLUy9r9PLIUkfxznEkQ19wKB6qG9Q
         4Muw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/1V/guL5iAuFPzWbu/J5qn2zrr3eBIKvgYB5FT90pHk=;
        b=N1d59yAK+cGn6d6tnqBRxW4rLM9Z4Sd+evSceq7VA/F8lCfghKYRyfPL8R4COX0aqw
         /rCx5uHyrbeH1gxHwWiaWDbmN0d5+9/gKBuOTKi+JHU5t6i6q3zunaldYQxDWSXXAUQ1
         N7guEbrky8mz5N2iC/QgU3xiATwMVxFoIyESXRuY+eLWJ4LnO3UDIgkwyXn0zlk0yVSf
         nPhJMxQ5u13PK1OvszkJmrDlgUvp6e4c6xDiv7IGv/EZix+Hge+0NM4hykEuu5bhMaZV
         2csfbcmiLSIV++mn2rDmRxtCQvirvfZ/GY+IG5hWl8JlG7dXQSwnjg066AZ+3jvY8UHv
         Utjg==
X-Gm-Message-State: APjAAAXnMJUTSUdsTyKQx2kHMHYLStz0XtgokaUL92LKGDmrRSnmIgOQ
        kDRbG/cRe3ORux98ZLOvE7ewi5puu91OwQpZCg==
X-Google-Smtp-Source: APXvYqxP8lQ9qPiM5mHYH7yiqijauzm9S16RYrWR8flgxA2r9BGMRJA+HbMZnSkg9/qdZabc+Iq1s0o59ucjrdD/Eto=
X-Received: by 2002:a6b:5106:: with SMTP id f6mr8539654iob.15.1559633105620;
 Tue, 04 Jun 2019 00:25:05 -0700 (PDT)
MIME-Version: 1.0
References: <1559543653-13185-1-git-send-email-kernelfans@gmail.com>
 <20190603164206.GB29719@infradead.org> <20190603235610.GB29018@iweiny-DESK2.sc.intel.com>
 <20190604070808.GA28858@infradead.org>
In-Reply-To: <20190604070808.GA28858@infradead.org>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Tue, 4 Jun 2019 15:24:54 +0800
Message-ID: <CAFgQCTtXQtL0DQdqQCUEKMjDYB-AFA0SsJsvcbhqUtNbiCu1Eg@mail.gmail.com>
Subject: Re: [PATCHv2 1/2] mm/gup: fix omission of check on FOLL_LONGTERM in get_user_pages_fast()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Keith Busch <keith.busch@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 4, 2019 at 3:08 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Jun 03, 2019 at 04:56:10PM -0700, Ira Weiny wrote:
> > On Mon, Jun 03, 2019 at 09:42:06AM -0700, Christoph Hellwig wrote:
> > > > +#if defined(CONFIG_CMA)
> > >
> > > You can just use #ifdef here.
> > >
> > > > +static inline int reject_cma_pages(int nr_pinned, unsigned int gup_flags,
> > > > + struct page **pages)
> > >
> > > Please use two instead of one tab to indent the continuing line of
> > > a function declaration.
> > >
> > > > +{
> > > > + if (unlikely(gup_flags & FOLL_LONGTERM)) {
> > >
> > > IMHO it would be a little nicer if we could move this into the caller.
> >
> > FWIW we already had this discussion and thought it better to put this here.
> >
> > https://lkml.org/lkml/2019/5/30/1565
>
> I don't see any discussion like this.  FYI, this is what I mean,
> code might be easier than words:
>
>
> diff --git a/mm/gup.c b/mm/gup.c
> index ddde097cf9e4..62d770b18e2c 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2197,6 +2197,27 @@ static int __gup_longterm_unlocked(unsigned long start, int nr_pages,
>         return ret;
>  }
>
> +#ifdef CONFIG_CMA
> +static int reject_cma_pages(struct page **pages, int nr_pinned)
> +{
> +       int i = 0;
> +
> +       for (i = 0; i < nr_pinned; i++)
> +               if (is_migrate_cma_page(pages[i])) {
> +                       put_user_pages(pages + i, nr_pinned - i);
> +                       return i;
> +               }
> +       }
> +
> +       return nr_pinned;
> +}
> +#else
> +static inline int reject_cma_pages(struct page **pages, int nr_pinned)
> +{
> +       return nr_pinned;
> +}
> +#endif /* CONFIG_CMA */
> +
>  /**
>   * get_user_pages_fast() - pin user pages in memory
>   * @start:     starting user address
> @@ -2237,6 +2258,9 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
>                 ret = nr;
>         }
>
> +       if (nr && unlikely(gup_flags & FOLL_LONGTERM))
> +               nr = reject_cma_pages(pages, nr);
> +
Yeah. Looks better to keep reject_cma_pages() away from gup flags.

>         if (nr < nr_pages) {
>                 /* Try to get the remaining pages with get_user_pages */
>                 start += nr << PAGE_SHIFT;
