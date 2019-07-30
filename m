Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8810C31E40
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95087206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="JX2L2oW6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387621AbfG3R5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 13:57:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50291 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387530AbfG3R5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 13:57:17 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UHv9aQ3321433
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 10:57:09 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UHv9aQ3321433
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564509430;
        bh=nFEtOKayQ4TFW+6C3U/jxWJknvtZuGzOHEiCbAZeOVs=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=JX2L2oW6OUiMSiv3Gkt3Cx5etQv14djo7FaairiJbCQyYuukMwMjSTZLbDnb/OVup
         F4C+q6UvFzMcM9/Q6yAg9QlsrXb/ySlUF/SBs/tbbJ5RWdh0eU7e9RCNpfVF5dlAX7
         GUFFqoXwRmZCCGhM2yN+2JDZSJr6mpP09X7QakH5E453+XKfUwDFhsq0LYhe4OmjB4
         Hbyrk0nuJTrABA5RQmv7mssAnUGzqGcMNMnLQ3q+C/0SetC/sSbPrndD2D0m0aCV44
         VdeDXIio92HEqLfDD06kXRfUOYLoqwTeqF+FYkge9v/ks95udLE+M75E6k4kAa6lZI
         5qDhc4hLbYo/g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UHv9Gd3321430;
        Tue, 30 Jul 2019 10:57:09 -0700
Date:   Tue, 30 Jul 2019 10:57:09 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-6xavwddruokp6ohs7tf4qilb@git.kernel.org>
Cc:     jolsa@kernel.org, hpa@zytor.com, namhyung@kernel.org,
        acme@redhat.com, mingo@kernel.org, adrian.hunter@intel.com,
        tglx@linutronix.de, lclaudio@redhat.com,
        linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, lclaudio@redhat.com,
          tglx@linutronix.de, adrian.hunter@intel.com, mingo@kernel.org,
          acme@redhat.com, namhyung@kernel.org, hpa@zytor.com,
          jolsa@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Look for default name for entries in
 the syscalls prog array
Git-Commit-ID: 8b8044e5c9527cdfff3b0937f2d17470cc4acf9e
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

Commit-ID:  8b8044e5c9527cdfff3b0937f2d17470cc4acf9e
Gitweb:     https://git.kernel.org/tip/8b8044e5c9527cdfff3b0937f2d17470cc4acf9e
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 16 Jul 2019 15:24:58 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:41 -0300

perf trace: Look for default name for entries in the syscalls prog array

I.e. just look for "!syscalls:sys_enter_" or "exit_" plus the syscall
name, that way we need just to add entries to the
augmented_raw_syscalls.c BPF source to add handlers.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-6xavwddruokp6ohs7tf4qilb@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index c64f7c99db15..5258399a1c94 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -830,13 +830,11 @@ static struct syscall_fmt {
 	{ .name	    = "newfstatat",
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* dfd */ }, }, },
 	{ .name	    = "open",
-	  .bpf_prog_name = { .sys_enter = "!syscalls:sys_enter_open", },
 	  .arg = { [1] = { .scnprintf = SCA_OPEN_FLAGS, /* flags */ }, }, },
 	{ .name	    = "open_by_handle_at",
 	  .arg = { [0] = { .scnprintf = SCA_FDAT,	/* dfd */ },
 		   [2] = { .scnprintf = SCA_OPEN_FLAGS, /* flags */ }, }, },
 	{ .name	    = "openat",
-	  .bpf_prog_name = { .sys_enter = "!syscalls:sys_enter_openat", },
 	  .arg = { [0] = { .scnprintf = SCA_FDAT,	/* dfd */ },
 		   [2] = { .scnprintf = SCA_OPEN_FLAGS, /* flags */ }, }, },
 	{ .name	    = "perf_event_open",
@@ -873,7 +871,6 @@ static struct syscall_fmt {
 	{ .name	    = "recvmsg",
 	  .arg = { [2] = { .scnprintf = SCA_MSG_FLAGS, /* flags */ }, }, },
 	{ .name	    = "renameat",
-	  .bpf_prog_name = { .sys_enter = "!syscalls:sys_enter_renameat", },
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* olddirfd */ },
 		   [2] = { .scnprintf = SCA_FDAT, /* newdirfd */ }, }, },
 	{ .name	    = "renameat2",
@@ -2778,12 +2775,27 @@ static struct bpf_program *trace__find_syscall_bpf_prog(struct trace *trace, str
 {
 	struct bpf_program *prog;
 
-	if (prog_name == NULL)
+	if (prog_name == NULL) {
+		char default_prog_name[256];
+		scnprintf(default_prog_name, sizeof(default_prog_name), "!syscalls:sys_%s_%s", type, sc->name);
+		prog = trace__find_bpf_program_by_title(trace, default_prog_name);
+		if (prog != NULL)
+			goto out_found;
+		if (sc->fmt && sc->fmt->alias) {
+			scnprintf(default_prog_name, sizeof(default_prog_name), "!syscalls:sys_%s_%s", type, sc->fmt->alias);
+			prog = trace__find_bpf_program_by_title(trace, default_prog_name);
+			if (prog != NULL)
+				goto out_found;
+		}
 		goto out_unaugmented;
+	}
 
 	prog = trace__find_bpf_program_by_title(trace, prog_name);
-	if (prog != NULL)
+
+	if (prog != NULL) {
+out_found:
 		return prog;
+	}
 
 	pr_debug("Couldn't find BPF prog \"%s\" to associate with syscalls:sys_%s_%s, not augmenting it\n",
 		 prog_name, type, sc->name);
@@ -2798,12 +2810,8 @@ static void trace__init_syscall_bpf_progs(struct trace *trace, int id)
 	if (sc == NULL)
 		return;
 
-	if (sc->fmt != NULL) {
-		sc->bpf_prog.sys_enter = trace__find_syscall_bpf_prog(trace, sc, sc->fmt->bpf_prog_name.sys_enter, "enter");
-		sc->bpf_prog.sys_exit  = trace__find_syscall_bpf_prog(trace, sc, sc->fmt->bpf_prog_name.sys_exit,  "exit");
-	} else {
-		sc->bpf_prog.sys_enter = sc->bpf_prog.sys_exit = trace->syscalls.unaugmented_prog;
-	}
+	sc->bpf_prog.sys_enter = trace__find_syscall_bpf_prog(trace, sc, sc->fmt ? sc->fmt->bpf_prog_name.sys_enter : NULL, "enter");
+	sc->bpf_prog.sys_exit  = trace__find_syscall_bpf_prog(trace, sc, sc->fmt ? sc->fmt->bpf_prog_name.sys_exit  : NULL,  "exit");
 }
 
 static int trace__bpf_prog_sys_enter_fd(struct trace *trace, int id)
