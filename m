Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0BECA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 06:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA58320856
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 06:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437678AbfJXGBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 02:01:23 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:55705 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2437466AbfJXGBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 02:01:22 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436418|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.199964-0.0374202-0.762616;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03289;MF=han_mao@c-sky.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.FpdA-Fy_1571896877;
Received: from localhost(mailfrom:han_mao@c-sky.com fp:SMTPD_---.FpdA-Fy_1571896877)
          by smtp.aliyun-inc.com(10.147.42.16);
          Thu, 24 Oct 2019 14:01:17 +0800
Date:   Thu, 24 Oct 2019 14:01:17 +0800
From:   Mao Han <han_mao@c-sky.com>
To:     Nick Kossifidis <mick@ics.forth.gr>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Perf-related compilation issues
Message-ID: <20191024060116.GA786@vmh-VirtualBox>
References: <1bba622b-1f59-d21b-f396-d9c1a021dc3a@ics.forth.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bba622b-1f59-d21b-f396-d9c1a021dc3a@ics.forth.gr>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 06:15:43PM +0300, Nick Kossifidis wrote:
> Hello all,
> 
> a) Compiling the current fixes branch with a minimal config I get the
> following error:
> 
> riscv64-unknown-linux-gnu-ld: arch/riscv/kernel/perf_callchain.o: in
> function `.L0 ':
> perf_callchain.c:(.text+0x16a): undefined reference to `walk_stackframe'
> make: *** [Makefile:1074: vmlinux] Error 1
> 
> 
> I've removed the static delcaration of walk_stackframe on stackframe.c
> and marked walk_stackframe as extern on perf_callchain.c to fix the
> above issue.
>

Beside the compile problem caused by:
[PATCH v3 5/8] riscv: mark some code and data as file-static
similar issue may happen when CONFIG_FRAME_POINTER is not defined.
I didn't see the CONFIG_FRAME_POINTER in stacktrace.c, and the 
conditional for !CONFIG_FRAME_POINTER looks quite strange, keep
adding the sp and read pc from that?

        ksp = (unsigned long *)sp;
        while (!kstack_end(ksp)) {
                if (__kernel_text_address(pc) && unlikely(fn(pc, arg)))
                        break;
                pc = (*ksp++) - 0x4;
        }

A conditional for perf_callchain_kernel might be properly to fix that.
--- a/arch/riscv/kernel/perf_callchain.c
+++ b/arch/riscv/kernel/perf_callchain.c
+#ifdef CONFIG_FRAME_POINTER
 void notrace walk_stackframe(struct task_struct *task,
        struct pt_regs *regs, bool (*fn)(unsigned long, void *), void *arg);
 void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
@@ -92,3 +93,4 @@ void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
 
        walk_stackframe(NULL, regs, fill_callchain, entry);
 }
+#endif


> 
> b) Then If I compile the kernel without CONFIG_RISCV_BASE_PMU I get
> 
> 
> ./arch/riscv/include/asm/perf_event.h:26:2: error: #error "Please
> provide a valid RISCV_MAX_COUNTERS for the PMU."
>  #error "Please provide a valid RISCV_MAX_COUNTERS for the PMU."
> 
> 
> I noticed that the only place where CONFIG_RISCV_BASE_PMU is checked is
> on perf_event.h and only for this parameter that's not defined anywhere
> else. So for now if one tries to compile the kernel without PMU the
> kernel won't compile + I don't see how unsetting this saves code size as
> the config description says.
> 

The content inside perf_event.h mostly relate to HW PMU. Other
architectures normally put them inside perf_event.c or pmu.h, they are
not compiled when CONFIG_PERF_EVENTS is selected and HW PMU is not
selected, user can use software event under this configuration.
Base pmu shouldn't be registed when it is defined in dts.
I think it can be fixed by put the content inside perf_event.h
into a riscv_pmu.h, only compile perf_event.c when CONFIG_RISCV_BASE_PMU
is selected or add conditional inside it:

--- a/arch/riscv/kernel/perf_event.c
+++ b/arch/riscv/kernel/perf_event.c
@@ -474,12 +474,13 @@ int __init init_hw_perf_events(void)
        if (node) {
                of_id = of_match_node(riscv_pmu_of_ids, node);
 
-               if (of_id)
+               if (of_id) {
                        riscv_pmu = of_id->data;
+                       perf_pmu_register(riscv_pmu->pmu, "cpu", PERF_TYPE_RAW);
+               }
                of_node_put(node);
        }
 
-       perf_pmu_register(riscv_pmu->pmu, "cpu", PERF_TYPE_RAW);
        return 0;
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -38,7 +38,7 @@ obj-$(CONFIG_MODULE_SECTIONS) += module-sections.o
 obj-$(CONFIG_FUNCTION_TRACER)  += mcount.o ftrace.o
 obj-$(CONFIG_DYNAMIC_FTRACE)   += mcount-dyn.o
 
-obj-$(CONFIG_PERF_EVENTS)      += perf_event.o
+obj-$(CONFIG_RISCV_BASE_PMU)   += perf_event.o
 obj-$(CONFIG_PERF_EVENTS)      += perf_callchain.o
 obj-$(CONFIG_HAVE_PERF_REGS)   += perf_regs.o

Thanks,
Mao Han
