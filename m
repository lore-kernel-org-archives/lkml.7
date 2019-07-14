Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB84C73C66
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 12:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E15F20820
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 12:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563105679;
	bh=Hygdyo6BvA7XGGXzJXM6qppzfROl8cDV+jlqyt/ktvI=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=ntUkuyWsCXUhER96dl9LQlr3zMh8ru+920HBRLsh0dNSRzKo+HcEAixRCQuQQGyEc
	 ikdmPyPq/wTRc43zmJjg3Eq+mWiPxaqPUfzdJH3ztuWMeePN+1rPy5ov4pDuk4hPP2
	 ibrdMZaFgr7NibWV92CM5Q1o2sZ4Fbz05KbI+Dzs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbfGNMBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 08:01:10 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:32947 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728259AbfGNMBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 08:01:09 -0400
Received: by mail-wm1-f66.google.com with SMTP id h19so12291720wme.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2019 05:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Fka8zcyQbM45wInFeXJUxRQ5ryysLBMdBBJ/Ie3z+7c=;
        b=mKkoTnH3POfJvEq+DbNvrCOPKvRXuC1yGzrYnw0egSEyek9sgXKKMRVagYhwt1M7Tc
         wp0/OiBkhnCey7DVz3DBDsSpptAlzdpjTgP2nSOeoTRsdtNXHZigC73niVJ4Q/AbzmNA
         5Uljb9jx4YURVBXwspuDGqF8zreJBCYw1oQY9ZphyLUS2rKcfD6I5C7vwY57P/D/YXsG
         G6x96gfpGuVR9ro9EJBa+9PXAkCxiQ/aeV/4r/IPOTxVf9kEziut7xb8uelmVuQCMFF+
         bgi+EV1hzG4LhzRARvtzUzcCSEa4KrM9q6oJY/jy4oh9kmUfYOhSyQPQHkHIPTVZWips
         Fw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=Fka8zcyQbM45wInFeXJUxRQ5ryysLBMdBBJ/Ie3z+7c=;
        b=PyEEjGMiKZfqimist8k8xDX5Cr78GlPGv2IStgRKH7nbuGds09s0hC7o175Ix19I8c
         xqgeQjsAA7pR5Fi94G/EhGDZBr30LtEqdsrhBbe0XQn1qPIXFDw1+CbpqypZAWUrfXvv
         LGt84P3u/pto47zhpxosCMbbg/xHR9TC4tNCjKRO962dnQo7YFcQPjAutRPFgUv1071F
         SMppqYdX8JwCg1ncxO0WsXG6JAJITOUAJIC41P2VRhTnxlICxlhIlk+678c/cBcYfiBR
         Gh4wMLbYP0lDltckBJw3a+5v79jncDn4Y7bxRZtFQQqao44qAAoFQy+1eEPhn0v68dcX
         jl+w==
X-Gm-Message-State: APjAAAUVs4rSOhQuOjvzUAjKuEPtL+K46tcrtk6MhUE+qTrX2g/eWzXr
        0YjnLToL2FJpXwayd/c7TC4=
X-Google-Smtp-Source: APXvYqyWfxDPfwPiT4Ayb5tOaNDpimlbHmfzscLNC5TQCCaumIB2CH0oXp3O55+dVfWma0juZI3jFA==
X-Received: by 2002:a1c:4b0b:: with SMTP id y11mr20273606wma.25.1563105665788;
        Sun, 14 Jul 2019 05:01:05 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id c1sm27847346wrh.1.2019.07.14.05.01.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 14 Jul 2019 05:01:04 -0700 (PDT)
Date:   Sun, 14 Jul 2019 14:01:02 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf fixes
Message-ID: <20190714120102.GA86321@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

   # HEAD: e4557c1a46b0d32746bd309e1941914b5a6912b4 perf/x86/intel: Fix spurious NMI on fixed counter

A number of PMU driver corner case fixes, a race fix, an event grouping 
fix, plus a bunch of tooling fixes/updates.

 Thanks,

	Ingo

