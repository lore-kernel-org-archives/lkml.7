Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8B5C31E40
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C712A21855
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Auw2vzhv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730687AbfHOJ3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 05:29:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39611 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfHOJ3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 05:29:31 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7F9TJ752274020
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 15 Aug 2019 02:29:19 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7F9TJ752274020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565861359;
        bh=ztWKzqOdIW3w57ysdvapt/fjXv/dmBEOrWr97SYP6Bk=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Auw2vzhvO9cGclAP4IBk9jo6AUd+IRjHGCndnQcSQ4dvCozmqYFxIc1noROEinn/e
         VCWvENPhSiU9JNZbxPtzrCrx/9hUuo2Pwcl+7g+7odWW126l2qGd/8YfiSGOK9fWp+
         ghD+vD8L7i/Bm2/Yzos3Ki9o4XM59w8ACTaYy3S1waBPzee4wCgtp7f4BCkN0PFTfP
         lecHPoKCHbuoO2RMeon5b7c7seor87b7i70klbtJN+jTIhO8Iq3t/q/4YyiR1Ksq0g
         AkBI1I4mKWRDRsxkZ2jl4lzMRZhkuqw9h3V4EtSX5Qk0WDFoN8bnBOuagkFBngS4js
         UtCaWx96Svjlg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7F9TIxZ2274015;
        Thu, 15 Aug 2019 02:29:18 -0700
Date:   Thu, 15 Aug 2019 02:29:18 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Alexander Shishkin <tipbot@zytor.com>
Message-ID: <tip-ce7b0e426ef359ee1d4a6126314ee3547a8eed87@git.kernel.org>
Cc:     hpa@zytor.com, tglx@linutronix.de, acme@redhat.com,
        adrian.hunter@intel.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        peterz@infradead.org
Reply-To: acme@redhat.com, tglx@linutronix.de, hpa@zytor.com,
          adrian.hunter@intel.com, peterz@infradead.org,
          linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
          mingo@kernel.org
In-Reply-To: <20190806144101.62892-1-alexander.shishkin@linux.intel.com>
References: <20190806144101.62892-1-alexander.shishkin@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf record: Add an option to take an AUX snapshot
 on exit
Git-Commit-ID: ce7b0e426ef359ee1d4a6126314ee3547a8eed87
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

Commit-ID:  ce7b0e426ef359ee1d4a6126314ee3547a8eed87
Gitweb:     https://git.kernel.org/tip/ce7b0e426ef359ee1d4a6126314ee3547a8eed87
Author:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
AuthorDate: Tue, 6 Aug 2019 17:41:01 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 14 Aug 2019 10:59:59 -0300

perf record: Add an option to take an AUX snapshot on exit

It is sometimes useful to generate a snapshot when perf record exits;
I've been using a wrapper script around the workload that would do a
killall -USR2 perf when the workload exits.

This patch makes it easier and also works when perf record is attached
to a pre-existing task. A new snapshot option 'e' can be specified in
-S to enable this behavior:

root@elsewhere:~# perf record -e intel_pt// -Se sleep 1
[ perf record: Woken up 2 times to write data ]
[ perf record: Captured and wrote 0.085 MB perf.data ]

Co-developed-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190806144101.62892-1-alexander.shishkin@linux.intel.com
[ Fixed up !HAVE_AUXTRACE_SUPPORT build in builtin-record.c, adding 2 missing __maybe_unused ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-record.txt | 11 +++++++---
 tools/perf/builtin-record.c              | 35 ++++++++++++++++++++++++++++----
 tools/perf/perf.h                        |  1 +
 tools/perf/util/auxtrace.c               | 14 +++++++++++--
 tools/perf/util/auxtrace.h               |  2 +-
 5 files changed, 53 insertions(+), 10 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 15e0fa87241b..d5e58e0a2bca 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -422,9 +422,14 @@ CLOCK_BOOTTIME, CLOCK_REALTIME and CLOCK_TAI.
 -S::
 --snapshot::
 Select AUX area tracing Snapshot Mode. This option is valid only with an
-AUX area tracing event. Optionally the number of bytes to capture per
-snapshot can be specified. In Snapshot Mode, trace data is captured only when
-signal SIGUSR2 is received.
+AUX area tracing event. Optionally, certain snapshot capturing parameters
+can be specified in a string that follows this option:
+  'e': take one last snapshot on exit; guarantees that there is at least one
+       snapshot in the output file;
+  <size>: if the PMU supports this, specify the desired snapshot size.
+
+In Snapshot Mode trace data is captured only when signal SIGUSR2 is received
+and on exit if the above 'e' option is given.
 
 --proc-map-timeout::
 When processing pre-existing threads /proc/XXX/mmap, it may take a long time,
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index d31d7a5a1be3..f71631f2bcb5 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -613,19 +613,35 @@ out:
 	return rc;
 }
 
