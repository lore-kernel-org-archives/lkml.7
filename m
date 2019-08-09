Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7B9C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 746142086A
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436607AbfHIPbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 11:31:33 -0400
Received: from mga01.intel.com ([192.55.52.88]:28149 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbfHIPbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 11:31:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2019 08:31:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,364,1559545200"; 
   d="scan'208";a="326657867"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 09 Aug 2019 08:31:32 -0700
Received: from [10.252.0.91] (abudanko-mobl.ccr.corp.intel.com [10.252.0.91])
        by linux.intel.com (Postfix) with ESMTP id 8BED45801AB;
        Fri,  9 Aug 2019 08:31:29 -0700 (PDT)
Subject: [PATCH v1 3/3] perf report: prefer dwarf callstacks to LBR ones when
 captured both
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        "Jin, Yao" <yao.jin@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <ec5fe6b1-a116-fb60-42c6-dc8a9dedfc15@linux.intel.com>
Organization: Intel Corp.
Message-ID: <ccbd9583-82f4-dec5-7e84-64bf56e351fb@linux.intel.com>
Date:   Fri, 9 Aug 2019 18:31:28 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ec5fe6b1-a116-fb60-42c6-dc8a9dedfc15@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Display dwarf based callchains when Perf trace contains as raw thread
stack data as LBR callstack data.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-report.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index d4288dcce156..5ecac3a1ed5b 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1271,6 +1271,8 @@ int cmd_report(int argc, const char **argv)
 
 	has_br_stack = perf_header__has_feat(&session->header,
 					     HEADER_BRANCH_STACK);
+	if (perf_evlist__combined_sample_type(session->evlist) & PERF_SAMPLE_STACK_USER)
+		has_br_stack = false;
 
 	setup_forced_leader(&report, session->evlist);
 
-- 
2.20.1

