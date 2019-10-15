Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E122C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F88B2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbfJOFe0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 01:34:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42114 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728537AbfJOFcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 01:32:10 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iKFR9-0000FZ-RI; Tue, 15 Oct 2019 07:32:00 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9D0FE1C04DD;
        Tue, 15 Oct 2019 07:31:43 +0200 (CEST)
Date:   Tue, 15 Oct 2019 05:31:43 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf trace: Introduce --filter for tracepoint events
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Luis =?utf-8?q?Cl=C3=A1udio_Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-95bfe5d4tzy5f66bx49d05rj@git.kernel.org>
References: <tip-95bfe5d4tzy5f66bx49d05rj@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157111750352.12254.17113253973879925388.tip-bot2@tip-bot2>
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

Commit-ID:     d4097f1937f2242d0aa0a7c654d2159a6895e5c8
Gitweb:        https://git.kernel.org/tip/d4097f1937f2242d0aa0a7c654d2159a6895e5c8
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Tue, 08 Oct 2019 07:33:08 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 09 Oct 2019 11:23:52 -03:00

perf trace: Introduce --filter for tracepoint events

Similar to what is in 'perf record', works just like there:

  # perf trace -e msr:*
   328.297 :0/0 msr:write_msr(msr: FS_BASE, val: 140240388381888)
   328.302 :0/0 msr:write_msr(msr: FS_BASE, val: 140240388381888)
   328.306 :0/0 msr:write_msr(msr: FS_BASE, val: 140240388381888)
   328.317 :0/0 msr:write_msr(msr: FS_BASE, val: 140240388381888)
   328.322 :0/0 msr:write_msr(msr: FS_BASE, val: 140240388381888)
   328.327 :0/0 msr:write_msr(msr: FS_BASE, val: 140240388381888)
   328.331 :0/0 msr:write_msr(msr: FS_BASE, val: 140240388381888)
   328.336 :0/0 msr:write_msr(msr: FS_BASE, val: 140240388381888)
   328.340 :0/0 ^Cmsr:write_msr(msr: FS_BASE, val: 140240388381888)
  #

So, for a system wide trace session looking at the write_msr tracepoint
we see a flood of MSR_FS_BASE, we need to get the number for that:

  # grep FS_BASE /tmp/build/perf/trace/beauty/generated/x86_arch_MSRs_array.c
	[0xc0000100 - x86_64_specific_MSRs_offset] = "FS_BASE",
  #

And then use it in a filter:

  # perf trace -e msr:* --filter="msr!=0xc0000100"
  <SNIP>
   942.177 :0/0 msr:write_msr(msr: IA32_TSC_DEADLINE, val: 3056931068232)
   942.199 :0/0 msr:write_msr(msr: IA32_TSC_DEADLINE, val: 3057135655252)
   942.203 :0/0 msr:write_msr(msr: IA32_TSC_DEADLINE, val: 3056931068222)
   942.231 :0/0 msr:write_msr(msr: IA32_TSC_DEADLINE, val: 3056998373022)
   942.241 :0/0 msr:write_msr(msr: IA32_TSC_DEADLINE, val: 3056931068236)
  <SNIP>
  #

