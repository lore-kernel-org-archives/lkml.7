Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0FEECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E40F2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbfJOFeP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 01:34:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42156 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728572AbfJOFcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 01:32:12 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iKFRF-0000O8-Bc; Tue, 15 Oct 2019 07:32:05 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EFAE21C06B2;
        Tue, 15 Oct 2019 07:31:47 +0200 (CEST)
Date:   Tue, 15 Oct 2019 05:31:47 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf trace: Move some scnprintf methods from syscall
 to syscall_arg_fmt
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Luis =?utf-8?q?Cl=C3=A1udio_Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-ynttrs1l75f0x9tk67spd7jd@git.kernel.org>
References: <tip-ynttrs1l75f0x9tk67spd7jd@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157111750778.12254.12478542200185986550.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     3e0c9b2cfaed25599a0a5cbd40e37871bdb10523
Gitweb:        https://git.kernel.org/tip/3e0c9b2cfaed25599a0a5cbd40e37871bdb10523
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Fri, 04 Oct 2019 11:30:41 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 07 Oct 2019 12:22:18 -03:00

perf trace: Move some scnprintf methods from syscall to syscall_arg_fmt

Since all they operate on is on a syscall_arg_fmt instance, so move them
to allow use it from the upcoming tracepoint fprintf routine.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-ynttrs1l75f0x9tk67spd7jd@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index aa70602..82d39ef 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1715,22 +1715,22 @@ static size_t syscall__scnprintf_name(struct syscall *sc, char *bf, size_t size,
  * as mount 'flags' argument that needs ignoring some magic flag, see comment
  * in tools/perf/trace/beauty/mount_flags.c
  */
-static unsigned long syscall__mask_val(struct syscall *sc, struct syscall_arg *arg, unsigned long val)
+static unsigned long syscall_arg_fmt__mask_val(struct syscall_arg_fmt *fmt, struct syscall_arg *arg, unsigned long val)
 {
-	if (sc->arg_fmt && sc->arg_fmt[arg->idx].mask_val)
-		return sc->arg_fmt[arg->idx].mask_val(arg, val);
+	if (fmt && fmt->mask_val)
+		return fmt->mask_val(arg, val);
 
 	return val;
 }
 
-static size_t syscall__scnprintf_val(struct syscall *sc, char *bf, size_t size,
-				     struct syscall_arg *arg, unsigned long val)
+static size_t syscall_arg_fmt__scnprintf_val(struct syscall_arg_fmt *fmt, char *bf, size_t size,
+					     struct syscall_arg *arg, unsigned long val)
 {
-	if (sc->arg_fmt && sc->arg_fmt[arg->idx].scnprintf) {
+	if (fmt && fmt->scnprintf) {
 		arg->val = val;
-		if (sc->arg_fmt[arg->idx].parm)
-			arg->parm = sc->arg_fmt[arg->idx].parm;
-		return sc->arg_fmt[arg->idx].scnprintf(bf, size, arg);
+		if (fmt->parm)
+			arg->parm = fmt->parm;
+		return fmt->scnprintf(bf, size, arg);
 	}
 	return scnprintf(bf, size, "%ld", val);
 }
@@ -1776,7 +1776,7 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 			 * Some syscall args need some mask, most don't and
 			 * return val untouched.
 			 */
-			val = syscall__mask_val(sc, &arg, val);
+			val = syscall_arg_fmt__mask_val(&sc->arg_fmt[arg.idx], &arg, val);
 
 			/*
  			 * Suppress this argument if its value is zero and
@@ -1797,7 +1797,8 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 			if (trace->show_arg_names)
 				printed += scnprintf(bf + printed, size - printed, "%s: ", field->name);
 
-			printed += syscall__scnprintf_val(sc, bf + printed, size - printed, &arg, val);
+			printed += syscall_arg_fmt__scnprintf_val(&sc->arg_fmt[arg.idx],
+								  bf + printed, size - printed, &arg, val);
 		}
 	} else if (IS_ERR(sc->tp_format)) {
 		/*
@@ -1812,7 +1813,7 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 			if (printed)
 				printed += scnprintf(bf + printed, size - printed, ", ");
 			printed += syscall__scnprintf_name(sc, bf + printed, size - printed, &arg);
-			printed += syscall__scnprintf_val(sc, bf + printed, size - printed, &arg, val);
+			printed += syscall_arg_fmt__scnprintf_val(&sc->arg_fmt[arg.idx], bf + printed, size - printed, &arg, val);
 next_arg:
 			++arg.idx;
 			bit <<= 1;
