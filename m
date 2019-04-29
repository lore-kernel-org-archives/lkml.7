Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15849C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD2FC216F4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ms9nqUQx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbfD2OhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 10:37:20 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:33140 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfD2OhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 10:37:20 -0400
Received: by mail-yb1-f194.google.com with SMTP id e197so1145023ybf.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 07:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M/6XEsIqR8VWQpLXIhH0FRoDcnonKS2KQt8PYqdEcmQ=;
        b=ms9nqUQx6QnRoflbPjYgEjlFy2Y9D0/6+0G9VqgYNlscBxoReHFFvdNWni+KPvrniA
         LyI6meDC6xaCQQcZpNBsWnausZSGUkfQLsxB2kAWos+57OQ52Pucuo8tCUdUsIudCDHZ
         vElK/QYsTago67Nbpl89mqFDK5RGuySBGU82zoLexyXiz1juRlqppKtH90OmOxaXTtwX
         Fio82mWAZZel9R/jB+y1QQYy4IHkRmjTMwdLDcuhsJpgFPqDu7u+6OKrhzVYEH2LN4R6
         NvvyeAIeOtREkegp0JCSBfdKaIbf9KB9vV7F6z0b5Xawd5KXDHlUeFFLCsrW3vW8G+Cx
         KX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M/6XEsIqR8VWQpLXIhH0FRoDcnonKS2KQt8PYqdEcmQ=;
        b=a21ST8Ohd0IDtt4wf3DpxbCuZqP8i9cQ8q2Z+rRcnsJn6nMACJSJUk+tkr3DB1McjP
         4dPzTqMpH8B6u1Ak3UQq/5++lxSgVHeWuSYJFM1fewUO877F/MEwZ7HdfNSUc9vt6grl
         qGL9FcCUzt4vPVEd4SZZJakcpRMj4MWng2YaH9DDIl/KmqriPJiPLYHdQJUeTlqQLYMA
         Wdm35nBJ1WZt4mJKFXfXAL/ot1TiMazT/f/3kBE2gTd6MeuD7zcXzsGYxqaY+cFPLegX
         YBVZDAl2YhHw3XDvYHjDHt3wWpCniqhVLzfrfxEDGPuIPahFhK5Jjkm0lFpj5cCnO10H
         tWdg==
X-Gm-Message-State: APjAAAXyqHawX1fqwGZyIXd1iEymiVakvgxoEEeUDmO0avbKnqwpJofg
        2zTH0K4GTr6yKcZPyqk5n5RQ5N1ODm+etFE4ZNiW1A==
X-Google-Smtp-Source: APXvYqx/Z+xcfTj7msxd406E4QiWuVUE8NaIn1RLZw9Lw5xls8pb2+5DuUvvMRyfEQAXJ9Frvtwob28ZJJDlwvkGBe4=
X-Received: by 2002:a25:f507:: with SMTP id a7mr49459321ybe.164.1556548639264;
 Mon, 29 Apr 2019 07:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190428235613.166330-1-shakeelb@google.com> <20190429122214.GK21837@dhcp22.suse.cz>
In-Reply-To: <20190429122214.GK21837@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 29 Apr 2019 07:37:08 -0700
Message-ID: <CALvZod6-EOAkcuiuBpoE6uR2DFNUkUY8syHxenFEAZTxhgNMhQ@mail.gmail.com>
Subject: Re: [PATCH] memcg, oom: no oom-kill for __GFP_RETRY_MAYFAIL
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 5:22 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Sun 28-04-19 16:56:13, Shakeel Butt wrote:
> > The documentation of __GFP_RETRY_MAYFAIL clearly mentioned that the
> > OOM killer will not be triggered and indeed the page alloc does not
> > invoke OOM killer for such allocations. However we do trigger memcg
> > OOM killer for __GFP_RETRY_MAYFAIL. Fix that.
>
> An example of __GFP_RETRY_MAYFAIL memcg OOM report would be nice. I
> thought we haven't been using that flag for memcg allocations yet.
> But this is definitely good to have addressed.

Actually I am planning to use it for memcg allocations (specifically
fsnotify allocations).

>
> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
>
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks.

>
> > ---
> >  mm/memcontrol.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 2713b45ec3f0..99eca724ed3b 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -2294,7 +2294,6 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
> >       unsigned long nr_reclaimed;
> >       bool may_swap = true;
> >       bool drained = false;
> > -     bool oomed = false;
> >       enum oom_status oom_status;
> >
> >       if (mem_cgroup_is_root(memcg))
> > @@ -2381,7 +2380,7 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
> >       if (nr_retries--)
> >               goto retry;
> >
> > -     if (gfp_mask & __GFP_RETRY_MAYFAIL && oomed)
> > +     if (gfp_mask & __GFP_RETRY_MAYFAIL)
> >               goto nomem;
> >
> >       if (gfp_mask & __GFP_NOFAIL)
> > @@ -2400,7 +2399,6 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
> >       switch (oom_status) {
> >       case OOM_SUCCESS:
> >               nr_retries = MEM_CGROUP_RECLAIM_RETRIES;
> > -             oomed = true;
> >               goto retry;
> >       case OOM_FAILED:
> >               goto force;
> > --
> > 2.21.0.593.g511ec345e18-goog
> >
>
> --
> Michal Hocko
> SUSE Labs