Ok, lets filter that too, too noisy:

  # grep TSC_DEADLINE /tmp/build/perf/trace/beauty/generated/x86_arch_MSRs_array.c
	[0x000006E0] = "IA32_TSC_DEADLINE",
  #

  # perf trace -e msr:* --filter="msr!=0xc0000100 && msr!=0x6e0" -a sleep 0.1
     0.000 :0/0 msr:read_msr(msr: IA32_TSC_ADJUST)
     0.066 CPU 0/KVM/4895 msr:write_msr(msr: IA32_SPEC_CTRL, val: 6)
     0.070 CPU 0/KVM/4895 msr:write_msr(msr: 0x830, val: 34359740667)
     0.099 CPU 0/KVM/4895 msr:read_msr(msr: IA32_SYSENTER_ESP, val: -2199021993472)
     0.100 CPU 0/KVM/4895 msr:read_msr(msr: IA32_APICBASE, val: 4276096000)
     0.101 CPU 0/KVM/4895 msr:read_msr(msr: IA32_DEBUGCTLMSR)
     0.109 :0/0 msr:write_msr(msr: IA32_SPEC_CTRL)
     1.000 :0/0 msr:write_msr(msr: 0x830, val: 17179871485)
    18.893 :0/0 msr:write_msr(msr: 0x83f, val: 246)
    28.810 :0/0 msr:write_msr(msr: 0x830, val: 68719479037)
    40.117 CPU 0/KVM/4895 msr:write_msr(msr: IA32_SPEC_CTRL, val: 6)
    40.127 CPU 0/KVM/4895 msr:read_msr(msr: IA32_DEBUGCTLMSR)
    40.139 CPU 0/KVM/4895 msr:write_msr(msr: LSTAR, val: -2130661312)
    40.141 CPU 0/KVM/4895 msr:write_msr(msr: SYSCALL_MASK, val: 14080)
    40.142 CPU 0/KVM/4895 msr:write_msr(msr: TSC_AUX)
    40.144 CPU 0/KVM/4895 msr:write_msr(msr: KERNEL_GS_BASE)
    40.147 CPU 0/KVM/4895 msr:write_msr(msr: IA32_SPEC_CTRL)
    40.148 CPU 0/KVM/4895 msr:write_msr(msr: IA32_FLUSH_CMD, val: 1)
    40.151 CPU 0/KVM/4895 msr:write_msr(msr: IA32_SPEC_CTRL, val: 6)
  ^C
  #

One can combine that with filtering pids as well:

  # perf trace -e msr:* --filter="msr!=0xc0000100 && msr!=0x6e0" --filter-pids 4895 -a sleep 0.09
     0.000 :0/0 msr:write_msr(msr: 0x830, val: 4294969597)
     0.291 gnome-terminal/2790 msr:write_msr(msr: SYSCALL_MASK, val: 292608)
     0.294 gnome-terminal/2790 msr:write_msr(msr: LSTAR, val: -1935671280)
     0.295 gnome-terminal/2790 msr:write_msr(msr: TSC_AUX, val: 6)
    10.940 gnome-terminal/2790 msr:write_msr(msr: 0x830, val: 4294969597)
    15.943 gnome-shell/2096 msr:write_msr(msr: 0x830, val: 4294969597)
    16.975 :0/0 msr:write_msr(msr: 0x830, val: 4294969597)
    19.560 :0/0 msr:write_msr(msr: 0x83f, val: 246)
    25.162 :0/0 msr:read_msr(msr: IA32_TSC_ADJUST)
    25.807 JS Watchdog/3635 msr:write_msr(msr: IA32_SPEC_CTRL, val: 6)
    25.820 :0/0 msr:write_msr(msr: IA32_SPEC_CTRL)
    25.941 gnome-terminal/2790 msr:write_msr(msr: 0x830, val: 4294969597)
    26.941 gnome-terminal/2790 msr:write_msr(msr: 0x830, val: 4294969597)
    29.942 gnome-terminal/2790 msr:write_msr(msr: 0x830, val: 4294969597)
    45.313 :0/0 msr:write_msr(msr: 0x83f, val: 246)
    56.945 gnome-terminal/2790 msr:write_msr(msr: 0x830, val: 4294969597)
    60.946 gnome-terminal/2790 msr:write_msr(msr: 0x830, val: 4294969597)
    74.096 JS Watchdog/8971 msr:write_msr(msr: IA32_SPEC_CTRL, val: 6)
    74.130 :0/0 msr:write_msr(msr: IA32_SPEC_CTRL)
    79.673 :0/0 msr:write_msr(msr: 0x83f, val: 246)
    79.947 gnome-terminal/2790 msr:write_msr(msr: 0x830, val: 17179871485)
  #

