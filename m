Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A9EC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 741C3208E4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKLUNnPr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfCHNhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:37:52 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41296 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfCHNhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 08:37:52 -0500
Received: by mail-qt1-f193.google.com with SMTP id v10so21157453qtp.8;
        Fri, 08 Mar 2019 05:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=a1rByFYv4+X1mG6QH9j6kaPK6kXBYHfgLqTu8M3VlKE=;
        b=cKLUNnPrTdDTBiWSqZU8N8WwBFPKGBPKP3rvCIWiVsxH7SxGwLMbkRzkf9TAT0UCsk
         bi5YA3e1lOWA+SAfIGfKH3Q/TqggfZVGpS3im7PYgN5xJKSM9RhRkERBOASfB5yzN+1E
         ocjZ+h2QhKPALey0jAepsV3c5w46KA5QS8lIi6ceAo2m6mMkaKcVGmvKK0DzE4hzk8Yt
         7O220NwkjlOX0DFLeD9rBmvjwbNHn23j+Q8NytN3f5AW4QRLj6Ml1H4IgjRXMpqwAtg9
         RB75h4UMkuSdqify9+swWsuGtmrmYdbiTI8cIoneTdhfecCh1tKgUzSdaCmKMsqIPbP6
         dqxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=a1rByFYv4+X1mG6QH9j6kaPK6kXBYHfgLqTu8M3VlKE=;
        b=s5Mev4Rm8YvP0wBrUNaDAl9DEh266KArqVU5Wxh1BtOt3WagnwDOv3uIq/VmLsFf6L
         uVyJf6PyB4fGCksiunn4RTDDAjcHg9BXyb5fqKbcAyQuPPd10k1501tgKKG9jGwWWGgb
         RIZujmlRycgJrcnoM9YE3scxLRdp5UM81kUSC66ZWTu7XvRnmsgU1xgHI6ZvgroZajBt
         16JMoTbpt9PuEBI7mUqez9v0xZSSzgbhVyL5QReSgvJj8L2fAstv7vc7vzoQ42SqCgyC
         05EKb62sUIBp95D2umqZIdnUth/FVVM9ZuSRUCYguIZCOUk6+BP/6yFSzLazKU/JamPK
         ttwA==
X-Gm-Message-State: APjAAAVuq/LP64A76+jmZbGvpBfVZZ/NERVPemktuNLy+neYwZTc1X1d
        wM8mHlO/LmGZwFMPJCJRX7bqTjH22FA=
X-Google-Smtp-Source: APXvYqytNSVYv46XePhYeKqK63ihhfGPQcRhiEMtwDX0mdNqRVmLoBTNWL9ElvtZKrGWS/OOoyY63A==
X-Received: by 2002:ac8:3361:: with SMTP id u30mr14790049qta.5.1552052270331;
        Fri, 08 Mar 2019 05:37:50 -0800 (PST)
Received: from quaco.ghostprotocols.net (177-59-154-188.3g.claro.net.br. [177.59.154.188])
        by smtp.gmail.com with ESMTPSA id f58sm4927100qtc.14.2019.03.08.05.37.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Mar 2019 05:37:49 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 42F7C4039C; Fri,  8 Mar 2019 10:37:43 -0300 (-03)
Date:   Fri, 8 Mar 2019 10:37:43 -0300
To:     Andi Kleen <andi@firstfloor.org>
Cc:     jolsa@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v4 02/15] perf tools script: Support insn output for
 normal samples
Message-ID: <20190308133743.GA26260@kernel.org>
References: <20190305144758.12397-1-andi@firstfloor.org>
 <20190305144758.12397-3-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190305144758.12397-3-andi@firstfloor.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 05, 2019 at 06:47:45AM -0800, Andi Kleen escreveu:
