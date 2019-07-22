Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1AE5C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC2EF21901
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563817211;
	bh=akX8pTRSgtWmvSY+wS4yy14rnr2wZfN2n3Sc5ej76tw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MU/Y7bAvgtR8tWC1uXzp7kHmH0x2bdV3YHrKWOGXjEb2fqfHFk7ZgIdLln6fmiWse
	 l7xjTyuKltVKcVRuJeUufptmOFm6jObJ3DcTItbT6yIS0aYP2k0gP2Q962HyFmG6gm
	 ER6Gcsoxv4M2enKfoI8vb18aXtXLLhCzJYPAvL0k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729797AbfGVRkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:40:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:46096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726653AbfGVRkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:40:09 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AE1C21955;
        Mon, 22 Jul 2019 17:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563817208;
        bh=akX8pTRSgtWmvSY+wS4yy14rnr2wZfN2n3Sc5ej76tw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rhWW1otopbrJ5Ax2470Z7RsmY9svMeTYVcVYp1fOTbpEM1+G3u6RF5U1pXGrut/Fa
         jT+zOOsGK4bBoh/UMEmfArNTR6nVQr+U64hUZOX2Q/U/xp1jq1UoB3Os52J6tHFoPu
         wTyHUNHMm1hC8BWM9Z/7eoQBrEb3h4tXqgwDYSKE=
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
Subject: [PATCH 10/37] perf trace: Handle raw_syscalls:sys_enter just like the BPF_OUTPUT augmented event
Date:   Mon, 22 Jul 2019 14:38:12 -0300
Message-Id: <20190722173839.22898-11-acme@kernel.org>
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

So, we use a PERF_COUNT_SW_BPF_OUTPUT to output the augmented sys_enter
payload, i.e. to output more than just the raw syscall args, and if
something goes wrong when handling an unfiltered syscall, we bail out
and just return 1 in the bpf program associated with
raw_syscalls:sys_enter, meaning, don't filter that tracepoint, in which
case what will appear in the perf ring buffer isn't the BPF_OUTPUT
event, but the original raw_syscalls:sys_enter event with its normal
payload.

Now that we're switching to using a bpf_tail_call +
BPF_MAP_TYPE_PROG_ARRAY we're going to use this in the common case, so a
bug where raw_syscalls:sys_enter wasn't being handled by
trace__sys_enter() surfaced and for  that case, instead of using the
strace-like augmenter (trace__sys_enter()), we continued to use the
normal generic tracepoint handler:

  (gdb) p evsel
  $2 = (struct perf_evsel *) 0xc03e40
  (gdb) p evsel->name
  $3 = 0xbc56c0 "raw_syscalls:sys_enter"
  (gdb) p ((struct perf_evsel *) 0xc03e40)->name
  $4 = 0xbc56c0 "raw_syscalls:sys_enter"
  (gdb) p ((struct perf_evsel *) 0xc03e40)->handler
  $5 = (void *) 0x495eb3 <trace__event_handler>

This resulted in this:

     0.027 raw_syscalls:sys_enter:NR 12 (0, 7fcfcac64c9b, 4d, 7fcfcac64c9b, 7fcfcac6ce00, 19)
     ... [continued]: brk())                = 0x563b88677000

I.e. only the sys_exit tracepoint was being properly handled, but since
the sys_enter went to the generic trace__event_handler() we printed it
using libtraceevent's formatter instead of 'perf trace's strace-like
one.

Fix it by setting trace__sys_enter() as the handler for
raw_syscalls:sys_enter and setup the tp_field tracepoint field
accessors.

Now, to test it we just make raw_syscalls:sys_enter return 1 right after
checking if the pid is filtered, making it not use
bpf_perf_output_event() but rather ask for the tracepoint not to be
filtered and the result is the expected one:

  brk(NULL)                               = 0x556f42d6e000

I.e. raw_syscalls:sys_enter returns 1, gets handled by
trace__sys_enter() and gets it combined with the raw_syscalls:sys_exit
in a strace-like way.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-0mkocgk31nmy0odknegcby4z@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index fb8b8e78d7b5..872c9cc982a5 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4128,7 +4128,22 @@ int cmd_trace(int argc, const char **argv)
 				if (perf_evsel__init_augmented_syscall_tp(augmented, evsel) ||
 				    perf_evsel__init_augmented_syscall_tp_args(augmented))
 					goto out;
+				/*
+				 * Augmented is __augmented_syscalls__ BPF_OUTPUT event
+				 * Above we made sure we can get from the payload the tp fields
+				 * that we get from syscalls:sys_enter tracefs format file.
+				 */
 				augmented->handler = trace__sys_enter;
+				/*
+				 * Now we do the same for the *syscalls:sys_enter event so that
+				 * if we handle it directly, i.e. if the BPF prog returns 0 so
+				 * as not to filter it, then we'll handle it just like we would
+				 * for the BPF_OUTPUT one:
+				 */
+				if (perf_evsel__init_augmented_syscall_tp(evsel, evsel) ||
+				    perf_evsel__init_augmented_syscall_tp_args(evsel))
+					goto out;
+				evsel->handler = trace__sys_enter;
 			}
 
 			if (strstarts(perf_evsel__name(evsel), "syscalls:sys_exit_")) {
-- 
2.21.0

