Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C809C47E49
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 19:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6952A20882
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 19:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jqJNlerT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730139AbfJUT37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 15:29:59 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42553 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbfJUT37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 15:29:59 -0400
Received: by mail-oi1-f196.google.com with SMTP id i185so12060547oif.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 12:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=38DEAaPe7VPNtXQ2EseqbfEr1C+gTTQIPutRtKmtjCg=;
        b=jqJNlerT/h0PB/yL2UqjliVjE/m9ZYB1YyN24nPa/HvH9kqLgg/UQ2jPkbYVK6v//M
         6dlvQUaOWUhzVi21Uisi0ck9tehmlXxQmY9svr55XdkPCfZ3QNAbbbjkCt3aJF9rT3jZ
         KqwC3rb+Q0U44fb236Fo5gIAlo19lc86VBZtIuITRWK4R0T/ZmefPz1JxZCBm71znt2T
         ZQ/GO6j2pVlyTnzm6NhtvBfugCp4kKOVcMrmgfxPJcdD3vpH5x6DdYqKm99Wgq2P9a8R
         ehLTNzh7cn5JOxuYkyr308NDoy0ddIIoZvUEhTub+mAUElgRAmbaIvxtjFPy+Ztzs1L2
         ujeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=38DEAaPe7VPNtXQ2EseqbfEr1C+gTTQIPutRtKmtjCg=;
        b=tNZDiUNeCjy3GbDCcWa0dBQosf86oU7KYF1svYhJIKCPWCtpBeDmHIdNb6DPChd+6x
         2tpKy9vS6Y/gLA0hzIqh0mfUrf5mbqO54+MOtWHC5z9OqjJtNLvUCTNof/aR9noORQ9A
         DmA54CvP0QV6m/nr+a1cRzwrZihHjtagcJzVRIxf663IbUmQ13PdFyDuZBP/7nOnaz3/
         9/8Oi5Wxd8KJ4X6B4/8bGUdtXkIffTQ5TGH4bPPbOTnnytvmUpfoX+x7VM4HcAyUd4Ru
         jtFnTbqnnwAW7Z/txG8xLGdwlL8F12Oj0wjKZNzD2x6BHC5F4spcSwRGH5Um8IA6P2ui
         zDdg==
X-Gm-Message-State: APjAAAW7M+rjYB+WbTM26J6CVqasR/GgWJ4hmOaZm5mGQXhyTbq2StQ5
        Kn6ZxExjfnbDVmj8jU/oZLjtsoJZxAywM7rxexdIxQ==
X-Google-Smtp-Source: APXvYqxbPxZzkZHwY5QcQh0HnZYMEGGsQw6/YuNBbPoU8glOU8Gu39g3Wnxa+m3+qpb/t8IKAD9aL3mBWGEtxUO+vNE=
X-Received: by 2002:aca:5f55:: with SMTP id t82mr20792170oib.65.1571686197480;
 Mon, 21 Oct 2019 12:29:57 -0700 (PDT)
MIME-Version: 1.0
References: <20191013003024.215429-1-almasrymina@google.com>
 <20191013003024.215429-5-almasrymina@google.com> <982efbbc-f795-5819-83a8-7d328537e070@oracle.com>
In-Reply-To: <982efbbc-f795-5819-83a8-7d328537e070@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Mon, 21 Oct 2019 12:29:46 -0700
Message-ID: <CAHS8izP5=6PFFkq7NMrXCS6x_oV8uNGO4hUM3uh8mBE+J-Y1TA@mail.gmail.com>
Subject: Re: [PATCH v6 5/9] hugetlb: disable region_add file_region coalescing
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     shuah <shuah@kernel.org>, David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        khalid.aziz@oracle.com, open list <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org,
        Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 12:02 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 10/12/19 5:30 PM, Mina Almasry wrote:
