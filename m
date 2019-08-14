Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EF6C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ABA02173B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565808306;
	bh=HipDK+C9VeDnmcBpthzXRqjh9O/54bSJBN0rvE/Vw/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YUNK2dSs6PZBhllLs2K6Kl2JrY4KqCK6fEuv8+RplgoVjGvpmVDt0KihIfPnALny3
	 Wf2jtv4JqRcC1DGR5S57ZM1GiQqPApMfDZEBiL28xasRPZWcMGfbpj4MIcw9b5vz5c
	 v7uc0OA+VTG8nAgx6A6sRB+yrs2Z+SIV3a4jSzis=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbfHNSpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:45:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:54824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728265AbfHNSpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:45:04 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.212.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91B3D2084F;
        Wed, 14 Aug 2019 18:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565808303;
        bh=HipDK+C9VeDnmcBpthzXRqjh9O/54bSJBN0rvE/Vw/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pOQU/CEPSj5PQBdCHiKseJTteQT4qPmsp3XjUTyRcKci0mr+thDYbmaFap/9Q8YsI
         ZIAfGiX0EKK279fuJAMWXpdRSPO+ULDM2YMns22Rjs+e55KDd3HUdjynN8x+MqsHE+
         lJhkQABiR9TDrP5gVpOb2lg4QC6w/0J+4gwjQ4Nw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 20/28] perf tools: Add itrace option 'o' to synthesize aux-output events
Date:   Wed, 14 Aug 2019 15:40:43 -0300
Message-Id: <20190814184051.3125-21-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190814184051.3125-1-acme@kernel.org>
References: <20190814184051.3125-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Add itrace option 'o' to synthesize events recorded in the AUX area due
to the use of perf record's aux-output config term.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190806084606.4021-5-alexander.shishkin@linux.intel.com
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/itrace.txt | 2 ++
 tools/perf/util/auxtrace.c          | 4 ++++
 tools/perf/util/auxtrace.h          | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/tools/perf/Documentation/itrace.txt b/tools/perf/Documentation/itrace.txt
index c2182cbabde3..82ff7dad40c2 100644
--- a/tools/perf/Documentation/itrace.txt
+++ b/tools/perf/Documentation/itrace.txt
@@ -5,6 +5,8 @@
 		x	synthesize transactions events
 		w	synthesize ptwrite events
 		p	synthesize power events
+		o	synthesize other events recorded due to the use
+			of aux-output (refer to perf record)
 		e	synthesize error events
 		d	create a debug log
 		g	synthesize a call chain (use with i or x)
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 72ce4c5e7c78..60428576426e 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -974,6 +974,7 @@ void itrace_synth_opts__set_default(struct itrace_synth_opts *synth_opts,
 	synth_opts->transactions = true;
 	synth_opts->ptwrites = true;
 	synth_opts->pwr_events = true;
+	synth_opts->other_events = true;
 	synth_opts->errors = true;
 	if (no_sample) {
 		synth_opts->period_type = PERF_ITRACE_PERIOD_INSTRUCTIONS;
@@ -1071,6 +1072,9 @@ int itrace_parse_synth_opts(const struct option *opt, const char *str,
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
index 8ccabacd0b11..8e637ac3918e 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -60,6 +60,8 @@ enum itrace_period_type {
  * @transactions: whether to synthesize events for transactions
  * @ptwrites: whether to synthesize events for ptwrites
  * @pwr_events: whether to synthesize power events
+ * @other_events: whether to synthesize other events recorded due to the use of
+ *                aux_output
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
2.21.0

