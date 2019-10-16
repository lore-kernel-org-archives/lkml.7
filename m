Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD4AFA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08ECB218DE
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393919AbfJPOZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 10:25:27 -0400
Received: from mga11.intel.com ([192.55.52.93]:59852 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726750AbfJPOZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 10:25:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2019 07:25:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,304,1566889200"; 
   d="scan'208";a="207926414"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 16 Oct 2019 07:25:25 -0700
Received: from [10.125.252.157] (abudanko-mobl.ccr.corp.intel.com [10.125.252.157])
        by linux.intel.com (Postfix) with ESMTP id A73F2580375;
        Wed, 16 Oct 2019 07:25:22 -0700 (PDT)
Subject: [PATCH v3 1/4] perf/core,x86: introduce sync_task_ctx() method at
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
References: <792a98c7-ed89-6c35-f1d7-98ddc9c1a117@linux.intel.com>
Organization: Intel Corp.
Message-ID: <0c94f0d8-67de-00d4-941f-19062eb0c592@linux.intel.com>
Date:   Wed, 16 Oct 2019 17:25:21 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <792a98c7-ed89-6c35-f1d7-98ddc9c1a117@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Declare sync_task_ctx() methods at the generic and x86 specific
pmu types to bridge calls to platform specific pmu code on optimized
context switch path between equivalent task perf event contexts.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 arch/x86/events/perf_event.h | 8 ++++++++
 include/linux/perf_event.h   | 7 +++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index ecacfbf4ebc1..a25e6d7eb87b 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -682,6 +682,14 @@ struct x86_pmu {
 	 */
 	atomic_t	lbr_exclusive[x86_lbr_exclusive_max];
 
+	/*
+	 * perf task context (i.e. struct perf_event_context::task_ctx_data) switch helper
+	 * to bridge calls from perf/core to perf/x86. See struct pmu::sync_task_ctx() usage
+	 * for examples;
+	 */
+	void		(*sync_task_ctx)(struct x86_perf_task_context *one,
+					 struct x86_perf_task_context *another);
+
 	/*
 	 * AMD bits
 	 */
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 61448c19a132..60bf17af69f0 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -409,6 +409,13 @@ struct pmu {
 	 */
 	size_t				task_ctx_size;
 
+	/*
+	 * PMU specific parts of task perf event context (i.e. ctx->task_ctx_data)
+	 * can be synchronized using this function. See Intel LBR callstack support
+	 * implementation and Perf core context switch handling callbacks for usage
+	 * examples.
+	 */
+	void (*sync_task_ctx)		(void *one, void *another);
 
 	/*
 	 * Set up pmu-private data structures for an AUX area
-- 
2.20.1