> From: Andi Kleen <ak@linux.intel.com>
> 
> perf script -F +insn was only working for PT traces because
> the PT instruction decoder was filling in the insn/insn_len
> sample attributes. Support it for non PT samples too on x86
> using the existing x86 instruction decoder.
> 
> This adds some extra checking to ensure that we don't try
> to decode instructions when using perf.data from a different
> architecture.
> 
> % perf record -a sleep 1
> % perf script -F ip,sym,insn --xed
>  ffffffff811704c9 remote_function               movl  %eax, 0x18(%rbx)
>  ffffffff8100bb50 intel_bts_enable_local                retq
>  ffffffff81048612 native_apic_mem_write                 movl  %esi, -0xa04000(%rdi)
>  ffffffff81048612 native_apic_mem_write                 movl  %esi, -0xa04000(%rdi)
>  ffffffff81048612 native_apic_mem_write                 movl  %esi, -0xa04000(%rdi)
>  ffffffff810f1f79 generic_exec_single           xor %eax, %eax
>  ffffffff811704c9 remote_function               movl  %eax, 0x18(%rbx)
>  ffffffff8100bb34 intel_bts_enable_local                movl  0x2000(%rax), %edx
>  ffffffff81048610 native_apic_mem_write                 mov %edi, %edi
> ...
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> 
> ---
> v2:
> Avoid printing instruction when empty
> Only decode when perf.data file was collected on same architecture

Thanks, applied and added some testing notes comparing the output with
the one from 'perf annotate --stdio2':

commit 2109d7fa73200bc6ff7abe909b5fe821224f98b3
Author: Andi Kleen <ak@linux.intel.com>
Date:   Tue Mar 5 06:47:45 2019 -0800

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
       ffffffffa4068804 native_write_msr            addb  %al, (%rax)
       ffffffffa4068804 native_write_msr            addb  %al, (%rax)
       ffffffffa4068804 native_write_msr            addb  %al, (%rax)
       ffffffffa4068806 native_write_msr            addb  %al, (%rax)
       ffffffffa4068806 native_write_msr            addb  %al, (%rax)
      # perf script -F ip,sym,insn --xed | grep -v "addb  %al, (%rax)"
      #
    
    After:
    
      # perf script -F ip,sym,insn --xed | head -5
       ffffffffa4068804 native_write_msr            wrmsr
       ffffffffa4068804 native_write_msr            wrmsr
       ffffffffa4068804 native_write_msr            wrmsr
       ffffffffa4068806 native_write_msr            nopl  %eax, (%rax,%rax,1)
       ffffffffa4068806 native_write_msr            nopl  %eax, (%rax,%rax,1)
      # perf script -F ip,sym,insn --xed | grep -v "addb  %al, (%rax)" | head -5
       ffffffffa4068804 native_write_msr            wrmsr
       ffffffffa4068804 native_write_msr            wrmsr
       ffffffffa4068804 native_write_msr            wrmsr
       ffffffffa4068806 native_write_msr            nopl  %eax, (%rax,%rax,1)
       ffffffffa4068806 native_write_msr            nopl  %eax, (%rax,%rax,1)
      #
    
    More examples:
    
      # perf script -F ip,sym,insn --xed | grep -v native_write_msr | head
       ffffffffa416b90e tick_check_broadcast_expired                btq  %rax, 0x1a5f42a(%rip)
       ffffffffa4956bd0 nmi_cpu_backtrace           pushq  %r13
       ffffffffa415b95e __hrtimer_next_event_base           movq  0x18(%rax), %rdx
       ffffffffa4956bf3 nmi_cpu_backtrace           popq  %r12
       ffffffffa4171d5c smp_call_function_single            pause
       ffffffffa4956bdd nmi_cpu_backtrace           mov %ebp, %r12d
       ffffffffa4797e4d menu_select                 cmp $0x190, %rax
       ffffffffa4171d5c smp_call_function_single            pause
       ffffffffa405a7d8 nmi_cpu_backtrace_handler           callq  0xffffffffa4956bd0
       ffffffffa4797f7a menu_select                 shr $0x3, %rax
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
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/Build
index 7aab0be5fc5f..7b8e69bbbdfe 100644
--- a/tools/perf/arch/x86/util/Build
+++ b/tools/perf/arch/x86/util/Build
@@ -6,6 +6,7 @@ perf-y += perf_regs.o
 perf-y += group.o
 perf-y += machine.o
 perf-y += event.o
+perf-y += archinsn.o
 
 perf-$(CONFIG_DWARF) += dwarf-regs.o
 perf-$(CONFIG_BPF_PROLOGUE) += dwarf-regs.o
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
