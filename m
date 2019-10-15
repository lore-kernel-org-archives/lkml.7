Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC325ECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD1721D7E
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbfJOFcO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 01:32:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42063 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728484AbfJOFcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 01:32:05 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iKFR6-0000DF-9L; Tue, 15 Oct 2019 07:31:56 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8D6091C0494;
        Tue, 15 Oct 2019 07:31:42 +0200 (CEST)
Date:   Tue, 15 Oct 2019 05:31:42 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf beauty: Introduce strtoul() for x86 MSRs
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Luis =?utf-8?q?Cl=C3=A1udio_Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-4qaai5iqjgefd11k4ddm7qg8@git.kernel.org>
References: <tip-4qaai5iqjgefd11k4ddm7qg8@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157111750247.12254.15504686044754816560.tip-bot2@tip-bot2>
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

Commit-ID:     728db198868c7b46db5e65717d4518aeb6523ccc
Gitweb:        https://git.kernel.org/tip/728db198868c7b46db5e65717d4518aeb6523ccc
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Wed, 09 Oct 2019 16:25:02 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 09 Oct 2019 16:25:02 -03:00

perf beauty: Introduce strtoul() for x86 MSRs

Continuing from the previous cset comment, now that filter expression
works:

  # perf trace -e msr:* --filter="msr!=FS_BASE && msr != IA32_TSC_DEADLINE && msr != 0x830 && msr != 0x83f && msr !=IA32_SPEC_CTRL" --filter-pids 3750
     0.000 Timer/5033 msr:write_msr(msr: SYSCALL_MASK, val: 292608)
     0.009 Timer/5033 msr:write_msr(msr: LSTAR, val: -1398800368)
     0.010 Timer/5033 msr:write_msr(msr: TSC_AUX, val: 4)
     0.050 :0/0 msr:read_msr(msr: IA32_TSC_ADJUST)
    45.661 gnome-terminal/12595 msr:write_msr(msr: SYSCALL_MASK, val: 292608)
    45.672 gnome-terminal/12595 msr:write_msr(msr: LSTAR, val: -1398800368)
    45.675 gnome-terminal/12595 msr:write_msr(msr: TSC_AUX, val: 3)
    54.852 :0/0 msr:read_msr(msr: IA32_TSC_ADJUST)
   130.508 Timer/4050 msr:write_msr(msr: SYSCALL_MASK, val: 292608)
   130.527 Timer/4050 msr:write_msr(msr: LSTAR, val: -1398800368)
   130.531 Timer/4050 msr:write_msr(msr: TSC_AUX, val: 3)
   140.924 :0/0 msr:read_msr(msr: IA32_TSC_ADJUST)
   164.738 :0/0 msr:read_msr(msr: IA32_TSC_ADJUST)
   603.578 :0/0 msr:read_msr(msr: IA32_TSC_ADJUST)
   620.809 :0/0 msr:read_msr(msr: IA32_TSC_ADJUST)
   690.115 JS Watchdog/4259 msr:write_msr(msr: SYSCALL_MASK, val: 292608)
   690.136 JS Watchdog/4259 msr:write_msr(msr: LSTAR, val: -1398800368)
   690.141 JS Watchdog/4259 msr:write_msr(msr: TSC_AUX, val: 3)
   690.186 :0/0 msr:read_msr(msr: IA32_TSC_ADJUST)
   759.016 :0/0 msr:read_msr(msr: IA32_TSC_ADJUST)
^C[root@quaco ~]#

