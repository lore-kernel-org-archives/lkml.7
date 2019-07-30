Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A822C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16C11206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="4Bp21u1Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387784AbfG3SEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:04:06 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51963 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728116AbfG3SEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:04:06 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UI3wTw3322512
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:03:58 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UI3wTw3322512
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564509839;
        bh=Q8r8DuGQ1Jlpl52DzFaeQCJat4D9MW6m7X95NaG4ub4=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=4Bp21u1YWc23HglypOyFpCuCmhyPyQH2f7JM86j38xnTEbJBmmYyNyL4e/k6Df5tE
         BxaTI9vBPwxtC9wPPuQIPDe1R69bfrmrbr8jAcs9xZ3LKQETYTCt7NLtVYO8IUenpR
         cyPugqNfcRAoeaCJ+nnsInCZuMZTebHXEiUnJFMuVGh+ck9UKCEDtkeuJA6UZitQrT
         5/ucvpr4pfbTuopEEE+8SsOCGGoBb8G7D8M3B5Q8KLd17BYoQRC5NRPOBbtIeN2Fu+
         GfYvoxcRW6siEpWRGlj6IWi+FCDx4ugApHzYBnfazK7OD92MjtQLfJK2N3vlnSEkfq
         st111Pke+DbgA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UI3wTB3322508;
        Tue, 30 Jul 2019 11:03:58 -0700
Date:   Tue, 30 Jul 2019 11:03:58 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-w3eluap63x9je0bb8o3t79tz@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        lclaudio@redhat.com, acme@redhat.com, tglx@linutronix.de,
        namhyung@kernel.org, hpa@zytor.com, jolsa@kernel.org,
        mingo@kernel.org
Reply-To: jolsa@kernel.org, tglx@linutronix.de, hpa@zytor.com,
          namhyung@kernel.org, acme@redhat.com, mingo@kernel.org,
          lclaudio@redhat.com, adrian.hunter@intel.com,
          linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Forward error codes when trying to read
 syscall info
Git-Commit-ID: 5d2bd88975117062766a48b5f36ce31d2c1a8269
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

Commit-ID:  5d2bd88975117062766a48b5f36ce31d2c1a8269
Gitweb:     https://git.kernel.org/tip/5d2bd88975117062766a48b5f36ce31d2c1a8269
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 17 Jul 2019 19:53:51 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:42 -0300

perf trace: Forward error codes when trying to read syscall info

We iterate thru the syscall table produced from the kernel syscall
tables reading info, propagate the error and add to the debug message.

This helps in fixing further bugs, such as failing to read the
"sendfile" syscall info when it really should try the aliasm
"sendfile64".

  Problems reading syscall 40: 2 (No such file or directory)(sendfile) information

  # grep sendfile /tmp/build/perf/arch/x86/include/generated/asm/syscalls_64.c
	[40] = "sendfile",
  #

I.e. in the tracefs format file for the syscall tracepoints we have it
as sendfile64:

  # find /sys -type f -name format | grep sendfile
  /sys/kernel/debug/tracing/events/syscalls/sys_enter_sendfile64/format
  /sys/kernel/debug/tracing/events/syscalls/sys_exit_sendfile64/format
  #

But as "sendfile" in the file used to build the syscall table used in
perf:

  $ grep sendfile arch/x86/entry/syscalls/syscall_64.tbl
  40	common	sendfile		__x64_sys_sendfile64
  $

So we need to add, in followup patches, aliases in 'perf trace' syscall
data structures to cope with thie.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-w3eluap63x9je0bb8o3t79tz@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index d403b09812d1..5dae7b172291 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1492,13 +1492,13 @@ static int trace__read_syscall_info(struct trace *trace, int id)
 	const char *name = syscalltbl__name(trace->sctbl, id);
 
 	if (name == NULL)
-		return -1;
+		return -EINVAL;
 
 	if (id > trace->syscalls.max) {
 		struct syscall *nsyscalls = realloc(trace->syscalls.table, (id + 1) * sizeof(*sc));
 
 		if (nsyscalls == NULL)
-			return -1;
+			return -ENOMEM;
 
 		if (trace->syscalls.max != -1) {
 			memset(nsyscalls + trace->syscalls.max + 1, 0,
@@ -1525,10 +1525,10 @@ static int trace__read_syscall_info(struct trace *trace, int id)
 	}
 
 	if (syscall__alloc_arg_fmts(sc, IS_ERR(sc->tp_format) ? 6 : sc->tp_format->format.nr_fields))
-		return -1;
+		return -ENOMEM;
 
 	if (IS_ERR(sc->tp_format))
-		return -1;
+		return PTR_ERR(sc->tp_format);
 
 	sc->args = sc->tp_format->format.fields;
 	/*
@@ -1789,6 +1789,7 @@ typedef int (*tracepoint_handler)(struct trace *trace, struct perf_evsel *evsel,
 static struct syscall *trace__syscall_info(struct trace *trace,
 					   struct perf_evsel *evsel, int id)
 {
+	int err = 0;
 
 	if (id < 0) {
 
@@ -1811,9 +1812,10 @@ static struct syscall *trace__syscall_info(struct trace *trace,
 	}
 
 	if ((id > trace->syscalls.max || trace->syscalls.table[id].name == NULL) &&
-	    trace__read_syscall_info(trace, id))
+	    (err = trace__read_syscall_info(trace, id)) != 0)
 		goto out_cant_read;
 
+	err = -EINVAL;
 	if ((id > trace->syscalls.max || trace->syscalls.table[id].name == NULL))
 		goto out_cant_read;
 
@@ -1821,7 +1823,8 @@ static struct syscall *trace__syscall_info(struct trace *trace,
 
 out_cant_read:
 	if (verbose > 0) {
-		fprintf(trace->output, "Problems reading syscall %d", id);
+		char sbuf[STRERR_BUFSIZE];
+		fprintf(trace->output, "Problems reading syscall %d: %d (%s)", id, -err, str_error_r(-err, sbuf, sizeof(sbuf)));
 		if (id <= trace->syscalls.max && trace->syscalls.table[id].name != NULL)
 			fprintf(trace->output, "(%s)", trace->syscalls.table[id].name);
 		fputs(" information\n", trace->output);
