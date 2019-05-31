Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE10DC46460
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 11:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BAB6267F3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 11:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4mRQqxd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfEaLFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 07:05:40 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42365 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbfEaLFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 07:05:39 -0400
Received: by mail-io1-f65.google.com with SMTP id g16so7801032iom.9
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 04:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=60Qw700xF164wG7p5BsIJw5jAg3eroN4jWr2z/QxvPU=;
        b=a4mRQqxdQjhQGZEE+NmBCzyeQc+ZVPtaxK/OqZYYdmzyZw/ms7KnKg28+WenzXoqQ9
         RbLiH8SECZHXZl8On7zljNcq9ZbjamcvHSHwwyZoYdNkt+LT5GrkwRdWOLKBNdrnV38S
         RIaZKQbm0SF/w7k8E3L2VoTpXgVwf/PDydUHQ0xZuEeua1Mhz9MrrMT3PGQXVYhjCk7h
         d5oDC2ML2yXo7Y4seRpm1X93vpVz2nzjRDhFxdO/Vjt+gUWgXQF1zdHCTqGhA6XRTLTq
         ikGo2JCpjGG+ey24sLxCJYHy6LbiQnz9qnul40bEzX/emxK25pjJC0HHewOFr6oTYZfM
         gRbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=60Qw700xF164wG7p5BsIJw5jAg3eroN4jWr2z/QxvPU=;
        b=fKQ8FgHavAWDtxFUxkmJWP/EjqF/O6F3bOP1Ju6Kv8icxS7P8pIdQXsh6RQMunxx5Q
         eu/DRqg3NF8EeJq+W/I0Gxm/wsTtNZ85daMMCQIeTTcCBOt+fYHH+ZfugD4XEicAb/xj
         kyD+y24C2W3TYeqbfDpY4bmcK+PmBjzJlTkgGsNbp0s75ewWUrKUM3m/nAfh5pliGB+9
         aCc5n2oOPQxUgy2iEdL5I3VV6oW066yETc9ECF2XfnXLEizgnQJuiQPhIy0r1ur0IYzv
         x5AuomBViuUjowBjc99MBLtmdL7/eyG72Txi2ywPmFrXzjkDrUX25fsiyCHpu0iJ2cjd
         VWPQ==
X-Gm-Message-State: APjAAAVX4CP7HVLIs7FsvIzEuH2gcnDSUmDJUNOje8ImuBL+OjCLfq8B
        rM/EITzfZWw/f4MbSq8LVcDQEIUEV+vkPvKMeQ==
X-Google-Smtp-Source: APXvYqwMU5rDEa406o+bbKgj0fzapXZvu0xsaWzm/rjJr4JCcUTfVdJypAB9+uofzpooHKyOjABQcmADHK211MgFzNE=
X-Received: by 2002:a5e:d70c:: with SMTP id v12mr5592967iom.12.1559300738725;
 Fri, 31 May 2019 04:05:38 -0700 (PDT)
MIME-Version: 1.0
References: <1559170444-3304-1-git-send-email-kernelfans@gmail.com>
 <20190530214726.GA14000@iweiny-DESK2.sc.intel.com> <1497636a-8658-d3ff-f7cd-05230fdead19@nvidia.com>
