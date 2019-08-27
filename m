Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0546C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 11:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C39142173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 11:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0fxmZy5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbfH0Lo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 07:44:26 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39979 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbfH0Lo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 07:44:26 -0400
Received: by mail-io1-f67.google.com with SMTP id t6so45544562ios.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 04:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B6JKwNjAX9OFJ5Xpu3hN1K2seR+5vG6lZdDfWoSwR4Y=;
        b=k0fxmZy5mkRO2ooZzqehi9uB3sSTOy7DeHxXcX76sPz5P/kJMkE6dE/KO8756/7LFu
         LzwR+VnWhUMMBLuZIOIOaQPqqt8Dt2/ANod0nT4sL8th5LprN+dh8fGsh89uWp960+lM
         7rjYfVHHjGi3yVT9YbaPA2DuFoYbh1ERUyFbLHE47q6uKgd8liYwqsEX9LdcH+jal+nB
         ajXw7FAJhUGoWC8BrTi6s/6AbFg2tBHUEd/mAVCCeqS8ZjOJgfSo9PMXyoL29h+3h/rA
         FdjkoZveFpVmVRok2wvo/sI5+M9WmjA/0+nYxuheAtFKAnVph2kVxMd04vwiVyKsvwwo
         hU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B6JKwNjAX9OFJ5Xpu3hN1K2seR+5vG6lZdDfWoSwR4Y=;
        b=LMGEeg8DcnWWLuuGUU1D4FdkLA9FK/g9FaR5HymNTX3b/ggLZSMXLSoRcXYg60U3lJ
         SHBXaQxXKui2z7FSkp2toz0hcVkHd+IXH8j9ec8GyKC6wqnrpjqhstj5mvVdlqplkjlP
         SHxDhciLzZCzmTAaX7Lh9HQA0i8PLEV7damZcbUzfDHwT4mVTeEFKUu7Ik9LA1/bQR4U
         wU5Fv6dsL+ymEIHN6zafaXGp0qSqKXi6vFTN6YCxNfI13Lk4DdRDg3redn2+t62ZWKHh
         4Y0JlZ0Ba0KUHC3Icg+a1HFvWj1PbSxsrzpVZ/FBRzy0UAt3kQp0ABLOuACyU3jwOfnM
         L3ZA==
X-Gm-Message-State: APjAAAWiW59vm3P+5FqyouXvsAnwENMRZ9312ULmMMsj4p6YSfBrjl2+
        J3j/NNLcavz67tMcnJYPHtKTy7V3J8dir8ZEs3jPjw==
X-Google-Smtp-Source: APXvYqwUjF2i+jobmTD/+17nn+qZUSU8T53snEGwU4Uiy0N1tHQF84x+e/mm0P637mHevNeqThe8tS+Ho+AmsZuexSg=
X-Received: by 2002:a6b:cac2:: with SMTP id a185mr17954858iog.142.1566906265777;
 Tue, 27 Aug 2019 04:44:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAE1jjeePxYPvw1mw2B3v803xHVR_BNnz0hQUY_JDMN8ny29M6w@mail.gmail.com>
 <b9cd7603-2441-d351-156a-57d6c13b2c79@linux.alibaba.com> <20190826105521.GF7538@dhcp22.suse.cz>
 <20190827104313.GW7538@dhcp22.suse.cz>
In-Reply-To: <20190827104313.GW7538@dhcp22.suse.cz>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Tue, 27 Aug 2019 19:43:49 +0800
Message-ID: <CALOAHbBMWyPBw+Ciup4+YupbLrxcTW76w+Mfc-mGEm9kcWb8YQ@mail.gmail.com>
Subject: Re: WARNINGs in set_task_reclaim_state with memory cgroup and full
 memory usage
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>,
        Adric Blake <promarbler14@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 6:43 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> If there are no objection to the patch I will post it as a standalong
> one.

I have no objection to your patch. It could fix the issue.

I still think that it is not proper to use a new scan_control here as
it breaks the global reclaim context.
This context switch from global reclaim to memcg reclaim is very
subtle change to the subsequent processing, that may cause some
unexpected behavior.
Anyway, we can send this patch as a standalong one.
Feel free to add:

Acked-by: Yafang Shao <laoar.shao@gmail.com>

>
> On Mon 26-08-19 12:55:21, Michal Hocko wrote:
> > From 59d128214a62bf2d83c2a2a9cde887b4817275e7 Mon Sep 17 00:00:00 2001
> > From: Michal Hocko <mhocko@suse.com>
> > Date: Mon, 26 Aug 2019 12:43:15 +0200
> > Subject: [PATCH] mm, memcg: do not set reclaim_state on soft limit reclaim
> >
> > Adric Blake has noticed the following warning:
> > [38491.963105] WARNING: CPU: 7 PID: 175 at mm/vmscan.c:245 set_task_reclaim_state+0x1e/0x40
> > [...]
> > [38491.963239] Call Trace:
> > [38491.963246]  mem_cgroup_shrink_node+0x9b/0x1d0
> > [38491.963250]  mem_cgroup_soft_limit_reclaim+0x10c/0x3a0
> > [38491.963254]  balance_pgdat+0x276/0x540
> > [38491.963258]  kswapd+0x200/0x3f0
> > [38491.963261]  ? wait_woken+0x80/0x80
> > [38491.963265]  kthread+0xfd/0x130
> > [38491.963267]  ? balance_pgdat+0x540/0x540
> > [38491.963269]  ? kthread_park+0x80/0x80
> > [38491.963273]  ret_from_fork+0x35/0x40
> > [38491.963276] ---[ end trace 727343df67b2398a ]---
> >
> > which tells us that soft limit reclaim is about to overwrite the
> > reclaim_state configured up in the call chain (kswapd in this case but
> > the direct reclaim is equally possible). This means that reclaim stats
> > would get misleading once the soft reclaim returns and another reclaim
> > is done.
> >
> > Fix the warning by dropping set_task_reclaim_state from the soft reclaim
> > which is always called with reclaim_state set up.
> >
> > Reported-by: Adric Blake <promarbler14@gmail.com>
> > Signed-off-by: Michal Hocko <mhocko@suse.com>
> > ---
> >  mm/vmscan.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index c77d1e3761a7..a6c5d0b28321 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -3220,6 +3220,7 @@ unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
> >
> >  #ifdef CONFIG_MEMCG
> >
> > +/* Only used by soft limit reclaim. Do not reuse for anything else. */
> >  unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
> >                                               gfp_t gfp_mask, bool noswap,
> >                                               pg_data_t *pgdat,
> > @@ -3235,7 +3236,8 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
> >       };
> >       unsigned long lru_pages;
> >
> > -     set_task_reclaim_state(current, &sc.reclaim_state);
> > +     WARN_ON_ONCE(!current->reclaim_state);
> > +
> >       sc.gfp_mask = (gfp_mask & GFP_RECLAIM_MASK) |
> >                       (GFP_HIGHUSER_MOVABLE & ~GFP_RECLAIM_MASK);
> >
> > @@ -3253,7 +3255,6 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
> >
> >       trace_mm_vmscan_memcg_softlimit_reclaim_end(sc.nr_reclaimed);
> >
> > -     set_task_reclaim_state(current, NULL);
> >       *nr_scanned = sc.nr_scanned;
> >
> >       return sc.nr_reclaimed;
> > --
> > 2.20.1
> >
> > --
> > Michal Hocko
> > SUSE Labs
>
> --
> Michal Hocko
> SUSE Labs
