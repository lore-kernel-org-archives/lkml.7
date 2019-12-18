Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24B2C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBCE7218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfLRO1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:27:12 -0500
Received: from mga01.intel.com ([192.55.52.88]:21667 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726856AbfLRO1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 09:27:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Dec 2019 06:27:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,329,1571727600"; 
   d="scan'208";a="240803857"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.76])
  by fmsmga004.fm.intel.com with ESMTP; 18 Dec 2019 06:27:09 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] perf/x86: Add perf text poke event
Date:   Wed, 18 Dec 2019 16:26:15 +0200
Message-Id: <20191218142618.19332-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here are patches to add a text poke event to record changes to kernel text
(i.e. self-modifying code) in order to support tracers like Intel PT
decoding through jump labels.

The first patch makes the kernel change and the subsequent patches are
tools changes.

The second patch adds support for updating perf tools' data cache
with the changed bytes.

The last patch is an Intel PT specific tools change.

The patches are based on linux-next.


Changes since RFC:

  Dropped 'flags' from the new event.  The consensus seemed to be that text
  pokes should emply a scheme similar to x86's INT3 method instead.

  dropped tools patches already applied.


Example:

  For jump labels, the kernel needs
	CONFIG_JUMP_LABEL=y
  and also an easy to flip jump label is in sysctl_schedstats() which needs
	CONFIG_SCHEDSTATS=y
	CONFIG_PROC_SYSCTL=y

  Also note the 'sudo perf record' is put into the background which, as
  written, needs sudo credential caching (otherwise the background task
  will stop awaiting the sudo password), hence the 'sudo echo' to start.

Before:

  $ sudo echo
  $ sudo perf record -o perf.data.before --kcore -a -e intel_pt//k -m,64M &
  [1] 1640
  $ cat /proc/sys/kernel/sched_schedstats
  0
  $ sudo bash -c 'echo 1 > /proc/sys/kernel/sched_schedstats'
  $ cat /proc/sys/kernel/sched_schedstats
  1
  $ sudo bash -c 'echo 0 > /proc/sys/kernel/sched_schedstats'
  $ cat /proc/sys/kernel/sched_schedstats
  0
  $ sudo kill 1640
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 16.635 MB perf.data.before ]
  $ perf script -i perf.data.before --itrace=e >/dev/null
  Warning:
  1946 instruction trace errors

After:

  $ sudo echo
  $ sudo perf record -o perf.data.after --kcore -a -e intel_pt//k -m,64M &
  [1] 1882
  $ cat /proc/sys/kernel/sched_schedstats
  0
  $ sudo bash -c 'echo 1 > /proc/sys/kernel/sched_schedstats'
  $ cat /proc/sys/kernel/sched_schedstats
  1
  $ sudo bash -c 'echo 0 > /proc/sys/kernel/sched_schedstats'
  $ cat /proc/sys/kernel/sched_schedstats
  0
  $ sudo kill 1882
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 10.893 MB perf.data.after ]
  $ perf script -i perf.data.after --itrace=e
  $


Adrian Hunter (3):
      perf/x86: Add perf text poke event
      perf tools: Add support for PERF_RECORD_TEXT_POKE
      perf intel-pt: Add support for text poke events

 arch/x86/kernel/alternative.c             | 37 ++++++++++++-
 include/linux/perf_event.h                |  6 +++
 include/uapi/linux/perf_event.h           | 19 ++++++-
 kernel/events/core.c                      | 87 ++++++++++++++++++++++++++++++-
 tools/include/uapi/linux/perf_event.h     | 19 ++++++-
 tools/perf/arch/x86/util/intel-pt.c       |  4 ++
 tools/perf/builtin-record.c               | 45 ++++++++++++++++
 tools/perf/lib/include/perf/event.h       |  8 +++
 tools/perf/util/event.c                   | 39 ++++++++++++++
 tools/perf/util/event.h                   |  5 ++
 tools/perf/util/evlist.h                  |  1 +
 tools/perf/util/intel-pt.c                | 71 +++++++++++++++++++++++++
 tools/perf/util/machine.c                 | 34 ++++++++++++
 tools/perf/util/machine.h                 |  3 ++
 tools/perf/util/perf_event_attr_fprintf.c |  1 +
 tools/perf/util/record.c                  | 10 ++++
 tools/perf/util/record.h                  |  1 +
 tools/perf/util/session.c                 | 20 +++++++
 tools/perf/util/tool.h                    |  3 +-
 19 files changed, 408 insertions(+), 5 deletions(-)


Regards
Adrian
