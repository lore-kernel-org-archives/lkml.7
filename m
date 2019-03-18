Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AB5C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C438A20854
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbfCRKIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:08:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46914 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727740AbfCRKIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 06:08:16 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C32C388AA7;
        Mon, 18 Mar 2019 10:08:15 +0000 (UTC)
Received: from krava (unknown [10.43.17.124])
        by smtp.corp.redhat.com (Postfix) with SMTP id CE6F41001E89;
        Mon, 18 Mar 2019 10:08:12 +0000 (UTC)
Date:   Mon, 18 Mar 2019 11:08:12 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, namhyung@kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>, rostedt@goodmis.org,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 00/16] fix some perf issues detected by ASan
Message-ID: <20190318100812.GC28556@krava>
References: <20190316080556.3075-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190316080556.3075-1-changbin.du@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 18 Mar 2019 10:08:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2019 at 04:05:40PM +0800, Changbin Du wrote:
> AddressSanitizer (or ASan) and UndefinedBehaviorSanitizer (or UBSan) are
> very useful tools to detect program bugs. This series fixed some issues
> disclosed by ASan.
> 
> AddressSanitizer (or ASan) is a GCC feature that detects memory corruption bugs
> such as buffer overflows or memory leaks.
>   $ cd tools/perf
>   $ make DEBUG=1 EXTRA_CFLAGS='-fno-omit-frame-pointer -fsanitize=address'
>   $ ASAN_OPTIONS=log_path=asan.log ./perf record -a
> ASan outputs all detected issues into log file 'asan.log.<pid>'.
> 
> Note that this only fixes parts of the detected issues. There are many remaining
> to be fixed[1].
> 
> [1] http://104.238.181.70:8080/asan.log.32555.txt
> 
> Changbin Du (16):
>   perf: add doc for how to build perf with Asan and UBSan
>   perf: list: fix memory leak in function is_event_supported
>   perf: fix errors under optimization level '-Og'
>   perf: fix an error in config template
>   perf: fix a memory leak in collect_config
>   perf: fix memory leak in print_sdt_events()
>   perf: top: fix heap-use-after-free issue
>   perf: top: fix error handing in cmd_top()
>   perf: missed a map__put() in error case
>   perf: remove map from names tree in __maps__remove
>   perf: purge all maps from the names tree
>   perf: top: fix global-buffer-overflow issue
>   perf: free all counts in perf_evsel__exit
>   perf: fix a memory leak of cpu_map object
>   perf: fix memory leak by expr__find_other
>   perf: fix a memory leak in test__perf_evsel__tp_sched_test

awesome.. thanks a lot

Reviewed-by: Jiri Olsa <jolsa@redhat.com>

jirka

> 
>  tools/lib/bpf/libbpf.c                     |  2 +-
>  tools/perf/Documentation/Build.txt         | 20 +++++++++
>  tools/perf/Documentation/perf-config.txt   |  2 +-
>  tools/perf/bench/epoll-ctl.c               |  2 +-
>  tools/perf/bench/epoll-wait.c              |  2 +-
>  tools/perf/builtin-top.c                   | 47 ++++++++++------------
>  tools/perf/tests/backward-ring-buffer.c    |  2 +-
>  tools/perf/tests/evsel-tp-sched.c          |  1 +
>  tools/perf/tests/expr.c                    |  5 ++-
>  tools/perf/tests/openat-syscall-all-cpus.c |  4 +-
>  tools/perf/util/build-id.c                 |  1 +
>  tools/perf/util/config.c                   |  3 +-
>  tools/perf/util/counts.c                   | 18 +++++++++
>  tools/perf/util/counts.h                   |  4 ++
>  tools/perf/util/evsel.c                    |  2 +
>  tools/perf/util/hist.c                     |  4 +-
>  tools/perf/util/map.c                      | 18 +++++++++
>  tools/perf/util/ordered-events.c           |  2 +
>  tools/perf/util/parse-events.c             |  2 +
>  tools/perf/util/stat.c                     | 18 ---------
>  20 files changed, 106 insertions(+), 53 deletions(-)
> 
> -- 
> 2.19.1
> 
