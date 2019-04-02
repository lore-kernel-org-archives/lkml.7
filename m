Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8430C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D5032084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554221165;
	bh=3jji6iHaPpnOe1nkmwXHg9jmA/oAc915BPkkP3IKurw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=PkCRcFWLbCXEE3ax3/1+YJQrxiyLO7o3Tn6rmqk3od/XdAzxpy3afiKNn3EV5Oj/E
	 /1VVqQ0wRdNZYbWzC9VcQBPITO02g7XHEN0d84/xroo0N8QT+R0CxZoICjclLqjTw6
	 9xJu8Xw7GaMoJ3vWWwwfVHDny/nHlottjUr7QU6I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbfDBQGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:06:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:43650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbfDBQGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:06:03 -0400
Received: from quaco.ghostprotocols.net (unknown [187.65.94.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEB392082C;
        Tue,  2 Apr 2019 16:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554221162;
        bh=3jji6iHaPpnOe1nkmwXHg9jmA/oAc915BPkkP3IKurw=;
        h=From:To:Cc:Subject:Date:From;
        b=SkB1px66qSHVHbP0Qn0CWdRAcnUrXuTC5cU/Z51PJn/zSgiQAT4l982w/9FrWbuar
         g2VTl6Axatgk9OGi8vU6HAr3+qGB4F76she047YNWKekg9W4sQmOuI/iOAK0cgmB7p
         abEI+5YvND2pyJ6s+irvQPuY5SDf8JQ7LMnUJZ9w=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL 00/44] perf/core improvements and fixes for 5.2
Date:   Tue,  2 Apr 2019 13:05:05 -0300
Message-Id: <20190402160549.13544-1-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo, Thomas,

	Please consider pulling into tip/perf/core, for 5.2, this is on
top of tip/perf/urgent.

Thanks,

- Arnaldo

The following changes since commit 22261fdf68f23df3ddf359642696d6ce98e584fa:

  Merge tag 'perf-urgent-for-mingo-5.1-20190329' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2019-03-29 21:28:58 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.2-20190402

for you to fetch changes up to 1c3a2c864d2da0454bca1e41d3e0090c18678909:

  perf vendor events intel: Update Silvermont to v14 (2019-04-01 15:23:48 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

perf record:

  Alexey Budankov:

  - Implement --mmap-flush=<number> option, to control a threshold for draining
    the mmap ring buffers and consequently the size of the write calls to the
    output, be it perf.data, pipe mode or soon a compressor that with bigger
    buffers will do a better job before dumping compressed data into a new
    perf.data content mode, which is in the final steps of reviewing and testing.

perf trace:

  Arnaldo Carvalho de Melo:

  - Add 'string' event alias to select syscalls with string args, i.e. for testing
    the BPF program used to copy those strings, allow for:

    # perf trace -e string

    To select all the syscalls that have things like pathnames.

  - Use a PERCPU_ARRAY BPF map to copy more string bytes than what is possible using
    the BPF stack, just like pioneered by the sysdig tool.

Feature detection:

  Alexey Budankov:

  - Implement libzstd feature check, which is a library that provides a uniform
    API to various compression formats, will be used in 'perf record', see note
    about --mmap-flush feature.

perf stat:

  Andi Kleen:

  - Implement a tool specific 'duration_time' event to allow showing the "time
    elapsed" line in the default 'perf stat' output as one of the events that
    can be asked for when using --field-separator and other script consumable
    outputs.

Intel vendor events (JSON files):

  Andi Kleen:

  - Update metrics from TMAM 3.5.

  - Update events:

    Bonnell to V4
    Broadwell-DE to v7
    Broadwell to v23
    BroadwellX to v14
    GoldmontPlus to v1.01
    Goldmont to v13
    Haswell to v28
    HaswellX to v20
    IvyBridge to v21
    IvyTown to v20
    JakeTown to v20
    KnightsLanding to v9
    SandyBridge to v16
    Silvermont to v14
    Skylake to v42
    SkylakeX to v1.12

IBM S/390 vendor events (JSON):

  Thomas Richter:

  - Fix s390 counter long description for L1D_RO_EXCL_WRITES.

tools lib traceevent:

  Steven Rostedt (Red Hat):

  - Add more debugging to see various internal ring buffer entries.

  Steven Rostedt (VMWare):

  - Handle trace_printk() "%px".
  - Add mono clocks to be parsed in seconds.
  - Removed unneeded !! and return parenthesis.

  Tzvetomir Stoyanov :

  - Implement a new API, tep_list_events_copy().
  - Implement new traceevent APIs for accessing struct tep_handler fields.
  - Remove tep filter trivial APIs, not used anymore.
  - Remove call to exit() from tep_filter_add_filter_str(), library routines shouldn't
    kill tools using it.
  - Make traceevent APIs more consistent.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Alexey Budankov (2):
      tools build: Implement libzstd feature check, LIBZSTD_DIR and NO_LIBZSTD defines
      perf record: Implement --mmap-flush=<number> option

Andi Kleen (21):
      perf stat: Revert checks for duration_time
      perf stat: Implement duration_time as a proper event
      perf evsel: Support printing evsel name for 'duration_time'
      perf list: Output tool events
      perf vendor events intel: Update metrics from TMAM 3.5
      perf vendor events intel: Update Broadwell events to v23
      perf vendor events intel: Update Broadwell-DE events to v7
      perf vendor events intel: Update Skylake events to v42
      perf vendor events intel: Update SkylakeX events to v1.12
      perf vendor events intel: Update BroadwellX events to v14
      perf vendor events intel: Update HaswellX events to v20
      perf vendor events intel: Update IvyTown events to v20
      perf vendor events intel: Update JakeTown events to v20
      perf vendor events intel: Update SandyBridge events to v16
      perf vendor events intel: Update IvyBridge events to v21
      perf vendor events intel: Update Haswell events to v28
      perf vendor events intel: Update KnightsLanding events to v9
      perf vendor events intel: Update Bonnell to V4
      perf vendor events intel: Update Goldmont to v13
      perf vendor events intel: Update GoldmontPlus to v1.01
      perf vendor events intel: Update Silvermont to v14

Arnaldo Carvalho de Melo (5):
      perf trace: Add 'string' event alias to select syscalls with string args
      perf augmented_raw_syscalls: Copy strings from all syscalls with 1st or 2nd string arg
      perf augmented_raw_syscalls: Use a PERCPU_ARRAY map to copy more string bytes
      perf trace beauty renameat: No need to include linux/fs.h
      perf tools: Add header defining used namespace struct to event.h

Steven Rostedt (Red Hat) (1):
      tools lib traceevent: Add more debugging to see various internal ring buffer entries

Steven Rostedt (VMware) (3):
      tools lib traceevent: Handle trace_printk() "%px"
      tools lib traceevent: Add mono clocks to be parsed in seconds
      tools lib traceevent: Removed unneeded !! and return parenthesis

Thomas Richter (1):
      perf list: Fix s390 counter long description for L1D_RO_EXCL_WRITES

Tzvetomir Stoyanov (11):
      tools lib traceevent: Implement a new API, tep_list_events_copy()
      tools lib traceevent: Change description of few APIs
      tools lib traceevent: Coding style fixes
      tools lib traceevent: Implement new traceevent APIs for accessing struct tep_handler fields
      tools lib traceevent: Remove tep filter trivial APIs
      tools lib traceevent: Remove call to exit() from tep_filter_add_filter_str()
      tools tools, tools lib traceevent: Make traceevent APIs more consistent
      tools lib traceevent: Rename input arguments of libtraceevent APIs from pevent to tep
      perf tools, tools lib traceevent: Rename "pevent" member of struct tep_event to "tep"
      perf tools, tools lib traceevent: Rename "pevent" member of struct tep_event_filter to "tep"
      tools lib traceevent: Rename input arguments and local variables of libtraceevent from pevent to tep

 tools/build/Makefile.feature                       |    2 +
 tools/build/feature/Makefile                       |    6 +-
 tools/build/feature/test-all.c                     |    5 +
 tools/build/feature/test-libzstd.c                 |   12 +
 tools/lib/traceevent/event-parse-api.c             |  278 ++-
 tools/lib/traceevent/event-parse-local.h           |    6 +-
 tools/lib/traceevent/event-parse.c                 |  909 ++++----
 tools/lib/traceevent/event-parse.h                 |  154 +-
 tools/lib/traceevent/event-plugin.c                |   32 +-
 tools/lib/traceevent/kbuffer-parse.c               |   49 +
 tools/lib/traceevent/kbuffer.h                     |   13 +
 tools/lib/traceevent/parse-filter.c                |  216 +-
 tools/lib/traceevent/plugin_cfg80211.c             |    8 +-
 tools/lib/traceevent/plugin_function.c             |   14 +-
 tools/lib/traceevent/plugin_hrtimer.c              |   12 +-
 tools/lib/traceevent/plugin_jbd2.c                 |   12 +-
 tools/lib/traceevent/plugin_kmem.c                 |   32 +-
 tools/lib/traceevent/plugin_kvm.c                  |   48 +-
 tools/lib/traceevent/plugin_mac80211.c             |    8 +-
 tools/lib/traceevent/plugin_sched_switch.c         |   18 +-
 tools/lib/traceevent/plugin_scsi.c                 |    8 +-
 tools/lib/traceevent/plugin_xen.c                  |    8 +-
 tools/perf/Documentation/perf-record.txt           |   19 +
 tools/perf/Makefile.config                         |   20 +
 tools/perf/Makefile.perf                           |    3 +
 tools/perf/builtin-kmem.c                          |    2 +-
 tools/perf/builtin-list.c                          |    6 +-
 tools/perf/builtin-record.c                        |   65 +-
 tools/perf/builtin-stat.c                          |   28 +-
 tools/perf/builtin-version.c                       |    2 +
 tools/perf/examples/bpf/augmented_raw_syscalls.c   |  196 +-
 tools/perf/perf.h                                  |    1 +
 .../perf/pmu-events/arch/s390/cf_z14/extended.json |    2 +-
 .../perf/pmu-events/arch/x86/bonnell/frontend.json |    2 +-
 .../perf/pmu-events/arch/x86/bonnell/pipeline.json |    2 +-
 .../pmu-events/arch/x86/broadwell/bdw-metrics.json |  260 ++-
 .../perf/pmu-events/arch/x86/broadwell/cache.json  | 1630 +++++++--------
 .../arch/x86/broadwell/floating-point.json         |   51 +-
 .../pmu-events/arch/x86/broadwell/frontend.json    |    4 +-
 .../perf/pmu-events/arch/x86/broadwell/memory.json | 1640 +++++++--------
 .../pmu-events/arch/x86/broadwell/pipeline.json    |   36 +-
 .../pmu-events/arch/x86/broadwellde/cache.json     |    4 +-
 .../pmu-events/arch/x86/broadwellde/pipeline.json  |    6 +-
 .../arch/x86/broadwellx/bdx-metrics.json           |  278 ++-
 .../perf/pmu-events/arch/x86/broadwellx/cache.json |  161 +-
 .../arch/x86/broadwellx/floating-point.json        |   16 +-
 .../pmu-events/arch/x86/broadwellx/memory.json     |  148 +-
 .../pmu-events/arch/x86/broadwellx/pipeline.json   |   50 +-
 .../arch/x86/cascadelakex/clx-metrics.json         |  304 ++-
 tools/perf/pmu-events/arch/x86/goldmont/cache.json | 1244 +++--------
 .../perf/pmu-events/arch/x86/goldmont/memory.json  |  260 ---
 .../pmu-events/arch/x86/goldmont/pipeline.json     |    5 +-
 .../arch/x86/goldmont/virtual-memory.json          |    9 +-
 .../pmu-events/arch/x86/goldmontplus/cache.json    |   74 +-
 .../pmu-events/arch/x86/goldmontplus/pipeline.json |    5 +-
 .../arch/x86/goldmontplus/virtual-memory.json      |    9 +-
 tools/perf/pmu-events/arch/x86/haswell/cache.json  |  175 +-
 .../arch/x86/haswell/floating-point.json           |   33 +-
 .../pmu-events/arch/x86/haswell/hsw-metrics.json   |  234 ++-
 tools/perf/pmu-events/arch/x86/haswell/memory.json |  172 +-
 .../perf/pmu-events/arch/x86/haswell/pipeline.json |   33 +-
 tools/perf/pmu-events/arch/x86/haswellx/cache.json |  173 +-
 .../pmu-events/arch/x86/haswellx/hsx-metrics.json  |  252 ++-
 .../perf/pmu-events/arch/x86/haswellx/memory.json  |  172 +-
 .../pmu-events/arch/x86/haswellx/pipeline.json     |   10 +-
 .../perf/pmu-events/arch/x86/ivybridge/cache.json  |   10 +-
 .../pmu-events/arch/x86/ivybridge/ivb-metrics.json |  250 ++-
 .../pmu-events/arch/x86/ivybridge/pipeline.json    |    4 -
 .../pmu-events/arch/x86/ivytown/ivt-metrics.json   |  256 ++-
 .../perf/pmu-events/arch/x86/ivytown/pipeline.json |    4 -
 tools/perf/pmu-events/arch/x86/jaketown/cache.json |    6 +-
 .../pmu-events/arch/x86/jaketown/jkt-metrics.json  |  150 +-
 .../pmu-events/arch/x86/jaketown/pipeline.json     |   12 +-
 .../pmu-events/arch/x86/knightslanding/cache.json  |  666 +++---
 .../pmu-events/arch/x86/knightslanding/memory.json |  268 +--
 .../arch/x86/knightslanding/pipeline.json          |   15 +-
 .../arch/x86/knightslanding/virtual-memory.json    |    2 +-
 .../pmu-events/arch/x86/sandybridge/cache.json     |  680 +++---
 .../arch/x86/sandybridge/floating-point.json       |  126 +-
 .../pmu-events/arch/x86/sandybridge/frontend.json  |  268 +--
 .../pmu-events/arch/x86/sandybridge/memory.json    |   68 +-
 .../pmu-events/arch/x86/sandybridge/other.json     |   18 +-
 .../pmu-events/arch/x86/sandybridge/pipeline.json  | 1338 ++++++------
 .../arch/x86/sandybridge/snb-metrics.json          |  144 +-
 .../arch/x86/sandybridge/virtual-memory.json       |  108 +-
 .../perf/pmu-events/arch/x86/silvermont/cache.json |    2 +-
 .../perf/pmu-events/arch/x86/silvermont/other.json |   20 +
 .../pmu-events/arch/x86/silvermont/pipeline.json   |    5 +-
 tools/perf/pmu-events/arch/x86/skylake/cache.json  | 2193 +++++++++++++++++++-
 .../perf/pmu-events/arch/x86/skylake/frontend.json |   14 +-
 tools/perf/pmu-events/arch/x86/skylake/memory.json | 1121 +++++++++-
 .../perf/pmu-events/arch/x86/skylake/pipeline.json |   39 +-
 .../pmu-events/arch/x86/skylake/skl-metrics.json   |  274 ++-
 tools/perf/pmu-events/arch/x86/skylakex/cache.json |  786 ++++---
 .../arch/x86/skylakex/floating-point.json          |    2 -
 .../pmu-events/arch/x86/skylakex/frontend.json     |  234 +--
 .../perf/pmu-events/arch/x86/skylakex/memory.json  |  751 +++----
 .../pmu-events/arch/x86/skylakex/pipeline.json     |  173 +-
 .../pmu-events/arch/x86/skylakex/skx-metrics.json  |  304 ++-
 tools/perf/trace/beauty/renameat.c                 |    1 -
 tools/perf/trace/strace/groups/string              |   65 +
 tools/perf/util/data-convert-bt.c                  |    4 +-
 tools/perf/util/event.h                            |    1 +
 tools/perf/util/evlist.c                           |    6 +-
 tools/perf/util/evlist.h                           |    3 +-
 tools/perf/util/evsel.c                            |   11 +-
 tools/perf/util/evsel.h                            |    6 +
 tools/perf/util/mmap.c                             |    4 +-
 tools/perf/util/mmap.h                             |    3 +-
 tools/perf/util/parse-events.c                     |   58 +-
 tools/perf/util/parse-events.h                     |    5 +
 tools/perf/util/parse-events.l                     |   11 +-
 tools/perf/util/parse-events.y                     |   12 +
 tools/perf/util/python.c                           |    2 +-
 .../perf/util/scripting-engines/trace-event-perl.c |    2 +-
 .../util/scripting-engines/trace-event-python.c    |    2 +-
 tools/perf/util/stat-display.c                     |   18 -
 tools/perf/util/trace-event-parse.c                |    2 +-
 tools/perf/util/trace-event-read.c                 |    2 +-
 tools/perf/util/trace-event.c                      |    4 +-
 120 files changed, 12238 insertions(+), 7941 deletions(-)
 create mode 100644 tools/build/feature/test-libzstd.c
 create mode 100644 tools/perf/pmu-events/arch/x86/silvermont/other.json
 create mode 100644 tools/perf/trace/strace/groups/string
