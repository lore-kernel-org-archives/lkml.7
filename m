Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796FFCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5682A20663
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503211AbfJYOIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 10:08:53 -0400
Received: from mga11.intel.com ([192.55.52.93]:57127 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405748AbfJYOIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 10:08:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 07:08:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,228,1569308400"; 
   d="scan'208";a="350035369"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 25 Oct 2019 07:08:48 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, adrian.hunter@intel.com,
        mathieu.poirier@linaro.org, mark.rutland@arm.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v3 0/3] perf: Add AUX data sampling
Date:   Fri, 25 Oct 2019 17:08:32 +0300
Message-Id: <20191025140835.53665-1-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Here's another version of the AUX sampling, addressing all the comments
from the previous one [5]: fixed group leader refcount leak if both
aux_source and aux_sample_size are set, changed aux_sample_size to u32
in the ABI and removed the pointless sample init bit. Also dropped 4/4
from this series, will send separately. This one has a context dependency
on the attr.__reserved_2 fix [6], as it adds one more reserved bit.

Changes since version one [3]: it addresses the issues of NMI-safety
and sampling hardware events. The former is addressed by adding a new
PMU callback, the latter by making use of grouping. It also depends
on the AUX output stop fix [4] to work correctly. I decided to post
them separately, because [4] is also a candidate for perf/urgent.

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
save the bandwidth. Adrian or I will post it separately. Meanwhile,
it can be found here [2], updated to reflect the ABI change.

[1] https://marc.info/?l=linux-kernel&m=147467007714928&w=2
[2] https://git.kernel.org/cgit/linux/kernel/git/ash/linux.git/log/?h=perf-aux-sampling
[3] https://marc.info/?l=linux-kernel&m=152878999928771
[4] https://marc.info/?l=linux-kernel&m=157172999231707
[5] https://marc.info/?l=linux-kernel&m=157173832302445
[6] https://marc.info/?l=linux-kernel&m=157200581818800

Alexander Shishkin (3):
  perf: Allow using AUX data in perf samples
  perf/x86/intel/pt: Factor out starting the trace
  perf/x86/intel/pt: Add sampling support

 arch/x86/events/intel/pt.c      |  76 ++++++++++++--
 include/linux/perf_event.h      |  19 ++++
 include/uapi/linux/perf_event.h |  10 +-
 kernel/events/core.c            | 172 +++++++++++++++++++++++++++++++-
 kernel/events/internal.h        |   1 +
 kernel/events/ring_buffer.c     |  36 +++++++
 6 files changed, 303 insertions(+), 11 deletions(-)

-- 
2.23.0

