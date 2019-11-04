Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E77CA9ED3
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 605AD214D9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D9p5Nchb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbfKDVTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 16:19:31 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:47099 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbfKDVTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 16:19:31 -0500
Received: by mail-ot1-f68.google.com with SMTP id n23so5477622otr.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 13:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/8yU3O5k24h9e3PyFN4Dj6MFbBb6JVOj0JoMWY+S3AE=;
        b=D9p5NchbwDhe9mp8NmRpUK2kC/a+iNk7mb4uEiZ8i732RHQD6+tLGJUqQxUtZVO/6E
         cj1d8a4CJKXF8pG7Zq7JEeo0VUK3rLYbIqPfzCn9VAy0MLJ3rg/OY1kog7CQmyv2Amrc
         JcgPRVvZUwSxwpa+ttmnJcoylJD3NkiLLnmjKjCHY/C1g4stQ8Ed1DyQrK1adfzuqzG0
         UtqL7KFhK1ty8dRL3C+GxB04afBz9u4VTY09zYZBWWaqrssMfw3imLZpgVrl9CnzcqC5
         01mxKNlxFe9J0MLshePp0EkD4m82n/DCA8btqZnttBF+d3W3jxDnTftdC5+8WtGvIWYe
         1bqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/8yU3O5k24h9e3PyFN4Dj6MFbBb6JVOj0JoMWY+S3AE=;
        b=IwgEZM5vnY9es/JTuN1MyGKLjWCYY1kyX8mMkWw75EH3hD+0/DNqmUKXSG1ou6sJim
         CyTZZGRo41jrp8khypQKZIRelFSYbgsXLu/5Ll4Y7ZdgVYZRJbdI5f8xTWcn8qIh8jqc
         QBgLozH8fJhgDM95+4tyeW+2cqFf2vYaCynqXMcMQzEkUND56AAdxdq5moRhq/o0GVcH
         LTFg9IrSpJX5/tdKrEPb3TvMGXS9w57QqMkd6UAneen3+vqMvQym0ryOk7IBm0SUdnFB
         TBmK//0Mr3iKqMuWAvOzGwWTJdsJSALZ0WjexhC+eIUMGzVKetUeYzJHWSvQHENW6ShW
         0P0w==
X-Gm-Message-State: APjAAAWQ5xugv2zv0n0ouq+Yp4TQ6rUoN4gt1NT+EHy1zT0mHvXPTk18
        FEiRVLzOlrg7cCJFL1GKh08V9u1WDx4aPr07QzmFf5ZN
X-Google-Smtp-Source: APXvYqwoI3V0DEHS32l9wQXVJE8EeGtjkg4VAjYe1lFrEIq00wE4DXN1gIePuof1MESKaL2zUS9xhTdMaCNp6fuM05o=
X-Received: by 2002:a9d:1c8f:: with SMTP id l15mr16022901ota.313.1572902369377;
 Mon, 04 Nov 2019 13:19:29 -0800 (PST)
MIME-Version: 1.0
References: <20191030013701.39647-1-almasrymina@google.com>
 <20191030013701.39647-5-almasrymina@google.com> <1c060bde-8d44-146c-6d67-a7b145aa1b59@oracle.com>
 <CAHS8izPTvybLq9Y9Fn6Z+hSc7gLP+goQ-ixzjxa1XJ-qhWM8ow@mail.gmail.com> <a5f991c8-3f74-6000-cbd3-09fb8626e3f5@oracle.com>
In-Reply-To: <a5f991c8-3f74-6000-cbd3-09fb8626e3f5@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Mon, 4 Nov 2019 13:19:18 -0800
Message-ID: <CAHS8izMYaHf-3zeVcM_73_KSMCpA5vds-NtRjNt0d8VsMfczQw@mail.gmail.com>
Subject: Re: [PATCH v8 5/9] hugetlb: disable region_add file_region coalescing
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     shuah <shuah@kernel.org>, open list <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org,
        Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 4, 2019 at 1:15 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 11/4/19 1:04 PM, Mina Almasry wrote:
