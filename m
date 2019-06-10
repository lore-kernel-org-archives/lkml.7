Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873D4C282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 07:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA50207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 07:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388181AbfFJH3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 03:29:43 -0400
Received: from mga01.intel.com ([192.55.52.88]:14549 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388149AbfFJH3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 03:29:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jun 2019 00:29:40 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by orsmga006.jf.intel.com with ESMTP; 10 Jun 2019 00:29:38 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] perf intel-pt: Add callchain to synthesized PEBS sample
Date:   Mon, 10 Jun 2019 10:28:03 +0300
Message-Id: <20190610072803.10456-12-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190610072803.10456-1-adrian.hunter@intel.com>
References: <20190610072803.10456-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like other synthesized events, if there is also an Intel PT branch trace,
then a call stack can also be synthesized.  Add that.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/intel-pt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 0b7beb98a028..ea03bdaf8009 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1626,6 +1626,14 @@ static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
 			sample.time = tsc_to_perf_time(timestamp, &pt->tc);
 	}
 
+	if (sample_type & PERF_SAMPLE_CALLCHAIN &&
+	    pt->synth_opts.callchain) {
+		thread_stack__sample(ptq->thread, ptq->cpu, ptq->chain,
+				     pt->synth_opts.callchain_sz, sample.ip,
+				     pt->kernel_start);
+		sample.callchain = ptq->chain;
+	}
+
 	if (sample_type & PERF_SAMPLE_REGS_INTR &&
 	    items->mask[INTEL_PT_GP_REGS_POS]) {
 		u64 regs[sizeof(sample.intr_regs.mask)];
-- 
2.17.1

