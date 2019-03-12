Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0FDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C849B20657
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 12:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfCLMcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 08:32:15 -0400
Received: from mga07.intel.com ([134.134.136.100]:46475 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbfCLMcP (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 08:32:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2019 05:32:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,471,1544515200"; 
   d="scan'208";a="281941359"
Received: from skl.sh.intel.com ([10.239.159.132])
  by orsmga004.jf.intel.com with ESMTP; 12 Mar 2019 05:32:12 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH] perf annotate: Remove hist__account_cycles from callback
Date:   Wed, 13 Mar 2019 04:22:54 +0800
Message-Id: <1552422174-27622-1-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hist__account_cycles is executed when the hist_iter__branch_callback
is called. But it looks it's not necessary. In hist__account_cycles, it
already walks on all branch entries.

This patch moves the hist__account_cycles out of callback, now the data
processing is much faster than before.

For example,
perf record -b ...
perf annotate

The before/after output should be no change.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-annotate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 67f9d9f..77deb3a 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -159,8 +159,6 @@ static int hist_iter__branch_callback(struct hist_entry_iter *iter,
 	struct perf_evsel *evsel = iter->evsel;
 	int err;
 
-	hist__account_cycles(sample->branch_stack, al, sample, false);
-
 	bi = he->branch_info;
 	err = addr_map_symbol__inc_samples(&bi->from, sample, evsel);
 
@@ -199,6 +197,8 @@ static int process_branch_callback(struct perf_evsel *evsel,
 	if (a.map != NULL)
 		a.map->dso->hit = 1;
 
+	hist__account_cycles(sample->branch_stack, al, sample, false);
+
 	ret = hist_entry_iter__add(&iter, &a, PERF_MAX_STACK_DEPTH, ann);
 	return ret;
 }
-- 
2.7.4

