Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F081DC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 07:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDBC12084F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 07:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbfLDHyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 02:54:52 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56149 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbfLDHyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 02:54:08 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1icPTy-0004RW-MZ; Wed, 04 Dec 2019 08:53:58 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5BF111C2645;
        Wed,  4 Dec 2019 08:53:53 +0100 (CET)
Date:   Wed, 04 Dec 2019 07:53:53 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] tools arch x86: Sync the msr-index.h copy with the
 kernel sources
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jan Beulich <jbeulich@suse.com>, Jiri Olsa <jolsa@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vineela Tummalapalli <vineela.tummalapalli@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <tip-n1xd78fpd5lxn4q1brqi2jl6@git.kernel.org>
References: <tip-n1xd78fpd5lxn4q1brqi2jl6@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157544603328.21853.231158169533011783.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     8122b047dd18ef6e7e1c564e28f3c7067c5a2d71
Gitweb:        https://git.kernel.org/tip/8122b047dd18ef6e7e1c564e28f3c7067c5a2d71
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 02 Dec 2019 12:03:49 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 02 Dec 2019 12:03:49 -03:00

tools arch x86: Sync the msr-index.h copy with the kernel sources

To pick up the changes from these csets:

  3f3c8be973af Merge tag 'for-linus-5.5a-rc1-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip
  4e3f77d8419b ("xen/mcelog: add PPIN to record when available")
  db4d30fbb71b ("x86/bugs: Add ITLB_MULTIHIT bug infrastructure")
  1b42f017415b ("x86/speculation/taa: Add mitigation for TSX Async Abort")
  c2955f270a84 ("x86/msr: Add the IA32_TSX_CTRL MSR")

These are the changes in tooling that this udpate ensues:

  $ tools/perf/trace/beauty/tracepoints/x86_msr.sh > /tmp/before
  $
  $ cp arch/x86/include/asm/msr-index.h tools/arch/x86/include/asm/msr-index.h
  $
  $ tools/perf/trace/beauty/tracepoints/x86_msr.sh > /tmp/after
  $ diff -u /tmp/before /tmp/after
  --- /tmp/before	2019-12-02 11:54:44.371035723 -0300
  +++ /tmp/after	2019-12-02 11:55:31.847859784 -0300
  @@ -48,6 +48,7 @@
   	[0x00000119] = "IA32_BBL_CR_CTL",
   	[0x0000011e] = "IA32_BBL_CR_CTL3",
   	[0x00000120] = "IDT_MCR_CTRL",
  +	[0x00000122] = "IA32_TSX_CTRL",
   	[0x00000140] = "MISC_FEATURES_ENABLES",
   	[0x00000174] = "IA32_SYSENTER_CS",
   	[0x00000175] = "IA32_SYSENTER_ESP",
  @@ -283,4 +284,6 @@
   	[0xc0010240 - x86_AMD_V_KVM_MSRs_offset] = "F15H_NB_PERF_CTL",
   	[0xc0010241 - x86_AMD_V_KVM_MSRs_offset] = "F15H_NB_PERF_CTR",
   	[0xc0010280 - x86_AMD_V_KVM_MSRs_offset] = "F15H_PTSC",
  +	[0xc00102f0 - x86_AMD_V_KVM_MSRs_offset] = "AMD_PPIN_CTL",
  +	[0xc00102f1 - x86_AMD_V_KVM_MSRs_offset] = "AMD_PPIN",
   };
  $

  CC       /tmp/build/perf/trace/beauty/tracepoints/x86_msr.o
  LD       /tmp/build/perf/trace/beauty/tracepoints/perf-in.o
  LD       /tmp/build/perf/trace/beauty/perf-in.o
  LD       /tmp/build/perf/perf-in.o

Now it is possible to use these strings when setting up filters for the msr:*
tracepoints, like:

  # perf trace -e msr:* --filter=msr==IA32_TSX_CTRL
  ^C[root@quaco ~]#

If we use an invalid operator we can check what is the filter that is put in
place:

  # perf trace -e msr:* --filter=msr=IA32_TSX_CTRL
  Failed to set filter "(msr=0x122) && (common_pid != 25976 && common_pid != 25860)" on event msr:read_msr with 22 (Invalid argument)

One can as well use -v to see the tracepoints and its filters:

  # perf trace -v -e msr:* --filter=msr==IA32_TSX_CTRL
  Using CPUID GenuineIntel-6-8E-A
  New filter for msr:read_msr: (msr==0x122) && (common_pid != 26110 && common_pid != 25860)
  New filter for msr:write_msr: (msr==0x122) && (common_pid != 26110 && common_pid != 25860)
  New filter for msr:rdpmc: (msr==0x122) && (common_pid != 26110 && common_pid != 25860)
  mmap size 528384B
  ^C#

