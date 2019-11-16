Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4D1C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 05:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A16A22084F
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 05:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfKPFwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 00:52:46 -0500
Received: from mga18.intel.com ([134.134.136.126]:37647 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbfKPFwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 00:52:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2019 21:52:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,311,1569308400"; 
   d="scan'208";a="214916243"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga001.fm.intel.com with ESMTP; 15 Nov 2019 21:52:44 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 08AD0300FFC; Fri, 15 Nov 2019 21:52:44 -0800 (PST)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v7 08/12] perf stat: Factor out open error handling
Date:   Fri, 15 Nov 2019 21:52:25 -0800
Message-Id: <20191116055229.62002-9-andi@firstfloor.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191116055229.62002-1-andi@firstfloor.org>
References: <20191116055229.62002-1-andi@firstfloor.org>
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
index 5964e808d73d..982246cf5cf4 100644
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

