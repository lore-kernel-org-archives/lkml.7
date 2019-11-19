Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E373EC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8C9422302
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 11:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574163180;
	bh=jmB0iNiZqnWeXqzXU+TxmkVa+bswHL8G0CZ7d/ndXf4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=td9IrfxwO+E3pXGvEuNAtdt0HeXoG5ApRe/hxoMLWYDRhq2VWEbBPp3tm4xkeogOs
	 +FFPeFI5BNVkYgNrHY9j2A2KDj49SJuU5i5i/WP0zXAojGcGpXC9LJvrYeRUgvSFSq
	 tber/iWOf+Ogi7A8rU58nPJbTz9whZen96WYwEok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbfKSLc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 06:32:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:46688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbfKSLc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 06:32:59 -0500
Received: from quaco.ghostprotocols.net (179.176.11.138.dynamic.adsl.gvt.net.br [179.176.11.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8C56222DD;
        Tue, 19 Nov 2019 11:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574163177;
        bh=jmB0iNiZqnWeXqzXU+TxmkVa+bswHL8G0CZ7d/ndXf4=;
        h=From:To:Cc:Subject:Date:From;
        b=Bl0rWCYVQAlfmV/X41VEwAH+ISRLyT9TQOzUT6GfUHXRE0ceF/0JmriE5VwtNIhsD
         CMuwb1BlsDr0kIlnZTEfAiMmSGuWn20Dfy8meiF6BufZVk9qiGWzXpjuVEVYo9U05D
         m5Fn2HWSYynmdMKoNtOxa44lwX+msHmvjBe8bj70=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf/core improvements and fixes
Date:   Tue, 19 Nov 2019 08:32:20 -0300
Message-Id: <20191119113245.19593-1-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo/Thomas,

	Please consider pulling,

Best regards,

- Arnaldo


The following changes since commit e1e9b78d3957a267346a86c8f2c433f6a332af65:

  perf parse: Use YYABORT to clear stack after failure, plugging leaks (2019-11-12 08:34:16 -0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.5-20191119

for you to fetch changes up to a910e4666d61712840c78de33cc7f89de8affa78:

  perf parse: Report initial event parsing error (2019-11-18 19:14:29 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

x86/insn:

  Adrian Hunter:

  - Add some more Intel instructions to the opcode map:

        cldemote, encls, enclu, enclv, enqcmd, enqcmds, movdir64b,
        movdiri, pconfig, tpause, umonitor, umwait, wbnoinvd.

  - The instruction decoding can be tested using the perf tools'
    "x86 instruction decoder - new instructions" test as folllows:

    $ perf test -v "new " 2>&1 | grep -i cldemote
    Decoded ok: 0f 1c 00                    cldemote (%eax)
    Decoded ok: 0f 1c 05 78 56 34 12        cldemote 0x12345678
    Decoded ok: 0f 1c 84 c8 78 56 34 12     cldemote 0x12345678(%eax,%ecx,8)
    Decoded ok: 0f 1c 00                    cldemote (%rax)
    Decoded ok: 41 0f 1c 00                 cldemote (%r8)
    Decoded ok: 0f 1c 04 25 78 56 34 12     cldemote 0x12345678
    Decoded ok: 0f 1c 84 c8 78 56 34 12     cldemote 0x12345678(%rax,%rcx,8)
    Decoded ok: 41 0f 1c 84 c8 78 56 34 12  cldemote 0x12345678(%r8,%rcx,8)
    $ perf test -v "new " 2>&1 | grep -i tpause
    Decoded ok: 66 0f ae f3                 tpause %ebx
    Decoded ok: 66 0f ae f3                 tpause %ebx
    Decoded ok: 66 41 0f ae f0              tpause %r8d

callchains:

  Adrian Hunter:

  - Fix segfault in thread__resolve_callchain_sample().

perf probe:

  - Line fixes to show only lines where probes can be used with 'perf probe -L',
    and when reporting them via 'perf probe -l'.

  - Support multiprobe events.

perf scripts python:

  Adrian Hunter:

  - Fix use of TRUE with SQLite < 3.23 in exported-sql-viewer.py.

perf maps:

  - Trim 'struct map' by removing the rb_node member for sorting
    by map name, as that is only needed for processing kernel maps,
    and only when classifying symbols by section at load time.
    Sort them by name using qsort() and do lookups using bsearch()
    when map_groups__find_by_name() is used.

perf parse:

  Ian Rogers:

  - Report initial event parsing error, providing a less cryptic message
    to state that a PMU wasn't found in the system.

perf vendor events:

  James Clark:

  - Fix commas so that PMU event files for arm64, power8 and power nine
    become valid JSON.

libtraceevent:

  Konstantin Khlebnikov:

  - Fix parsing of event %o and %X argument types.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (4):
      perf scripts python: exported-sql-viewer.py: Fix use of TRUE with SQLite
      perf callchain: Fix segfault in thread__resolve_callchain_sample()
      x86/insn: perf tools: Add some instructions to the new instructions test
      x86/insn: Add some Intel instructions to the opcode map

Arnaldo Carvalho de Melo (9):
      perf maps: Purge the entries from maps->names in __maps__purge()
      perf maps: Do not use an rbtree to sort by map name
      perf map_groups: Add a front end cache for map lookups by name
      perf map: No need to adjust the long name of modules
      perf record: No need to process the synthesized MMAP events twice
      perf machine: No need to check if kernel module maps pre-exist
      perf map_groups: Auto sort maps by name, if needed
      perf map: Use bitmap for booleans
      perf map: Move seldom used ->flags field to second cacheline

Ian Rogers (1):
      perf parse: Report initial event parsing error

James Clark (3):
      perf vendor events arm64: Fix commas so PMU event files are valid JSON
      perf vendor events power8: Fix commas so PMU event files are valid JSON
      perf vendor events power9: Fix commas so PMU event files are valid JSON

Konstantin Khlebnikov (1):
      libtraceevent: Fix parsing of event %o and %X argument types

Masami Hiramatsu (7):
      perf probe: Show correct statement line number by perf probe -l
      perf probe: Verify given line is a representive line
      perf probe: Do not show non representive lines by perf-probe -L
      perf probe: Generate event name with line number
      perf probe: Support multiprobe event
      perf probe: Support DW_AT_const_value constant value
      perf probe: Trace a magic number if variable is not found

 arch/x86/lib/x86-opcode-map.txt                    |   18 +-
 tools/arch/x86/lib/x86-opcode-map.txt              |   18 +-
 tools/lib/traceevent/event-parse.c                 |    7 +-
 tools/perf/arch/powerpc/util/kvm-stat.c            |    4 +-
 tools/perf/arch/x86/tests/insn-x86-dat-32.c        |   52 +
 tools/perf/arch/x86/tests/insn-x86-dat-64.c        |   62 ++
 tools/perf/arch/x86/tests/insn-x86-dat-src.c       |  109 ++
 tools/perf/builtin-record.c                        |   29 +-
 tools/perf/builtin-stat.c                          |    2 +
 tools/perf/builtin-trace.c                         |   16 +-
 .../pmu-events/arch/arm64/ampere/emag/branch.json  |    8 +-
 .../pmu-events/arch/arm64/ampere/emag/bus.json     |   14 +-
 .../pmu-events/arch/arm64/ampere/emag/cache.json   |   28 +-
 .../pmu-events/arch/arm64/ampere/emag/clock.json   |    2 +-
 .../arch/arm64/ampere/emag/exception.json          |   26 +-
 .../arch/arm64/ampere/emag/instruction.json        |   28 +-
 .../arch/arm64/ampere/emag/intrinsic.json          |   10 +-
 .../pmu-events/arch/arm64/ampere/emag/memory.json  |   12 +-
 .../arch/arm64/ampere/emag/pipeline.json           |    2 +-
 .../arch/arm64/arm/cortex-a53/branch.json          |    2 +-
 .../pmu-events/arch/arm64/arm/cortex-a53/bus.json  |    4 +-
 .../arch/arm64/arm/cortex-a53/other.json           |    4 +-
 .../arm64/arm/cortex-a57-a72/core-imp-def.json     |  120 +-
 .../pmu-events/arch/arm64/armv8-recommended.json   |  158 +--
 .../arch/arm64/cavium/thunderx2/core-imp-def.json  |   74 +-
 .../arch/arm64/hisilicon/hip08/core-imp-def.json   |   60 +-
 .../arch/arm64/hisilicon/hip08/uncore-ddrc.json    |   18 +-
 .../arch/arm64/hisilicon/hip08/uncore-hha.json     |   22 +-
 .../arch/arm64/hisilicon/hip08/uncore-l3c.json     |   28 +-
 .../perf/pmu-events/arch/powerpc/power8/cache.json |   60 +-
 .../arch/powerpc/power8/floating-point.json        |    6 +-
 .../pmu-events/arch/powerpc/power8/frontend.json   |  158 +--
 .../pmu-events/arch/powerpc/power8/marked.json     |  266 ++---
 .../pmu-events/arch/powerpc/power8/memory.json     |   72 +-
 .../perf/pmu-events/arch/powerpc/power8/other.json | 1150 ++++++++++----------
 .../pmu-events/arch/powerpc/power8/pipeline.json   |  118 +-
 tools/perf/pmu-events/arch/powerpc/power8/pmc.json |   48 +-
 .../arch/powerpc/power8/translation.json           |   60 +-
 .../perf/pmu-events/arch/powerpc/power9/cache.json |   44 +-
 .../arch/powerpc/power9/floating-point.json        |   14 +-
 .../pmu-events/arch/powerpc/power9/frontend.json   |  142 +--
 .../pmu-events/arch/powerpc/power9/marked.json     |  250 ++---
 .../pmu-events/arch/powerpc/power9/memory.json     |   52 +-
 .../perf/pmu-events/arch/powerpc/power9/other.json |  934 ++++++++--------
 .../pmu-events/arch/powerpc/power9/pipeline.json   |  212 ++--
 tools/perf/pmu-events/arch/powerpc/power9/pmc.json |   48 +-
 .../arch/powerpc/power9/translation.json           |   92 +-
 tools/perf/scripts/python/exported-sql-viewer.py   |   12 +-
 tools/perf/tests/map_groups.c                      |    2 +-
 tools/perf/tests/parse-events.c                    |    3 +-
 tools/perf/util/dwarf-aux.c                        |   62 +-
 tools/perf/util/machine.c                          |   43 +-
 tools/perf/util/machine.h                          |    2 -
 tools/perf/util/map.c                              |  116 +-
 tools/perf/util/map.h                              |    7 +-
 tools/perf/util/map_groups.h                       |   21 +-
 tools/perf/util/metricgroup.c                      |    2 +-
 tools/perf/util/parse-events.c                     |   78 +-
 tools/perf/util/parse-events.h                     |    4 +
 tools/perf/util/probe-event.c                      |   19 +-
 tools/perf/util/probe-event.h                      |    3 +
 tools/perf/util/probe-file.c                       |   14 +
 tools/perf/util/probe-file.h                       |    2 +
 tools/perf/util/probe-finder.c                     |  116 +-
 tools/perf/util/probe-finder.h                     |    1 +
 tools/perf/util/symbol.c                           |   84 +-
 66 files changed, 2888 insertions(+), 2366 deletions(-)
