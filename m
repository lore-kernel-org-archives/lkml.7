Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF3DC76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68BAA21955
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563817234;
	bh=iqntjTMM3MBLznOhI3BXDGyS9WB4aYP76B8QqXkMqWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Uv75kDItT2CrpkFrEUEskULO6TelCQLXTxH7Gt8KtXzs6opuJ6Afus8DgMfNok9ID
	 5eOLEDmpN60ilaSPsSpf4iKgTL2dEbjp1Mx0PZY3iIOF3jkIcdaOScW1S9SIgeOEke
	 JQ56WC4UdPLsiAOU/fLrjGIN5pkiHErWS0V3281k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731263AbfGVRkc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:40:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:46338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726653AbfGVRkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:40:31 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F197721985;
        Mon, 22 Jul 2019 17:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563817230;
        bh=iqntjTMM3MBLznOhI3BXDGyS9WB4aYP76B8QqXkMqWI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SRTLkvV1wqGIqCCCCds0SimMu/RFW0UNdUgjT9FftaS50n6izzT2D/roscDMAth9k
         Z9K91R0DydL/EUauetFJCd7NtcmyGWJVvxNjN4estFibDaPQlgT6kHaG86V/UknIR5
         Ymo/Mp8cQi1Q45lw9Ff+kkQ8yzrASIBAZqKfOXtg=
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
Subject: [PATCH 14/37] perf trace: Look for default name for entries in the syscalls prog array
Date:   Mon, 22 Jul 2019 14:38:16 -0300
Message-Id: <20190722173839.22898-15-acme@kernel.org>
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
-- 
2.21.0

