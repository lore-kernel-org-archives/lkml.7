Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69C8C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9663E2190D
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563817197;
	bh=Xf/wX2ohg/gTko7xy9JBaxdRaYjDHUz6ncXm9zQnIqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2XAFBnUqKYMwOuY6nRfhJbU90XA37knal8UFylAkNAVpqqpHSc+KFhXuWrCx2fLl0
	 FJTsS+HBdogj8tIhLuZlnFv+WPrSdVv9BSVazg6vONSz/8XZLff3lVV8ER4leBU2e8
	 iASVmusWxk0TPZrI05AU6fkcj1i2Q8O/MbX0aJIM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbfGVRj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:39:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:45938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726653AbfGVRjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:39:55 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28BAA21955;
        Mon, 22 Jul 2019 17:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563817194;
        bh=Xf/wX2ohg/gTko7xy9JBaxdRaYjDHUz6ncXm9zQnIqc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OZu0OeAsZn4MKHnXFTbGDwoEFw8C3+nBAhTgBFvcbzb+si+Fx6fXx5r046vtDlOb+
         EuAh1slBtJjPFA/jECx/JyXoMSUXclUpUhvKcMxBgZbaLrGvaYApSXJ6FVOx4OiJtV
         Z/QNVcmPEZgI6czChh0N4GlksaBJ4PzsYVZfDJIk=
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
Subject: [PATCH 08/37] perf trace: Allow specifying the bpf prog to augment specific syscalls
Date:   Mon, 22 Jul 2019 14:38:10 -0300
Message-Id: <20190722173839.22898-9-acme@kernel.org>
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

This is a step in the direction of being able to use a
BPF_MAP_TYPE_PROG_ARRAY to handle syscalls that need to copy pointer
payloads in addition to the raw tracepoint syscall args.

There is a first example in
tools/perf/examples/bpf/augmented_raw_syscalls.c for the 'open' syscall.

