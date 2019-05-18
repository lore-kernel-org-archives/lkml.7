Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2027C46460
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 01:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A7121897
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 01:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Aa2aThr8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbfERBTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 21:19:32 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:43885 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbfERBTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 21:19:32 -0400
Received: by mail-yb1-f194.google.com with SMTP id t7so3333406ybq.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 18:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Ho8cHrK4qMqiN3LtaRzVtq4HS5hpwx3f8cFy/TZJ4Y=;
        b=Aa2aThr8oZpP0WVahD8NCNtshzOd5qsE6LqKaPa6VLI3iYk06oUL4BlBH5BA18zwU4
         Gq3Rt3R6ehByjfoq9VBjVL/B24UpZw5SethE0DegFvSksoigMBv9jPJcnkpsG7vVKnei
         7eB9NigP6sVXiyh6W3xmHGF2LtlTntNh8IWQG1gltDpbv/Vnqwt/dDkSv32UQ+Zyvmuj
         7W64PTuAiZN+TtH90+krk10ZQRyYxIinqRqWZJElqdKAXDdwkbAtXLjE7EHAVHb0pNoh
         RHgbOyZnzTbbTsUszgg8DRq5iAKYSjwFf09KEFH7+p2jQNeUpkR8kOulHqKzRSL9pd69
         RqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Ho8cHrK4qMqiN3LtaRzVtq4HS5hpwx3f8cFy/TZJ4Y=;
        b=OOlgE7hvod5XHusKe4kf7gebrOZ7JmdkzpTZNw0/b3bV7HkEwpkB6TZ71FpvHfzhex
         iuJI3fmEhz3UME/19kqvl6gey6fLTiEKih/iFplIoR/sQanoLCreMLvXYJlja5CVBfrW
         TCDSk3Z/SSjfY51t+P+GIYhD1BWkdz+zuLZgkydi5Z0qWkKj9qc9qGafcZs+2mWRppGO
         bG7j53V9Wfu4onAsJqs0yN6p2+Z58pevaBmRTHsS92rGQ/jhtVk6jZN3xxXvnNNRaxdR
         HGuKJVw4ECnIF6yV75DgcykDKVWfGiXdIZKi3ROXHQ7bWXOv92rvcwv03GT5YJBAIvUy
         ZI+w==
X-Gm-Message-State: APjAAAWT7Wg2u5wyYRFFSHyYn/kDWMniLLruChdFfXg+p3JG92GgWv5R
        tx3pm1FV/fITqUBDCqp79NK0qIZTVnAsa5R+bjqIcg==
X-Google-Smtp-Source: APXvYqzvKyMFNOSqSc71NU74orRIuvu6avgzOT91rXMBDzXJ82LO1zMIoynfnQdIB73p8+SDOiYAK9X4zzYXERAIrcA=
X-Received: by 2002:a25:8608:: with SMTP id y8mr28856096ybk.100.1558142371276;
 Fri, 17 May 2019 18:19:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190518001818.193336-1-shakeelb@google.com> <20190518005927.GB3431@tower.DHCP.thefacebook.com>
In-Reply-To: <20190518005927.GB3431@tower.DHCP.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 17 May 2019 18:19:19 -0700
Message-ID: <CALvZod4cOWrzGzJncCzaPqBbnmavbkrbTZnwY6r1V5eFVwOJAQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm, memcg: introduce memory.events.local
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Down <chris@chrisdown.name>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 5:59 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Fri, May 17, 2019 at 05:18:18PM -0700, Shakeel Butt wrote:
> > The memory controller in cgroup v2 exposes memory.events file for each
> > memcg which shows the number of times events like low, high, max, oom
> > and oom_kill have happened for the whole tree rooted at that memcg.
> > Users can also poll or register notification to monitor the changes in
> > that file. Any event at any level of the tree rooted at memcg will
> > notify all the listeners along the path till root_mem_cgroup. There are
> > existing users which depend on this behavior.
> >
> > However there are users which are only interested in the events
> > happening at a specific level of the memcg tree and not in the events in
> > the underlying tree rooted at that memcg. One such use-case is a
> > centralized resource monitor which can dynamically adjust the limits of
> > the jobs running on a system. The jobs can create their sub-hierarchy
> > for their own sub-tasks. The centralized monitor is only interested in
> > the events at the top level memcgs of the jobs as it can then act and
> > adjust the limits of the jobs. Using the current memory.events for such
> > centralized monitor is very inconvenient. The monitor will keep
> > receiving events which it is not interested and to find if the received
> > event is interesting, it has to read memory.event files of the next
> > level and compare it with the top level one. So, let's introduce
> > memory.events.local to the memcg which shows and notify for the events
> > at the memcg level.
> >
> > Now, does memory.stat and memory.pressure need their local versions.
> > IMHO no due to the no internal process contraint of the cgroup v2. The
> > memory.stat file of the top level memcg of a job shows the stats and
> > vmevents of the whole tree. The local stats or vmevents of the top level
> > memcg will only change if there is a process running in that memcg but
> > v2 does not allow that. Similarly for memory.pressure there will not be
> > any process in the internal nodes and thus no chance of local pressure.
> >
> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> > ---
> > Changelog since v1:
> > - refactor memory_events_show to share between events and events.local
>
> Reviewed-by: Roman Gushchin <guro@fb.com>
>
> You also need to add some stuff into cgroup v2 documentation.
>

Thanks, will update the doc in the next version.

Shakeel
