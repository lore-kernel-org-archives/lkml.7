Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB30C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A57218A6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 16:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfGDQAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 12:00:42 -0400
Received: from mga03.intel.com ([134.134.136.65]:53366 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727087AbfGDQAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 12:00:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2019 09:00:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,451,1557212400"; 
   d="scan'208";a="185016981"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Jul 2019 09:00:37 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kan.liang@linux.intel.com, Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH v1 4/7] perf tools: Add itrace option 'o' to synthesize aux-source events
Date:   Thu,  4 Jul 2019 19:00:21 +0300
Message-Id: <20190704160024.56600-5-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190704160024.56600-1-alexander.shishkin@linux.intel.com>
References: <20190704160024.56600-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Add itrace option 'o' to synthesize events recorded in the AUX area due to
the use of perf record's aux-source config term.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 tools/perf/Documentation/itrace.txt | 2 ++
 tools/perf/util/auxtrace.c          | 4 ++++
 tools/perf/util/auxtrace.h          | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/tools/perf/Documentation/itrace.txt b/tools/perf/Documentation/itrace.txt
index c2182cbabde3..a9d1ff65e52b 100644
--- a/tools/perf/Documentation/itrace.txt
+++ b/tools/perf/Documentation/itrace.txt
@@ -5,6 +5,8 @@
 		x	synthesize transactions events
 		w	synthesize ptwrite events
 		p	synthesize power events
+		o	synthesize other events recorded due to the use
+			of aux-source (refer to perf record)
 		e	synthesize error events
 		d	create a debug log
 		g	synthesize a call chain (use with i or x)
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index bc215fe0b4b4..0262ac393fa5 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -964,6 +964,7 @@ void itrace_synth_opts__set_default(struct itrace_synth_opts *synth_opts,
 	synth_opts->transactions = true;
 	synth_opts->ptwrites = true;
 	synth_opts->pwr_events = true;
+	synth_opts->other_events = true;
 	synth_opts->errors = true;
 	if (no_sample) {
 		synth_opts->period_type = PERF_ITRACE_PERIOD_INSTRUCTIONS;
@@ -1061,6 +1062,9 @@ int itrace_parse_synth_opts(const struct option *opt, const char *str,
 		case 'p':
 			synth_opts->pwr_events = true;
 			break;
+		case 'o':
+			synth_opts->other_events = true;
+			break;
 		case 'e':
 			synth_opts->errors = true;
 			break;
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index e9b4c5edf78b..2690791974b0 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -60,6 +60,8 @@ enum itrace_period_type {
  * @transactions: whether to synthesize events for transactions
  * @ptwrites: whether to synthesize events for ptwrites
  * @pwr_events: whether to synthesize power events
+ * @other_events: whether to synthesize other events recorded due to the use of
+ *                aux_source
  * @errors: whether to synthesize decoder error events
  * @dont_decode: whether to skip decoding entirely
  * @log: write a decoding log
@@ -86,6 +88,7 @@ struct itrace_synth_opts {
 	bool			transactions;
 	bool			ptwrites;
 	bool			pwr_events;
+	bool			other_events;
 	bool			errors;
 	bool			dont_decode;
 	bool			log;
-- 
2.20.1