-static void record__read_auxtrace_snapshot(struct record *rec)
+static void record__read_auxtrace_snapshot(struct record *rec, bool on_exit)
 {
 	pr_debug("Recording AUX area tracing snapshot\n");
 	if (record__auxtrace_read_snapshot_all(rec) < 0) {
 		trigger_error(&auxtrace_snapshot_trigger);
 	} else {
-		if (auxtrace_record__snapshot_finish(rec->itr))
+		if (auxtrace_record__snapshot_finish(rec->itr, on_exit))
 			trigger_error(&auxtrace_snapshot_trigger);
 		else
 			trigger_ready(&auxtrace_snapshot_trigger);
 	}
 }
 
+static int record__auxtrace_snapshot_exit(struct record *rec)
+{
+	if (trigger_is_error(&auxtrace_snapshot_trigger))
+		return 0;
+
+	if (!auxtrace_record__snapshot_started &&
+	    auxtrace_record__snapshot_start(rec->itr))
+		return -1;
+
+	record__read_auxtrace_snapshot(rec, true);
+	if (trigger_is_error(&auxtrace_snapshot_trigger))
+		return -1;
+
+	return 0;
+}
+
 static int record__auxtrace_init(struct record *rec)
 {
 	int err;
@@ -654,7 +670,8 @@ int record__auxtrace_mmap_read(struct record *rec __maybe_unused,
 }
 
 static inline
-void record__read_auxtrace_snapshot(struct record *rec __maybe_unused)
+void record__read_auxtrace_snapshot(struct record *rec __maybe_unused,
+				    bool on_exit __maybe_unused)
 {
 }
 
@@ -664,6 +681,12 @@ int auxtrace_record__snapshot_start(struct auxtrace_record *itr __maybe_unused)
 	return 0;
 }
 
+static inline
+int record__auxtrace_snapshot_exit(struct record *rec __maybe_unused)
+{
+	return 0;
+}
+
 static int record__auxtrace_init(struct record *rec __maybe_unused)
 {
 	return 0;
@@ -1536,7 +1559,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		if (auxtrace_record__snapshot_started) {
 			auxtrace_record__snapshot_started = 0;
 			if (!trigger_is_error(&auxtrace_snapshot_trigger))
-				record__read_auxtrace_snapshot(rec);
+				record__read_auxtrace_snapshot(rec, false);
 			if (trigger_is_error(&auxtrace_snapshot_trigger)) {
 				pr_err("AUX area tracing snapshot failed\n");
 				err = -1;
@@ -1609,9 +1632,13 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 			disabled = true;
 		}
 	}
+
 	trigger_off(&auxtrace_snapshot_trigger);
 	trigger_off(&switch_output_trigger);
 
+	if (opts->auxtrace_snapshot_on_exit)
+		record__auxtrace_snapshot_exit(rec);
+
 	if (forks && workload_exec_errno) {
 		char msg[STRERR_BUFSIZE];
 		const char *emsg = str_error_r(workload_exec_errno, msg, sizeof(msg));
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index 74d0124d38f3..dc0a7a237887 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -57,6 +57,7 @@ struct record_opts {
 	bool	     running_time;
 	bool	     full_auxtrace;
 	bool	     auxtrace_snapshot_mode;
+	bool	     auxtrace_snapshot_on_exit;
 	bool	     record_namespaces;
 	bool	     record_switch_events;
 	bool	     all_kernel;
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 65728cdeefb6..72ce4c5e7c78 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -539,9 +539,9 @@ int auxtrace_record__snapshot_start(struct auxtrace_record *itr)
 	return 0;
 }
 
-int auxtrace_record__snapshot_finish(struct auxtrace_record *itr)
+int auxtrace_record__snapshot_finish(struct auxtrace_record *itr, bool on_exit)
 {
-	if (itr && itr->snapshot_finish)
+	if (!on_exit && itr && itr->snapshot_finish)
 		return itr->snapshot_finish(itr);
 	return 0;
 }
@@ -577,6 +577,16 @@ int auxtrace_parse_snapshot_options(struct auxtrace_record *itr,
 	if (!str)
 		return 0;
 
+	/* PMU-agnostic options */
+	switch (*str) {
+	case 'e':
+		opts->auxtrace_snapshot_on_exit = true;
+		str++;
+		break;
+	default:
+		break;
+	}
+
 	if (itr)
 		return itr->parse_snapshot_options(itr, opts, str);
 
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 17eb04a1da4d..8ccabacd0b11 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -499,7 +499,7 @@ int auxtrace_record__info_fill(struct auxtrace_record *itr,
 			       size_t priv_size);
 void auxtrace_record__free(struct auxtrace_record *itr);
 int auxtrace_record__snapshot_start(struct auxtrace_record *itr);
-int auxtrace_record__snapshot_finish(struct auxtrace_record *itr);
+int auxtrace_record__snapshot_finish(struct auxtrace_record *itr, bool on_exit);
 int auxtrace_record__find_snapshot(struct auxtrace_record *itr, int idx,
 				   struct auxtrace_mmap *mm,
 				   unsigned char *data, u64 *head, u64 *old);