Better than keep looking up those numbers, works with callchains as
well, e.g. for something more common:

  # perf trace -e msr:*/max-stack=16/ --filter="msr==IA32_SPEC_CTRL" --max-events=2
       0.000 SCTP timer/6158 msr:write_msr(msr: IA32_SPEC_CTRL, val: 6)
                                         do_trace_write_msr ([kernel.kallsyms])
                                         do_trace_write_msr ([kernel.kallsyms])
                                         __switch_to_xtra ([kernel.kallsyms])
                                         __switch_to ([kernel.kallsyms])
                                         __sched_text_start ([kernel.kallsyms])
                                         schedule ([kernel.kallsyms])
                                         schedule_hrtimeout_range_clock ([kernel.kallsyms])
                                         poll_schedule_timeout.constprop.0 ([kernel.kallsyms])
                                         do_select ([kernel.kallsyms])
                                         core_sys_select ([kernel.kallsyms])
                                         kern_select ([kernel.kallsyms])
                                         __x64_sys_select ([kernel.kallsyms])
                                         do_syscall_64 ([kernel.kallsyms])
                                         entry_SYSCALL_64 ([kernel.kallsyms])
                                         __select (/usr/lib64/libc-2.29.so)
                                         [0] ([unknown])
       0.024 :0/0 msr:write_msr(msr: IA32_SPEC_CTRL)
                                         do_trace_write_msr ([kernel.kallsyms])
                                         do_trace_write_msr ([kernel.kallsyms])
                                         __switch_to_xtra ([kernel.kallsyms])
                                         __switch_to ([kernel.kallsyms])
                                         __sched_text_start ([kernel.kallsyms])
                                         schedule_idle ([kernel.kallsyms])
                                         do_idle ([kernel.kallsyms])
                                         cpu_startup_entry ([kernel.kallsyms])
                                         start_secondary ([kernel.kallsyms])
                                         [0x2000d4] ([kernel.kallsyms])
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jan Beulich <jbeulich@suse.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vineela Tummalapalli <vineela.tummalapalli@intel.com>
Link: https://lkml.kernel.org/n/tip-n1xd78fpd5lxn4q1brqi2jl6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/msr-index.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index 20ce682..084e98d 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -93,6 +93,18 @@
 						  * Microarchitectural Data
 						  * Sampling (MDS) vulnerabilities.
 						  */
+#define ARCH_CAP_PSCHANGE_MC_NO		BIT(6)	 /*
+						  * The processor is not susceptible to a
+						  * machine check error due to modifying the
+						  * code page size along with either the
+						  * physical address or cache type
+						  * without TLB invalidation.
+						  */
+#define ARCH_CAP_TSX_CTRL_MSR		BIT(7)	/* MSR for TSX control is available. */
+#define ARCH_CAP_TAA_NO			BIT(8)	/*
+						 * Not susceptible to
+						 * TSX Async Abort (TAA) vulnerabilities.
+						 */
 
 #define MSR_IA32_FLUSH_CMD		0x0000010b
 #define L1D_FLUSH			BIT(0)	/*
@@ -103,6 +115,10 @@
 #define MSR_IA32_BBL_CR_CTL		0x00000119
 #define MSR_IA32_BBL_CR_CTL3		0x0000011e
 
+#define MSR_IA32_TSX_CTRL		0x00000122
+#define TSX_CTRL_RTM_DISABLE		BIT(0)	/* Disable RTM feature */
+#define TSX_CTRL_CPUID_CLEAR		BIT(1)	/* Disable TSX enumeration */
+
 #define MSR_IA32_SYSENTER_CS		0x00000174
 #define MSR_IA32_SYSENTER_ESP		0x00000175
 #define MSR_IA32_SYSENTER_EIP		0x00000176
@@ -393,6 +409,8 @@
 #define MSR_AMD_PSTATE_DEF_BASE		0xc0010064
 #define MSR_AMD64_OSVW_ID_LENGTH	0xc0010140
 #define MSR_AMD64_OSVW_STATUS		0xc0010141
+#define MSR_AMD_PPIN_CTL		0xc00102f0
+#define MSR_AMD_PPIN			0xc00102f1
 #define MSR_AMD64_LS_CFG		0xc0011020
 #define MSR_AMD64_DC_CFG		0xc0011022
 #define MSR_AMD64_BU_CFG2		0xc001102a
