Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E79CA9EAE
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 07:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D35FE2084C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 07:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389757AbfJWHLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 03:11:11 -0400
Received: from mga09.intel.com ([134.134.136.24]:58107 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389733AbfJWHLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 03:11:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 00:11:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,219,1569308400"; 
   d="scan'208";a="201047833"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 23 Oct 2019 00:11:09 -0700
Received: from [10.249.230.188] (abudanko-mobl.ccr.corp.intel.com [10.249.230.188])
        by linux.intel.com (Postfix) with ESMTP id 282BE58048F;
        Wed, 23 Oct 2019 00:11:05 -0700 (PDT)
Subject: [PATCH v5 1/4] perf/core,x86: introduce swap_task_ctx() method at
 struct pmu
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Song Liu <songliubraving@fb.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <f8d5a880-38e5-29f4-9e6a-848f70a67988@linux.intel.com>
Organization: Intel Corp.
Message-ID: <9a0aa84a-f062-9b64-3133-373658550c4b@linux.intel.com>
Date:   Wed, 23 Oct 2019 10:11:04 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <f8d5a880-38e5-29f4-9e6a-848f70a67988@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Declare swap_task_ctx() methods at the generic and x86 specific
pmu types to bridge calls to platform specific pmu code on optimized
context switch path between equivalent task perf event contexts.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 arch/x86/events/perf_event.h | 8 ++++++++
 include/linux/perf_event.h   | 9 +++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index ecacfbf4ebc1..5384317eaa16 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -682,6 +682,14 @@ struct x86_pmu {
 	 */
 	atomic_t	lbr_exclusive[x86_lbr_exclusive_max];
 
+	/*
+	 * perf task context (i.e. struct perf_event_context::task_ctx_data)
+	 * switch helper to bridge calls from perf/core to perf/x86.
+	 * See struct pmu::swap_task_ctx() usage for examples;
+	 */
+	void		(*swap_task_ctx)(struct perf_event_context *prev,
+					 struct perf_event_context *next);
+
 	/*
 	 * AMD bits
 	 */
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 587ae4d002f5..7887e4a3d487 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -410,6 +410,15 @@ struct pmu {
 	 */
 	size_t				task_ctx_size;
 
+	/*
+	 * PMU specific parts of task perf event context (i.e. ctx->task_ctx_data)
+	 * can be synchronized using this function. See Intel LBR callstack support
+	 * implementation and Perf core context switch handling callbacks for usage
+	 * examples.
+	 */
+	void (*swap_task_ctx)		(struct perf_event_context *prev,
+					 struct perf_event_context *next);
+					/* optional */
 
 	/*
 	 * Set up pmu-private data structures for an AUX area
-- 
2.20.1

