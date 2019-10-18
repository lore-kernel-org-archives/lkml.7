Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70B2CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E9A2082C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 18:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qgj6QTI/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505599AbfJRS3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 14:29:37 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]:35226 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502485AbfJRS3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 14:29:36 -0400
Received: by mail-qt1-f173.google.com with SMTP id m15so10510105qtq.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 11:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ka1jde4meHyxobWU4esILBOv5JEOtUjz6qkwUWVqweM=;
        b=Qgj6QTI//JtzBjEw4ZWi4StC9S7tbLBWy2TH0BGjzLGRunn+mD60OHqCNIF18bQu1P
         Pufp12x51hM9wWoBwgc9V9Lz+qFWCWfsCSFTA96wEPypA26nLBYFMyHC8chYrGCDdDCP
         Pdolyenf36XjuyISmDaPY6Pa0NB3k0xKT6UqkaMad8vIl84dAuRkE0TywYt1B2vQDK1m
         RH6zaWbPvXEnbzJ7NfOXpGWD9z3I92aaE89qD3c+rcKSLMA/mCCr+cwefIouRGGtZTs8
         rvGDSMetv4gzEtgmtcbxa6EpoT12WsP/MG6qbVtLSGVOV9uKwetPX8ISZye+Gp3Rimo1
         9fLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ka1jde4meHyxobWU4esILBOv5JEOtUjz6qkwUWVqweM=;
        b=AI4byzQY3qBvGjmFcMyqQPSQNCm9uolQvuFad0O63bLLBddub1ia52oQ7XGKS5hrUV
         pJ90BMevCnJaKEiON9m6OfJ5wz15jikBxXaN2Fl8LncUuqgIaf8RPN9YcSr6huwdw8xs
         NHnhVLg1/m4nP+/bzU/cAWBoXVdAlpVh6tHgjIxWl53uYXliMnaz9RknQEWeSxjLRfdj
         c/IZDpg2NisZucCmDnLnWV79W/kGbNGFOUmllJvP3njjJ1qIN4fWbouFZdRUBBZIfrcv
         xd4ILQzHYBPzFeKJ8ZbYg4NXaRyM5plTj7wv1BiD1kCQjakFQrPJWam0lGzBvhf3vajV
         cbvA==
X-Gm-Message-State: APjAAAWX3Yn7qBU0sAWYIFb4jS8TG+NM3nd4xE+E35V8O1kWOvsjEHeU
        GSDXWHGtF3gKFVfrWLOU4rHOM9lOw4E=
X-Google-Smtp-Source: APXvYqzqjsWRa5qxWt9U0lAfYjxBbdSmGUCJRFQR5YOV5CURR4WlFQYentEbjzqlqVHUmvyF+VdqZw==
X-Received: by 2002:a0c:8522:: with SMTP id n31mr11284330qva.161.1571423375639;
        Fri, 18 Oct 2019 11:29:35 -0700 (PDT)
Received: from quaco.ghostprotocols.net (179-240-170-47.3g.claro.net.br. [179.240.170.47])
        by smtp.gmail.com with ESMTPSA id n42sm4843784qta.31.2019.10.18.11.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 11:29:34 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3E1704DD66; Fri, 18 Oct 2019 15:29:31 -0300 (-03)
Date:   Fri, 18 Oct 2019 15:29:31 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Song Liu <songliubraving@fb.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Jin Yao <yao.jin@linux.intel.com>
Subject: Re: [PATCHv3 00/10] libperf: Add sampling interface (leftover)
Message-ID: <20191018182931.GG1797@kernel.org>
References: <20191017105918.20873-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017105918.20873-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Oct 17, 2019 at 12:59:08PM +0200, Jiri Olsa escreveu:
> hi,
> sending changes for exporting basic sampling interface
> in libperf. It's now possible to use following code in
> applications via libperf:
 

Thanks, applied.