Next step is to introduce the prog array map and use this 'open'
augmenter, then use that augmenter in other syscalls that also only copy
the first arg as a string, and then show how to use with a syscall that
reads more than one filename, like 'rename', etc.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-pys4v57x5qqrybb4cery2mc8@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c                    | 50 ++++++++++++++++++-
 .../examples/bpf/augmented_raw_syscalls.c     | 23 +++++++++
 2 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 07df952a0d7f..6cc696edf24a 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -690,6 +690,10 @@ struct syscall_arg_fmt {
 static struct syscall_fmt {
 	const char *name;
 	const char *alias;
+	struct {
+		const char *sys_enter,
+			   *sys_exit;
+	}	   bpf_prog_name;
 	struct syscall_arg_fmt arg[6];
 	u8	   nr_args;
 	bool	   errpid;
@@ -823,6 +827,7 @@ static struct syscall_fmt {
 	{ .name	    = "newfstatat",
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* dfd */ }, }, },
 	{ .name	    = "open",
+	  .bpf_prog_name = { .sys_enter = "!syscalls:sys_enter_open", },
 	  .arg = { [1] = { .scnprintf = SCA_OPEN_FLAGS, /* flags */ }, }, },
 	{ .name	    = "open_by_handle_at",
 	  .arg = { [0] = { .scnprintf = SCA_FDAT,	/* dfd */ },
@@ -967,6 +972,10 @@ struct syscall {
 	struct tep_event    *tp_format;
 	int		    nr_args;
 	int		    args_size;
+	struct {
+		struct bpf_program *sys_enter,
+				   *sys_exit;
+	}		    bpf_prog;
 	bool		    is_exit;
 	bool		    is_open;
 	struct tep_format_field *args;
@@ -2742,6 +2751,39 @@ static struct bpf_program *trace__find_bpf_program_by_title(struct trace *trace,
 	return bpf_object__find_program_by_title(trace->bpf_obj, name);
 }
 
+static struct bpf_program *trace__find_syscall_bpf_prog(struct trace *trace, struct syscall *sc,
+							const char *prog_name, const char *type)
+{
+	struct bpf_program *prog;
+
+	if (prog_name == NULL)
+		goto out_unaugmented;
+
+	prog = trace__find_bpf_program_by_title(trace, prog_name);
+	if (prog != NULL)
+		return prog;
+
+	pr_debug("Couldn't find BPF prog \"%s\" to associate with syscalls:sys_%s_%s, not augmenting it\n",
+		 prog_name, type, sc->name);
+out_unaugmented:
+	return trace->syscalls.unaugmented_prog;
+}
+
+static void trace__init_syscall_bpf_progs(struct trace *trace, int id)
+{
+	struct syscall *sc = trace__syscall_info(trace, NULL, id);
+
+	if (sc == NULL)
+		return;
+
+	if (sc->fmt != NULL) {
+		sc->bpf_prog.sys_enter = trace__find_syscall_bpf_prog(trace, sc, sc->fmt->bpf_prog_name.sys_enter, "enter");
+		sc->bpf_prog.sys_exit  = trace__find_syscall_bpf_prog(trace, sc, sc->fmt->bpf_prog_name.sys_exit,  "exit");
+	} else {
+		sc->bpf_prog.sys_enter = sc->bpf_prog.sys_exit = trace->syscalls.unaugmented_prog;
+	}
+}
+
 static void trace__init_bpf_map_syscall_args(struct trace *trace, int id, struct bpf_map_syscall_entry *entry)
 {
 	struct syscall *sc = trace__syscall_info(trace, NULL, id);
@@ -2773,8 +2815,10 @@ static int trace__set_ev_qualifier_bpf_filter(struct trace *trace)
 	for (i = 0; i < trace->ev_qualifier_ids.nr; ++i) {
 		int key = trace->ev_qualifier_ids.entries[i];
 
-		if (value.enabled)
+		if (value.enabled) {
 			trace__init_bpf_map_syscall_args(trace, key, &value);
+			trace__init_syscall_bpf_progs(trace, key);
+		}
 
 		err = bpf_map_update_elem(fd, &key, &value, BPF_EXIST);
 		if (err)
@@ -2793,8 +2837,10 @@ static int __trace__init_syscalls_bpf_map(struct trace *trace, bool enabled)
 	int err = 0, key;
 
 	for (key = 0; key < trace->sctbl->syscalls.nr_entries; ++key) {
-		if (enabled)
+		if (enabled) {
 			trace__init_bpf_map_syscall_args(trace, key, &value);
+			trace__init_syscall_bpf_progs(trace, key);
+		}
 
 		err = bpf_map_update_elem(fd, &key, &value, BPF_ANY);
 		if (err)
diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index 48a536b1be6d..66b33b299349 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -94,6 +94,29 @@ int syscall_unaugmented(struct syscall_enter_args *args)
 	return 1;
 }
 
+/*
+ * This will be tail_called from SEC("raw_syscalls:sys_enter"), so will find in
+ * augmented_filename_map what was read by that raw_syscalls:sys_enter and go
+ * on from there, reading the first syscall arg as a string, i.e. open's
+ * filename.
+ */
+SEC("!syscalls:sys_enter_open")
+int sys_enter_open(struct syscall_enter_args *args)
+{
+	int key = 0;
+	struct augmented_args_filename *augmented_args = bpf_map_lookup_elem(&augmented_filename_map, &key);
+	const void *filename_arg = (const void *)args->args[0];
+	unsigned int len = sizeof(augmented_args->args);
+
+        if (augmented_args == NULL)
+                return 1; /* Failure: don't filter */
+
+	len += augmented_filename__read(&augmented_args->filename, filename_arg, sizeof(augmented_args->filename.value));
+
+	/* If perf_event_output fails, return non-zero so that it gets recorded unaugmented */
+	return perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, augmented_args, len);
+}
+
 SEC("raw_syscalls:sys_enter")
 int sys_enter(struct syscall_enter_args *args)
 {
-- 
2.21.0

