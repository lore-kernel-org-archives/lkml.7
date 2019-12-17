Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037AAC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 11:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE2B82067C
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 11:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576582472;
	bh=fNPUYjQrXg3OGRX0jlTA8XAS4kQEySJCGSTxx8mfRK0=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Z2/lXUnypoBpbhgrZhD0Het3TbEeE46MGmCNPBr/PhFjHP4dzQ8/qnM9ZJnm5N3/h
	 5G/f476WHAh6tcUYGQyk1zpEz8yKj7odlIpGzJCgCqKTaVIKXAklr7G9wCkUb5XEqM
	 53G3Su57DTRq8bnNx44u1vpKy1PoB/zQDyf/XPIo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbfLQLeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 06:34:31 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:34371 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfLQLeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 06:34:31 -0500
Received: by mail-wm1-f45.google.com with SMTP id f4so2044196wmj.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 03:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=6P7ASDrpvxMA3at/uGU6dnhQ2gwUkcqzz4reDsPXKps=;
        b=bg5OicfanLYvTuP6LLkXcWW9AvZOGtLKfrF9rJo9cvVqjAtaULNTQOXaURCjBOGBWg
         aywm4W/etI0vqnQ64McH1EJiPPQUZQaPlRVCOaJDn2ngwNzyNyAIE0yxAcXvvimk8X+A
         zrm9I6aU9GPajE99Us6afREC1BKcbrnF885o+q6owe2zr/HMYvdb6KzuwDqXaVGP9RhR
         YZA+c7X+HX01wuyf4BFcpNRCuEgYNMU5ZoT6OZ1h0VfkCPz1Sjzeqf9QsrPJTlkimJ1b
         TIAq8yCc1C6QLsLxZ8K9V1jrG3K7xenyaIWKykafMk08au7AAlkMPz30pKfQGizbJZP1
         zX3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=6P7ASDrpvxMA3at/uGU6dnhQ2gwUkcqzz4reDsPXKps=;
        b=FKF4hNh2h4fUOxyT8q6XNjspSJx1lmWy31wfIT9FILwv06/XEJlLlJlryk/BSOoo1b
         QNUAqoRYa/m2AnzhqxzQjVgOlTVQOL+YJENkWftfnBK8HcRaMqqPF2ZfMs5v7KrcSOLr
         2N3lk8tqjcJfwiyHGP2XfG39X44yiP2IIh6fUqPPzUd3eadZZk3Li5jfrCtdF00St3v7
         b+U0/CQlR3JH6lXV49op2D0g+SsfzFQOHIY+3iyrP+hOHWf/HeiJ6UbF/spye5hEYs1B
         KqSiBwbZ9PDWFUWQSYe8G1vKWRww3+ZWK06EQrwGu3ZHLiIqIPRZbSDaaBBFAFpj6+Oh
         i3/g==
X-Gm-Message-State: APjAAAU8UkXxQ2+aiY0qHkUd8qspM+o96hUK5U7Y/ViABZBscOnxLYBB
        Zp6pgSUlHkMmQ7rYSU8Vwx5kGxKd
X-Google-Smtp-Source: APXvYqzc907F05d1DstSPuD0M82TwrmWuNPLrs6fzbxClRCYza6Ul0aQI+b0gw4K56GY+FXRF7yhYg==
X-Received: by 2002:a1c:a9c2:: with SMTP id s185mr4928908wme.119.1576582468355;
        Tue, 17 Dec 2019 03:34:28 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id f65sm2748771wmf.2.2019.12.17.03.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 03:34:27 -0800 (PST)
Date:   Tue, 17 Dec 2019 12:34:25 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf fixes
Message-ID: <20191217113425.GA78787@gmail.com>
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

   # HEAD: 57e04eeda515ee979fec3bc3d64c408feae18acc Merge tag 'perf-urgent-for-mingo-5.5-20191216' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent

These are all perf tooling changes: most of them are fixes.

Note that the large CPU count related fixes go beyond regression fixes - 
but the IPI-flood symptoms are severe enough that I think justifies their 
inclusion. If it's too much we'll redo the branch.

 Thanks,

	Ingo

------------------>
Adrian Hunter (1):
      perf inject: Fix processing of ID index for injected instruction tracing

Andi Kleen (10):
      perf cpumap: Maintain cpumaps ordered and without dups
      perf evlist: Maintain evlist->all_cpus
      perf evsel: Add iterator to iterate over events ordered by CPU
      perf evsel: Add functions to close evsel on a CPU
      perf stat: Use affinity for closing file descriptors
      perf stat: Factor out open error handling
      perf stat: Use affinity for opening events
      perf stat: Use affinity for reading
      perf evsel: Add functions to enable/disable for a specific CPU
      perf stat: Use affinity for enabling/disabling events

Arnaldo Carvalho de Melo (15):
      perf machine: Fill map_symbol->maps in append_inlines() to fix segfault
      perf bench: Update the copies of x86's mem{cpy,set}_64.S
      tools arch x86: Sync the msr-index.h copy with the kernel sources
      tools headers uapi: Sync linux/fscrypt.h with the kernel sources
      tools headers uapi: Sync linux/stat.h with the kernel sources
      tools headers kvm: Sync kvm headers with the kernel sources
      tools headers UAPI: Sync sched.h with the kernel
      perf beauty: Add CLEAR_SIGHAND support for clone's flags arg
      tools arch x86: Sync asm/cpufeatures.h with the kernel sources
      perf kvm: Clarify the 'perf kvm' -i and -o command line options
      tools headers UAPI: Sync drm/i915_drm.h with the kernel sources
      tools headers UAPI: Update tools's copy of drm.h headers
      tools headers kvm: Sync linux/kvm.h with the kernel sources
      perf arch: Make the default get_cpuid() return compatible error
      perf top: Do not bail out when perf_env__read_cpuid() returns ENOSYS

