Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78836C742D7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 09:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C06320838
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 09:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563009245;
	bh=s00rUlb0l9Ebl+rBQLkCuDRNYnfUr6S2czniLHdc7x0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YsuU2zmisOnQfg46LHPmSckovcBDYFBwyOcm5Jrk8Niz/o/bKOCrnnOr+vVoh2g5G
	 /yRzUj7zohw0pvKN50fp0KLmyCYoq3KZe5SqopdLKs2/29qkZ76z5LkN4R8sk2qqwA
	 Sn+egZR8Sa+Ma52SqQDZc3hankTnN54N6i/fsXAM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbfGMJOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 05:14:04 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51537 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfGMJOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 05:14:03 -0400
Received: by mail-wm1-f67.google.com with SMTP id 207so10866255wma.1;
        Sat, 13 Jul 2019 02:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GMyC3mRBowXNn8Tmcd+dX6r2mkpFjrEG99PBYb/cLrg=;
        b=M5jCgSKldcyMUR/l2GDvQNM15adU26rA7DIQu+L9N0TNdQvhPduMfGpWpiwMQWA9mQ
         tMhxlNrKzUz9S2AfyEriCUoYU9T1uk6HJ5SC1SzvGzoBiyxux8pDNFt09aED7OkzeoWr
         fTBKWQAjXDSt/pssYNiZAcgBR2kKssvWhv/vKMl54ZKqGk+vCQltFUPBXJeoOIWgzfhT
         LkhvYrm9SAwwfOvQhWEXR3X7BqqE/9WuBo1gNE+aqxuJhTIJ15yonqaa0qUFUVntvTxX
         O6q5vpA6fV+2PxLACvsLk40A1HK9/Stvov4JKa2k0UKiBmJMmlXKSTMQ/IOOyU8UAItL
         m3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=GMyC3mRBowXNn8Tmcd+dX6r2mkpFjrEG99PBYb/cLrg=;
        b=fqTp6ztTr7o5nxXGD/rbdqwxV/OqKmShXTJRW8R450/pFAiqdUqdFHRdaaHbPXX/pH
         blqDj2TGHo5XI2o3ep+eGCh6GmPJIzgPanmDKk4tcBGA51m0ksSjvx0BGf4/55UTiWNn
         +1EHfLGI7eMpnzckWS3iN0FfEKg2v8vl45QTSW09Y3UKLtlS1cXY2EVhG5Eb9Vrf3oaP
         N7ZpG60BzYwybu8JWply+axdrdF6ftaTiNfEyi4BHcEQzIN7PhpITWsxzieLdqJaTtJl
         DGHcyx69PWmVeEKPBz0joBvaSlszJZ3dFuRjP+uX3lIj8pY0AwHQv15X7yIQWlMqiC8e
         f89A==
X-Gm-Message-State: APjAAAVeiYwV/FsJch62PbonxKphcHAsPuh9mG64oNqwKktk8In8rIiv
        /xQTSqFFR2nZdgPIjwTZ49c=
X-Google-Smtp-Source: APXvYqzCQRIa7jBzUMYhspRKtvis9hbnF2dTRmK4sQz5zJM+i9hJdDez2p+/B7Z4pDDRcDQ5D+kElQ==
X-Received: by 2002:a1c:7f57:: with SMTP id a84mr13725487wmd.3.1563009239408;
        Sat, 13 Jul 2019 02:13:59 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id s10sm13339622wmf.8.2019.07.13.02.13.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 13 Jul 2019 02:13:58 -0700 (PDT)
Date:   Sat, 13 Jul 2019 11:13:56 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Carrillo Cisneros <davidca@fb.com>,
        Leo Yan <leo.yan@linaro.org>,
        Luke Mujica <lukemujica@google.com>,
        Numfor Mbiziwo-Tiapo <nums@google.com>,
        Song Liu <songliubraving@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL] perf/core improvements and fixes
