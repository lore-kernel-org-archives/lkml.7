Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDAEC282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 07:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84FE207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 07:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388194AbfFJH3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 03:29:48 -0400
Received: from mga01.intel.com ([192.55.52.88]:14549 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388150AbfFJH3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 03:29:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jun 2019 00:29:38 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by orsmga006.jf.intel.com with ESMTP; 10 Jun 2019 00:29:36 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] perf intel-pt: Add memory information to synthesized PEBS sample
Date:   Mon, 10 Jun 2019 10:28:02 +0300
Message-Id: <20190610072803.10456-11-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190610072803.10456-1-adrian.hunter@intel.com>
References: <20190610072803.10456-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add memory information from PEBS data in the Intel PT trace to the
synthesized PEBS sample. This provides sample types PERF_SAMPLE_ADDR,
PERF_SAMPLE_WEIGHT, and PERF_SAMPLE_TRANSACTION, but not
PERF_SAMPLE_DATA_SRC.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/intel-pt.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index a73d92189b45..0b7beb98a028 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1662,6 +1662,33 @@ static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
 		}
 	}
 
+	if (sample_type & PERF_SAMPLE_ADDR && items->has_mem_access_address)
+		sample.addr = items->mem_access_address;
+
+	if (sample_type & PERF_SAMPLE_WEIGHT) {
+		/*
+		 * Refer kernel's setup_pebs_adaptive_sample_data() and
+		 * intel_hsw_weight().
+		 */
+		if (items->has_mem_access_latency)
+			sample.weight = items->mem_access_latency;
+		if (!sample.weight && items->has_tsx_aux_info) {
+			/* Cycles last block */
+			sample.weight = (u32)items->tsx_aux_info;
+		}
+	}
+
+	if (sample_type & PERF_SAMPLE_TRANSACTION && items->has_tsx_aux_info) {
+		u64 ax = items->has_rax ? items->rax : 0;
+		/* Refer kernel's intel_hsw_transaction() */
+		u64 txn = (u8)(items->tsx_aux_info >> 32);
+
+		/* For RTM XABORTs also log the abort code from AX */
+		if (txn & PERF_TXN_TRANSACTION && ax & 1)
+			txn |= ((ax >> 24) & 0xff) << PERF_TXN_ABORT_SHIFT;
+		sample.transaction = txn;
+	}
+
 	return intel_pt_deliver_synth_event(pt, ptq, event, &sample, sample_type);
 }
 
-- 
2.17.1

