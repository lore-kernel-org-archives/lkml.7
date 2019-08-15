Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801F6C31E40
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 510012189E
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="BQxSA8TW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731436AbfHOJd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 05:33:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53455 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730379AbfHOJd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 05:33:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7F9Xlvj2274823
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 15 Aug 2019 02:33:47 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7F9Xlvj2274823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565861628;
        bh=6FarSPnS0jen9KDGpJ/PUw7WmbV2kwW2gRzfUtXxg4w=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=BQxSA8TWlvyffA64Uydo+4uE0IUZ1iwg1TA4NXezArVFk2aZY7OP8GNOgqTFC37fI
         Q0e6BdIlWKv3JC+Uk6BrH9ctp7z90GOcB7IRPkVaPhE17pFh+fK7zpsnuD8b2rLFCo
         pbPD9pvaWkof22zrycCnEotvf2vcwxuFTWyViPZk5yda8GpuZXu69ail6sNuz56/Ds
         f1tPOgObQRPfnC/9HXtSbVl8RRPfyuAgS9pyd8QEsuNW9JQghe0k9OPYy4mkUIN+LU
         Rc8Dlti+ENvqesNqM39J7W5KxipufAnmoTy2Lsw75DURFyQXK57gvOu3bA92PHT7Hd
         JIDDESS2PmqQw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7F9Xltq2274820;
        Thu, 15 Aug 2019 02:33:47 -0700
Date:   Thu, 15 Aug 2019 02:33:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-wgjsjroe1e150c0metgwmqwd@git.kernel.org>
Cc:     peterz@infradead.org, mingo@kernel.org, acme@redhat.com,
        jolsa@kernel.org, adrian.hunter@intel.com, tglx@linutronix.de,
        namhyung@kernel.org, hpa@zytor.com, kan.liang@linux.intel.com,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org
Reply-To: mingo@kernel.org, peterz@infradead.org, acme@redhat.com,
          jolsa@kernel.org, adrian.hunter@intel.com, tglx@linutronix.de,
          namhyung@kernel.org, hpa@zytor.com, kan.liang@linux.intel.com,
          alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf evsel: Provide meaningful warning when trying
 to use 'aux_output' on older kernels
Git-Commit-ID: acb9f2d4755a70e31343f99791aa43b05401b996
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  acb9f2d4755a70e31343f99791aa43b05401b996
Gitweb:     https://git.kernel.org/tip/acb9f2d4755a70e31343f99791aa43b05401b996
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 13 Aug 2019 11:06:38 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 14 Aug 2019 10:59:59 -0300

perf evsel: Provide meaningful warning when trying to use 'aux_output' on older kernels

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
@@ -1912,7 +1913,11 @@ try_fallback:
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
