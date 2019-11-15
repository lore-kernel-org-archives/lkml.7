Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC74C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E042320728
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfKOMnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 07:43:23 -0500
Received: from mga14.intel.com ([192.55.52.115]:58938 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727272AbfKOMnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 07:43:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2019 04:43:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,308,1569308400"; 
   d="scan'208";a="257749644"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.197])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Nov 2019 04:43:21 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 00/15] perf tools: Add support for AUX area sampling
Date:   Fri, 15 Nov 2019 14:42:10 +0200
Message-Id: <20191115124225.5247-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

The kernel changes for AUX area sampling are now in tip, so here are the
tools' patches.

AUX area sampling allows bytes from a AUX area buffer to be copied onto
samples of other events.

Here is the Intel PT documentation from patch "perf intel-pt: Add support
for recording AUX area":

  perf record AUX area sampling option
  ------------------------

  To select Intel PT "sampling" the AUX area sampling option can be used:

  	--aux-sample

  Optionally it can be followed by the sample size in bytes e.g.

  	--aux-sample=8192

  In addition, the Intel PT event to sample must be defined e.g.

  	-e intel_pt//u

  Samples on other events will be created containing Intel PT data e.g. the
  following will create Intel PT samples on the branch-misses event, note the
  events must be grouped using {}:

  	perf record --aux-sample -e '{intel_pt//u,branch-misses:u}'

  An alternative to '--aux-sample' is to add the config term 'aux-sample-size' to
  events.  In this case, the grouping is implied e.g.

  	perf record -e intel_pt//u -e branch-misses/aux-sample-size=8192/u

  is the same as:

  	perf record -e '{intel_pt//u,branch-misses/aux-sample-size=8192/u}'

  but allows for also using an address filter e.g.:

  	perf record -e intel_pt//u --filter 'filter * @/bin/ls' -e branch-misses/aux-sample-size=8192/u -- ls

  It is important to select a sample size that is big enough to contain at least
  one PSB packet.  If not a warning will be displayed:

  	Intel PT sample size (%zu) may be too small for PSB period (%zu)

  The calculation used for that is: if sample_size <= psb_period + 256 display the
  warning.  When sampling is used, psb_period defaults to 0 (2KiB).

  The default sample size is 4KiB.

  The sample size is passed in aux_sample_size in struct perf_event_attr.  The
  sample size is limited by the maximum event size which is 64KiB.  It is
  difficult to know how big the event might be without the trace sample attached,
  but the tool validates that the sample size is not greater than 60KiB.


Adrian Hunter (15):
      perf tools: Add kernel AUX area sampling definitions
      perf tools: Add AUX area sample parsing
      perf tools: Add a function to test for kernel support for AUX area sampling
      perf auxtrace: Move perf_evsel__find_pmu()
      perf auxtrace: Add support for AUX area sample recording
      perf record: Add support for AUX area sampling
      perf record: Add aux-sample-size config term
      perf inject: Cut AUX area samples
      perf auxtrace: Add support for dumping AUX area samples
      perf session: Add facility to peek at all events
      perf auxtrace: Add support for queuing AUX area samples
      perf pmu: When using default config, record which bits of config were changed by the user
      perf intel-pt: Add support for recording AUX area samples
      perf intel-pt: Add support for decoding AUX area samples
      perf intel-bts: Does not support AUX area sampling

 tools/include/uapi/linux/perf_event.h     |  10 +-
 tools/perf/Documentation/intel-pt.txt     |  59 +++++-
 tools/perf/Documentation/perf-record.txt  |   9 +
 tools/perf/arch/x86/util/auxtrace.c       |   4 +
 tools/perf/arch/x86/util/intel-bts.c      |   5 +
 tools/perf/arch/x86/util/intel-pt.c       |  81 +++++++-
 tools/perf/builtin-inject.c               |  29 +++
 tools/perf/builtin-record.c               |  21 +-
 tools/perf/tests/attr/base-record         |   2 +-
 tools/perf/tests/attr/base-stat           |   2 +-
 tools/perf/tests/sample-parsing.c         |  16 +-
 tools/perf/util/auxtrace.c                | 322 ++++++++++++++++++++++++++++--
 tools/perf/util/auxtrace.h                |  42 ++++
 tools/perf/util/event.h                   |   6 +
 tools/perf/util/evlist.h                  |   1 +
 tools/perf/util/evsel.c                   |  31 +++
 tools/perf/util/evsel_config.h            |  13 ++
 tools/perf/util/intel-pt.c                | 109 +++++++++-
 tools/perf/util/parse-events.c            |  56 +++++-
 tools/perf/util/parse-events.h            |   1 +
 tools/perf/util/parse-events.l            |   1 +
 tools/perf/util/perf_event_attr_fprintf.c |   3 +-
 tools/perf/util/pmu.c                     |  10 +
 tools/perf/util/pmu.h                     |   2 +
 tools/perf/util/record.c                  |  30 +++
 tools/perf/util/record.h                  |   2 +
 tools/perf/util/session.c                 |  38 +++-
 tools/perf/util/session.h                 |   5 +
 tools/perf/util/synthetic-events.c        |  12 ++
 29 files changed, 894 insertions(+), 28 deletions(-)


Regards
Adrian