> > On Fri, Nov 1, 2019 at 4:23 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >>
> >> On 10/29/19 6:36 PM, Mina Almasry wrote:
> >>>  static long add_reservation_in_range(struct resv_map *resv, long f, long t,
> >>> -                                  bool count_only)
> >>> +                                  long *regions_needed, bool count_only)
> >>>  {
> >>> -     long chg = 0;
> >>> +     long add = 0;
> >>>       struct list_head *head = &resv->regions;
> >>> +     long last_accounted_offset = f;
> >>>       struct file_region *rg = NULL, *trg = NULL, *nrg = NULL;
> >>>
> >>> -     /* Locate the region we are before or in. */
> >>> -     list_for_each_entry (rg, head, link)
> >>> -             if (f <= rg->to)
> >>> -                     break;
> >>> +     if (regions_needed)
> >>> +             *regions_needed = 0;
> >>>
> >>> -     /* Round our left edge to the current segment if it encloses us. */
> >>> -     if (f > rg->from)
> >>> -             f = rg->from;
> >>> -
> >>> -     chg = t - f;
> >>> +     /* In this loop, we essentially handle an entry for the range
> >>> +      * [last_accounted_offset, rg->from), at every iteration, with some
> >>> +      * bounds checking.
> >>> +      */
> >>> +     list_for_each_entry_safe(rg, trg, head, link) {
> >>> +             /* Skip irrelevant regions that start before our range. */
> >>> +             if (rg->from < f) {
> >>> +                     /* If this region ends after the last accounted offset,
> >>> +                      * then we need to update last_accounted_offset.
> >>> +                      */
> >>> +                     if (rg->to > last_accounted_offset)
> >>> +                             last_accounted_offset = rg->to;
> >>> +                     continue;
> >>> +             }
> >>>
> >>> -     /* Check for and consume any regions we now overlap with. */
> >>> -     nrg = rg;
> >>> -     list_for_each_entry_safe (rg, trg, rg->link.prev, link) {
> >>> -             if (&rg->link == head)
> >>> -                     break;
> >>> +             /* When we find a region that starts beyond our range, we've
> >>> +              * finished.
> >>> +              */
> >>>               if (rg->from > t)
> >>>                       break;
> >>>
> >>> -             /* We overlap with this area, if it extends further than
> >>> -              * us then we must extend ourselves.  Account for its
> >>> -              * existing reservation.
> >>> +             /* Add an entry for last_accounted_offset -> rg->from, and
> >>> +              * update last_accounted_offset.
> >>>                */
> >>> -             if (rg->to > t) {
> >>> -                     chg += rg->to - t;
> >>> -                     t = rg->to;
> >>> +             if (rg->from > last_accounted_offset) {
> >>> +                     add += rg->from - last_accounted_offset;
> >>> +                     if (!count_only) {
> >>> +                             nrg = get_file_region_entry_from_cache(
> >>> +                                     resv, last_accounted_offset, rg->from);
> >>> +                             list_add(&nrg->link, rg->link.prev);
> >>> +                     } else if (regions_needed)
> >>> +                             *regions_needed += 1;
> >>>               }
> >>> -             chg -= rg->to - rg->from;
> >>>
> >>> -             if (!count_only && rg != nrg) {
> >>> -                     list_del(&rg->link);
> >>> -                     kfree(rg);
> >>> -             }
> >>> +             last_accounted_offset = rg->to;
> >>
> >> That last assignment is unneeded.  Correct?
> >>
> >
> > Not to make you nervous, but this assignment is needed.
> >
> > The basic idea is that there are 2 loop invariants here:
> > 1. Everything before last_accounted_offset is filled in with file_regions.
> > 2. rg points to the first region past last_account_offset.
> >
> > Each loop iteration compares rg->from to last_accounted_offset, and if
> > there is a gap, it creates a new region to fill this gap. Then this
> > assignment restores loop invariant #2 by assigning
> > last_accounted_offset to rg->to, since now everything before rg->to is
> > filled in with file_regions.
> >
>
> My apologies!
>
> >>>       }
> >>>
> >>> -     if (!count_only) {
> >>> -             nrg->from = f;
> >>> -             nrg->to = t;
> >>> +     /* Handle the case where our range extends beyond
> >>> +      * last_accounted_offset.
> >>> +      */
> >>> +     if (last_accounted_offset < t) {
> >>> +             add += t - last_accounted_offset;
> >>> +             if (!count_only) {
> >>> +                     nrg = get_file_region_entry_from_cache(
> >>> +                             resv, last_accounted_offset, t);
> >>> +                     list_add(&nrg->link, rg->link.prev);
> >>> +             } else if (regions_needed)
> >>> +                     *regions_needed += 1;
> >>> +             last_accounted_offset = t;
>
> The question about an unnecessary assignment was supposed to be
> directed at the above line.
>

Oh, yes. That assignment is completely unnecessary; the function just
exits after pretty much. Will remove, thanks!

> --
> Mike Kravetz
>
>
> >>>       }
> >>>
> >>> -     return chg;
> >>> +     return add;
> >>>  }
