Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A14C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6704218DA
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732066AbfHFH25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 03:28:57 -0400
Received: from mga02.intel.com ([134.134.136.20]:31201 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731557AbfHFH25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 03:28:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2019 00:24:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,352,1559545200"; 
   d="scan'208";a="325555334"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 06 Aug 2019 00:24:38 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kan.liang@linux.intel.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v5 0/7] perf, intel: Add support for PEBS output to Intel PT
Date:   Tue,  6 Aug 2019 10:24:26 +0300
Message-Id: <20190806072433.26820-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Sixth attempt at the PEBS-via-PT feature. The previous ones were [1], [2],
[3], [4], [5]. This one addresses the most recent review comments, mainly
renaming the new attribute bit and everything related to 'aux_output'.
Tooling also changed to use /aux-output/ config term.

The PEBS feature: output to Intel PT stream instead of the DS area. It's
theoretically useful in virtualized environments, where DS area can't be
used. It's also good for those who are interested in instruction trace for
context of the PEBS events. As PEBS goes, it can provide LBR context with
all the branch-related information that PT doesn't provide at the moment.

PEBS records are packetized in the PT stream, so instead of extracting
them in the PMI, we leave it to the perf tool, because real time PT
decoding is not practical.

[1] https://marc.info/?l=linux-kernel&m=155679423430002
[2] https://marc.info/?l=linux-kernel&m=156225605132606
[3] https://marc.info/?l=linux-kernel&m=156458152126310
[4] https://marc.info/?l=linux-kernel&m=156458348626999
[5] https://marc.info/?l=linux-kernel&m=156498939722450

Adrian Hunter (5):
  perf tools: Add aux_output attribute flag
  perf tools: Add itrace option 'o' to synthesize aux-output events
  perf intel-pt: Process options for PEBS event synthesis
  perf tools: Add aux-output config term
  perf intel-pt: Add brief documentation for PEBS via Intel PT

Alexander Shishkin (2):
  perf: Allow normal events to output AUX data
  perf/x86/intel: Support PEBS output to PT

 arch/x86/events/core.c                   | 34 +++++++++
 arch/x86/events/intel/core.c             | 18 +++++
 arch/x86/events/intel/ds.c               | 51 ++++++++++++-
 arch/x86/events/intel/pt.c               |  5 ++
 arch/x86/events/perf_event.h             | 17 +++++
 arch/x86/include/asm/intel_pt.h          |  2 +
 arch/x86/include/asm/msr-index.h         |  4 +
 include/linux/perf_event.h               | 14 ++++
 include/uapi/linux/perf_event.h          |  3 +-
 kernel/events/core.c                     | 93 ++++++++++++++++++++++++
 tools/include/uapi/linux/perf_event.h    |  3 +-
 tools/perf/Documentation/intel-pt.txt    | 15 ++++
 tools/perf/Documentation/itrace.txt      |  2 +
 tools/perf/Documentation/perf-record.txt |  2 +
 tools/perf/arch/x86/util/intel-pt.c      | 23 ++++++
 tools/perf/util/auxtrace.c               |  4 +
 tools/perf/util/auxtrace.h               |  3 +
 tools/perf/util/evsel.c                  |  4 +
 tools/perf/util/evsel.h                  |  2 +
 tools/perf/util/intel-pt.c               | 18 +++++
 tools/perf/util/parse-events.c           |  8 ++
 tools/perf/util/parse-events.h           |  1 +
 tools/perf/util/parse-events.l           |  1 +
 23 files changed, 324 insertions(+), 3 deletions(-)

-- 
2.20.1

