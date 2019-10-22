Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96363CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73A4F20B7C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731552AbfJVJ6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 05:58:39 -0400
Received: from mga12.intel.com ([192.55.52.136]:26087 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731220AbfJVJ6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 05:58:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2019 02:58:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,326,1566889200"; 
   d="scan'208";a="197074450"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 22 Oct 2019 02:58:36 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, adrian.hunter@intel.com,
        mathieu.poirier@linaro.org, mark.rutland@arm.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v2 0/4] perf: Add AUX data sampling
Date:   Tue, 22 Oct 2019 12:58:08 +0300
Message-Id: <20191022095812.67071-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Here's a new version of the AUX sampling. Since the previous one [3],
it addresses the issues of NMI-safety and sampling hardware events.
The former is addressed by adding a new PMU callback, the latter by
making use of grouping. It also depends on the AUX output stop fix
[4] to work correctly. I decided to post them separately, because [4]
is also a candidate for perf/urgent.

This series introduces AUX data sampling for perf events, which in
case of our instruction/branch tracing PMUs like Intel PT, BTS, CS
ETM means execution flow history leading up to a perf event's
overflow.

In case of Intel PT, this can be used as an alternative to LBR, with
virtually as many as you like branches per sample. It doesn't support
some of the LBR features (branch prediction indication, basic block
level timing, etc [1]) and it can't be exposed as BRANCH_STACK, because
that would require decoding PT stream in kernel space, which is not
practical. Instead, we deliver the PT data to userspace as is, for
offline processing. The PT decoder already supports presenting PT as
virtual LBR.

AUX sampling is different from the snapshot mode in that it doesn't
require instrumentation (for when to take a snapshot) and is better
for generic data collection, when you don't yet know what you are
looking for. It's also useful for automated data collection, for
example, for feedback-driven compiler optimizaitions.

It's also different from the "full trace mode" in that it produces
much less data and, consequently, takes up less I/O bandwidth and
storage space, and takes less time to decode.

The bulk of code is in 1/4, which adds the user interface bits and
the code to measure and copy out AUX data. 3/4 adds PT side support
for sampling. 4/4 is not strictly related, but makes an improvement
to the PT's snapshot mode by implementing a simpler buffer management
that would also benefit the sampling.

The tooling support is ready, although I'm not including it here to
save the bandwidth. Adrian or I will post itseparately. Meanwhile,
it can be found here [2].

[1] https://marc.info/?l=linux-kernel&m=147467007714928&w=2
[2] https://git.kernel.org/cgit/linux/kernel/git/ash/linux.git/log/?h=perf-aux-sampling
[3] https://marc.info/?l=linux-kernel&m=152878999928771
[4] https://marc.info/?l=linux-kernel&m=157172999231707

Alexander Shishkin (4):
  perf: Allow using AUX data in perf samples
  perf/x86/intel/pt: Factor out starting the trace
  perf/x86/intel/pt: Add sampling support
  perf/x86/intel/pt: Opportunistically use single range output mode

 arch/x86/events/intel/pt.c      | 192 ++++++++++++++++++++++++++------
 arch/x86/events/intel/pt.h      |   2 +
 include/linux/perf_event.h      |  20 ++++
 include/uapi/linux/perf_event.h |   7 +-
 kernel/events/core.c            | 159 +++++++++++++++++++++++++-
 kernel/events/internal.h        |   1 +
 kernel/events/ring_buffer.c     |  36 ++++++
 7 files changed, 380 insertions(+), 37 deletions(-)

-- 
2.23.0

