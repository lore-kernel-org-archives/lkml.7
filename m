Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6A5C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 23:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB6AA229F9
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 23:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTEVk08h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfGYXst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 19:48:49 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45361 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbfGYXst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 19:48:49 -0400
Received: by mail-ot1-f66.google.com with SMTP id x21so15059210otq.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 16:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0/601dflBui9fUKU13mAsQ6rd2OiEZJpX1vt/upGwrU=;
        b=GTEVk08hKujXGWe5eMnIgIADu2PDqqGQHd1fXyoOBVjcUi9jRRJQvLA7UY9mzOtUW7
         MvzofGlJrbylhZ+E0lPaGRZiSHVQCWIiFDaZobfAZZHIx3NPzA781HBRhvzgSuqUTEF8
         chlv2uucelGR7GZieGehPxRdXXh5P42GVVqbzjdkg+sW1KfpUbUystcuygosJPfM4ChO
         tMJF6yqP554r383UvBqO6oHO5yB4tdl3Qodr8zELOPhAdXvu1eVW5OGFZZNCaRAooBya
         wlT3wHBHEBGbl3FLD4Gbu0Gr2KQ8kPIZMC+p8qy1RLYB9A9sljlTrM9y0e4Xg13/aEl1
         3QHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0/601dflBui9fUKU13mAsQ6rd2OiEZJpX1vt/upGwrU=;
        b=GUWCFAkGPXJ4QrOApBmxJct8F5oF7Kq+MVNyrS8I2Hp99Ej9eagoMbxJnAoJ/Dmvaq
         Idvloz3aATkJUSty7oSVcuz6XnilnciRkxzAvwD2QW8PuROABZe+sb8j4eDbjT7GJ4di
         Nm6u5J8mWRxNCuI1GC06UtcOZmD+No/t4X8XIkeOEXeIY8Dmubdu8PnWlPcBfo8XUz0i
         mEO0Z9doEcH2RVvIDOr09dTZh74VUZLVZi9Iu4SkYRGmayAGSLF5CXPFaMAfdwpcrkhf
         9FslKGRiaj6GICFhrNFjD4aEstkw5NX9VvtGYV6VUrfKzaHvGw/SRzBnApnWpzT+rJzZ
         XsDg==
X-Gm-Message-State: APjAAAWxLsjjAwXvzaESS0lz70E09nw6k8b5kQ9AUGu8vAtHqPaG/AdY
        JXtB/Op7ivNClTW6cuAm+Ooqwdw2fDuLWGn2dg4=
X-Google-Smtp-Source: APXvYqwwrd1A4w1ujcS1G8VV0f9obBolPkKbeDxwmn74a0mZM1Q3fruAl5PiPEU3KMAmQeS4ihLVDIlAxJswctoCjVI=
X-Received: by 2002:a05:6830:2098:: with SMTP id y24mr25212379otq.173.1564098528292;
 Thu, 25 Jul 2019 16:48:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190725184253.21160-1-lpf.vector@gmail.com> <1564080768.11067.22.camel@lca.pw>
In-Reply-To: <1564080768.11067.22.camel@lca.pw>
From:   Pengfei Li <lpf.vector@gmail.com>
Date:   Fri, 26 Jul 2019 07:48:36 +0800
Message-ID: <CAD7_sbEXQt0oHuD01BXdW2_=G4h8U8ogHVt0N1Yez2ajFJkShw@mail.gmail.com>
Subject: Re: [PATCH 00/10] make "order" unsigned int
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        mgorman@techsingularity.net, mhocko@suse.com, vbabka@suse.cz,
        aryabinin@virtuozzo.com, osalvador@suse.de, rostedt@goodmis.org,
        mingo@redhat.com, pavel.tatashin@microsoft.com, rppt@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 2:52 AM Qian Cai <cai@lca.pw> wrote:
>
> On Fri, 2019-07-26 at 02:42 +0800, Pengfei Li wrote:
> > Objective
> > ----
> > The motivation for this series of patches is use unsigned int for
> > "order" in compaction.c, just like in other memory subsystems.
>
> I suppose you will need more justification for this change. Right now, I don't

Thanks for your comments.

> see much real benefit apart from possibly introducing more regressions in those

As you can see, except for patch [05/10], other commits only modify the type
of "order". So the change is not big.

For the benefit, "order" may be negative, which is confusing and weird.
There is no good reason not to do this since it can be avoided.

> tricky areas of the code. Also, your testing seems quite lightweight.
>

Yes, you are right.
I use "stress" for stress testing, and made some small code coverage testing.

As you said, I need more ideas and comments about testing.
Any suggestions for testing?

Thanks again.

--
Pengfei

> >
> > In addition, did some cleanup about "order" in page_alloc
> > and vmscan.
> >
> >
> > Description
> > ----
> > Directly modifying the type of "order" to unsigned int is ok in most
> > places, because "order" is always non-negative.
> >
> > But there are two places that are special, one is next_search_order()
> > and the other is compact_node().
> >
> > For next_search_order(), order may be negative. It can be avoided by
> > some modifications.
> >
> > For compact_node(), order = -1 means performing manual compaction.
> > It can be avoided by specifying order = MAX_ORDER.
> >
> > Key changes in [PATCH 05/10] mm/compaction: make "order" and
> > "search_order" unsigned.
> >
> > More information can be obtained from commit messages.
> >
> >
> > Test
> > ----
> > I have done some stress testing locally and have not found any problems.
> >
> > In addition, local tests indicate no performance impact.
> >
> >
> > Pengfei Li (10):
> >   mm/page_alloc: use unsigned int for "order" in should_compact_retry()
> >   mm/page_alloc: use unsigned int for "order" in __rmqueue_fallback()
> >   mm/page_alloc: use unsigned int for "order" in should_compact_retry()
> >   mm/page_alloc: remove never used "order" in alloc_contig_range()
> >   mm/compaction: make "order" and "search_order" unsigned int in struct
> >     compact_control
> >   mm/compaction: make "order" unsigned int in compaction.c
> >   trace/events/compaction: make "order" unsigned int
> >   mm/compaction: use unsigned int for "compact_order_failed" in struct
> >     zone
> >   mm/compaction: use unsigned int for "kcompactd_max_order" in struct
> >     pglist_data
> >   mm/vmscan: use unsigned int for "kswapd_order" in struct pglist_data
> >
> >  include/linux/compaction.h        |  30 +++----
> >  include/linux/mmzone.h            |   8 +-
> >  include/trace/events/compaction.h |  40 +++++-----
> >  include/trace/events/kmem.h       |   6 +-
> >  include/trace/events/oom.h        |   6 +-
> >  include/trace/events/vmscan.h     |   4 +-
> >  mm/compaction.c                   | 127 +++++++++++++++---------------
> >  mm/internal.h                     |   6 +-
> >  mm/page_alloc.c                   |  16 ++--
> >  mm/vmscan.c                       |   6 +-
> >  10 files changed, 126 insertions(+), 123 deletions(-)
> >
