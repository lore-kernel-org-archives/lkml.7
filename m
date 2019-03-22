Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B9EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 21:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03164218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 21:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbfCVV7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 17:59:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:32957 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbfCVV7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 17:59:20 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MLx9sk744795
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 14:59:10 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MLx9Mi744792;
        Fri, 22 Mar 2019 14:59:09 -0700
Date:   Fri, 22 Mar 2019 14:59:09 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-3ab481a1cfe1511b94e142b648e2c5ade9175ed3@git.kernel.org>
Cc:     hpa@zytor.com, jolsa@kernel.org, namhyung@kernel.org,
        ak@linux.intel.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, acme@redhat.com, mingo@kernel.org
Reply-To: mingo@kernel.org, acme@redhat.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, ak@linux.intel.com, hpa@zytor.com,
          namhyung@kernel.org, jolsa@kernel.org
In-Reply-To: <20190305144758.12397-3-andi@firstfloor.org>
References: <20190305144758.12397-3-andi@firstfloor.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf script: Support insn output for normal
 samples
Git-Commit-ID: 3ab481a1cfe1511b94e142b648e2c5ade9175ed3
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

Commit-ID:  3ab481a1cfe1511b94e142b648e2c5ade9175ed3
Gitweb:     https://git.kernel.org/tip/3ab481a1cfe1511b94e142b648e2c5ade9175ed3
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Tue, 5 Mar 2019 06:47:45 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 11 Mar 2019 11:56:02 -0300

perf script: Support insn output for normal samples

perf script -F +insn was only working for PT traces because the PT
instruction decoder was filling in the insn/insn_len sample attributes.
Support it for non PT samples too on x86 using the existing x86
instruction decoder.

This adds some extra checking to ensure that we don't try to decode
instructions when using perf.data from a different architecture.

  % perf record -a sleep 1
  % perf script -F ip,sym,insn --xed
   ffffffff811704c9 remote_function               movl  %eax, 0x18(%rbx)
   ffffffff8100bb50 intel_bts_enable_local                retq
   ffffffff81048612 native_apic_mem_write                 movl  %esi, -0xa04000(%rdi)
   ffffffff81048612 native_apic_mem_write                 movl  %esi, -0xa04000(%rdi)
   ffffffff81048612 native_apic_mem_write                 movl  %esi, -0xa04000(%rdi)
   ffffffff810f1f79 generic_exec_single           xor %eax, %eax
   ffffffff811704c9 remote_function               movl  %eax, 0x18(%rbx)
   ffffffff8100bb34 intel_bts_enable_local                movl  0x2000(%rax), %edx
   ffffffff81048610 native_apic_mem_write                 mov %edi, %edi
  ...

Committer testing:

Before:

  # perf script -F ip,sym,insn --xed | head -5
   ffffffffa4068804 native_write_msr 		addb  %al, (%rax)
   ffffffffa4068804 native_write_msr 		addb  %al, (%rax)
   ffffffffa4068804 native_write_msr 		addb  %al, (%rax)
   ffffffffa4068806 native_write_msr 		addb  %al, (%rax)
   ffffffffa4068806 native_write_msr 		addb  %al, (%rax)
  # perf script -F ip,sym,insn --xed | grep -v "addb  %al, (%rax)"
  #

After:

  # perf script -F ip,sym,insn --xed | head -5
   ffffffffa4068804 native_write_msr 		wrmsr
   ffffffffa4068804 native_write_msr 		wrmsr
   ffffffffa4068804 native_write_msr 		wrmsr
   ffffffffa4068806 native_write_msr 		nopl  %eax, (%rax,%rax,1)
   ffffffffa4068806 native_write_msr 		nopl  %eax, (%rax,%rax,1)
  # perf script -F ip,sym,insn --xed | grep -v "addb  %al, (%rax)" | head -5
   ffffffffa4068804 native_write_msr 		wrmsr
   ffffffffa4068804 native_write_msr 		wrmsr
   ffffffffa4068804 native_write_msr 		wrmsr
   ffffffffa4068806 native_write_msr 		nopl  %eax, (%rax,%rax,1)
   ffffffffa4068806 native_write_msr 		nopl  %eax, (%rax,%rax,1)
  #

