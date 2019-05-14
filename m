Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5AFC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 20:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5649E20879
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 20:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfENUUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 16:20:15 -0400
Received: from mga09.intel.com ([134.134.136.24]:23576 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbfENUUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 16:20:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 May 2019 13:20:09 -0700
X-ExtLoop1: 1
Received: from otc-lr-04.jf.intel.com ([10.54.39.157])
  by fmsmga006.fm.intel.com with ESMTP; 14 May 2019 13:20:09 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, jolsa@kernel.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 3/3] perf regs x86: Add X86 specific arch__intr_reg_mask()
Date:   Tue, 14 May 2019 13:19:34 -0700
Message-Id: <1557865174-56264-3-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557865174-56264-1-git-send-email-kan.liang@linux.intel.com>
References: <1557865174-56264-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

XMM registers can be collected on Icelake and later platforms.

Add specific arch__intr_reg_mask(), which creating an event to check if
the kernel and hardware can collect XMM registers.

Test on Skylake which doesn't support XMM registers collection. There is
nothing changed.

   #perf record -I?
   available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9
   R10 R11 R12 R13 R14 R15

   Usage: perf record [<options>] [<command>]
    or: perf record [<options>] -- <command> [<options>]

    -I, --intr-regs[=<any register>]
                          sample selected machine registers on
   interrupt, use '-I?' to list register names

   #perf record -I
   [ perf record: Woken up 1 times to write data ]
   [ perf record: Captured and wrote 0.905 MB perf.data (2520 samples) ]

   #perf evlist -v
   cycles: size: 112, { sample_period, sample_freq }: 4000, sample_type:
   IP|TID|TIME|CPU|PERIOD|REGS_INTR, read_format: ID, disabled: 1,
   inherit: 1, mmap: 1, comm: 1, freq: 1, task: 1, precise_ip: 3,
   sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol:
   1, bpf_event: 1, sample_regs_intr: 0xff0fff

Test on Icelake which support XMM registers collection.

   #perf record -I?
   available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10
   R11 R12 R13 R14 R15 XMM0 XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 XMM9
   XMM10 XMM11 XMM12 XMM13 XMM14 XMM15

   Usage: perf record [<options>] [<command>]
    or: perf record [<options>] -- <command> [<options>]

    -I, --intr-regs[=<any register>]
                          sample selected machine registers on
   interrupt, use '-I?' to list register names

   #perf record -I
   [ perf record: Woken up 1 times to write data ]
   [ perf record: Captured and wrote 0.800 MB perf.data (318 samples) ]

   #perf evlist -v
   cycles: size: 112, { sample_period, sample_freq }: 4000, sample_type:
   IP|TID|TIME|CPU|PERIOD|REGS_INTR, read_format: ID, disabled: 1,
   inherit: 1, mmap: 1, comm: 1, freq: 1, task: 1, precise_ip: 3,
   sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol:
   1, bpf_event: 1, sample_regs_intr: 0xffffffff00ff0fff

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V1:
- Add specific arch__intr_reg_mask() support
  Drop specific has_non_gprs_support() and non_gprs_mask()

 tools/perf/arch/x86/include/perf_regs.h |  1 +
 tools/perf/arch/x86/util/perf_regs.c    | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/tools/perf/arch/x86/include/perf_regs.h b/tools/perf/arch/x86/include/perf_regs.h
index b732133..b7cd91a 100644
--- a/tools/perf/arch/x86/include/perf_regs.h
+++ b/tools/perf/arch/x86/include/perf_regs.h
@@ -9,6 +9,7 @@
 void perf_regs_load(u64 *regs);
 
 #define PERF_REGS_MAX PERF_REG_X86_XMM_MAX
+#define PERF_XMM_REGS_MASK	(~((1ULL << PERF_REG_X86_XMM0) - 1))
 #ifndef HAVE_ARCH_X86_64_SUPPORT
 #define PERF_REGS_MASK ((1ULL << PERF_REG_X86_32_MAX) - 1)
 #define PERF_SAMPLE_REGS_ABI PERF_SAMPLE_REGS_ABI_32
diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/arch/x86/util/perf_regs.c
index 71d7604..c3d7479 100644
--- a/tools/perf/arch/x86/util/perf_regs.c
+++ b/tools/perf/arch/x86/util/perf_regs.c
@@ -270,3 +270,28 @@ int arch_sdt_arg_parse_op(char *old_op, char **new_op)
 
 	return SDT_ARG_VALID;
 }
+
+uint64_t arch__intr_reg_mask(void)
+{
+	struct perf_event_attr attr = {
+		.type			= PERF_TYPE_HARDWARE,
+		.config			= PERF_COUNT_HW_CPU_CYCLES,
+		.sample_period		= 1,
+		.sample_type		= PERF_SAMPLE_REGS_INTR,
+		.sample_regs_intr	= PERF_XMM_REGS_MASK,
+		.precise_ip		= 1,
+		.disabled 		= 1,
+		.exclude_kernel		= 1,
+	};
+	int fd;
+
+	event_attr_init(&attr);
+
+	fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
+	if (fd != -1) {
+		close(fd);
+		return (PERF_XMM_REGS_MASK | PERF_REGS_MASK);
+	}
+
+	return PERF_REGS_MASK;
+}
-- 
2.7.4

