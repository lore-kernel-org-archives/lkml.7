Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B0BECE58D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB68D21D71
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570824487;
	bh=DWH/lgULadfPKCnCLx4uBruY9REjl6hRDLTaDTIkwT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cfJYPGgHM1hAweW5iwuTONkC4DsfwgwKNba0qY4pcnulyKwBBK+Z97S01b8IZW0FA
	 J6kSDZab3rmJCtSGbV7aHEIxGrAt2/vw/rQyp3bh4NkPEvAMK4SYcS5ZnmeLe8CYW2
	 6DvqjyryzwhQePXrPjyoWn6lwv2e3iK/SAYzeHkA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbfJKUIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:08:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:44088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729032AbfJKUIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 16:08:06 -0400
Received: from quaco.ghostprotocols.net (189-94-137-67.3g.claro.net.br [189.94.137.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A1E721D7E;
        Fri, 11 Oct 2019 20:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570824485;
        bh=DWH/lgULadfPKCnCLx4uBruY9REjl6hRDLTaDTIkwT4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b4Z+YbmIhs4fgEV6y7jb+F/IgQ1NnAnmbFmDsQq0kN2HZY6IVPP12DF0gMNyd3i1l
         Sq4aELGySF2Y2Mh2oyuel3e3vorEydkIPwDsT3EYzSBjWDyCpdTQrxOUa9XN5gkf3c
         3UR8DrXhQAp/c+0z/n1/MILwWC50kSXCs6l8cvjM=
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
Subject: [PATCH 18/69] perf trace: Factor out the initialization of syscal_arg_fmt->scnprintf
Date:   Fri, 11 Oct 2019 17:05:08 -0300
Message-Id: <20191011200559.7156-19-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191011200559.7156-1-acme@kernel.org>
References: <20191011200559.7156-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
index 6c7025370ec0..d52dd2bad980 100644
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
 
-- 
2.21.0