More examples:

  # perf script -F ip,sym,insn --xed | grep -v native_write_msr | head
   ffffffffa416b90e tick_check_broadcast_expired 		btq  %rax, 0x1a5f42a(%rip)
   ffffffffa4956bd0 nmi_cpu_backtrace 		pushq  %r13
   ffffffffa415b95e __hrtimer_next_event_base 		movq  0x18(%rax), %rdx
   ffffffffa4956bf3 nmi_cpu_backtrace 		popq  %r12
   ffffffffa4171d5c smp_call_function_single 		pause
   ffffffffa4956bdd nmi_cpu_backtrace 		mov %ebp, %r12d
   ffffffffa4797e4d menu_select 		cmp $0x190, %rax
   ffffffffa4171d5c smp_call_function_single 		pause
   ffffffffa405a7d8 nmi_cpu_backtrace_handler 		callq  0xffffffffa4956bd0
   ffffffffa4797f7a menu_select 		shr $0x3, %rax
  #

Which matches the annotate output modulo resolving callqs:

  # perf annotate --stdio2 nmi_cpu_backtrace_handler
  Samples: 4  of event 'cycles:ppp', 4000 Hz, Event count (approx.): 35908, [percent: local period]
  nmi_cpu_backtrace_handler() /lib/modules/5.0.0+/build/vmlinux
  Percent
              Disassembly of section .text:

              ffffffff8105a7d0 <nmi_cpu_backtrace_handler>:
              nmi_cpu_backtrace_handler():
                      nmi_trigger_cpumask_backtrace(mask, exclude_self,
                                                    nmi_raise_cpu_backtrace);
              }

              static int nmi_cpu_backtrace_handler(unsigned int cmd, struct pt_regs *regs)
              {
   24.45      → callq  __fentry__
                      if (nmi_cpu_backtrace(regs))
                mov    %rsi,%rdi
   75.55      → callq  nmi_cpu_backtrace
                              return NMI_HANDLED;
                movzbl %al,%eax

                      return NMI_DONE;
              }
              ← retq
    #

  # perf annotate --stdio2 __hrtimer_next_event_base
  Samples: 4  of event 'cycles:ppp', 4000 Hz, Event count (approx.): 767977, [percent: local period]
  __hrtimer_next_event_base() /lib/modules/5.0.0+/build/vmlinux
  Percent
              Disassembly of section .text:

              ffffffff8115b910 <__hrtimer_next_event_base>:
              __hrtimer_next_event_base():

              static ktime_t __hrtimer_next_event_base(struct hrtimer_cpu_base *cpu_base,
                                                       const struct hrtimer *exclude,
                                                       unsigned int active,
                                                       ktime_t expires_next)
              {
              → callq  __fentry__
<SNIP>
          4a:   add    $0x1,%r14
   77.31        mov    0x18(%rax),%rdx
                shl    $0x6,%r14
                sub    0x38(%rbx,%r14,1),%rdx
                              if (expires < expires_next) {
                cmp    %r12,%rdx
              ↓ jge    68
<SNIP>

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20190305144758.12397-3-andi@firstfloor.org
[ Converted fetch_exe() to use the name it ended up having when merged: thread__memcpy() ]
[ archinsn.c needs the instruction decoder that is only build when CONFIG_AUXTRACE=y, fix that ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/util/Build      |  1 +
 tools/perf/arch/x86/util/archinsn.c | 26 ++++++++++++++++++++++++++
 tools/perf/builtin-script.c         | 21 ++++++++++++++++++++-
 tools/perf/util/archinsn.h          | 12 ++++++++++++
 4 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/Build
index 7aab0be5fc5f..47f9c56e744f 100644
--- a/tools/perf/arch/x86/util/Build
+++ b/tools/perf/arch/x86/util/Build
@@ -14,5 +14,6 @@ perf-$(CONFIG_LOCAL_LIBUNWIND)    += unwind-libunwind.o
 perf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
 
 perf-$(CONFIG_AUXTRACE) += auxtrace.o
+perf-$(CONFIG_AUXTRACE) += archinsn.o
 perf-$(CONFIG_AUXTRACE) += intel-pt.o
 perf-$(CONFIG_AUXTRACE) += intel-bts.o
diff --git a/tools/perf/arch/x86/util/archinsn.c b/tools/perf/arch/x86/util/archinsn.c
new file mode 100644
index 000000000000..4237bb2e7fa2
--- /dev/null
+++ b/tools/perf/arch/x86/util/archinsn.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "perf.h"
+#include "archinsn.h"
+#include "util/intel-pt-decoder/insn.h"
+#include "machine.h"
+#include "thread.h"
+#include "symbol.h"
+
+void arch_fetch_insn(struct perf_sample *sample,
+		     struct thread *thread,
+		     struct machine *machine)
+{
+	struct insn insn;
+	int len;
+	bool is64bit = false;
+
+	if (!sample->ip)
+		return;
+	len = thread__memcpy(thread, machine, sample->insn, sample->ip, sizeof(sample->insn), &is64bit);
+	if (len <= 0)
+		return;
+	insn_init(&insn, sample->insn, len, is64bit);
+	insn_get_length(&insn);
+	if (insn_complete(&insn) && insn.length <= len)
+		sample->insn_len = insn.length;
+}
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 53f78cf3113f..a5080afd361d 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -29,10 +29,12 @@
 #include "util/time-utils.h"
 #include "util/path.h"
 #include "print_binary.h"
+#include "archinsn.h"
 #include <linux/bitmap.h>
 #include <linux/kernel.h>
 #include <linux/stringify.h>
 #include <linux/time64.h>
+#include <sys/utsname.h>
 #include "asm/bug.h"
 #include "util/mem-events.h"
 #include "util/dump-insn.h"
@@ -63,6 +65,7 @@ static const char		*cpu_list;
 static DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
 static struct perf_stat_config	stat_config;
 static int			max_blocks;
+static bool			native_arch;
 
 unsigned int scripting_max_stack = PERF_MAX_STACK_DEPTH;
 
@@ -1227,6 +1230,12 @@ static int perf_sample__fprintf_callindent(struct perf_sample *sample,
 	return len + dlen;
 }
 
+__weak void arch_fetch_insn(struct perf_sample *sample __maybe_unused,
+			    struct thread *thread __maybe_unused,
+			    struct machine *machine __maybe_unused)
+{
+}
+
 static int perf_sample__fprintf_insn(struct perf_sample *sample,
 				     struct perf_event_attr *attr,
 				     struct thread *thread,
@@ -1234,9 +1243,12 @@ static int perf_sample__fprintf_insn(struct perf_sample *sample,
 {
 	int printed = 0;
 
+	if (sample->insn_len == 0 && native_arch)
+		arch_fetch_insn(sample, thread, machine);
+
 	if (PRINT_FIELD(INSNLEN))
 		printed += fprintf(fp, " ilen: %d", sample->insn_len);
-	if (PRINT_FIELD(INSN)) {
+	if (PRINT_FIELD(INSN) && sample->insn_len) {
 		int i;
 
 		printed += fprintf(fp, " insn:");
@@ -3277,6 +3289,7 @@ int cmd_script(int argc, const char **argv)
 		.set = false,
 		.default_no_sample = true,
 	};
+	struct utsname uts;
 	char *script_path = NULL;
 	const char **__argv;
 	int i, j, err = 0;
@@ -3615,6 +3628,12 @@ int cmd_script(int argc, const char **argv)
 	if (symbol__init(&session->header.env) < 0)
 		goto out_delete;
 
+	uname(&uts);
+	if (!strcmp(uts.machine, session->header.env.arch) ||
+	    (!strcmp(uts.machine, "x86_64") &&
+	     !strcmp(session->header.env.arch, "i386")))
+		native_arch = true;
+
 	script.session = session;
 	script__setup_sample_type(&script);
 
diff --git a/tools/perf/util/archinsn.h b/tools/perf/util/archinsn.h
new file mode 100644
index 000000000000..448cbb6b8d7e
--- /dev/null
+++ b/tools/perf/util/archinsn.h
@@ -0,0 +1,12 @@
+#ifndef INSN_H
+#define INSN_H 1
+
+struct perf_sample;
+struct machine;
+struct thread;
+
+void arch_fetch_insn(struct perf_sample *sample,
+		     struct thread *thread,
+		     struct machine *machine);
+
+#endif
