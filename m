Return-Path: <SRS0=SILN=ZX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D477C432C0
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 22:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16A0620833
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 22:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575238535;
	bh=TOxd3SlGVBC5GTVaBzg+iOAIIbZme4nhhW7ih8cbrAQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=XPzPq/w6BiI5BQObH/U9S/G1ie6vURB3QaYeAhzrx9HrsNeq+VttFPaWERw/pIC0/
	 Pgo75LOztwpTqtQyT3kflH1uBx7mAdRG3yQQSmqmpMo0Mlpn0gzXZd/hq6Pk54kMAi
	 1U1p+/xgnb7aM2p2Olf+OlW+C9HpE2qJwVj28eGQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfLAWPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 17:15:33 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:39741 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbfLAWPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 17:15:33 -0500
Received: by mail-wm1-f53.google.com with SMTP id s14so14254357wmh.4
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2019 14:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=OisUhr6PFkZU82S9m6283yhNXuH+N900GBKiMYrU9xk=;
        b=XVRCsX6ZZDZMzyndIpwR4qJ6dQM+7vcUw0hIRLxz4PVL34KwS3SqgTNwzeDfFSLazp
         wbIDV6aFPuSYu0A5CjC6TKb7C/t7maSkicIc1k/eUlcszGs3J808GIaVozCJc7BbtqD3
         qZfkgLco8Ry9Yw9qPH3xRvkLYT3pM+hMH5Dp0OE+d+Y9t/6Bb2OpCpy8afR1RwRPJ03g
         1IZzGyoa9wzXnhZUQ8xhrZ9Q1tn7Ma+WjAgh7UL0oIo41QakoAgTF8eFrk9W3puXVCE2
         YPyg6scusUfJ7HdQViMNU8FvzrGTe28EfjsIb3PGAB5c/zMcPvNf6d1amjgaoMJJ8m0E
         eOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=OisUhr6PFkZU82S9m6283yhNXuH+N900GBKiMYrU9xk=;
        b=hMfvtPGbthnTGclKBedp3xhgtr6FwLYfg1rCrCjUottziL/s7AmG1X7qm0OQwNj+fw
         6P+/U4r5jdAiArKy2MahABV8KIppPzY/5khQbuzTksO/gIEo5baGIkY6xYRcT6Lh2/+f
         PznQhjwYmf1DxSkRAjQIV1iWjk5jwHmC6Xqu/8/Ief5FFvinNyftCZngqrBzzH+DmVj7
         Ed/MYbroBPJru+D3pi/upsAun/Dgecbg7pQ1ISTKcltdpxNZRvq0ZLjNU4s3hwfeNGDF
         0SbNIBuqCOdzLH3CvtEUMWbmed6q1KUyBOKB7fa4zkJSvq4ISphgv22h8tvNn9AlkVfa
         gY5g==
X-Gm-Message-State: APjAAAVZX65yILUac5xH5rVcAcM7NBkrLZdPSzr+Dno0TSp8ERm/Uftj
        awxJa0vy0RxG4xyLtQNa1eg=
X-Google-Smtp-Source: APXvYqx0ZaWpc4kv/GJcyXpRSi4kPAhxXaJ57/fy2YdIg5fSXEupNTVefzrq7hlXxfLjrbJF/MuyRw==
X-Received: by 2002:a7b:c392:: with SMTP id s18mr12566646wmj.169.1575238530366;
        Sun, 01 Dec 2019 14:15:30 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id l3sm2783277wrt.29.2019.12.01.14.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2019 14:15:29 -0800 (PST)
Date:   Sun, 1 Dec 2019 23:15:22 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Jiri Olsa <jolsa@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf fixes
Message-ID: <20191201221522.GA7267@gmail.com>
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

   # HEAD: e680a41fcaf07ccac8817c589fc4824988b48eac Merge tag 'perf-core-for-mingo-5.5-20191128' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent

Mostly fixes:


 - Make /sys/devices/cpu/rdpmc based RDPMC enforcement more instantaneous

 - decoder: Update the Intel opcode map

 - Various tooling fixes, including a few late optimizations and cleanups.

 Thanks,

	Ingo

------------------>
Adrian Hunter (4):
      x86/insn: Add some more Intel instructions to the opcode map
      x86/insn: perf tools: Add some more instructions to the new instructions test
      perf script: Fix brstackinsn for AUXTRACE
      perf script: Fix invalid LBR/binary mismatch error

Andi Kleen (2):
      perf pmu: Use file system cache to optimize sysfs access
      perf affinity: Add infrastructure to save/restore affinity

Anthony Steinhauser (1):
      perf/x86: Implement immediate enforcement of /sys/devices/cpu/rdpmc value of 0

Arnaldo Carvalho de Melo (15):
      perf script: Move map__fprintf_srccode() to near its only user
      perf map: Ditch leftover map__reloc_vmlinux() prototype
      perf map: Remove needless struct forward declarations
      perf map: Remove unused functions
      perf maps: Merge 'struct maps' with 'struct map_groups'
      perf thread: Rename thread->mg to thread->maps
      perf addr_location: Rename al->mg to al->maps
      perf map_symbol: Rename ms->mg to ms->maps
      perf maps: Rename 'mg' variables to 'maps'
      perf maps: Rename map_groups.h to maps.h
      perf tests: Rename thread-mg-share to thread-maps-share
      perf tests: Rename tests/map_groups.c to tests/maps.c
      perf diff: Use llabs() with 64-bit values
      perf diff: Use llabs() with 64-bit values
      perf regs: Make perf_reg_name() return "unknown" instead of NULL

