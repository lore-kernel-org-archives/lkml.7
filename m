Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BA0C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AE32216FD
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558122076;
	bh=F3BEMl8o9kO4AIxXMmyZHB6wzw2jrs6GGBbgsDOY9Mo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WmruO+1QC9lmV6hdQE/QjuAItIvCsWdltvRSo5gPBJNjRwsQmj+GTitsWP4Ccbtb1
	 YLsz6CTJpGy8QYLOWweMTe+NwnDXf6KXNgyx8CdNUx7ikpgd2PRkQ75P/40YK+SDxU
	 KoDUwBybo+urCo1A2LcavCRPSLrcreGnV04SUpMo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbfEQTlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 15:41:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:58028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726648AbfEQTlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 15:41:13 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68483217D9;
        Fri, 17 May 2019 19:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558122072;
        bh=F3BEMl8o9kO4AIxXMmyZHB6wzw2jrs6GGBbgsDOY9Mo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r6jg9LxKI9WbWmLWQUgUzZ5yKPHl5KPG5/CFMgII5iXuRYPimYkBUK+HIPWzYQBea
         MMJ/UXTcF1wlr+04MaqZ77lm1H3tbOmde106fHvrQ7knf1tf3WkqLFITt63cYElCJl
         MFyNVxDL0kND1D/5J/zH1/9c767OfiPFNyyI4hmc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 66/73] perf regs x86: Add X86 specific arch__intr_reg_mask()
Date:   Fri, 17 May 2019 16:36:04 -0300
Message-Id: <20190517193611.4974-67-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190517193611.4974-1-acme@kernel.org>
References: <20190517193611.4974-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Committer notes:

Don't set attr.sample_period as a named struct init, as it is part of an
unnamed union in 'struct perf_event_attr', and doing so breaks the build
on older gcc versions, such as:

  gcc version 4.1.2 20080704 (Red Hat 4.1.2-55)
  gcc version 4.4.7 20120313 (Red Hat 4.4.7-23) (GCC)

  arch/x86/util/perf_regs.c: In function 'arch__intr_reg_mask':
  arch/x86/util/perf_regs.c:279: error: unknown field 'sample_period' specified in initializer
  cc1: warnings being treated as errors
  arch/x86/util/perf_regs.c:279: warning: missing braces around initializer
  arch/x86/util/perf_regs.c:279: warning: (near initialization for 'attr.<anonymous>')

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
[ Only on a lenovo t480s, a skylake machine, where the XMM registers didn't show up in -I?/--user-regs=? as expected ]
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/1557865174-56264-3-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/include/perf_regs.h |  1 +
 tools/perf/arch/x86/util/perf_regs.c    | 28 +++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/tools/perf/arch/x86/include/perf_regs.h b/tools/perf/arch/x86/include/perf_regs.h
index b7321337d100..b7cd91a9014f 100644
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
index 71d7604dbf0b..7886ca5263e3 100644
--- a/tools/perf/arch/x86/util/perf_regs.c
+++ b/tools/perf/arch/x86/util/perf_regs.c
@@ -270,3 +270,31 @@ int arch_sdt_arg_parse_op(char *old_op, char **new_op)
 
 	return SDT_ARG_VALID;
 }
+
+uint64_t arch__intr_reg_mask(void)
+{
+	struct perf_event_attr attr = {
+		.type			= PERF_TYPE_HARDWARE,
+		.config			= PERF_COUNT_HW_CPU_CYCLES,
+		.sample_type		= PERF_SAMPLE_REGS_INTR,
+		.sample_regs_intr	= PERF_XMM_REGS_MASK,
+		.precise_ip		= 1,
+		.disabled 		= 1,
+		.exclude_kernel		= 1,
+	};
+	int fd;
+	/*
+	 * In an unnamed union, init it here to build on older gcc versions
+	 */
+	attr.sample_period = 1;
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
2.20.1