Or look at the first 3 write_msr events for that IA32_TSC_DEADLINE to learn why
it happens so often:

  # perf trace --max-events=3 --max-stack=8 -e msr:* --filter="msr==IA32_TSC_DEADLINE" --filter-pids 3750
     0.000 :0/0 msr:write_msr(msr: IA32_TSC_DEADLINE, val: 19296732550862)
                                       do_trace_write_msr ([kernel.kallsyms])
                                       do_trace_write_msr ([kernel.kallsyms])
                                       lapic_next_deadline ([kernel.kallsyms])
                                       clockevents_program_event ([kernel.kallsyms])
                                       hrtimer_interrupt ([kernel.kallsyms])
                                       smp_apic_timer_interrupt ([kernel.kallsyms])
                                       apic_timer_interrupt ([kernel.kallsyms])
                                       cpuidle_enter_state ([kernel.kallsyms])
    32.646 :0/0 msr:write_msr(msr: IA32_TSC_DEADLINE, val: 19296800134158)
                                       do_trace_write_msr ([kernel.kallsyms])
                                       do_trace_write_msr ([kernel.kallsyms])
                                       lapic_next_deadline ([kernel.kallsyms])
                                       clockevents_program_event ([kernel.kallsyms])
                                       hrtimer_start_range_ns ([kernel.kallsyms])
                                       tick_nohz_restart_sched_tick ([kernel.kallsyms])
                                       tick_nohz_idle_exit ([kernel.kallsyms])
                                       do_idle ([kernel.kallsyms])
    32.802 :0/0 msr:write_msr(msr: IA32_TSC_DEADLINE, val: 19297507436922)
                                       do_trace_write_msr ([kernel.kallsyms])
                                       do_trace_write_msr ([kernel.kallsyms])
                                       lapic_next_deadline ([kernel.kallsyms])
                                       clockevents_program_event ([kernel.kallsyms])
                                       hrtimer_try_to_cancel ([kernel.kallsyms])
                                       hrtimer_cancel ([kernel.kallsyms])
                                       tick_nohz_restart_sched_tick ([kernel.kallsyms])
                                       tick_nohz_idle_exit ([kernel.kallsyms])
  #

And if some of the strings can't be found:

  # trace -e msr:* --filter="msr!=SPECULATIVE_EXECUTION_PROBLEMS_SOLUTION && msr != IA32_TSC_DEADLINE && msr != 0x830 && msr != 0x83f && msr !=IA32_SPEC_CTRL" --filter-pids 3750
  "SPECULATIVE_EXECUTION_PROBLEMS_SOLUTION" not found for "msr" in "msr:read_msr", can't set filter "(msr!=SPECULATIVE_EXECUTION_PROBLEMS_SOLUTION && msr != IA32_TSC_DEADLINE && msr != 0x830 && msr != 0x83f && msr !=IA32_SPEC_CTRL) && (common_pid != 28131 && common_pid != 3750)"
  #

Next step is to automatically wire up the pre-existing strarrays, which there
are quite a few.

The strtoul() methods will be further enhanced to allow for looking at other
arguments in a syscall/tracepoint, just like going from integer to string
(scnprintf methods), so that those "val" lines for the msr tracepoints can be
properly formatted or even resolved into some string.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-4qaai5iqjgefd11k4ddm7qg8@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c                    | 2 +-
 tools/perf/trace/beauty/beauty.h              | 3 +++
 tools/perf/trace/beauty/tracepoints/x86_msr.c | 5 +++++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 515a800..b627975 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1512,7 +1512,7 @@ static int syscall__alloc_arg_fmts(struct syscall *sc, int nr_args)
 }
 
 static struct syscall_arg_fmt syscall_arg_fmts__by_name[] = {
-	{ .name = "msr", .scnprintf = SCA_X86_MSR, }
+	{ .name = "msr", .scnprintf = SCA_X86_MSR, .strtoul = STUL_X86_MSR, }
 };
 
 static int syscall_arg_fmt__cmp(const void *name, const void *fmtp)
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 919ac45..77ad80a 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -122,6 +122,9 @@ size_t syscall_arg__scnprintf_strarray_flags(char *bf, size_t size, struct sysca
 size_t syscall_arg__scnprintf_x86_MSR(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_X86_MSR syscall_arg__scnprintf_x86_MSR
 
+bool syscall_arg__strtoul_x86_MSR(char *bf, size_t size, struct syscall_arg *arg, u64 *ret);
+#define STUL_X86_MSR syscall_arg__strtoul_x86_MSR
+
 size_t syscall_arg__scnprintf_strarrays(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_STRARRAYS syscall_arg__scnprintf_strarrays
 
diff --git a/tools/perf/trace/beauty/tracepoints/x86_msr.c b/tools/perf/trace/beauty/tracepoints/x86_msr.c
index 5e9ef53..6b8f129 100644
--- a/tools/perf/trace/beauty/tracepoints/x86_msr.c
+++ b/tools/perf/trace/beauty/tracepoints/x86_msr.c
@@ -32,3 +32,8 @@ size_t syscall_arg__scnprintf_x86_MSR(char *bf, size_t size, struct syscall_arg 
 
 	return x86_MSR__scnprintf(flags, bf, size, arg->show_string_prefix);
 }
+
+bool syscall_arg__strtoul_x86_MSR(char *bf, size_t size, struct syscall_arg *arg __maybe_unused, u64 *ret)
+{
+	return strarrays__strtoul(&strarrays__x86_MSRs_tables, bf, size, ret);
+}
