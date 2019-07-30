Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB548C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5D4E206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="HJIc84z6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729986AbfG3SFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:05:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34097 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfG3SFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:05:35 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UI5QgA3324308
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:05:27 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UI5QgA3324308
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564509927;
        bh=gBwnrLx5/+nX5CLimOylMgo/GRjturMKXCM/bpTUPr0=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=HJIc84z6oJYSlRP/3HyRAoD5W979aBAfKw0Vc6jwFHEwMBTSyJ7U2ztXLgjOvWmqg
         lBgiZ/PnNnDUj7MvkDV6s+rdHt6ewqZTdMmqMgTdG6ku9aiXsXM4UFz1eC5i1+7Oqg
         5uDnYEN+mJFdgKYgD4GyHkvu01hVfzHx8iQOpyFfHtPB9TnBotI0rHTtcjWJ6C8ylD
         OlD0jKnqPMW6Pb9EypColF1gpGkAzF5cnWiE2sDfb77J6CwFxCXHj7BGAwbKTW4zY9
         4Y1nSITGGzcg8WxrVFY8ntlnx/yPrIGLJhGaiq26Ht/tbEpBf8pPEtOmnxSkwy0GYw
         d6IZ7ngB0T5bQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UI5POq3324305;
        Tue, 30 Jul 2019 11:05:25 -0700
Date:   Tue, 30 Jul 2019 11:05:25 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-m3cjzzifibs13imafhkk77a0@git.kernel.org>
Cc:     adrian.hunter@intel.com, mingo@kernel.org, lclaudio@redhat.com,
        jolsa@kernel.org, tglx@linutronix.de, hpa@zytor.com,
        acme@redhat.com, linux-kernel@vger.kernel.org,
        brendan.d.gregg@gmail.com, namhyung@kernel.org
Reply-To: lclaudio@redhat.com, adrian.hunter@intel.com, mingo@kernel.org,
          namhyung@kernel.org, hpa@zytor.com, tglx@linutronix.de,
          jolsa@kernel.org, linux-kernel@vger.kernel.org,
          brendan.d.gregg@gmail.com, acme@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Preallocate the syscall table
Git-Commit-ID: 30a910d7d3e04dd920e4ca3e8dcabf10c67fb03e
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

Commit-ID:  30a910d7d3e04dd920e4ca3e8dcabf10c67fb03e
Gitweb:     https://git.kernel.org/tip/30a910d7d3e04dd920e4ca3e8dcabf10c67fb03e
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 18 Jul 2019 20:19:30 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:42 -0300

perf trace: Preallocate the syscall table

We'll continue reading its details from tracefs as we need it, but
preallocate the whole thing otherwise we may realloc and end up with
pointers to the previous buffer.

I.e. in an upcoming algorithm we'll look for syscalls that have function
signatures that are similar to a given syscall to see if we can reuse
its BPF augmenter, so we may be at syscall 42, having a 'struct syscall'
pointing to that slot in trace->syscalls.table[] and try to read the
slot for an yet unread syscall, which would realloc that table to read
the info for syscall 43, say, which would trigger a realoc of
trace->syscalls.table[], and then the pointer we had for syscall 42
would be pointing to the previous block of memory. b00m.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-m3cjzzifibs13imafhkk77a0@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c   | 29 +++++++----------------------
 tools/perf/util/syscalltbl.c |  1 +
 tools/perf/util/syscalltbl.h |  1 +
 3 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 765b998755ce..d8565c9a18a2 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -79,7 +79,6 @@ struct trace {
 	struct perf_tool	tool;
 	struct syscalltbl	*sctbl;
 	struct {
-		int		max;
 		struct syscall  *table;
 		struct bpf_map  *map;
 		struct { // per syscall BPF_MAP_TYPE_PROG_ARRAY
@@ -1493,21 +1492,10 @@ static int trace__read_syscall_info(struct trace *trace, int id)
 	struct syscall *sc;
 	const char *name = syscalltbl__name(trace->sctbl, id);
 
-	if (id > trace->syscalls.max) {
-		struct syscall *nsyscalls = realloc(trace->syscalls.table, (id + 1) * sizeof(*sc));
-
-		if (nsyscalls == NULL)
+	if (trace->syscalls.table == NULL) {
+		trace->syscalls.table = calloc(trace->sctbl->syscalls.nr_entries, sizeof(*sc));
+		if (trace->syscalls.table == NULL)
 			return -ENOMEM;
-
-		if (trace->syscalls.max != -1) {
-			memset(nsyscalls + trace->syscalls.max + 1, 0,
-			       (id - trace->syscalls.max) * sizeof(*sc));
-		} else {
-			memset(nsyscalls, 0, (id + 1) * sizeof(*sc));
-		}
-
-		trace->syscalls.table = nsyscalls;
-		trace->syscalls.max   = id;
 	}
 
 	sc = trace->syscalls.table + id;
@@ -1819,11 +1807,11 @@ static struct syscall *trace__syscall_info(struct trace *trace,
 
 	err = -EINVAL;
 
-	if ((id > trace->syscalls.max || trace->syscalls.table[id].name == NULL) &&
-	    (err = trace__read_syscall_info(trace, id)) != 0)
+	if (id > trace->sctbl->syscalls.max_id)
 		goto out_cant_read;
 
-	if (id > trace->syscalls.max)
+	if ((trace->syscalls.table == NULL || trace->syscalls.table[id].name == NULL) &&
+	    (err = trace__read_syscall_info(trace, id)) != 0)
 		goto out_cant_read;
 
 	if (trace->syscalls.table[id].name == NULL) {
@@ -1838,7 +1826,7 @@ out_cant_read:
 	if (verbose > 0) {
 		char sbuf[STRERR_BUFSIZE];
 		fprintf(trace->output, "Problems reading syscall %d: %d (%s)", id, -err, str_error_r(-err, sbuf, sizeof(sbuf)));
-		if (id <= trace->syscalls.max && trace->syscalls.table[id].name != NULL)
+		if (id <= trace->sctbl->syscalls.max_id && trace->syscalls.table[id].name != NULL)
 			fprintf(trace->output, "(%s)", trace->syscalls.table[id].name);
 		fputs(" information\n", trace->output);
 	}
@@ -3922,9 +3910,6 @@ int cmd_trace(int argc, const char **argv)
 		NULL
 	};
 	struct trace trace = {
-		.syscalls = {
-			. max = -1,
-		},
 		.opts = {
 			.target = {
 				.uid	   = UINT_MAX,
diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
index 022a9c670338..820fceeb19a9 100644
--- a/tools/perf/util/syscalltbl.c
+++ b/tools/perf/util/syscalltbl.c
@@ -79,6 +79,7 @@ static int syscalltbl__init_native(struct syscalltbl *tbl)
 
 	qsort(tbl->syscalls.entries, nr_entries, sizeof(struct syscall), syscallcmp);
 	tbl->syscalls.nr_entries = nr_entries;
+	tbl->syscalls.max_id	 = syscalltbl_native_max_id;
 	return 0;
 }
 
diff --git a/tools/perf/util/syscalltbl.h b/tools/perf/util/syscalltbl.h
index c8e7e9ce0f01..9172613028d0 100644
--- a/tools/perf/util/syscalltbl.h
+++ b/tools/perf/util/syscalltbl.h
@@ -6,6 +6,7 @@ struct syscalltbl {
 	union {
 		int audit_machine;
 		struct {
+			int max_id;
 			int nr_entries;
 			void *entries;
 		} syscalls;