Ed Maste (2):
      perf vendor events s390: Fix counter long description for DTLB1_GPAGE_WRITES
      perf vendor events s390: Remove name from L1D_RO_EXCL_WRITES description

Ian Rogers (1):
      perf jit: Move test functionality in to a test

Kajol Jain (1):
      perf metricgroup: Fix printing event names of metric group with multiple events

Michael Petlan (1):
      perf header: Fix false warning when there are no duplicate cache entries

Ravi Bangoria (4):
      perf report/top TUI: Replace pr_err() with ui__error()
      perf report: Make -F more strict like -s
      perf report: Bail out --mem-mode if mem info is not available
      perf/x86/pmu-events: Fix Kernel_Utilization metric

Sudip Mukherjee (3):
      libtraceevent: Fix lib installation with O=
      libtraceevent: Copy pkg-config file to output folder when using O=
      libtraceevent: Allow custom libdir path


 tools/arch/arm/include/uapi/asm/kvm.h              |   3 +-
 tools/arch/arm64/include/uapi/asm/kvm.h            |   5 +-
 tools/arch/powerpc/include/uapi/asm/kvm.h          |   3 +
 tools/arch/x86/include/asm/cpufeatures.h           |   3 +
 tools/arch/x86/include/asm/msr-index.h             |  18 ++
 tools/arch/x86/lib/memcpy_64.S                     |  20 +-
 tools/arch/x86/lib/memset_64.S                     |  16 +-
 tools/include/uapi/drm/drm.h                       |   3 +-
 tools/include/uapi/drm/i915_drm.h                  | 128 ++++++++-
 tools/include/uapi/linux/fscrypt.h                 |   3 +-
 tools/include/uapi/linux/kvm.h                     |  12 +
 tools/include/uapi/linux/sched.h                   |  60 +++--
 tools/include/uapi/linux/stat.h                    |   2 +-
 tools/lib/traceevent/Makefile                      |  11 +-
 tools/lib/traceevent/plugins/Makefile              |   5 +-
 tools/perf/Documentation/perf-kvm.txt              |   5 +-
 tools/perf/arch/arm/tests/regs_load.S              |   4 +-
 tools/perf/arch/arm64/tests/regs_load.S            |   4 +-
 tools/perf/arch/x86/tests/regs_load.S              |   8 +-
 tools/perf/builtin-inject.c                        |  13 +-
 tools/perf/builtin-record.c                        |   2 +-
 tools/perf/builtin-report.c                        |   8 +
 tools/perf/builtin-stat.c                          | 288 +++++++++++++++------
 tools/perf/builtin-top.c                           |  10 +-
 tools/perf/check-headers.sh                        |   4 +-
 tools/perf/lib/cpumap.c                            |  73 +++++-
 tools/perf/lib/evlist.c                            |   1 +
 tools/perf/lib/evsel.c                             |  76 ++++--
 tools/perf/lib/include/internal/evlist.h           |   1 +
 tools/perf/lib/include/perf/cpumap.h               |   2 +
 tools/perf/lib/include/perf/evsel.h                |   3 +
 .../perf/pmu-events/arch/s390/cf_z13/extended.json |   2 +-
 .../perf/pmu-events/arch/s390/cf_z14/extended.json |   2 +-
 .../pmu-events/arch/x86/broadwell/bdw-metrics.json |   2 +-
 .../arch/x86/broadwellde/bdwde-metrics.json        |   2 +-
 .../arch/x86/broadwellx/bdx-metrics.json           |   2 +-
 .../arch/x86/cascadelakex/clx-metrics.json         |   2 +-
 .../pmu-events/arch/x86/haswell/hsw-metrics.json   |   2 +-
 .../pmu-events/arch/x86/haswellx/hsx-metrics.json  |   2 +-
 .../pmu-events/arch/x86/ivybridge/ivb-metrics.json |   2 +-
 .../pmu-events/arch/x86/ivytown/ivt-metrics.json   |   2 +-
 .../pmu-events/arch/x86/jaketown/jkt-metrics.json  |   2 +-
 .../arch/x86/sandybridge/snb-metrics.json          |   2 +-
 .../pmu-events/arch/x86/skylake/skl-metrics.json   |   2 +-
 .../pmu-events/arch/x86/skylakex/skx-metrics.json  |   2 +-
 tools/perf/tests/Build                             |   1 +
 tools/perf/tests/builtin-test.c                    |   9 +
 tools/perf/tests/cpumap.c                          |  16 ++
 tools/perf/tests/event-times.c                     |   4 +-
 tools/perf/tests/genelf.c                          |  51 ++++
 tools/perf/tests/tests.h                           |   2 +
 tools/perf/trace/beauty/clone.c                    |   1 +
 tools/perf/util/cpumap.h                           |   1 +
 tools/perf/util/evlist.c                           | 113 +++++++-
 tools/perf/util/evlist.h                           |  11 +-
 tools/perf/util/evsel.c                            |  35 ++-
 tools/perf/util/evsel.h                            |   9 +-
 tools/perf/util/genelf.c                           |  46 ----
 tools/perf/util/header.c                           |  23 +-
 tools/perf/util/include/linux/linkage.h            |  89 ++++++-
 tools/perf/util/machine.c                          |   1 +
 tools/perf/util/metricgroup.c                      |   7 +-
 tools/perf/util/sort.c                             |  16 +-
 tools/perf/util/stat.c                             |   5 +-
 tools/perf/util/stat.h                             |   3 +-
 65 files changed, 976 insertions(+), 289 deletions(-)
 create mode 100644 tools/perf/tests/genelf.c

