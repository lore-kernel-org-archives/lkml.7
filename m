Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116E0C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 14:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A0320640
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 14:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387423AbfIVOrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 10:47:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49390 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729072AbfIVOrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 10:47:10 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0CC2110CC1E3;
        Sun, 22 Sep 2019 14:47:10 +0000 (UTC)
Received: from krava (ovpn-204-75.brq.redhat.com [10.40.204.75])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8713319C78;
        Sun, 22 Sep 2019 14:47:06 +0000 (UTC)
Date:   Sun, 22 Sep 2019 16:47:05 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
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
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [RFC 00/73] libperf: Add sampling interface
Message-ID: <20190922144705.GA17104@krava>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.65]); Sun, 22 Sep 2019 14:47:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 03:22:42PM +0200, Jiri Olsa wrote:
> hi,
> sending changes for exporting basic sampling interface
> in libperf. It's now possible to use following code in
> applications via libperf:
> 
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
> mmap code rewrite, so would be great if guys could run your usual
> workloads to see if all is fine.. so far so good in my tests ;-)
> 
> It's also available in here:
>   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>   perf/lib

hi,
I rebased the branch to latest Arnaldo's perf/core branch

jirka
