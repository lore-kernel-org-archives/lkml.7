Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6C1C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E74FA233FF
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567105097;
	bh=duPGYi0KGNL7c268Bpbj1unSZQReY410jyectYXWvfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JGWC7Ux9zVawAGBuO/pqOdk7SUxAKk209GgcUKD9wz+SvFXT4PPikRQMxSGOFtOqc
	 TvkrTUHWuioPYsinRgW8QkSIXDQqTtGv4emAgh9JQ77wEwqaaUcw+n4r6INGx6o5SF
	 OmYQqTrsicXXE5a3SdvA26bbCgn3rLoNXbpkhtKc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbfH2S6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:58:16 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52757 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbfH2S6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:58:15 -0400
Received: by mail-wm1-f68.google.com with SMTP id t17so4800952wmi.2;
        Thu, 29 Aug 2019 11:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Tq/PqHrqXDOnlXMKWrNZj4Q6pVSfEnpdOdZYupOzAXA=;
        b=gERnNSXSNGuMolPLg+Aj6WYXZu/sfh6QrcD6yXdZhs6Kk7KNgOusf+W+6C+81paL+k
         xOIFktapF+5l0zzbZiACPRyn8U/tW67HyrE9MqKAexkqAUVlTsz+p9FSsoq7Yn0TSZr+
         PkCs3qvfsEk0vUxm3joxrYn2tsOB/HlW8FmTnCGbr1doXWoIA6htCSsGt+loJcr9xlSj
         BWM+1zu/V2S2lGQSGkiFvWx1hbRBgN2wghIpI+KMKZt4xC17ds7XKNjKbyFPOtWJrF86
         6JtAgq/nIfcgfBbTxQMPMybH4fTMNC7X2dnLcK0IJjB/1RSctKRjqjicLtuz3yolYC+I
         Jt1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Tq/PqHrqXDOnlXMKWrNZj4Q6pVSfEnpdOdZYupOzAXA=;
        b=LgiGvR35pyEIP8WJqc89OsG5v1NZ+1JA7afrQLH4JcNFIbrlZM+Z6mHr5uIf1GZ0Sy
         Injo9rRTqvyH+417CLELbo/PwEz0HosjLuhUg/TanTKydHREZVfX1yT8TshcyQxbS22J
         qdzc/zG4ufzaNoVixrAcq7a8xwyqCB4hblSSQMvGQ1fUGfK/AeZiRAiQo8d96UvBi+Th
         7HRP/e47fB1TGRfbyJWE/0MmHzPtw8ybuzkNkBPk2mnPJtYpwaunppzTlc1xbNiOojqu
         BDZNUh8p5c2hmT76CJzbgEAbYiczk2mrMVpEEGbtBpjTHWgwb3/aCpXoAQKOa+lhNezL
         g4kQ==
X-Gm-Message-State: APjAAAV3N9pQ0XRkwDV6W3yL7nVBMbf+NLWlEk62+IqzeTj8C4OgZ/ZN
        1y4FbYHThC64Vb42XsX77UA=
X-Google-Smtp-Source: APXvYqx3z+SNN2fECKA0TyzWw0aXpe9RwPUg6RjWg3VVWJnAvZoeyuEg8KIQ9AA8z2uDXf+u//EmLQ==
X-Received: by 2002:a1c:cf88:: with SMTP id f130mr13586018wmg.10.1567105091708;
        Thu, 29 Aug 2019 11:58:11 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id c11sm2847558wrt.25.2019.08.29.11.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 11:58:10 -0700 (PDT)
Date:   Thu, 29 Aug 2019 20:58:07 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Igor Lubashev <ilubashe@akamai.com>,
        Karl Rister <krister@redhat.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL] perf/core improvements and fixes