> > A follow up patch in this series adds hugetlb cgroup uncharge info the
> > file_region entries in resv->regions. The cgroup uncharge info may
> > differ for different regions, so they can no longer be coalesced at
> > region_add time. So, disable region coalescing in region_add in this
> > patch.
> >
> > Behavior change:
> >
> > Say a resv_map exists like this [0->1], [2->3], and [5->6].
> >
> > Then a region_chg/add call comes in region_chg/add(f=0, t=5).
> >
> > Old code would generate resv->regions: [0->5], [5->6].
> > New code would generate resv->regions: [0->1], [1->2], [2->3], [3->5],
> > [5->6].
> >
> > Special care needs to be taken to handle the resv->adds_in_progress
> > variable correctly. In the past, only 1 region would be added for every
> > region_chg and region_add call. But now, each call may add multiple
> > regions, so we can no longer increment adds_in_progress by 1 in region_chg,
> > or decrement adds_in_progress by 1 after region_add or region_abort. Instead,
> > region_chg calls add_reservation_in_range() to count the number of regions
> > needed and allocates those, and that info is passed to region_add and
> > region_abort to decrement adds_in_progress correctly.
> >
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> >
> > ---
> >
> > Changes in v6:
> > - Fix bug in number of region_caches allocated by region_chg
> >
> > ---
> >  mm/hugetlb.c | 256 +++++++++++++++++++++++++++++----------------------
> >  1 file changed, 147 insertions(+), 109 deletions(-)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 4a60d7d44b4c3..f9c1947925bb9 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> <snip>
> > -static long region_chg(struct resv_map *resv, long f, long t)
> > +static long region_chg(struct resv_map *resv, long f, long t,
> > +                    long *out_regions_needed)
> >  {
> > +     struct file_region *trg = NULL;
> >       long chg = 0;
> >
> > +     /* Allocate the maximum number of regions we're going to need for this
> > +      * reservation. The maximum number of regions we're going to need is
> > +      * (t - f) / 2 + 1, which corresponds to a region with alternating
> > +      * reserved and unreserved pages.
> > +      */
> > +     *out_regions_needed = (t - f) / 2 + 1;
> > +
> >       spin_lock(&resv->lock);
> > -retry_locked:
> > -     resv->adds_in_progress++;
> > +
> > +     resv->adds_in_progress += *out_regions_needed;
> >
> >       /*
> >        * Check for sufficient descriptors in the cache to accommodate
> >        * the number of in progress add operations.
> >        */
> > -     if (resv->adds_in_progress > resv->region_cache_count) {
> > -             struct file_region *trg;
> > -
> > -             VM_BUG_ON(resv->adds_in_progress - resv->region_cache_count > 1);
> > +     while (resv->region_cache_count < resv->adds_in_progress) {
> >               /* Must drop lock to allocate a new descriptor. */
> > -             resv->adds_in_progress--;
> >               spin_unlock(&resv->lock);
> > -
> >               trg = kmalloc(sizeof(*trg), GFP_KERNEL);
> >               if (!trg)
> >                       return -ENOMEM;
> > @@ -393,9 +395,9 @@ static long region_chg(struct resv_map *resv, long f, long t)
> >               spin_lock(&resv->lock);
> >               list_add(&trg->link, &resv->region_cache);
> >               resv->region_cache_count++;
> > -             goto retry_locked;
> >       }
>
>
> I know that I suggested allocating the worst case number of entries, but this
> is going to be too much of a hit for existing hugetlbfs users.  It is not
> uncommon for DBs to have a shared areas in excess of 1TB mapped by hugetlbfs.
> With this new scheme, the above while loop will allocate over a half million
> file region entries and end up only using one.
>
> I think we need to step back and come up with a different approach.  Let me
> give it some more thought before throwing out ideas that may waste more of
> your time.  Sorry.

No problem at all. The other more reasonable option is to have it such
that region_add allocates its own cache entries if it needs to, and
the effect of that is that region_add may fail, so the callers must
handle that possibility. Doesn't seem too difficult to handle.

> --
> Mike Kravetz