Or for just a pid, with callchains:

  # grep SYSCALL_MAS /tmp/build/perf/trace/beauty/generated/x86_arch_MSRs_array.c
	[0xc0000084 - x86_64_specific_MSRs_offset] = "SYSCALL_MASK",
  # perf trace -e msr:* --filter="msr==0xc0000084" --pid 2790 --call-graph=dwarf

     0.000 gnome-terminal/2790 msr:write_msr(msr: SYSCALL_MASK, val: 292608)
                                       do_trace_write_msr ([kernel.kallsyms])
                                       do_trace_write_msr ([kernel.kallsyms])
                                       kvm_on_user_return ([kvm])
                                       fire_user_return_notifiers ([kernel.kallsyms])
                                       exit_to_usermode_loop ([kernel.kallsyms])
                                       do_syscall_64 ([kernel.kallsyms])
                                       entry_SYSCALL_64 ([kernel.kallsyms])
                                       __GI___poll (inlined)
  9299.073 gnome-terminal/2790 msr:write_msr(msr: SYSCALL_MASK, val: 292608)
                                       do_trace_write_msr ([kernel.kallsyms])
                                       do_trace_write_msr ([kernel.kallsyms])
                                       kvm_on_user_return ([kvm])
                                       fire_user_return_notifiers ([kernel.kallsyms])
                                       exit_to_usermode_loop ([kernel.kallsyms])
                                       do_syscall_64 ([kernel.kallsyms])
                                       entry_SYSCALL_64 ([kernel.kallsyms])
                                       __GI___poll (inlined)
  9348.374 gnome-terminal/2790 msr:write_msr(msr: SYSCALL_MASK, val: 292608)
                                       do_trace_write_msr ([kernel.kallsyms])
                                       do_trace_write_msr ([kernel.kallsyms])
                                       kvm_on_user_return ([kvm])
                                       fire_user_return_notifiers ([kernel.kallsyms])
                                       exit_to_usermode_loop ([kernel.kallsyms])
                                       do_syscall_64 ([kernel.kallsyms])
                                       entry_SYSCALL_64 ([kernel.kallsyms])
                                       __GI___poll (inlined)
  <SNIP>
  #

Ok, just another form of KVM to emit MSRs :-)

Next step: elliminate those greps by getting the filter expression,
looking for arg names, then for the arrays associated with it to do a
reverse lookup.

Also allow those filters to be associated with strace-like syscall
names.

After that: augment the 'val' arg for 'msr:write_msr' based on the first
arg, 'msr'.

Then, do that with eBPF too, not just with tracepoint filters.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-95bfe5d4tzy5f66bx49d05rj@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-trace.txt | 5 +++++
 tools/perf/builtin-trace.c              | 8 +++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/Documentation/perf-trace.txt
index ba16cd5..3bb89c2 100644
--- a/tools/perf/Documentation/perf-trace.txt
+++ b/tools/perf/Documentation/perf-trace.txt
@@ -42,6 +42,11 @@ OPTIONS
 	Prefixing with ! shows all syscalls but the ones specified.  You may
 	need to escape it.
 
+--filter=<filter>::
+        Event filter. This option should follow an event selector (-e) which
+	selects tracepoint event(s).
+
+
 -D msecs::
 --delay msecs::
 After starting the program, wait msecs before measuring. This is useful to
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index e9f132a..2c19680 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3362,7 +3362,7 @@ static int trace__set_filter_loop_pids(struct trace *trace)
 		thread = parent;
 	}
 
-	err = perf_evlist__set_tp_filter_pids(trace->evlist, nr, pids);
+	err = perf_evlist__append_tp_filter_pids(trace->evlist, nr, pids);
 	if (!err && trace->filter_pids.map)
 		err = bpf_map__set_filter_pids(trace->filter_pids.map, nr, pids);
 
@@ -3379,8 +3379,8 @@ static int trace__set_filter_pids(struct trace *trace)
 	 * we fork the workload in perf_evlist__prepare_workload.
 	 */
 	if (trace->filter_pids.nr > 0) {
-		err = perf_evlist__set_tp_filter_pids(trace->evlist, trace->filter_pids.nr,
-						      trace->filter_pids.entries);
+		err = perf_evlist__append_tp_filter_pids(trace->evlist, trace->filter_pids.nr,
+							 trace->filter_pids.entries);
 		if (!err && trace->filter_pids.map) {
 			err = bpf_map__set_filter_pids(trace->filter_pids.map, trace->filter_pids.nr,
 						       trace->filter_pids.entries);
@@ -4294,6 +4294,8 @@ int cmd_trace(int argc, const char **argv)
 	OPT_CALLBACK('e', "event", &trace, "event",
 		     "event/syscall selector. use 'perf list' to list available events",
 		     trace__parse_events_option),
+	OPT_CALLBACK(0, "filter", &trace.evlist, "filter",
+		     "event filter", parse_filter),
 	OPT_BOOLEAN(0, "comm", &trace.show_comm,
 		    "show the thread COMM next to its id"),
 	OPT_BOOLEAN(0, "tool_stats", &trace.show_tool_stats, "show tool stats"),
