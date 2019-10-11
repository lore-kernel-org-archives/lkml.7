Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4CEC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54B3121D7C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570824579;
	bh=EHPbqmaIcrrAdxr30uG/4xrKMX83KfeWVIiA9yNF4Gc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AXRiTyV8Y/aR2f33Y9tCrj7taxSTpK8wc7VSWu021nt1GRMM+K1gUyrR/q40qD7xc
	 gJ04KMsqTrXW5KJBks3KphYVV9E7SUrTqtcE33aix4tU0rstsvz/o9BxdwUyGTLKz+
	 97351qepp5C7+4E0prlQe09luZv5bYP66Q4zN2pw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbfJKUJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:09:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:45156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728855AbfJKUJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 16:09:37 -0400
Received: from quaco.ghostprotocols.net (189-94-137-67.3g.claro.net.br [189.94.137.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B803222C1;
        Fri, 11 Oct 2019 20:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570824576;
        bh=EHPbqmaIcrrAdxr30uG/4xrKMX83KfeWVIiA9yNF4Gc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r42srjQoK3EtxZrS81D8VO5hZZOPbeAt7UJ1FB10coQ29r/DZ5E7NA3oJZWw3vrnX
         QpEPozef10f5cMwJDkQjzG4dhFiIav5ez+NO1zmC6DLGdD+C34tAo95m91F3Xgq0R8
         xMMRBSHdH0Z5s3zCTs7fIe9085GwXl7T07qPKUok=
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
        <lclaudio@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 35/69] perf trace: Introduce --filter for tracepoint events
Date:   Fri, 11 Oct 2019 17:05:25 -0300
Message-Id: <20191011200559.7156-36-acme@kernel.org>
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
index ba16cd5b680f..3bb89c2e9020 100644
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
index e9f132aa5a09..2c1968061b4b 100644
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
-- 
2.21.0