Message-ID: <20190713091356.GA81998@gmail.com>
References: <20190709183126.30257-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709183126.30257-1-acme@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling,
> 
> Best regards,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit d1d59b817939821bee149e870ce7723f61ffb512:
> 
>   Merge tag 'perf-urgent-for-mingo-5.3-20190708-2' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2019-07-09 13:22:03 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.3-20190709
> 
> for you to fetch changes up to 323fd749821daab0f327ec86d707c4542963cdb0:
> 
>   perf intel-pt: Fix potential NULL pointer dereference found by the smatch tool (2019-07-09 10:13:28 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> Intel PT:
> 
>   Adrian Hunter:
> 
>   - Fix DROP VIEW power_events_view in the postgresql and sqlite export-db
>     python scripts.
> 
> perf script:
> 
>   Song Liu:
> 
>   - Assume native_arch for pipe mode, fixing a segfault.
> 
> perf inject:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - The tool->read() call may pass a NULL evsel, handle it.
> 
> core:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Move zalloc/zfree.c to tools/lib, further eroding tools/perf/util.[ch]
> 
>   - Use zfree() where applicable instead of open coded equivalent.
> 
>   - Add stdlib.h and some other headers to places where its needed and were
>     getting via util.h, that doesn't need that anymore.
> 
>   - Use list_del_init() more thoroughly.
> 
> Miscellaneous:
> 
>   Leo Yan:
> 
>   - Fix use after free and potential NULL pointer derefs detected by the
>     smatch tool in various places.
> 
>   Luke Mujica:
> 
>   - Remove a couple unused variables in the parse-events code.
> 
>   Numfor Mbiziwo-Tiapo:
> 
>   - Initialize variable to suppress memory sanitizer warning in the
>     mmap-thread-lookup 'perf test' entry.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Adrian Hunter (2):
>       perf scripts python: export-to-postgresql.py: Fix DROP VIEW power_events_view
>       perf scripts python: export-to-sqlite.py: Fix DROP VIEW power_events_view
> 
> Arnaldo Carvalho de Melo (9):
>       perf inject: The tool->read() call may pass a NULL evsel, handle it
>       perf evsel: perf_evsel__name(NULL) is valid, no need to check evsel
>       perf tools: Add missing headers, mostly stdlib.h
>       perf namespaces: Move the conditional setns() prototype to namespaces.h
>       perf tools: Move get_current_dir_name() cond prototype out of util.h
>       tools lib: Adopt zalloc()/zfree() from tools/perf
>       perf tools: Use zfree() where applicable
>       perf tools: Use list_del_init() more thorougly
>       perf metricgroup: Add missing list_del_init() when flushing egroups list
> 
> Leo Yan (10):
>       perf stat: Fix use-after-freed pointer detected by the smatch tool
>       perf top: Fix potential NULL pointer dereference detected by the smatch tool
>       perf annotate: Fix dereferencing freed memory found by the smatch tool
>       perf trace: Fix potential NULL pointer dereference found by the smatch tool
>       perf map: Fix potential NULL pointer dereference found by smatch tool
>       perf session: Fix potential NULL pointer dereference found by the smatch tool
>       perf cs-etm: Fix potential NULL pointer dereference found by the smatch tool
>       perf hists browser: Fix potential NULL pointer dereference found by the smatch tool
>       perf intel-bts: Fix potential NULL pointer dereference found by the smatch tool
>       perf intel-pt: Fix potential NULL pointer dereference found by the smatch tool
> 
> Luke Mujica (2):
>       perf parse-events: Remove unused variable 'i'
>       perf parse-events: Remove unused variable: error
> 
> Numfor Mbiziwo-Tiapo (1):
>       perf test mmap-thread-lookup: Initialize variable to suppress memory sanitizer warning
> 
> Song Liu (1):
>       perf script: Assume native_arch for pipe mode
> 
>  tools/include/linux/zalloc.h                       | 12 +++++
>  tools/lib/zalloc.c                                 | 15 ++++++
>  tools/perf/MANIFEST                                |  1 +
>  tools/perf/arch/arm/annotate/instructions.c        |  1 +
>  tools/perf/arch/arm/util/auxtrace.c                |  1 +
>  tools/perf/arch/arm/util/cs-etm.c                  |  1 +
>  tools/perf/arch/arm64/util/arm-spe.c               |  1 +
>  tools/perf/arch/common.c                           |  3 +-
>  tools/perf/arch/powerpc/util/perf_regs.c           |  4 +-
>  tools/perf/arch/s390/util/auxtrace.c               |  1 +
>  tools/perf/arch/s390/util/header.c                 |  3 +-
>  tools/perf/arch/x86/util/event.c                   |  2 +-
>  tools/perf/arch/x86/util/intel-bts.c               |  2 +-
>  tools/perf/arch/x86/util/intel-pt.c                |  2 +-
>  tools/perf/arch/x86/util/perf_regs.c               |  2 +-
>  tools/perf/bench/futex-hash.c                      |  3 +-
>  tools/perf/bench/futex-lock-pi.c                   |  3 +-
>  tools/perf/bench/mem-functions.c                   |  2 +-
>  tools/perf/bench/numa.c                            |  2 +-
>  tools/perf/builtin-annotate.c                      |  2 +-
>  tools/perf/builtin-bench.c                         |  2 +-
>  tools/perf/builtin-c2c.c                           |  2 +-
>  tools/perf/builtin-config.c                        |  1 +
>  tools/perf/builtin-diff.c                          |  2 +-
>  tools/perf/builtin-ftrace.c                        |  2 +-
>  tools/perf/builtin-help.c                          |  2 +
>  tools/perf/builtin-inject.c                        |  2 +-
>  tools/perf/builtin-kmem.c                          |  2 +-
>  tools/perf/builtin-kvm.c                           |  2 +-
>  tools/perf/builtin-lock.c                          | 10 ++--
>  tools/perf/builtin-probe.c                         |  2 +-
>  tools/perf/builtin-record.c                        |  4 +-
>  tools/perf/builtin-report.c                        |  4 +-
>  tools/perf/builtin-sched.c                         |  2 +-
>  tools/perf/builtin-script.c                        |  5 +-
>  tools/perf/builtin-stat.c                          |  8 ++--
>  tools/perf/builtin-timechart.c                     |  4 +-
>  tools/perf/builtin-top.c                           |  8 +++-
>  tools/perf/builtin-trace.c                         |  7 +--
>  tools/perf/perf.c                                  |  2 +-
>  tools/perf/pmu-events/jevents.c                    |  2 +-
>  tools/perf/scripts/python/export-to-postgresql.py  |  2 +-
>  tools/perf/scripts/python/export-to-sqlite.py      |  2 +-
>  tools/perf/tests/dwarf-unwind.c                    |  5 +-
>  tools/perf/tests/expr.c                            |  3 +-
>  tools/perf/tests/llvm.c                            |  1 +
>  tools/perf/tests/mem2node.c                        |  3 +-
>  tools/perf/tests/mmap-thread-lookup.c              |  2 +-
>  tools/perf/tests/sample-parsing.c                  |  1 +
>  tools/perf/tests/switch-tracking.c                 |  3 +-
>  tools/perf/tests/thread-map.c                      |  3 +-
>  tools/perf/tests/vmlinux-kallsyms.c                |  1 +
>  tools/perf/ui/browser.c                            |  2 +-
>  tools/perf/ui/browser.h                            |  1 +
>  tools/perf/ui/browsers/annotate.c                  |  2 +-
>  tools/perf/ui/browsers/hists.c                     | 17 +++++--
>  tools/perf/ui/browsers/map.c                       |  1 +
>  tools/perf/ui/browsers/res_sample.c                |  6 +--
>  tools/perf/ui/browsers/scripts.c                   |  4 +-
>  tools/perf/ui/gtk/annotate.c                       |  2 +-
>  tools/perf/ui/gtk/util.c                           |  3 +-
>  tools/perf/ui/stdio/hist.c                         |  2 +-
>  tools/perf/ui/tui/setup.c                          |  1 +
>  tools/perf/ui/tui/util.c                           |  2 +-
>  tools/perf/util/Build                              |  5 ++
>  tools/perf/util/annotate.c                         | 13 ++---
>  tools/perf/util/arm-spe.c                          |  2 +-
>  tools/perf/util/auxtrace.c                         | 11 ++---
>  tools/perf/util/bpf-loader.c                       |  3 +-
>  tools/perf/util/build-id.c                         |  1 +
>  tools/perf/util/call-path.c                        |  5 +-
>  tools/perf/util/callchain.c                        | 12 ++---
>  tools/perf/util/cgroup.c                           |  4 +-
>  tools/perf/util/comm.c                             |  2 +-
>  tools/perf/util/config.c                           |  3 +-
>  tools/perf/util/counts.c                           |  2 +-
>  tools/perf/util/cpumap.c                           |  2 +-
>  tools/perf/util/cputopo.c                          |  5 +-
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c    |  1 +
>  tools/perf/util/cs-etm.c                           |  8 ++--
>  tools/perf/util/data-convert-bt.c                  |  4 +-
>  tools/perf/util/data.c                             |  3 +-
>  tools/perf/util/db-export.c                        |  7 +--
>  tools/perf/util/debug.c                            |  1 +
>  tools/perf/util/demangle-java.c                    |  3 +-
>  tools/perf/util/dso.c                              |  5 +-
>  tools/perf/util/dwarf-aux.c                        |  2 +-
>  tools/perf/util/env.c                              | 11 +++--
>  tools/perf/util/event.c                            |  3 +-
>  tools/perf/util/evlist.c                           |  2 +-
>  tools/perf/util/evsel.c                            |  4 +-
>  tools/perf/util/get_current_dir_name.c             |  6 +--
>  tools/perf/util/get_current_dir_name.h             |  8 ++++
>  tools/perf/util/header.c                           |  8 ++--
>  tools/perf/util/help-unknown-cmd.c                 |  2 +
>  tools/perf/util/hist.c                             | 20 ++++----
>  tools/perf/util/intel-bts.c                        |  7 ++-
>  .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |  2 +-
>  tools/perf/util/intel-pt.c                         | 15 +++---
>  tools/perf/util/jitdump.c                          |  7 ++-
>  tools/perf/util/llvm-utils.c                       |  4 +-
>  tools/perf/util/machine.c                          |  6 +--
>  tools/perf/util/map.c                              |  9 ++--
>  tools/perf/util/mem2node.c                         |  2 +-
>  tools/perf/util/metricgroup.c                      | 10 ++--
>  tools/perf/util/mmap.c                             |  1 +
>  tools/perf/util/namespaces.c                       |  3 +-
>  tools/perf/util/namespaces.h                       |  4 ++
>  tools/perf/util/ordered-events.c                   |  6 +--
>  tools/perf/util/parse-branch-options.c             |  2 +-
>  tools/perf/util/parse-events.c                     |  3 +-
>  tools/perf/util/parse-events.y                     |  2 -
>  tools/perf/util/parse-regs-options.c               |  8 +++-
>  tools/perf/util/pmu.c                              |  4 +-
>  tools/perf/util/probe-event.c                      | 55 ++++++++++------------
>  tools/perf/util/probe-file.c                       |  2 +-
>  tools/perf/util/probe-finder.c                     |  2 +-
>  tools/perf/util/pstack.c                           |  2 +-
>  tools/perf/util/python-ext-sources                 |  1 +
>  tools/perf/util/s390-cpumsf.c                      | 11 ++---
>  tools/perf/util/session.c                          |  7 ++-
>  tools/perf/util/setns.c                            |  4 +-
>  tools/perf/util/srccode.c                          | 11 +++--
>  tools/perf/util/srcline.c                          |  2 +-
>  tools/perf/util/stat-shadow.c                      |  3 +-
>  tools/perf/util/stat.c                             |  3 +-
>  tools/perf/util/strbuf.c                           |  3 +-
>  tools/perf/util/strfilter.c                        |  3 +-
>  tools/perf/util/strlist.c                          |  2 +-
>  tools/perf/util/svghelper.c                        |  2 +-
>  tools/perf/util/symbol-elf.c                       | 18 +++----
>  tools/perf/util/symbol-minimal.c                   |  3 +-
>  tools/perf/util/symbol.c                           |  1 +
>  tools/perf/util/syscalltbl.c                       |  2 +-
>  tools/perf/util/target.c                           |  2 +-
>  tools/perf/util/thread-stack.c                     |  3 +-
>  tools/perf/util/thread.c                           |  6 +--
>  tools/perf/util/thread_map.c                       |  4 +-
>  tools/perf/util/trace-event-info.c                 |  1 +
>  tools/perf/util/trace-event-scripting.c            |  2 +-
>  tools/perf/util/unwind-libdw.c                     |  1 +
>  tools/perf/util/unwind-libunwind-local.c           |  3 +-
>  tools/perf/util/usage.c                            |  3 ++
>  tools/perf/util/util.h                             | 17 -------
>  tools/perf/util/values.c                           |  2 +-
>  tools/perf/util/vdso.c                             |  1 +
>  tools/perf/util/xyarray.c                          |  2 +-
>  147 files changed, 375 insertions(+), 279 deletions(-)
>  create mode 100644 tools/include/linux/zalloc.h
>  create mode 100644 tools/lib/zalloc.c
>  create mode 100644 tools/perf/util/get_current_dir_name.h

Pulled, thanks a lot Arnaldo!

	Ingo