Jiri Olsa (1):
      perf tools: Allow to link with libbpf dynamicaly


 arch/x86/events/core.c                             |  18 +-
 arch/x86/include/asm/mmu_context.h                 |   4 +-
 arch/x86/lib/x86-opcode-map.txt                    |  44 +-
 tools/arch/x86/lib/x86-opcode-map.txt              |  44 +-
 tools/build/Makefile.feature                       |   3 +-
 tools/build/feature/Makefile                       |   4 +
 tools/build/feature/test-libbpf.c                  |   7 +
 tools/perf/Makefile.config                         |  10 +
 tools/perf/Makefile.perf                           |   6 +-
 tools/perf/arch/arm/tests/dwarf-unwind.c           |   4 +-
 tools/perf/arch/arm64/tests/dwarf-unwind.c         |   4 +-
 tools/perf/arch/powerpc/tests/dwarf-unwind.c       |   4 +-
 tools/perf/arch/s390/annotate/instructions.c       |   2 +-
 tools/perf/arch/x86/tests/dwarf-unwind.c           |   4 +-
 tools/perf/arch/x86/tests/insn-x86-dat-32.c        | 366 ++++++++++++
 tools/perf/arch/x86/tests/insn-x86-dat-64.c        | 484 +++++++++++++++
 tools/perf/arch/x86/tests/insn-x86-dat-src.c       | 655 +++++++++++++++++++++
 tools/perf/arch/x86/util/event.c                   |   5 +-
 tools/perf/builtin-diff.c                          |   6 +-
 tools/perf/builtin-report.c                        |   7 +-
 tools/perf/builtin-script.c                        |  46 +-
 tools/perf/tests/Build                             |   4 +-
 tools/perf/tests/builtin-test.c                    |   8 +-
 tools/perf/tests/code-reading.c                    |   2 +-
 tools/perf/tests/{map_groups.c => maps.c}          |  26 +-
 tools/perf/tests/tests.h                           |   4 +-
 .../{thread-mg-share.c => thread-maps-share.c}     |  36 +-
 tools/perf/tests/vmlinux-kallsyms.c                |   9 +-
 tools/perf/ui/browsers/annotate.c                  |   2 +-
 tools/perf/ui/stdio/hist.c                         |   4 +-
 tools/perf/util/Build                              |   2 +
 tools/perf/util/affinity.c                         |  73 +++
 tools/perf/util/affinity.h                         |  17 +
 tools/perf/util/annotate.c                         |   8 +-
 tools/perf/util/bpf-event.c                        |   4 +-
 tools/perf/util/callchain.c                        |   8 +-
 tools/perf/util/cs-etm.c                           |   2 +-
 tools/perf/util/db-export.c                        |  12 +-
 tools/perf/util/event.c                            |  14 +-
 tools/perf/util/fncache.c                          |  63 ++
 tools/perf/util/fncache.h                          |   7 +
 tools/perf/util/hist.c                             |   8 +-
 tools/perf/util/intel-pt.c                         |   2 +-
 tools/perf/util/machine.c                          |  80 ++-
 tools/perf/util/machine.h                          |  10 +-
 tools/perf/util/map.c                              | 223 ++-----
 tools/perf/util/map.h                              |  14 +-
 tools/perf/util/map_groups.h                       | 106 ----
 tools/perf/util/map_symbol.h                       |   4 +-
 tools/perf/util/maps.h                             |  87 +++
 tools/perf/util/perf_regs.h                        |   2 +-
 tools/perf/util/pmu.c                              |  34 +-
 tools/perf/util/probe-event.c                      |   4 +-
 tools/perf/util/python-ext-sources                 |   1 +
 .../util/scripting-engines/trace-event-python.c    |   2 +-
 tools/perf/util/srccode.c                          |   9 +-
 tools/perf/util/symbol-elf.c                       |  16 +-
 tools/perf/util/symbol.c                           |  91 ++-
 tools/perf/util/symbol.h                           |   6 +-
 tools/perf/util/synthetic-events.c                 |   2 +-
 tools/perf/util/thread-stack.c                     |   4 +-
 tools/perf/util/thread.c                           |  38 +-
 tools/perf/util/thread.h                           |   4 +-
 tools/perf/util/unwind-libdw.c                     |   4 +-
 tools/perf/util/unwind-libunwind-local.c           |  22 +-
 tools/perf/util/unwind-libunwind.c                 |  36 +-
 tools/perf/util/unwind.h                           |  27 +-
 tools/perf/util/vdso.c                             |   2 +-
 68 files changed, 2245 insertions(+), 625 deletions(-)
 create mode 100644 tools/build/feature/test-libbpf.c
 rename tools/perf/tests/{map_groups.c => maps.c} (83%)
 rename tools/perf/tests/{thread-mg-share.c => thread-maps-share.c} (64%)
 create mode 100644 tools/perf/util/affinity.c
 create mode 100644 tools/perf/util/affinity.h
 create mode 100644 tools/perf/util/fncache.c
 create mode 100644 tools/perf/util/fncache.h
 delete mode 100644 tools/perf/util/map_groups.h
 create mode 100644 tools/perf/util/maps.h
