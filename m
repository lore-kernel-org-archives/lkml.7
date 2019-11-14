Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F92C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED9720643
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iO1A/b4l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbfKNAnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 19:43:10 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40014 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfKNAnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 19:43:10 -0500
Received: by mail-wr1-f67.google.com with SMTP id i10so4476648wrs.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 16:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZJ2vg6lRpb9kWQ2Ir+kHNao0DW/EVUTH+nPIta6hjcA=;
        b=iO1A/b4l4fmDbaFMKCddNT/e+qOJnr8YjRadRCA1SnbBt6E0iKMiPDlg8+hkcGWPhk
         V4NJAu2hFV9lp8pfeR4jxrI+BNxmeYJGaLz+xBxcMIL5KgGjtrELpDgqECUhiHlSAORS
         YjOrD43x7G06OHpXfNaCAs4c6fxA0iIzJ4TaXNDiAgoWNEjXRQfyasUkeT5rbYYunxkE
         XjvT0S6ZV73KJXSUWXoYAHuybYMy8Jt81ZDRM/FJ9Upj4AqTJL78G0fWLHcc2/CktY5T
         e8o3a7ci3niNXnmNzGbDuS5wYlZT1ItLbAt3gNM9xa+aLMza9CTLJdF2fgZqip5EM/92
         c9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZJ2vg6lRpb9kWQ2Ir+kHNao0DW/EVUTH+nPIta6hjcA=;
        b=NprIpYKrVOwWJ5RF/r+do21eoYxlwnYgHePPsg2egcTRsGmggKntk/9c0MPAmekdhi
         l8W1JoEuKNNa5YqQMJTlwPQ68NzNOc+SBqX+91spSh5P7Kw0DlSRyMxm5Jl8Mhf0LAtd
         PN9zBqCNDVo00Parvdmxjw/8IyVVJO4R5Cxw7OL+0//OUj3Al//eECdyrpiSikj3tC/E
         sSRPsnQTk7ZFFKkasr6nnwNjspet46eglJDvdw+HU2JKFAQOJlwKLdHoixB26tQeXdsa
         CK7ijmfE7vssBvWjFS37V6G8Q5Nr0Dy29ehrVGmfGJbmw1PCgtWzWky7KC9B0NX4WgTJ
         BAVA==
X-Gm-Message-State: APjAAAU4Ylt3BPoPcthbDFFsZS4kkP1zbxwgsTLEX3YIrUjpHA0Ttrl1
        8+07rw37ZI1f/gL5CVHw0JZcnC7zMEeQIc4qc8fOCA==
X-Google-Smtp-Source: APXvYqww9MDo/oLjckfKZftNJgoOA354m5+zaC4lhMjhE3aBPbc8lwnrhI7EtMw33h9S7JjEDRUCAuNJbiEpH8uaySY=
X-Received: by 2002:adf:f1c7:: with SMTP id z7mr5866675wro.355.1573692186564;
 Wed, 13 Nov 2019 16:43:06 -0800 (PST)
MIME-Version: 1.0
References: <20191114003042.85252-1-irogers@google.com>
In-Reply-To: <20191114003042.85252-1-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 13 Nov 2019 16:42:55 -0800
Message-ID: <CAP-5=fUSYpy97VWLb4nLnkiZ-0D1uP4nnRLhLL3=E6gYWv2UZQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] Optimize cgroup context switch
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Qian Cai <cai@lca.pw>, Joe Lawrence <joe.lawrence@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Gary Hook <Gary.Hook@amd.com>, Arnd Bergmann <arnd@arndb.de>,
        Kan Liang <kan.liang@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies, I missed the in-reply-to
<20190724223746.153620-1-irogers@google.com>.

Ian

On Wed, Nov 13, 2019 at 4:30 PM Ian Rogers <irogers@google.com> wrote:
>
> Avoid iterating over all per-CPU events during cgroup changing context
> switches by organizing events by cgroup.
>
> To make an efficient set of iterators, introduce a min max heap
> utility with test.
>
> These patches include a caching algorithm to improve the search for
> the first event in a group by Kan Liang <kan.liang@linux.intel.com> as
> well as rebasing hit "optimize event_filter_match during sched_in"
> from https://lkml.org/lkml/2019/8/7/771.
>
> The v2 patch set was modified by Peter Zijlstra in his perf/cgroup
> branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
>
> These patches follow Peter's reorganization and his fixes to the
> perf_cpu_context min_heap storage code.
>
> Ian Rogers (8):
>   lib: introduce generic min max heap
>   perf: Use min_max_heap in visit_groups_merge
>   perf: Add per perf_cpu_context min_heap storage
>   perf/cgroup: Grow per perf_cpu_context heap storage
>   perf/cgroup: Order events in RB tree by cgroup id
>   perf: simplify and rename visit_groups_merge
>   perf: cache perf_event_groups_first for cgroups
>   perf: optimize event_filter_match during sched_in
>
> Kan Liang (1):
>   perf/cgroup: Do not switch system-wide events in cgroup switch
>
> Peter Zijlstra (1):
>   perf/cgroup: Reorder perf_cgroup_connect()
>
>  include/linux/min_max_heap.h | 134 +++++++++
>  include/linux/perf_event.h   |  14 +
>  kernel/events/core.c         | 512 ++++++++++++++++++++++++++++-------
>  lib/Kconfig.debug            |  10 +
>  lib/Makefile                 |   1 +
>  lib/test_min_max_heap.c      | 194 +++++++++++++
>  6 files changed, 769 insertions(+), 96 deletions(-)
>  create mode 100644 include/linux/min_max_heap.h
>  create mode 100644 lib/test_min_max_heap.c
>
> --
> 2.24.0.432.g9d3f5f5b63-goog
>