------------------>
Adrian Hunter (2):
      perf scripts python: export-to-postgresql.py: Fix DROP VIEW power_events_view
      perf scripts python: export-to-sqlite.py: Fix DROP VIEW power_events_view

Alexander Shishkin (1):
      perf/core: Fix exclusive events' grouping

Arnaldo Carvalho de Melo (9):
      perf inject: The tool->read() call may pass a NULL evsel, handle it
      perf evsel: perf_evsel__name(NULL) is valid, no need to check evsel
      perf tools: Add missing headers, mostly stdlib.h
      perf namespaces: Move the conditional setns() prototype to namespaces.h
      perf tools: Move get_current_dir_name() cond prototype out of util.h
      tools lib: Adopt zalloc()/zfree() from tools/perf
      perf tools: Use zfree() where applicable
      perf tools: Use list_del_init() more thorougly
      perf metricgroup: Add missing list_del_init() when flushing egroups list

Kan Liang (1):
      perf/x86/intel: Fix spurious NMI on fixed counter

Kim Phillips (2):
      perf/x86/amd/uncore: Do not set 'ThreadMask' and 'SliceMask' for non-L3 PMCs
      perf/x86/amd/uncore: Set the thread mask for F17h L3 PMCs

Leo Yan (10):
      perf stat: Fix use-after-freed pointer detected by the smatch tool
      perf top: Fix potential NULL pointer dereference detected by the smatch tool
      perf annotate: Fix dereferencing freed memory found by the smatch tool
      perf trace: Fix potential NULL pointer dereference found by the smatch tool
      perf map: Fix potential NULL pointer dereference found by smatch tool
      perf session: Fix potential NULL pointer dereference found by the smatch tool
      perf cs-etm: Fix potential NULL pointer dereference found by the smatch tool
      perf hists browser: Fix potential NULL pointer dereference found by the smatch tool
      perf intel-bts: Fix potential NULL pointer dereference found by the smatch tool
      perf intel-pt: Fix potential NULL pointer dereference found by the smatch tool

Luke Mujica (2):
      perf parse-events: Remove unused variable 'i'
      perf parse-events: Remove unused variable: error

Numfor Mbiziwo-Tiapo (1):
      perf test mmap-thread-lookup: Initialize variable to suppress memory sanitizer warning

Peter Zijlstra (1):
      perf/core: Fix race between close() and fork()

