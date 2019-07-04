Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AACC0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FEDB2085A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfGDQAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 12:00:33 -0400
Received: from mga03.intel.com ([134.134.136.65]:53366 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbfGDQAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 12:00:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2019 09:00:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,451,1557212400"; 
   d="scan'208";a="185016921"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Jul 2019 09:00:29 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kan.liang@linux.intel.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v1 0/7] perf, intel: Add support for PEBS output to Intel PT
Date:   Thu,  4 Jul 2019 19:00:17 +0300
Message-Id: <20190704160024.56600-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Second attempt at the PEBS-via-PT feature. The previous one is here [1].
This one depends on the legitimacy including exclusive events (PT, in this
case) in groups, as I posted earlier [2]. Although, it will work without
that patch, because this kind of grouping wasn't really disallowed.

The first problem with the previous patchset was bad handling of
conflicting PEBS events (PEBS->PT and PEBS->DS). This version fails to
schedule the first conflicting event, thus allowing conflicting events
to be rotated. This is done in an x86 perf patch 2/7.

The second problem was lack of guarantees that the PT event is scheduled
together with the PEBS->PT event and that it's the correct PT event. This
is addressed via grouping. The requirement is that the PEBS event is added
to a group where there is a PT event, then a link between them in created.
If that group later is broken down, the PEBS event will fail to schedule.
This is done in perf core patch 1/7.

The rest of the series (2/7..7/7) are the remaining tooling patches needed
to enable this are included.

The PEBS feature: output to Intel PT stream instead of the DS area. It's
theoretically useful in virtualized environments, where DS area can't be
used. It's also good for those who are interested in instruction trace for
context of the PEBS events. As PEBS goes, it can provide LBR context with
all the branch-related information that PT doesn't provide at the moment.

PEBS records are packetized in the PT stream, so instead of extracting
them in the PMI, we leave it to the perf tool, because real time PT
decoding is not practical.

[1] https://marc.info/?l=linux-kernel&m=155679423430002
[2] https://marc.info/?l=linux-kernel&m=156197929026646

Adrian Hunter (5):
  perf tools: Add aux_source attribute flag
  perf tools: Add itrace option 'o' to synthesize aux-source events
  perf intel-pt: Process options for PEBS event synthesis
  perf tools: Add aux-source config term
  perf intel-pt: Add brief documentation for PEBS via Intel PT

Alexander Shishkin (2):
  perf: Allow normal events to be sources of AUX data
  perf/x86/intel: Support PEBS output to PT

 arch/x86/events/core.c                   | 45 ++++++++++++
 arch/x86/events/intel/core.c             | 20 ++++++
 arch/x86/events/intel/ds.c               | 61 +++++++++++++++-
 arch/x86/events/perf_event.h             | 11 +++
 arch/x86/include/asm/msr-index.h         |  4 ++
 include/linux/perf_event.h               | 14 ++++
 include/uapi/linux/perf_event.h          |  3 +-
 kernel/events/core.c                     | 92 ++++++++++++++++++++++++
 tools/include/uapi/linux/perf_event.h    |  3 +-
 tools/perf/Documentation/intel-pt.txt    | 15 ++++
 tools/perf/Documentation/itrace.txt      |  2 +
 tools/perf/Documentation/perf-record.txt |  2 +
 tools/perf/arch/x86/util/intel-pt.c      | 23 ++++++
 tools/perf/util/auxtrace.c               |  4 ++
 tools/perf/util/auxtrace.h               |  3 +
 tools/perf/util/evsel.c                  |  4 ++
 tools/perf/util/evsel.h                  |  2 +
 tools/perf/util/intel-pt.c               | 18 +++++
 tools/perf/util/parse-events.c           |  8 +++
 tools/perf/util/parse-events.h           |  1 +
 tools/perf/util/parse-events.l           |  1 +
 21 files changed, 333 insertions(+), 3 deletions(-)

-- 
2.20.1

