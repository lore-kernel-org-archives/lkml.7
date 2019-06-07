Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D75FC46470
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 06:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36F12208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 06:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IV4zLHj0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfFGGK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 02:10:28 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:33314 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbfFGGK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 02:10:27 -0400
Received: by mail-it1-f196.google.com with SMTP id v193so3827292itc.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 23:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eTktKQuTzdipksXwS2CKl7p1qhwpDhKrtnVfw336+xs=;
        b=IV4zLHj0L6VpXbqbPfvaZO0ippEsxT1gmsZ7V2S/nWcvEDeFcJtFVigu0otcpMlb4V
         xAIju+cbPCdOUT/MuR2nvYjv7p64PSoDQV1uECjr4JHKj5Cd399GbXWWJ0gcLYHdTTVU
         5Uibii/zVZc66zpE6bfmIS+FyQQHjvFWJQjNEyfTxcbOh2oo2vngN6QmQ/6F2J/S9FKv
         q9C3T2kLzobgefw3JAKSlbn5eeyfuSdFfkDiWGmOUY612TsQA2FMNDYyalfQvUz6kRuY
         hybvTl/YG2k1RrhoZC9b2f2XqMGHaltcu1HerUN+9/Ctgc2x3estuK7G6OirSjs9v0/f
         6efg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eTktKQuTzdipksXwS2CKl7p1qhwpDhKrtnVfw336+xs=;
        b=XudIsYKzWpWuy39Vm2xUZ9DIcAbTRuA+xf+Nwa+NMm9GITx96JfHwZ9xo04KW1OTF0
         pCw6ZfdLLiJu0qgO41Xg0pkEnZQKTKr/tVWrP9/SG2hXkkRqdGAP1r0RTFwaMl9hAQFM
         C9z8YLEToDS8g08hqUBYkddnGHDGYuVGDRzzst+4Jb6UThgg4h/dX2s8CwHsHHNX6kgQ
         NaqITo4l76ERufD6eQ6loMRdXKC7Qco07ZXFngeVEg/JIB4+v6L4yVAmiNlS1Cff0btO
         Z/bwNRM9dIdMYZRh3SpA0X57578fzWkU9k3vmRzPm7RfujHjM0F5y1boP2UrE7XvOhl7
         LTZQ==
X-Gm-Message-State: APjAAAV4sSssMUhwCwzy/0Toofvs8uL/g1Y1vORpn+OJ3AZN9euXr8Er
        XjRSQVuq+XcP1N9aP92tnzVW3gn9oLuO3Ce6WLIYAZA=
X-Google-Smtp-Source: APXvYqzCsB1yAjyy0lGkL6B8lZPrG+ajfCwjKyc+XM3O8ufM9vWUUtbOwWEDnqbjq8EZSqrub7VU4D5R8bU7jEiNJpU=
X-Received: by 2002:a05:6638:40c:: with SMTP id q12mr29265442jap.17.1559887826860;
 Thu, 06 Jun 2019 23:10:26 -0700 (PDT)
MIME-Version: 1.0
References: <1559725820-26138-1-git-send-email-kernelfans@gmail.com>
 <20190605144912.f0059d4bd13c563ddb37877e@linux-foundation.org>
 <CAFgQCTur5ReVHm6NHdbD3wWM5WOiAzhfEXdLnBGRdZtf7q1HFw@mail.gmail.com> <2b0a65ec-4fb0-430e-3e6a-b713fb5bb28f@nvidia.com>
In-Reply-To: <2b0a65ec-4fb0-430e-3e6a-b713fb5bb28f@nvidia.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Fri, 7 Jun 2019 14:10:15 +0800
Message-ID: <CAFgQCTtS7qOByXBnGzCW-Rm9fiNsVmhQTgqmNU920m77XyAwZQ@mail.gmail.com>
Subject: Re: [PATCHv3 1/2] mm/gup: fix omission of check on FOLL_LONGTERM in get_user_pages_fast()
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Ira Weiny <ira.weiny@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 7, 2019 at 5:17 AM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 6/5/19 7:19 PM, Pingfan Liu wrote:
> > On Thu, Jun 6, 2019 at 5:49 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> ...
> >>> --- a/mm/gup.c
> >>> +++ b/mm/gup.c
> >>> @@ -2196,6 +2196,26 @@ static int __gup_longterm_unlocked(unsigned long start, int nr_pages,
> >>>       return ret;
> >>>  }
> >>>
> >>> +#ifdef CONFIG_CMA
> >>> +static inline int reject_cma_pages(int nr_pinned, struct page **pages)
> >>> +{
> >>> +     int i;
> >>> +
> >>> +     for (i = 0; i < nr_pinned; i++)
> >>> +             if (is_migrate_cma_page(pages[i])) {
> >>> +                     put_user_pages(pages + i, nr_pinned - i);
> >>> +                     return i;
> >>> +             }
> >>> +
> >>> +     return nr_pinned;
> >>> +}
> >>
> >> There's no point in inlining this.
> > OK, will drop it in V4.
> >
> >>
> >> The code seems inefficient.  If it encounters a single CMA page it can
> >> end up discarding a possibly significant number of non-CMA pages.  I
> > The trick is the page is not be discarded, in fact, they are still be
> > referrenced by pte. We just leave the slow path to pick up the non-CMA
> > pages again.
> >
> >> guess that doesn't matter much, as get_user_pages(FOLL_LONGTERM) is
> >> rare.  But could we avoid this (and the second pass across pages[]) by
> >> checking for a CMA page within gup_pte_range()?
> > It will spread the same logic to hugetlb pte and normal pte. And no
> > improvement in performance due to slow path. So I think maybe it is
> > not worth.
> >
> >>
>
> I think the concern is: for the successful gup_fast case with no CMA
> pages, this patch is adding another complete loop through all the
> pages. In the fast case.
>
> If the check were instead done as part of the gup_pte_range(), then
> it would be a little more efficient for that case.
>
> As for whether it's worth it, *probably* this is too small an effect to measure.
> But in order to attempt a measurement: running fio (https://github.com/axboe/fio)
> with O_DIRECT on an NVMe drive, might shed some light. Here's an fio.conf file
> that Jan Kara and Tom Talpey helped me come up with, for related testing:
>
> [reader]
> direct=1
> ioengine=libaio
> blocksize=4096
> size=1g
> numjobs=1
> rw=read
> iodepth=64
>
Yeah, agreed. Data is more persuasive. Thanks for your suggestion. I
will try to bring out the result.

Thanks,
  Pingfan
