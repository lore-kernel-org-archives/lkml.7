Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2FFC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2685721721
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565808380;
	bh=IAl4vRgOmf+cdoEXQV0HZR0Nc3laFUyyaAEbIjD6jrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X3Xgdi4Fdi6tQsJuUx3Qr4MdmwBUzFzRkQTNd8xGAQyiyHVOiWvdcURho+EbAnxUY
	 YXJRlyQ7Epqq1VqILbdxGM7B9x3jigcfO7oYkFXDdUrG0ffsT6dx1CYzL/IW8HXQ7w
	 qYhPgSOymXEfy9o5Vx+7ZzRSs9FGvRnSipdQIU74=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbfHNSqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:46:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:55312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728713AbfHNSqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:46:18 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.212.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50090216F4;
        Wed, 14 Aug 2019 18:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565808377;
        bh=IAl4vRgOmf+cdoEXQV0HZR0Nc3laFUyyaAEbIjD6jrQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wZGOsQlfe4iNjOaipHMUj2Bp8o3rmGAf4aNfLv80KnuvGPWtMQ7taFKfLHf/02JeK
         fQ1qV+38TP5LBC9tomVheN33ldkEODYW7IxQuIB22GIcdMXnJRc8eRVm/Uhz76Buo9
         iTG/HDVBwoI+bODvqTQu0y7bIyM3Qfk/MWgEnbWA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 24/28] perf evsel: Provide meaningful warning when trying to use 'aux_output' on older kernels
Date:   Wed, 14 Aug 2019 15:40:47 -0300
Message-Id: <20190814184051.3125-25-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190814184051.3125-1-acme@kernel.org>
References: <20190814184051.3125-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Just like we do with the 'write_backwards' feature:

Before:

  # perf record -e {intel_pt/branch=0/,cycles/aux-output/ppp} uname
  Error:
  The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (cycles/aux-output/ppp).
  /bin/dmesg | grep -i perf may provide additional information.

  #

After:

  # perf record -e {intel_pt/branch=0/,cycles/aux-output/ppp} uname
  Error:
  The 'aux_output' feature is not supported, update the kernel.
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/n/tip-wgjsjroe1e150c0metgwmqwd@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 11 +++++++++--
 tools/perf/util/evsel.h |  1 +
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 5da40511546b..0a33f7322ecc 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1738,7 +1738,8 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 	int pid = -1, err;
 	enum { NO_CHANGE, SET_TO_MAX, INCREASED_MAX } set_rlimit = NO_CHANGE;
 
-	if (perf_missing_features.write_backward && evsel->core.attr.write_backward)
+	if ((perf_missing_features.write_backward && evsel->core.attr.write_backward) ||
+	    (perf_missing_features.aux_output     && evsel->core.attr.aux_output))
 		return -EINVAL;
 
 	if (cpus == NULL) {
@@ -1912,7 +1913,11 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 	 * Must probe features in the order they were added to the
 	 * perf_event_attr interface.
 	 */
-	if (!perf_missing_features.bpf_event && evsel->core.attr.bpf_event) {
+	if (!perf_missing_features.aux_output && evsel->core.attr.aux_output) {
+		perf_missing_features.aux_output = true;
+		pr_debug2("Kernel has no attr.aux_output support, bailing out\n");
+		goto out_close;
+	} else if (!perf_missing_features.bpf_event && evsel->core.attr.bpf_event) {
 		perf_missing_features.bpf_event = true;
 		pr_debug2("switching off bpf_event\n");
 		goto fallback_missing_features;
@@ -2926,6 +2931,8 @@ int perf_evsel__open_strerror(struct evsel *evsel, struct target *target,
 			return scnprintf(msg, size, "clockid feature not supported.");
 		if (perf_missing_features.clockid_wrong)
 			return scnprintf(msg, size, "wrong clockid (%d).", clockid);
+		if (perf_missing_features.aux_output)
+			return scnprintf(msg, size, "The 'aux_output' feature is not supported, update the kernel.");
 		break;
 	default:
 		break;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 8a316dd54cd0..9cd6e3ae479a 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -184,6 +184,7 @@ struct perf_missing_features {
 	bool group_read;
 	bool ksymbol;
 	bool bpf_event;
+	bool aux_output;
 };
 
 extern struct perf_missing_features perf_missing_features;
-- 
2.21.0