In-Reply-To: <1497636a-8658-d3ff-f7cd-05230fdead19@nvidia.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Fri, 31 May 2019 19:05:27 +0800
Message-ID: <CAFgQCTtVcmLUdua_nFwif_TbzeX5wp31GfTpL6CWmXXviYYLyw@mail.gmail.com>
Subject: Re: [PATCH] mm/gup: fix omission of check on FOLL_LONGTERM in get_user_pages_fast()
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Keith Busch <keith.busch@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 7:21 AM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 5/30/19 2:47 PM, Ira Weiny wrote:
> > On Thu, May 30, 2019 at 06:54:04AM +0800, Pingfan Liu wrote:
> [...]
> >> +                            for (j = i; j < nr; j++)
> >> +                                    put_page(pages[j]);
> >
> > Should be put_user_page() now.  For now that just calls put_page() but it is
> > slated to change soon.
> >
> > I also wonder if this would be more efficient as a check as we are walking the
> > page tables and bail early.
> >
> > Perhaps the code complexity is not worth it?
>
> Good point, it might be worth it. Because now we've got two loops that
> we run, after the interrupts-off page walk, and it's starting to look like
> a potential performance concern.
>
> >
> >> +                            nr = i;
> >
> > Why not just break from the loop here?
> >
> > Or better yet just use 'i' in the inner loop...
> >
>
> ...but if you do end up putting in the after-the-fact check, then we can
> go one or two steps further in cleaning it up, by:
>
>     * hiding the visible #ifdef that was slicing up gup_fast,
>
>     * using put_user_pages() instead of either put_page or put_user_page,
>       thus getting rid of j entirely, and
>
>     * renaming an ancient minor confusion: nr --> nr_pinned),
>
> we could have this, which is looks cleaner and still does the same thing:
>
> diff --git a/mm/gup.c b/mm/gup.c
> index f173fcbaf1b2..0c1f36be1863 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1486,6 +1486,33 @@ static __always_inline long __gup_longterm_locked(struct task_struct *tsk,
>  }
>  #endif /* CONFIG_FS_DAX || CONFIG_CMA */
>
> +#ifdef CONFIG_CMA
> +/*
> + * Returns the number of pages that were *not* rejected. This makes it
> + * exactly compatible with its callers.
> + */
> +static int reject_cma_pages(int nr_pinned, unsigned gup_flags,
> +                           struct page **pages)
> +{
> +       int i = 0;
> +       if (unlikely(gup_flags & FOLL_LONGTERM)) {
> +
> +               for (i = 0; i < nr_pinned; i++)
> +                       if (is_migrate_cma_page(pages[i])) {
> +                               put_user_pages(&pages[i], nr_pinned - i);
> +                               break;
> +                       }
> +       }
> +       return i;
> +}
> +#else
> +static int reject_cma_pages(int nr_pinned, unsigned gup_flags,
> +                           struct page **pages)
> +{
> +       return nr_pinned;
> +}
> +#endif
> +
>  /*
>   * This is the same as get_user_pages_remote(), just with a
>   * less-flexible calling convention where we assume that the task
> @@ -2216,7 +2243,7 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
>                         unsigned int gup_flags, struct page **pages)
>  {
>         unsigned long addr, len, end;
> -       int nr = 0, ret = 0;
> +       int nr_pinned = 0, ret = 0;
>
>         start &= PAGE_MASK;
>         addr = start;
> @@ -2231,25 +2258,27 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
>
>         if (gup_fast_permitted(start, nr_pages)) {
>                 local_irq_disable();
> -               gup_pgd_range(addr, end, gup_flags, pages, &nr);
> +               gup_pgd_range(addr, end, gup_flags, pages, &nr_pinned);
>                 local_irq_enable();
> -               ret = nr;
> +               ret = nr_pinned;
>         }
>
> -       if (nr < nr_pages) {
> +       nr_pinned = reject_cma_pages(nr_pinned, gup_flags, pages);
> +
> +       if (nr_pinned < nr_pages) {
>                 /* Try to get the remaining pages with get_user_pages */
> -               start += nr << PAGE_SHIFT;
> -               pages += nr;
> +               start += nr_pinned << PAGE_SHIFT;
> +               pages += nr_pinned;
>
> -               ret = __gup_longterm_unlocked(start, nr_pages - nr,
> +               ret = __gup_longterm_unlocked(start, nr_pages - nr_pinned,
>                                               gup_flags, pages);
>
>                 /* Have to be a bit careful with return values */
> -               if (nr > 0) {
> +               if (nr_pinned > 0) {
>                         if (ret < 0)
> -                               ret = nr;
> +                               ret = nr_pinned;
>                         else
> -                               ret += nr;
> +                               ret += nr_pinned;
>                 }
>         }
>
>
> Rather lightly tested...I've compile-tested with CONFIG_CMA and !CONFIG_CMA,
> and boot tested with CONFIG_CMA, but could use a second set of eyes on whether
> I've added any off-by-one errors, or worse. :)
>
Do you mind I send V2 based on your above patch? Anyway, it is a simple bug fix.

Thanks,
  Pingfan
