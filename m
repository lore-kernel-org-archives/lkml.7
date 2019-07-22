Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31575C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08F2721903
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563817188;
	bh=x/wdaYnu+HnppXR7un8ZPC5OfdP3CmOn74wa8zzZwMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZYu/LTsLG2RB09NJnPheiccVgUsKr6Sv0UieEZ0TlE4i0ToMYDAy2c/W3b9zOOs1G
	 q2AeZo5SFADpY+2+ekZpwGTiXFucPqcZzBKCq44YZmegIBIMTjQ+sSx66Nlopmaw3t
	 SNFgj4GuEUpi452XCeC3xzGSgh4AXlZDnqYHZ8NM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbfGVRjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:39:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:45840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729589AbfGVRjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:39:43 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6326E2190D;
        Mon, 22 Jul 2019 17:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563817183;
        bh=x/wdaYnu+HnppXR7un8ZPC5OfdP3CmOn74wa8zzZwMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dXmTFPF9yvsN45SkI/BqI52AhHv0Zo4IZ9DDOufmMVVS9ZtvuX4GmP5+86W62eGNb
         XzY6AL8Fu1d5rWjG7ZM9gsCOqklAG961uEbv1rMhZYltNofZ3XRjo1Ix+8gd3b1BCt
         lKjqkjGQVZ35AT0wusyT0+OQ4vDqEWaThw0dVjaI=
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
Subject: [PATCH 07/37] perf trace: Add BPF handler for unaugmented syscalls
Date:   Mon, 22 Jul 2019 14:38:09 -0300
Message-Id: <20190722173839.22898-8-acme@kernel.org>
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

Will be used to assign to syscalls that don't need augmentation, i.e.
those with just integer args.

All syscalls will be in a BPF_MAP_TYPE_PROG_ARRAY, and the
bpf_tail_call() keyed by the syscall id will either find nothing in
place, which means the syscall is being filtered, or a function that
will either add things like filenames to the ring buffer, right after
the raw syscall args, or be this unaugmented handler that will just
return 1, meaning don't filter the original
raw_syscalls:sys_{enter,exit} tracepoint.

For now it is not really being used, this is just leg work to break the
patch into smaller pieces.

It introduces a trace__find_bpf_program_by_title() helper that in turn
uses libbpf's bpf_object__find_program_by_title() on the BPF object with
the __augmented_syscalls__ map. "title" is how libbpf calls the SEC()
argument for functions, i.e. the ELF section that follows a convention
to specify what BPF program (a function with this SEC() marking) should
be connected to which tracepoint, kprobes, etc.

In perf anything that is of the form SEC("sys:event_name") will be
connected to that tracepoint by perf's BPF loader.

In this case its something that will be bpf_tail_call()ed from either
the "raw_syscalls:sys_enter" or "raw_syscall:sys_exit" tracepoints, so
its named "!raw_syscalls:unaugmented" to convey that idea, i.e. its not
going to be directly attached to a tracepoint, thus it starts with a
"!".

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-meucpjx2u0slpkayx56lxqq6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c                       | 16 ++++++++++++++++
 tools/perf/examples/bpf/augmented_raw_syscalls.c |  6 ++++++
 2 files changed, 22 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 9bd5ecd6a8dd..07df952a0d7f 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -88,6 +88,7 @@ struct trace {
 					  *sys_exit,
 					  *augmented;
 		}		events;
+		struct bpf_program *unaugmented_prog;
 	} syscalls;
 	struct {
 		struct bpf_map *map;
@@ -2733,6 +2734,14 @@ static int trace__set_ev_qualifier_tp_filter(struct trace *trace)
 }
 
 #ifdef HAVE_LIBBPF_SUPPORT
+static struct bpf_program *trace__find_bpf_program_by_title(struct trace *trace, const char *name)
+{
+	if (trace->bpf_obj == NULL)
+		return NULL;
+
+	return bpf_object__find_program_by_title(trace->bpf_obj, name);
+}
+
 static void trace__init_bpf_map_syscall_args(struct trace *trace, int id, struct bpf_map_syscall_entry *entry)
 {
 	struct syscall *sc = trace__syscall_info(trace, NULL, id);
@@ -2814,6 +2823,12 @@ static int trace__init_syscalls_bpf_map(struct trace *trace __maybe_unused)
 {
 	return 0;
 }
+
+static struct bpf_program *trace__find_bpf_program_by_title(struct trace *trace __maybe_unused,
+							    const char *name __maybe_unused)
+{
+	return NULL;
+}
 #endif // HAVE_LIBBPF_SUPPORT
 
 static int trace__set_ev_qualifier_filter(struct trace *trace)
@@ -3914,6 +3929,7 @@ int cmd_trace(int argc, const char **argv)
 
 		trace__set_bpf_map_filtered_pids(&trace);
 		trace__set_bpf_map_syscalls(&trace);
+		trace.syscalls.unaugmented_prog = trace__find_bpf_program_by_title(&trace, "!raw_syscalls:unaugmented");
 	}
 
 	err = bpf__setup_stdout(trace.evlist);
diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index 2f822bb51717..48a536b1be6d 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -88,6 +88,12 @@ unsigned int augmented_filename__read(struct augmented_filename *augmented_filen
 	return len;
 }
 
+SEC("!raw_syscalls:unaugmented")
+int syscall_unaugmented(struct syscall_enter_args *args)
+{
+	return 1;
+}
+
 SEC("raw_syscalls:sys_enter")
 int sys_enter(struct syscall_enter_args *args)
 {
-- 
2.21.0

