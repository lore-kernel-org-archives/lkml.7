Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A928C43215
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F380207DD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575381484;
	bh=IrLpZ2UHKbC6Xn8lyJxmNoUkNe51oQQ+qRh3tyfd9DA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wEC+Z/aKGUBJrnhwpWygali8weMdMgxQsDkhKzFmik6nIC3ua2jtdE/j1kMIL3e1Y
	 GjN9l4+gIGpkKubL8k/tR+PavLpd3C1GpDkDY3C8ltErpYephXGgjqtOzUL2MHMc6Z
	 BqFF7v5qFLxEmXOjOuobP7ELv5DPCf87vIfVAUBg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfLCN6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 08:58:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:34416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbfLCN4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 08:56:32 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 134F22080A;
        Tue,  3 Dec 2019 13:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575381391;
        bh=IrLpZ2UHKbC6Xn8lyJxmNoUkNe51oQQ+qRh3tyfd9DA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hXpH0h3Bn7cY66KsZBXIw+8Msfk1PQmJhcYjVjp+ea5szELcnDKztfA9DZbABj7Q7
         Xnp8xyIrVUV0k34ZRqHYSF0wCdWdGXBXzw8IU3xR39IXCPxLfLWx2mFkZGYXFw+vEE
         5PBQaWOKuAtrIS42hvx1frsirgrBztTLpBS9yhV0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 06/23] perf stat: Factor out open error handling
Date:   Tue,  3 Dec 2019 10:55:49 -0300
Message-Id: <20191203135606.24902-7-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191203135606.24902-1-acme@kernel.org>
References: <20191203135606.24902-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Factor out the open error handling into a separate function.  This is
useful for followon patches who need to duplicate this.

No behavior change intended.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lore.kernel.org/lkml/20191121001522.180827-9-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 100 +++++++++++++++++++++++---------------
 1 file changed, 60 insertions(+), 40 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 0a15253b438c..1d9d7161815e 100644
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
2.21.0

