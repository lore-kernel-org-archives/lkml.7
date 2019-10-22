Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9894DCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 05:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72C6F2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 05:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730959AbfJVF73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 01:59:29 -0400
Received: from mga06.intel.com ([134.134.136.31]:55889 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbfJVF72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 01:59:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2019 22:59:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,326,1566889200"; 
   d="scan'208";a="209598441"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 21 Oct 2019 22:59:27 -0700
Received: from [10.249.230.171] (abudanko-mobl.ccr.corp.intel.com [10.249.230.171])
        by linux.intel.com (Postfix) with ESMTP id E79C6580100;
        Mon, 21 Oct 2019 22:59:23 -0700 (PDT)
Subject: [PATCH v4 2/4] perf/x86: install platform specific sync_task_ctx
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
References: <f4662ac9-e72e-d141-bead-da07e29f81e8@linux.intel.com>
Organization: Intel Corp.
Message-ID: <359cc996-50bc-2ab3-5c66-f1e5135d08c2@linux.intel.com>
Date:   Tue, 22 Oct 2019 08:59:22 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <f4662ac9-e72e-d141-bead-da07e29f81e8@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Bridge perf core and x86 sync_task_ctx() method calls.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 arch/x86/events/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 7b21455d7504..f51bddf5f48c 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2243,6 +2243,12 @@ static void x86_pmu_sched_task(struct perf_event_context *ctx, bool sched_in)
 		x86_pmu.sched_task(ctx, sched_in);
 }
 
+static void x86_pmu_sync_task_ctx(void *prev, void *next)
+{
+	if (x86_pmu.sync_task_ctx)
+		x86_pmu.sync_task_ctx(prev, next);
+}
+
 void perf_check_microcode(void)
 {
 	if (x86_pmu.check_microcode)
@@ -2297,6 +2303,7 @@ static struct pmu pmu = {
 	.event_idx		= x86_pmu_event_idx,
 	.sched_task		= x86_pmu_sched_task,
 	.task_ctx_size          = sizeof(struct x86_perf_task_context),
+	.sync_task_ctx		= x86_pmu_sync_task_ctx,
 	.check_period		= x86_pmu_check_period,
 
 	.aux_output_match	= x86_pmu_aux_output_match,
-- 
2.20.1

