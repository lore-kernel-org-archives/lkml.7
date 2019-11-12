Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76AD4C17447
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 00:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 541C421E6F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 00:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfKLA7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 19:59:45 -0500
Received: from mga14.intel.com ([192.55.52.115]:61338 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727295AbfKLA7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 19:59:44 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Nov 2019 16:59:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,294,1569308400"; 
   d="scan'208";a="215864800"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga002.jf.intel.com with ESMTP; 11 Nov 2019 16:59:43 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 28682301A83; Mon, 11 Nov 2019 16:59:43 -0800 (PST)
From:   Andi Kleen <andi@firstfloor.org>
To:     jolsa@kernel.org
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v6 08/12] perf stat: Factor out open error handling
Date:   Mon, 11 Nov 2019 16:59:37 -0800
Message-Id: <20191112005941.649137-9-andi@firstfloor.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191112005941.649137-1-andi@firstfloor.org>
References: <20191112005941.649137-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Factor out the open error handling into a separate function.
This is useful for followon patches who need to duplicate this.

No behavior change intended.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/builtin-stat.c | 100 +++++++++++++++++++++++---------------
 1 file changed, 60 insertions(+), 40 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index c88d4e118409..1a586009e5a7 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -420,6 +420,57 @@ static bool is_target_alive(struct target *_target,
 	return false;
 }
 
+enum counter_recovery {
+	COUNTER_SKIP,
+	COUNTER_RETRY,
+	COUNTER_FATAL,
+};
+
+static enum counter_recovery stat_handle_error(struct evsel *counter)
+{
+	char msg[BUFSIZ];
+	/*
+	 * PPC returns ENXIO for HW counters until 2.6.37
+	 * (behavior changed with commit b0a873e).
+	 */
+	if (errno == EINVAL || errno == ENOSYS ||
+	    errno == ENOENT || errno == EOPNOTSUPP ||
+	    errno == ENXIO) {
+		if (verbose > 0)
+			ui__warning("%s event is not supported by the kernel.\n",
+				    perf_evsel__name(counter));
+		counter->supported = false;
+
+		if ((counter->leader != counter) ||
+		    !(counter->leader->core.nr_members > 1))
+			return COUNTER_SKIP;
+	} else if (perf_evsel__fallback(counter, errno, msg, sizeof(msg))) {
+		if (verbose > 0)
+			ui__warning("%s\n", msg);
+		return COUNTER_RETRY;
+	} else if (target__has_per_thread(&target) &&
+		   evsel_list->core.threads &&
+		   evsel_list->core.threads->err_thread != -1) {
+		/*
+		 * For global --per-thread case, skip current
+		 * error thread.
+		 */
+		if (!thread_map__remove(evsel_list->core.threads,
+					evsel_list->core.threads->err_thread)) {
+			evsel_list->core.threads->err_thread = -1;
+			return COUNTER_RETRY;
+		}
+	}
+
+	perf_evsel__open_strerror(counter, &target,
+				  errno, msg, sizeof(msg));
+	ui__error("%s\n", msg);
+
+	if (child_pid != -1)
+		kill(child_pid, SIGTERM);
+	return COUNTER_FATAL;
+}
+
 static int __run_perf_stat(int argc, const char **argv, int run_idx)
 {
 	int interval = stat_config.interval;
@@ -469,47 +520,16 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 				goto try_again;
 			}
 
-			/*
-			 * PPC returns ENXIO for HW counters until 2.6.37
-			 * (behavior changed with commit b0a873e).
-			 */
-			if (errno == EINVAL || errno == ENOSYS ||
-			    errno == ENOENT || errno == EOPNOTSUPP ||
-			    errno == ENXIO) {
-				if (verbose > 0)
-					ui__warning("%s event is not supported by the kernel.\n",
-						    perf_evsel__name(counter));
-				counter->supported = false;
-
-				if ((counter->leader != counter) ||
-				    !(counter->leader->core.nr_members > 1))
-					continue;
-			} else if (perf_evsel__fallback(counter, errno, msg, sizeof(msg))) {
-                                if (verbose > 0)
-                                        ui__warning("%s\n", msg);
-                                goto try_again;
-			} else if (target__has_per_thread(&target) &&
-				   evsel_list->core.threads &&
-				   evsel_list->core.threads->err_thread != -1) {
-				/*
-				 * For global --per-thread case, skip current
-				 * error thread.
-				 */
-				if (!thread_map__remove(evsel_list->core.threads,
-							evsel_list->core.threads->err_thread)) {
-					evsel_list->core.threads->err_thread = -1;
-					goto try_again;
-				}
+			switch (stat_handle_error(counter)) {
+			case COUNTER_FATAL:
+				return -1;
+			case COUNTER_RETRY:
+				goto try_again;
+			case COUNTER_SKIP:
+				continue;
+			default:
+				break;
 			}
-
-			perf_evsel__open_strerror(counter, &target,
-						  errno, msg, sizeof(msg));
-			ui__error("%s\n", msg);
-
-			if (child_pid != -1)
-				kill(child_pid, SIGTERM);
-
-			return -1;
 		}
 		counter->supported = true;
 
-- 
2.23.0