Message-ID: <20190829185807.GA109374@gmail.com>
References: <20190829143917.29745-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829143917.29745-1-acme@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo/Thomas,
> 
> 	Please consider pulling,
> 
> Best regards,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 42880f726c66f13ae1d9ac9ce4c43abe64ecac84:
> 
>   perf/x86/intel: Support PEBS output to PT (2019-08-28 11:29:39 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.4-20190829
> 
> for you to fetch changes up to 301011ba622513cb41ced59973972204e0da2f71:
> 
>   tools lib traceevent: Remove unneeded qsort and uses memmove instead (2019-08-29 08:36:12 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> perf top:
> 
>   Namhyung Kim:
> 
>   - Decay all events in the evlist, we were decaying just the first event
>     in a group.
> 
>   - Fix linking of histograms in different evsels in a event group with more
>     than two events.
> 
>   With the two fixes above a command line such as:
> 
>     # perf top -e '{cycles,instructions,cache-misses,cache-references}
> 
>     Should work as expected, with four columns and with all of them being
>     decayed over time, i.e. less weight is given for older samples.
> 
> perf record:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Fix collection of build-ids when using setns() to get into namespaces,
>     which had been broken with the introduction of the extra thread to
>     react to PERF_RECORD_BPF_EVENT, i.e. to collect extra info for BPF
>     programs. We need to unshare(CLONE_FS) in that thread so that the
>     main one can do the setns(CLONE_NEWNS) when collectingthe build-ids.
>     Without that symbol resolution gets more difficult and potentially
>     misresolves symbols.
> 
> core:
> 
>   Igor Lubashev:
> 
>   - Further alignment in permission checking via capabilities to how the
>     kernel checks what tooling tries to do.
> 
> PowerPC:
> 
>   Naveen N. Rao:
> 
>   - Sync powerpc syscall.tbl, so that 'perf trace' gets the definitions
>     for recent syscalls.
> 
> libperf:
> 
>   Jiri Olsa:
> 
>   - Move the rest of the PERF_RECORD_ metadata struct definitions so that
>     we can use 'union perf_event'.
> 
> libtraceevent:
> 
>   Steven Rostedt (VMware):
> 
>   - Do not free tep->cmdlines in add_new_comm() on failure.
> 
>   - Remove unneeded qsort and uses memmove instead
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (4):
>       perf tools: Remove needless util.h include from builtin.h
>       perf evlist: Remove needless util.h from evlist.h
>       perf clang: Delete needless util-cxx.h header
>       perf evlist: Use unshare(CLONE_FS) in sb threads to let setns(CLONE_NEWNS) work
> 
> Igor Lubashev (5):
>       perf event: Check ref_reloc_sym before using it
>       perf tools: Use CAP_SYS_ADMIN with perf_event_paranoid checks
>       perf evsel: Kernel profiling is disallowed only when perf_event_paranoid > 1
>       perf symbols: Use CAP_SYSLOG with kptr_restrict checks
>       perf tools: Warn that perf_event_paranoid can restrict kernel symbols
> 
> Jiri Olsa (23):
>       libperf: Add PERF_RECORD_HEADER_ATTR 'struct attr_event' to perf/event.h
>       libperf: Add PERF_RECORD_CPU_MAP 'struct cpu_map_event' to perf/event.h
>       libperf: Add PERF_RECORD_EVENT_UPDATE 'struct event_update_event' to perf/event.h
>       libperf: Add PERF_RECORD_HEADER_EVENT_TYPE 'struct event_type_event' to perf/event.h
>       libperf: Add PERF_RECORD_HEADER_TRACING_DATA 'struct tracing_data_event' to perf/event.h
>       libperf: Add PERF_RECORD_HEADER_BUILD_ID 'struct build_id_event' to perf/event.h
>       libperf: Add PERF_RECORD_ID_INDEX 'struct id_index_event' to perf/event.h
>       libperf: Add PERF_RECORD_AUXTRACE_INFO 'struct auxtrace_info_event' to perf/event.h
>       libperf: Add PERF_RECORD_AUXTRACE 'struct auxtrace_event' to perf/event.h
>       libperf: Add PERF_RECORD_AUXTRACE_ERROR 'struct auxtrace_error_event' to perf/event.h
>       libperf: Add PERF_RECORD_AUX 'struct aux_event' to perf/event.h
>       libperf: Add PERF_RECORD_ITRACE_START 'struct itrace_start_event' to perf/event.h
>       libperf: Add PERF_RECORD_SWITCH 'struct context_switch_event' to perf/event.h
>       libperf: Add PERF_RECORD_THREAD_MAP 'struct thread_map_event' to perf/event.h
>       libperf: Add PERF_RECORD_STAT_CONFIG 'struct stat_config_event' to perf/event.h
>       libperf: Add PERF_RECORD_STAT 'struct stat_event' to perf/event.h
>       libperf: Add PERF_RECORD_STAT_ROUND 'struct stat_round_event' to perf/event.h
>       libperf: Add PERF_RECORD_TIME_CONV 'struct time_conv_event' to perf/event.h
>       libperf: Add PERF_RECORD_HEADER_FEATURE 'struct feature_event' to perf/event.h
>       libperf: Add PERF_RECORD_COMPRESSED 'struct compressed_event' to perf/event.h
>       libperf: Add 'union perf_event' to perf/event.h
>       libperf: Rename the PERF_RECORD_ structs to have a "perf" prefix
>       libperf: Move 'enum perf_user_event_type' to perf/event.h
> 
> Namhyung Kim (2):
>       perf top: Decay all events in the evlist
>       perf top: Fix event group with more than two events
> 
> Naveen N. Rao (1):
>       perf arch powerpc: Sync powerpc syscall.tbl
> 
> Steven Rostedt (VMware) (2):
>       tools lib traceevent: Do not free tep->cmdlines in add_new_comm() on failure
>       tools lib traceevent: Remove unneeded qsort and uses memmove instead
> 
>  tools/lib/traceevent/event-parse.c                 |  58 ++++-
>  tools/perf/arch/arm/util/cs-etm.c                  |   7 +-
>  tools/perf/arch/arm64/util/arm-spe.c               |   5 +-
>  tools/perf/arch/powerpc/entry/syscalls/syscall.tbl | 146 +++++++++--
>  tools/perf/arch/s390/util/auxtrace.c               |   2 +-
>  tools/perf/arch/x86/util/intel-bts.c               |   6 +-
>  tools/perf/arch/x86/util/intel-pt.c                |   7 +-
>  tools/perf/arch/x86/util/tsc.c                     |   2 +-
>  tools/perf/builtin-buildid-cache.c                 |   1 +
>  tools/perf/builtin-record.c                        |   6 +-
>  tools/perf/builtin-report.c                        |   3 +-
>  tools/perf/builtin-script.c                        |   3 +-
>  tools/perf/builtin-stat.c                          |   2 +-
>  tools/perf/builtin-top.c                           |  47 ++--
>  tools/perf/builtin-trace.c                         |   3 +-
>  tools/perf/builtin.h                               |   2 -
>  tools/perf/lib/include/perf/event.h                | 273 ++++++++++++++++++++
>  tools/perf/perf.c                                  |   1 +
>  tools/perf/tests/cpumap.c                          |  12 +-
>  tools/perf/tests/event_update.c                    |  16 +-
>  tools/perf/tests/sdt.c                             |   1 +
>  tools/perf/tests/stat.c                            |   8 +-
>  tools/perf/tests/thread-map.c                      |   2 +-
>  tools/perf/util/arm-spe.c                          |   6 +-
>  tools/perf/util/auxtrace.c                         |  21 +-
>  tools/perf/util/auxtrace.h                         |   8 +-
>  tools/perf/util/bpf-loader.c                       |   1 +
>  tools/perf/util/build-id.c                         |   2 +-
>  tools/perf/util/c++/clang-c.h                      |   2 +-
>  tools/perf/util/c++/clang-test.cpp                 |   4 +-
>  tools/perf/util/cpumap.c                           |   6 +-
>  tools/perf/util/cpumap.h                           |   4 +-
>  tools/perf/util/cs-etm.c                           |   4 +-
>  tools/perf/util/event.c                            |  45 ++--
>  tools/perf/util/event.h                            | 278 +--------------------
>  tools/perf/util/evlist.c                           |  10 +
>  tools/perf/util/evlist.h                           |   1 -
>  tools/perf/util/evsel.c                            |   3 +-
>  tools/perf/util/header.c                           |  57 ++---
>  tools/perf/util/hist.c                             |  39 +--
>  tools/perf/util/hist.h                             |   1 +
>  tools/perf/util/intel-bts.c                        |   6 +-
>  tools/perf/util/intel-pt.c                         |  12 +-
>  tools/perf/util/python.c                           |   4 +-
>  tools/perf/util/s390-cpumsf.c                      |   4 +-
>  tools/perf/util/session.c                          |  29 +--
>  tools/perf/util/session.h                          |   2 +-
>  tools/perf/util/stat.c                             |  12 +-
>  tools/perf/util/symbol.c                           |  15 +-
>  tools/perf/util/thread_map.c                       |   4 +-
>  tools/perf/util/thread_map.h                       |   4 +-
>  tools/perf/util/util-cxx.h                         |  27 --
>  52 files changed, 684 insertions(+), 540 deletions(-)
>  delete mode 100644 tools/perf/util/util-cxx.h

Pulled, thanks a lot Arnaldo!

	Ingo