Song Liu (1):
      perf script: Assume native_arch for pipe mode


 arch/x86/events/amd/uncore.c                       | 15 ++--
 arch/x86/events/intel/core.c                       |  8 +--
 include/linux/perf_event.h                         |  5 ++
 kernel/events/core.c                               | 83 ++++++++++++++++------
 tools/include/linux/zalloc.h                       | 12 ++++
 tools/lib/zalloc.c                                 | 15 ++++
 tools/perf/MANIFEST                                |  1 +
 tools/perf/arch/arm/annotate/instructions.c        |  1 +
 tools/perf/arch/arm/util/auxtrace.c                |  1 +
 tools/perf/arch/arm/util/cs-etm.c                  |  1 +
 tools/perf/arch/arm64/util/arm-spe.c               |  1 +
 tools/perf/arch/common.c                           |  3 +-
 tools/perf/arch/powerpc/util/perf_regs.c           |  4 +-
 tools/perf/arch/s390/util/auxtrace.c               |  1 +
 tools/perf/arch/s390/util/header.c                 |  3 +-
 tools/perf/arch/x86/util/event.c                   |  2 +-
 tools/perf/arch/x86/util/intel-bts.c               |  2 +-
 tools/perf/arch/x86/util/intel-pt.c                |  2 +-
 tools/perf/arch/x86/util/perf_regs.c               |  2 +-
 tools/perf/bench/futex-hash.c                      |  3 +-
 tools/perf/bench/futex-lock-pi.c                   |  3 +-
 tools/perf/bench/mem-functions.c                   |  2 +-
 tools/perf/bench/numa.c                            |  2 +-
 tools/perf/builtin-annotate.c                      |  2 +-
 tools/perf/builtin-bench.c                         |  2 +-
 tools/perf/builtin-c2c.c                           |  2 +-
 tools/perf/builtin-config.c                        |  1 +
 tools/perf/builtin-diff.c                          |  2 +-
 tools/perf/builtin-ftrace.c                        |  2 +-
 tools/perf/builtin-help.c                          |  2 +
 tools/perf/builtin-inject.c                        |  2 +-
 tools/perf/builtin-kmem.c                          |  2 +-
 tools/perf/builtin-kvm.c                           |  2 +-
 tools/perf/builtin-lock.c                          | 10 +--
 tools/perf/builtin-probe.c                         |  2 +-
 tools/perf/builtin-record.c                        |  4 +-
 tools/perf/builtin-report.c                        |  4 +-
 tools/perf/builtin-sched.c                         |  2 +-
 tools/perf/builtin-script.c                        |  5 +-
 tools/perf/builtin-stat.c                          |  8 +--
 tools/perf/builtin-timechart.c                     |  4 +-
 tools/perf/builtin-top.c                           |  8 ++-
 tools/perf/builtin-trace.c                         |  7 +-
 tools/perf/perf.c                                  |  2 +-
 tools/perf/pmu-events/jevents.c                    |  2 +-
 tools/perf/scripts/python/export-to-postgresql.py  |  2 +-
 tools/perf/scripts/python/export-to-sqlite.py      |  2 +-
 tools/perf/tests/dwarf-unwind.c                    |  5 +-
 tools/perf/tests/expr.c                            |  3 +-
 tools/perf/tests/llvm.c                            |  1 +
 tools/perf/tests/mem2node.c                        |  3 +-
 tools/perf/tests/mmap-thread-lookup.c              |  2 +-
 tools/perf/tests/sample-parsing.c                  |  1 +
 tools/perf/tests/switch-tracking.c                 |  3 +-
 tools/perf/tests/thread-map.c                      |  3 +-
 tools/perf/tests/vmlinux-kallsyms.c                |  1 +
 tools/perf/ui/browser.c                            |  2 +-
 tools/perf/ui/browser.h                            |  1 +
 tools/perf/ui/browsers/annotate.c                  |  2 +-
 tools/perf/ui/browsers/hists.c                     | 17 +++--
 tools/perf/ui/browsers/map.c                       |  1 +
 tools/perf/ui/browsers/res_sample.c                |  6 +-
 tools/perf/ui/browsers/scripts.c                   |  4 +-
 tools/perf/ui/gtk/annotate.c                       |  2 +-
 tools/perf/ui/gtk/util.c                           |  3 +-
 tools/perf/ui/stdio/hist.c                         |  2 +-
 tools/perf/ui/tui/setup.c                          |  1 +
 tools/perf/ui/tui/util.c                           |  2 +-
 tools/perf/util/Build                              |  5 ++
 tools/perf/util/annotate.c                         | 13 ++--
 tools/perf/util/arm-spe.c                          |  2 +-
 tools/perf/util/auxtrace.c                         | 11 ++-
 tools/perf/util/bpf-loader.c                       |  3 +-
 tools/perf/util/build-id.c                         |  1 +
 tools/perf/util/call-path.c                        |  5 +-
 tools/perf/util/callchain.c                        | 12 ++--
 tools/perf/util/cgroup.c                           |  4 +-
 tools/perf/util/comm.c                             |  2 +-
 tools/perf/util/config.c                           |  3 +-
 tools/perf/util/counts.c                           |  2 +-
 tools/perf/util/cpumap.c                           |  2 +-
 tools/perf/util/cputopo.c                          |  5 +-
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c    |  1 +
 tools/perf/util/cs-etm.c                           |  8 +--
 tools/perf/util/data-convert-bt.c                  |  4 +-
 tools/perf/util/data.c                             |  3 +-
 tools/perf/util/db-export.c                        |  7 +-
 tools/perf/util/debug.c                            |  1 +
 tools/perf/util/demangle-java.c                    |  3 +-
 tools/perf/util/dso.c                              |  5 +-
 tools/perf/util/dwarf-aux.c                        |  2 +-
 tools/perf/util/env.c                              | 11 +--
 tools/perf/util/event.c                            |  3 +-
 tools/perf/util/evlist.c                           |  2 +-
 tools/perf/util/evsel.c                            |  4 +-
 tools/perf/util/get_current_dir_name.c             |  6 +-
 tools/perf/util/get_current_dir_name.h             |  8 +++
 tools/perf/util/header.c                           |  8 +--
 tools/perf/util/help-unknown-cmd.c                 |  2 +
 tools/perf/util/hist.c                             | 20 +++---
 tools/perf/util/intel-bts.c                        |  7 +-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |  2 +-
 tools/perf/util/intel-pt.c                         | 15 ++--
 tools/perf/util/jitdump.c                          |  7 +-
 tools/perf/util/llvm-utils.c                       |  4 +-
 tools/perf/util/machine.c                          |  6 +-
 tools/perf/util/map.c                              |  9 ++-
 tools/perf/util/mem2node.c                         |  2 +-
 tools/perf/util/metricgroup.c                      | 10 +--
 tools/perf/util/mmap.c                             |  1 +
 tools/perf/util/namespaces.c                       |  3 +-
 tools/perf/util/namespaces.h                       |  4 ++
 tools/perf/util/ordered-events.c                   |  6 +-
 tools/perf/util/parse-branch-options.c             |  2 +-
 tools/perf/util/parse-events.c                     |  3 +-
 tools/perf/util/parse-events.y                     |  2 -
 tools/perf/util/parse-regs-options.c               |  8 ++-
 tools/perf/util/pmu.c                              |  4 +-
 tools/perf/util/probe-event.c                      | 55 +++++++-------
 tools/perf/util/probe-file.c                       |  2 +-
 tools/perf/util/probe-finder.c                     |  2 +-
 tools/perf/util/pstack.c                           |  2 +-
 tools/perf/util/python-ext-sources                 |  1 +
 tools/perf/util/s390-cpumsf.c                      | 11 ++-
 tools/perf/util/session.c                          |  7 +-
 tools/perf/util/setns.c                            |  4 +-
 tools/perf/util/srccode.c                          | 11 +--
 tools/perf/util/srcline.c                          |  2 +-
 tools/perf/util/stat-shadow.c                      |  3 +-
 tools/perf/util/stat.c                             |  3 +-
 tools/perf/util/strbuf.c                           |  3 +-
 tools/perf/util/strfilter.c                        |  3 +-
 tools/perf/util/strlist.c                          |  2 +-
 tools/perf/util/svghelper.c                        |  2 +-
 tools/perf/util/symbol-elf.c                       | 18 ++---
 tools/perf/util/symbol-minimal.c                   |  3 +-
 tools/perf/util/symbol.c                           |  1 +
 tools/perf/util/syscalltbl.c                       |  2 +-
 tools/perf/util/target.c                           |  2 +-
 tools/perf/util/thread-stack.c                     |  3 +-
 tools/perf/util/thread.c                           |  6 +-
 tools/perf/util/thread_map.c                       |  4 +-
 tools/perf/util/trace-event-info.c                 |  1 +
 tools/perf/util/trace-event-scripting.c            |  2 +-
 tools/perf/util/unwind-libdw.c                     |  1 +
 tools/perf/util/unwind-libunwind-local.c           |  3 +-
 tools/perf/util/usage.c                            |  3 +
 tools/perf/util/util.h                             | 17 -----
 tools/perf/util/values.c                           |  2 +-
 tools/perf/util/vdso.c                             |  1 +
 tools/perf/util/xyarray.c                          |  2 +-
 151 files changed, 457 insertions(+), 308 deletions(-)
 create mode 100644 tools/include/linux/zalloc.h
 create mode 100644 tools/lib/zalloc.c
 create mode 100644 tools/perf/util/get_current_dir_name.h
