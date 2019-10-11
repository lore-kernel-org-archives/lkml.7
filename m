Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B076C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECEA021835
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570824601;
	bh=ANpPMU/wykeZzCMARk2rrEbPWF1T/FGO3riKNFGEjdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rB3CsytXetTTe90eJ+TkezH3s4VtXYmXLhDSP5bniZCN/ApaKpakLiJ9UuQeAGFuB
	 SDVn8szawCEWV0+8yelCk3DL2nLTTtEBqBh9D8aPXHoqxP1pfY5aXvz2joBE5ZBn8m
	 6+r9v8TXSvii9tz5oJHAXKxcYibqawJivjKiiuo8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbfJKUJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:09:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:45518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728855AbfJKUJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 16:09:58 -0400
Received: from quaco.ghostprotocols.net (189-94-137-67.3g.claro.net.br [189.94.137.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C2A021D71;
        Fri, 11 Oct 2019 20:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570824597;
        bh=ANpPMU/wykeZzCMARk2rrEbPWF1T/FGO3riKNFGEjdk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X18C2LGw5R3Y7S7JnURpjyN4v5c4UitkHQ/V9Wc69ekIpl9WLGAqLRJn7sFkL3dXi
         z4O5KB6ORjZC4VtroIHv1yn/oQ2DbgSLyweow1gxuVGdDIFlAUk7L7jpawBP1GKfbd
         N2tkylF0TGS0f3ru+3dqrUEnxcwFb7NXcq5I0sn0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 39/69] perf beauty: Introduce strtoul() for x86 MSRs
Date:   Fri, 11 Oct 2019 17:05:29 -0300
Message-Id: <20191011200559.7156-40-acme@kernel.org>
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
index 515a800efc9c..b627975d1c3e 100644
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
index 919ac4548bd8..77ad80a399fd 100644
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
index 5e9ef5369fb5..6b8f129579d6 100644
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
-- 
2.21.0

