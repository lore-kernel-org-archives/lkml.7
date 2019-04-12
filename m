Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4E8C282CE
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 20:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C75B20850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 20:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LP65T9uo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfDLUHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 16:07:30 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:34815 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbfDLUH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 16:07:29 -0400
Received: by mail-yw1-f68.google.com with SMTP id x129so3835506ywc.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 13:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cWy39L110bpl90KlTOYN36nnj0m9Og8hXJw1+zoZDKk=;
        b=LP65T9uo0dVn2Y5omvF5mxvXGRfAgu6NngtzQkPAnlMx95MzRaoxUddWsZp48rD13D
         DVYmLNGVWFeqmVnvvMAV+nlf+frio4tA488tODN1HVqEvHfhTW5BOunil70RJ/PsIhYE
         AVgukhQXhJcaGfW/bxdzEpdpiwIo/iM6ZGTv3XE8Y3RuPKBM4A8WyrvK4tDNZUmeWYl9
         wLKIa898nv5rY6FJxM+Z2Bz1Tk8gGszZttNaJ7iQfD4v9jr1wIsYMwMZhHPbEWz/2gJT
         zl199wVxdgncig7ajSNj8hQEX/RicdcdKS2ywd0YJfPSMTtbNXfvLGLH43wX3vF0nHyC
         CWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cWy39L110bpl90KlTOYN36nnj0m9Og8hXJw1+zoZDKk=;
        b=G1xY8ebuWPReirMBZfgG2G9WlBbvWbSTxGyIfkC35HAkjdZaPigS53pUspFvAy1zs4
         NJh5+QEK+HRh4Lsm8Dxa5rnZ8z/SiS6YVAyOvEjLTp2LBPLWe7mONBVD7OG8hXlE1phb
         DX46jHeq4dnmiSMi6oHnm4wNyvIcrtd5MuvHEF8S99ffbXQtC+aHX3zNPi7bRKBBBp/G
         0oZJ3PvFs1I90n5+MAvrOdS3/U/i0UlPwh0h3W7aesuUEQo1TM4CUr6Vv3y1Q2leXCEF
         g4BbM1SMr1dx/gk3u22TKaw+hg4w5DSWmTYNzWpxu5LnwyvUsUg3kzwRsb8rVKOpl2XW
         jG4Q==
X-Gm-Message-State: APjAAAVurFPggGKwtK3gsff8o0jGxFZXLuQWLXNELChAh5gRQe3yNN+1
        9lgrlymxP4LtmY7JCNztvLQxHcCA3cSb72LJMJGZZQ==
X-Google-Smtp-Source: APXvYqznZO7Qm/QhFUfHKm3tnghM46ifrr9A348bqIDJYnm/2sGPr6e7rkOfkOAFCHIVkOnCoZYMtWSNR8ycH5WBDbs=
X-Received: by 2002:a81:9ad0:: with SMTP id r199mr46915127ywg.310.1555099648342;
 Fri, 12 Apr 2019 13:07:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190412151507.2769-1-hannes@cmpxchg.org>
In-Reply-To: <20190412151507.2769-1-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 12 Apr 2019 13:07:17 -0700
Message-ID: <CALvZod4-7a1aCELqWb+6xJ=-cPtfntNipAG634PA6UEQcN3Lag@mail.gmail.com>
Subject: Re: [PATCH 0/4] mm: memcontrol: memory.stat cost & correctness
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 8:15 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> The cgroup memory.stat file holds recursive statistics for the entire
> subtree. The current implementation does this tree walk on-demand
> whenever the file is read. This is giving us problems in production.
>
> 1. The cost of aggregating the statistics on-demand is high. A lot of
> system service cgroups are mostly idle and their stats don't change
> between reads, yet we always have to check them. There are also always
> some lazily-dying cgroups sitting around that are pinned by a handful
> of remaining page cache; the same applies to them.
>
> In an application that periodically monitors memory.stat in our fleet,
> we have seen the aggregation consume up to 5% CPU time.
>
> 2. When cgroups die and disappear from the cgroup tree, so do their
> accumulated vm events. The result is that the event counters at
> higher-level cgroups can go backwards and confuse some of our
> automation, let alone people looking at the graphs over time.
>
> To address both issues, this patch series changes the stat
> implementation to spill counts upwards when the counters change.
>
> The upward spilling is batched using the existing per-cpu cache. In a
> sparse file stress test with 5 level cgroup nesting, the additional
> cost of the flushing was negligible (a little under 1% of CPU at 100%
> CPU utilization, compared to the 5% of reading memory.stat during
> regular operation).

For whole series:

Reviewed-by: Shakeel Butt <shakeelb@google.com>

>
>  include/linux/memcontrol.h |  96 +++++++-------
>  mm/memcontrol.c            | 290 +++++++++++++++++++++++++++----------------
>  mm/vmscan.c                |   4 +-
>  mm/workingset.c            |   7 +-
>  4 files changed, 234 insertions(+), 163 deletions(-)
>
>
