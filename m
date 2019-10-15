Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DC7C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E88F12086A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbfJOFcd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 01:32:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42192 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728609AbfJOFcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 01:32:15 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iKFRJ-0000PP-3E; Tue, 15 Oct 2019 07:32:09 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 890BB1C04CB;
        Tue, 15 Oct 2019 07:31:48 +0200 (CEST)
Date:   Tue, 15 Oct 2019 05:31:48 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf trace: Factor out the initialization of
 syscal_arg_fmt->scnprintf
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Luis =?utf-8?q?Cl=C3=A1udio_Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-xs3x0zzyes06c7scdsjn01ty@git.kernel.org>
References: <tip-xs3x0zzyes06c7scdsjn01ty@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157111750842.12254.9042699783487450531.tip-bot2@tip-bot2>
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

Commit-ID:     8d1d4ff5e239d9ef385444bc0d855127d7b32754
Gitweb:        https://git.kernel.org/tip/8d1d4ff5e239d9ef385444bc0d855127d7b32754
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Thu, 03 Oct 2019 15:57:42 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 07 Oct 2019 12:22:18 -03:00

perf trace: Factor out the initialization of syscal_arg_fmt->scnprintf

We set the default scnprint routines for the syscall args based on its
type or on heuristics based on its names, now we'll use this for
tracepoints as well, so move it out of syscall__set_arg_fmts() and into
a routine that receive just an array of syscall_arg_fmt entries + the
tracepoint format fields list.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-xs3x0zzyes06c7scdsjn01ty@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 6c70253..d52dd2b 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1467,15 +1467,16 @@ static int syscall__alloc_arg_fmts(struct syscall *sc, int nr_args)
 	return 0;
 }
 
-static int syscall__set_arg_fmts(struct syscall *sc)
+static struct tep_format_field *
+syscall_arg_fmt__init_array(struct syscall_arg_fmt *arg, struct tep_format_field *field)
 {
-	struct tep_format_field *field, *last_field = NULL;
-	int idx = 0, len;
+	struct tep_format_field *last_field = NULL;
+	int len;
 
-	for (field = sc->args; field; field = field->next, ++idx) {
+	for (; field; field = field->next, ++arg) {
 		last_field = field;
 
-		if (sc->fmt && sc->fmt->arg[idx].scnprintf)
+		if (arg->scnprintf)
 			continue;
 
 		len = strlen(field->name);
@@ -1483,13 +1484,13 @@ static int syscall__set_arg_fmts(struct syscall *sc)
 		if (strcmp(field->type, "const char *") == 0 &&
 		    ((len >= 4 && strcmp(field->name + len - 4, "name") == 0) ||
 		     strstr(field->name, "path") != NULL))
-			sc->arg_fmt[idx].scnprintf = SCA_FILENAME;
+			arg->scnprintf = SCA_FILENAME;
 		else if ((field->flags & TEP_FIELD_IS_POINTER) || strstr(field->name, "addr"))
-			sc->arg_fmt[idx].scnprintf = SCA_PTR;
+			arg->scnprintf = SCA_PTR;
 		else if (strcmp(field->type, "pid_t") == 0)
-			sc->arg_fmt[idx].scnprintf = SCA_PID;
+			arg->scnprintf = SCA_PID;
 		else if (strcmp(field->type, "umode_t") == 0)
-			sc->arg_fmt[idx].scnprintf = SCA_MODE_T;
+			arg->scnprintf = SCA_MODE_T;
 		else if ((strcmp(field->type, "int") == 0 ||
 			  strcmp(field->type, "unsigned int") == 0 ||
 			  strcmp(field->type, "long") == 0) &&
@@ -1501,10 +1502,17 @@ static int syscall__set_arg_fmts(struct syscall *sc)
 			 * 23 unsigned int
 			 * 7 unsigned long
 			 */
-			sc->arg_fmt[idx].scnprintf = SCA_FD;
+			arg->scnprintf = SCA_FD;
 		}
 	}
 
+	return last_field;
+}
+
+static int syscall__set_arg_fmts(struct syscall *sc)
+{
+	struct tep_format_field *last_field = syscall_arg_fmt__init_array(sc->arg_fmt, sc->args);
+
 	if (last_field)
 		sc->args_size = last_field->offset + last_field->size;
 
