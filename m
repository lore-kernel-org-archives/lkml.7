Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8185BC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D9D121734
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558121842;
	bh=yggLRxzJ4nG3QZuc5+2I/LVsvKOE4fhvAhKid/PTmYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EaWHeX+XjRlmo0/jZWF5N5GoDGHSoDonHepwYSxO/Dmche3GoEwTVKdoRu6z9tj/b
	 iM0PH60hnPNal8kS8or15cjZ0XJM/paBZNWwqgk3EQ6CU54T7UkpPv07b/8Bmd/0YS
	 L58P+0ZRcUtEd3ctXah2N6DM2ycPpqa1WBtrqmZQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729528AbfEQThV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 15:37:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:51194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727225AbfEQThT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 15:37:19 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B57712087B;
        Fri, 17 May 2019 19:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558121838;
        bh=yggLRxzJ4nG3QZuc5+2I/LVsvKOE4fhvAhKid/PTmYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ek8MAFkzr2oqVZknZ2bY7wCNhpbOeJ/y/Hjo3iME1ZKgQex+6awQ7eHjQkCZ/gC6N
         xIrP/HHUgUUf/J5eph14f0WK1xi754ExBR9bLo4adW5/V+v7BuM/gjDFXLtF4AxFD9
         zHxfTs1S9RBKYvuMxK/6RclHHX0P3o0BOEmXmvYg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 12/73] perf tools x86: Add support for recording and printing XMM registers
Date:   Fri, 17 May 2019 16:35:10 -0300
Message-Id: <20190517193611.4974-13-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190517193611.4974-1-acme@kernel.org>
References: <20190517193611.4974-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Icelake and later platforms support collecting XMM registers with PEBS
event.

Add support for 'perf script' to dump them, and support for the register
parser in 'perf record -I=' ... to configure them.

For now they are just printed in hex, we could potentially later add
other formats too.

Committer testing:

Before:

  # perf record -IXMM0
  Warning:
  unknown register XMM0, check man page or run 'perf record -I?'

   Usage: perf record [<options>] [<command>]
      or: perf record [<options>] -- <command> [<options>]

  #
  # perf record -I?
  available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10 R11 R12 R13 R14 R15

   Usage: perf record [<options>] [<command>]
      or: perf record [<options>] -- <command> [<options>]
  #

After:

  # perf record -IXMM0
  Error:
  The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (cycles).
  /bin/dmesg | grep -i perf may provide additional information.

  #
  # perf record -I?
  available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10 R11 R12 R13 R14 R15 XMM0 XMM1 XMM2 XMM3 XMM4 XMM5 XMM6 XMM7 XMM8 XMM9 XMM10 XMM11 XMM12 XMM13 XMM14 XMM15

   Usage: perf record [<options>] [<command>]
      or: perf record [<options>] -- <command> [<options>]

      -I, --intr-regs[=<any register>]
                            sample selected machine registers on interrupt, use -I ? to list register names
  #

More work is needed to, when faced with such error, warn the user that
that register is not available on the running platform.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190506141926.13659-1-kan.liang@linux.intel.com
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/include/perf_regs.h | 25 +++++++++++++++++++++++--
 tools/perf/arch/x86/util/perf_regs.c    | 16 ++++++++++++++++
 tools/perf/util/perf_regs.h             |  1 +
 3 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/x86/include/perf_regs.h b/tools/perf/arch/x86/include/perf_regs.h
index 7f6d538f8a89..b7321337d100 100644
--- a/tools/perf/arch/x86/include/perf_regs.h
+++ b/tools/perf/arch/x86/include/perf_regs.h
@@ -8,9 +8,9 @@
 
 void perf_regs_load(u64 *regs);
 
+#define PERF_REGS_MAX PERF_REG_X86_XMM_MAX
 #ifndef HAVE_ARCH_X86_64_SUPPORT
 #define PERF_REGS_MASK ((1ULL << PERF_REG_X86_32_MAX) - 1)
