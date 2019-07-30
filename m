Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B50AC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65760206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="kckDgO/Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731785AbfG3RyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 13:54:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52619 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728287AbfG3RyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 13:54:16 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UHs6N83320855
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 10:54:06 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UHs6N83320855
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564509247;
        bh=syc0/h2IW1ZVlTnW3uRN/cg62JnR/88rTxa1qTJpkDM=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=kckDgO/ZSflCK+OkKGPU36vq9BOiPnUDI6UWS1Kx29TR0ApIrcK2WgDhLAgecJ2/1
         FGjIT+ivVJV6D1A7UgrrCq1VQxrBFsP7tgiVXXFkG+zcyxtUM590i9c2z6JPwE2eWK
         gqeSWdBzRY6XvDseFTJq97/qaf3bKUPbO1IxXaXN7ozAbSSy5zuszgkVHr/bFm5VE/
         1dFhShN/17wzZer4srIDtvo5RU1f5i5rk5RN8d80reUc7vbfmTuliPbAtL1NP8CZpR
         hgO6jQ6rV3s/AFM9Vbv3YDZSQF8v3e9v+u0As0sD9g4SPpiBPrKH7V0vAawc5Ghb2Q
         lixH7vZidmzEg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UHs6nG3320852;
        Tue, 30 Jul 2019 10:54:06 -0700
Date:   Tue, 30 Jul 2019 10:54:06 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-0mkocgk31nmy0odknegcby4z@git.kernel.org>
Cc:     jolsa@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, namhyung@kernel.org, lclaudio@redhat.com,
        acme@redhat.com, hpa@zytor.com, adrian.hunter@intel.com
Reply-To: adrian.hunter@intel.com, hpa@zytor.com, acme@redhat.com,
          lclaudio@redhat.com, namhyung@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, mingo@kernel.org, jolsa@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Handle raw_syscalls:sys_enter just like
 the BPF_OUTPUT augmented event
Git-Commit-ID: b119970aa541091e405373399690c24ead9d2920
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

Commit-ID:  b119970aa541091e405373399690c24ead9d2920
Gitweb:     https://git.kernel.org/tip/b119970aa541091e405373399690c24ead9d2920
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 16 Jul 2019 11:53:03 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:41 -0300

perf trace: Handle raw_syscalls:sys_enter just like the BPF_OUTPUT augmented event

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