- Arnaldo
> --- (example is without error checks for simplicity)
> 
>   struct perf_event_attr attr = {
>           .type             = PERF_TYPE_TRACEPOINT,
>           .sample_period    = 1,
>           .wakeup_watermark = 1,
>           .disabled         = 1,
>   };
>   /* ... setup attr */
> 
>   cpus = perf_cpu_map__new(NULL);
> 
>   evlist = perf_evlist__new();
>   evsel  = perf_evsel__new(&attr);
>   perf_evlist__add(evlist, evsel);
> 
>   perf_evlist__set_maps(evlist, cpus, NULL);
> 
>   err = perf_evlist__open(evlist);
>   err = perf_evlist__mmap(evlist, 4);
> 
>   err = perf_evlist__enable(evlist);
> 
>   /* ... monitored area, plus all the other cpus */
> 
>   err = perf_evlist__disable(evlist);
> 
>   perf_evlist__for_each_mmap(evlist, map) {
>           if (perf_mmap__read_init(map) < 0)
>                   continue;
> 
>           while ((event = perf_mmap__read_event(map)) != NULL) {
>                   perf_mmap__consume(map);
>           }
> 
>           perf_mmap__read_done(map);
>   }
> 
>   perf_evlist__delete(evlist);
>   perf_cpu_map__put(cpus);
> 
> --- (end)
> 
> Nothing is carved in stone so far, the interface is exported
> as is available in perf now and we can change it as we want.
> 
> New tests are added in test-evlist.c to do thread and cpu based
> sampling.
> 
> All the functionality should not change, however there's considerable
> mmap code rewrite.
> 
> Now we have perf_evlist__mmap_ops called by both perf and libperf
> mmaps functions with specific 'struct perf_evlist_mmap_ops'
> callbacks:
> 
>   - get  - to get mmap object, both libperf and perf use different
>            objects, because perf needs to carry more data for aio,
>            compression and auxtrace
>   - mmap - to actually mmap the object, it's simple mmap for libperf,
>            but more work for perf wrt aio, compression and auxtrace
>   - idx  - callback to get current IDs, used only in perf for auxtrace
>            setup
> 
> 
> It would be great if guys could run your usual workloads to see if all
> is fine.. so far so good in my tests ;-)
> 
> 
> It's also available in here:
>   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>   perf/lib
> 
> v3 changes:
>   - changed mmap0 and mmap_ovw0 to mmap_first and mmap_ovw_first
>   - rebased to latest perf/core
>   - portion of patches already taken
> 
> v2 changes:
>   - rebased to latest perf/core
>   - portion of patches already taken
>   - explained mmap refcnt management in following patch changelog:
>     libperf: Centralize map refcnt setting
> 
> thanks,
> jirka
> 
> 
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Stephane Eranian <eranian@google.com>
> Cc: Song Liu <songliubraving@fb.com>
> Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> ---
> Jiri Olsa (10):
>       libperf: Add perf_evlist__for_each_mmap function
>       libperf: Move mmap allocation to perf_evlist__mmap_ops::get
>       libperf: Move mask setup to perf_evlist__mmap_ops function
>       libperf: Link static tests with libapi.a
>       libperf: Add _GNU_SOURCE define to compilation
>       libperf: Add tests_mmap_thread test
>       libperf: Add tests_mmap_cpus test
>       libperf: Keep count of failed tests
>       libperf: Do not export perf_evsel__init/perf_evlist__init
>       libperf: Add pr_err macro
> 
>  tools/perf/lib/Makefile                  |   2 ++
>  tools/perf/lib/evlist.c                  |  71 ++++++++++++++++++++++++++++++++++++++---------------
>  tools/perf/lib/include/internal/evlist.h |   3 +++
>  tools/perf/lib/include/internal/evsel.h  |   1 +
>  tools/perf/lib/include/internal/mmap.h   |   5 ++--
>  tools/perf/lib/include/internal/tests.h  |  20 ++++++++++++---
>  tools/perf/lib/include/perf/core.h       |   1 +
>  tools/perf/lib/include/perf/evlist.h     |  10 +++++++-
>  tools/perf/lib/include/perf/evsel.h      |   2 --
>  tools/perf/lib/internal.h                |   3 +++
>  tools/perf/lib/libperf.map               |   3 +--
>  tools/perf/lib/mmap.c                    |   6 +++--
>  tools/perf/lib/tests/Makefile            |   8 +++---
>  tools/perf/lib/tests/test-cpumap.c       |   2 +-
>  tools/perf/lib/tests/test-evlist.c       | 218 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  tools/perf/lib/tests/test-evsel.c        |   2 +-
>  tools/perf/lib/tests/test-threadmap.c    |   2 +-
>  tools/perf/util/evlist.c                 |  29 +++++++++-------------
>  18 files changed, 333 insertions(+), 55 deletions(-)

-- 

- Arnaldo
