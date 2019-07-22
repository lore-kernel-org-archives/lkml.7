Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93501C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C7C821985
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563817342;
	bh=EASSxj9sw+3zA2cPBdwt8kv9OFzKD98mWXpVd808xiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SmyjUGwEFSAPC7R584yMpIOM/vGgrW7XK1la09uPdGWEOt8de84Uzt/DJdV4a8ZGm
	 o2oDyL6+lAuGxzZLw3uAx/ESbbiSRuqfR1d2VfYj2eTz5oHSGI4hs5GIdQI/QiCM9H
	 s8en5nVwLPkqoAaGrsnZ9mW2bU/dfoX/9l5TziP4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731962AbfGVRmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:42:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:47420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728762AbfGVRmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:42:19 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D29F21955;
        Mon, 22 Jul 2019 17:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563817338;
        bh=EASSxj9sw+3zA2cPBdwt8kv9OFzKD98mWXpVd808xiQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U+6LpDrxQH+dFJZiLHiIwJ+0rtoHbsjRr+OemwpYx95k/DAn/jAJgoqg2aOnjhRVi
         P7pgvr3p/furFT/p91sYIkDUOC1CU9ne3ApDT7C5pSx+2Wtk1OSsSzvbFVaB1xTBld
         arrNxh1JyB1yIpZIuXHngEDkCmXYdm3J56ij6KDE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 30/37] perf trace: Forward error codes when trying to read syscall info
Date:   Mon, 22 Jul 2019 14:38:32 -0300
Message-Id: <20190722173839.22898-31-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190722173839.22898-1-acme@kernel.org>
References: <20190722173839.22898-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.21.0

