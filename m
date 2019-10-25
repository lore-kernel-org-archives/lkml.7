Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7440CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87BFA21D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408067AbfJYI7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 04:59:06 -0400
Received: from mga01.intel.com ([192.55.52.88]:1920 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405717AbfJYI7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 04:59:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 01:59:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,228,1569308400"; 
   d="scan'208";a="282203232"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 25 Oct 2019 01:59:05 -0700
Received: from [10.125.252.238] (abudanko-mobl.ccr.corp.intel.com [10.125.252.238])
        by linux.intel.com (Postfix) with ESMTP id 778F458042B;
        Fri, 25 Oct 2019 01:59:02 -0700 (PDT)
Subject: [PATCH v5 2/4] perf/x86: install platform specific swap_task_ctx
 adapter
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
References: <6fa20503-b5ad-16c7-260e-5243509176bc@linux.intel.com>
Organization: Intel Corp.
Message-ID: <073ee661-72cb-b046-4b10-d13cf5c3789b@linux.intel.com>
Date:   Fri, 25 Oct 2019 11:59:01 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <6fa20503-b5ad-16c7-260e-5243509176bc@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Bridge perf core and x86 swap_task_ctx() method calls.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 arch/x86/events/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 7b21455d7504..6e3f0c18908e 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2243,6 +2243,13 @@ static void x86_pmu_sched_task(struct perf_event_context *ctx, bool sched_in)
 		x86_pmu.sched_task(ctx, sched_in);
 }
 
+static void x86_pmu_swap_task_ctx(struct perf_event_context *prev,
+				  struct perf_event_context *next)
+{
+	if (x86_pmu.swap_task_ctx)
+		x86_pmu.swap_task_ctx(prev, next);
+}
+
 void perf_check_microcode(void)
 {
 	if (x86_pmu.check_microcode)
@@ -2297,6 +2304,7 @@ static struct pmu pmu = {
 	.event_idx		= x86_pmu_event_idx,
 	.sched_task		= x86_pmu_sched_task,
 	.task_ctx_size          = sizeof(struct x86_perf_task_context),
+	.swap_task_ctx		= x86_pmu_swap_task_ctx,
 	.check_period		= x86_pmu_check_period,
 
 	.aux_output_match	= x86_pmu_aux_output_match,
-- 
2.20.1

