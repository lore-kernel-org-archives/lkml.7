Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD41C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 03:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BED8A2171F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 03:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfCLDwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 23:52:35 -0400
Received: from mga11.intel.com ([192.55.52.93]:16016 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbfCLDwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 23:52:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2019 20:52:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,469,1544515200"; 
   d="scan'208";a="121867592"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga007.jf.intel.com with ESMTP; 11 Mar 2019 20:52:29 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 48F27301E34; Mon, 11 Mar 2019 20:52:29 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 2/3] perf, tools, report: Pass on -f to child perf script
Date:   Mon, 11 Mar 2019 20:52:23 -0700
Message-Id: <20190312035224.30350-3-andi@firstfloor.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190312035224.30350-1-andi@firstfloor.org>
References: <20190312035224.30350-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Pass on -f to the child perf script, so that it can read the perf.data
file if it's owned by a different user.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/ui/browsers/res_sample.c | 3 ++-
 tools/perf/ui/browsers/scripts.c    | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/ui/browsers/res_sample.c b/tools/perf/ui/browsers/res_sample.c
index c450a3536f10..6e17e11a2ab9 100644
--- a/tools/perf/ui/browsers/res_sample.c
+++ b/tools/perf/ui/browsers/res_sample.c
@@ -70,7 +70,7 @@ int res_sample_browse(struct res_sample *res_samples, int num_res,
 
 	attr_to_script(extra_format, &evsel->attr);
 
-	if (asprintf(&cmd, "%s script %s%s --time %s %s%s %s%s --ns %s %s %s %s %s | less +/%s",
+	if (asprintf(&cmd, "%s script %s%s --time %s %s%s %s%s --ns %s %s %s %s %s %s | less +/%s",
 		     perf,
 		     input_name ? "-i " : "",
 		     input_name ? input_name : "",
@@ -85,6 +85,7 @@ int res_sample_browse(struct res_sample *res_samples, int num_res,
 		     symbol_conf.inline_name ? "--inline" : "",
 		     "--show-lost-events ",
 		     r->tid ? "--show-switch-events --show-task-events " : "",
+		     symbol_conf.force ? "-f" : "",
 		     tsample) < 0)
 		return -1;
 	run_script(cmd);
diff --git a/tools/perf/ui/browsers/scripts.c b/tools/perf/ui/browsers/scripts.c
index 27cf3ab88d13..f4c438dead66 100644
--- a/tools/perf/ui/browsers/scripts.c
+++ b/tools/perf/ui/browsers/scripts.c
@@ -171,12 +171,13 @@ int script_browse(const char *script_opt, struct perf_evsel *evsel)
 	if (list_scripts(script_name, &custom, evsel))
 		return -1;
 
-	if (asprintf(&cmd, "%s%s %s %s%s 2>&1 | less",
+	if (asprintf(&cmd, "%s%s %s %s%s %s 2>&1 | less",
 			custom ? "perf script -s " : "",
 			script_name,
 			script_opt ? script_opt : "",
 			input_name ? "-i " : "",
-			input_name ? input_name : "") < 0)
+			input_name ? input_name : "",
+			symbol_conf.force ? "-f " : "") < 0)
 		return -1;
 
 	run_script(cmd);
-- 
2.20.1