-#define PERF_REGS_MAX PERF_REG_X86_32_MAX
 #define PERF_SAMPLE_REGS_ABI PERF_SAMPLE_REGS_ABI_32
 #else
 #define REG_NOSUPPORT ((1ULL << PERF_REG_X86_DS) | \
@@ -18,7 +18,6 @@ void perf_regs_load(u64 *regs);
 		       (1ULL << PERF_REG_X86_FS) | \
 		       (1ULL << PERF_REG_X86_GS))
 #define PERF_REGS_MASK (((1ULL << PERF_REG_X86_64_MAX) - 1) & ~REG_NOSUPPORT)
-#define PERF_REGS_MAX PERF_REG_X86_64_MAX
 #define PERF_SAMPLE_REGS_ABI PERF_SAMPLE_REGS_ABI_64
 #endif
 #define PERF_REG_IP PERF_REG_X86_IP
@@ -77,6 +76,28 @@ static inline const char *perf_reg_name(int id)
 	case PERF_REG_X86_R15:
 		return "R15";
 #endif /* HAVE_ARCH_X86_64_SUPPORT */
+
+#define XMM(x) \
+	case PERF_REG_X86_XMM ## x:	\
+	case PERF_REG_X86_XMM ## x + 1:	\
+		return "XMM" #x;
+	XMM(0)
+	XMM(1)
+	XMM(2)
+	XMM(3)
+	XMM(4)
+	XMM(5)
+	XMM(6)
+	XMM(7)
+	XMM(8)
+	XMM(9)
+	XMM(10)
+	XMM(11)
+	XMM(12)
+	XMM(13)
+	XMM(14)
+	XMM(15)
+#undef XMM
 	default:
 		return NULL;
 	}
diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/arch/x86/util/perf_regs.c
index fead6b3b4206..71d7604dbf0b 100644
--- a/tools/perf/arch/x86/util/perf_regs.c
+++ b/tools/perf/arch/x86/util/perf_regs.c
@@ -31,6 +31,22 @@ const struct sample_reg sample_reg_masks[] = {
 	SMPL_REG(R14, PERF_REG_X86_R14),
 	SMPL_REG(R15, PERF_REG_X86_R15),
 #endif
+	SMPL_REG2(XMM0, PERF_REG_X86_XMM0),
+	SMPL_REG2(XMM1, PERF_REG_X86_XMM1),
+	SMPL_REG2(XMM2, PERF_REG_X86_XMM2),
+	SMPL_REG2(XMM3, PERF_REG_X86_XMM3),
+	SMPL_REG2(XMM4, PERF_REG_X86_XMM4),
+	SMPL_REG2(XMM5, PERF_REG_X86_XMM5),
+	SMPL_REG2(XMM6, PERF_REG_X86_XMM6),
+	SMPL_REG2(XMM7, PERF_REG_X86_XMM7),
+	SMPL_REG2(XMM8, PERF_REG_X86_XMM8),
+	SMPL_REG2(XMM9, PERF_REG_X86_XMM9),
+	SMPL_REG2(XMM10, PERF_REG_X86_XMM10),
+	SMPL_REG2(XMM11, PERF_REG_X86_XMM11),
+	SMPL_REG2(XMM12, PERF_REG_X86_XMM12),
+	SMPL_REG2(XMM13, PERF_REG_X86_XMM13),
+	SMPL_REG2(XMM14, PERF_REG_X86_XMM14),
+	SMPL_REG2(XMM15, PERF_REG_X86_XMM15),
 	SMPL_REG_END
 };
 
diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
index c9319f8d17a6..1a15a4bfc28d 100644
--- a/tools/perf/util/perf_regs.h
+++ b/tools/perf/util/perf_regs.h
@@ -12,6 +12,7 @@ struct sample_reg {
 	uint64_t mask;
 };
 #define SMPL_REG(n, b) { .name = #n, .mask = 1ULL << (b) }
+#define SMPL_REG2(n, b) { .name = #n, .mask = 3ULL << (b) }
 #define SMPL_REG_END { .name = NULL }
 
 extern const struct sample_reg sample_reg_masks[];
-- 
2.20.1

