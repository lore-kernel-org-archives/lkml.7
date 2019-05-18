Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE75CC04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 08:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94050206BF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 08:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="x1+XmGBJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbfERIyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 04:54:13 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54003 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbfERIyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 04:54:13 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I8rtP91732589
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 01:53:55 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I8rtP91732589
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558169636;
        bh=CpcAmEqoDzVpVoCdxkbM2aW7oCswSJ0v61o2zehBuMo=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=x1+XmGBJbSNbdbdxwAE5MtM2NQOrFdftGGv0g3nfk+WDuu4wRraQHrIJYnOluqndw
         YNGy7gtRnIHk1PzXHMQv37s2h7B9n3aXfPHaiYqelu+bsMZVKRjVkDVoGz7GYbma0G
         RmNMjVHffVq0Kc6kyGs7OpIN7L2IK67/sfEKq4f9EiHC449wMxIHg27Axtic5lXkKU
         X7UHU30UDLuQg+i4ota1tPwPV/i3+1NPkfP4LoW3JIPxeXPwKZHMQNr77OtafR+6DP
         Gj+d9QNWtYKaK7VgZ3oQynENwDG8QBPods9SNi/KsPVYPCdw0hFsa3+KBM1J3rqeo1
         m2QRDjfxI4W5w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I8rsMI1732586;
        Sat, 18 May 2019 01:53:54 -0700
Date:   Sat, 18 May 2019 01:53:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-ca138a7aabc68bf727918bb40ce08157cd5ec0a5@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, alexander.shishkin@linux.intel.com,
        kan.liang@linux.intel.com, jolsa@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, ak@linux.intel.com, acme@redhat.com
Reply-To: jolsa@kernel.org, hpa@zytor.com, tglx@linutronix.de,
          kan.liang@linux.intel.com, alexander.shishkin@linux.intel.com,
          ak@linux.intel.com, acme@redhat.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, peterz@infradead.org
In-Reply-To: <20190506141926.13659-1-kan.liang@linux.intel.com>
References: <20190506141926.13659-1-kan.liang@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools x86: Add support for recording and
 printing XMM registers
Git-Commit-ID: ca138a7aabc68bf727918bb40ce08157cd5ec0a5
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

Commit-ID:  ca138a7aabc68bf727918bb40ce08157cd5ec0a5
Gitweb:     https://git.kernel.org/tip/ca138a7aabc68bf727918bb40ce08157cd5ec0a5
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Mon, 6 May 2019 07:19:24 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 15 May 2019 16:36:47 -0300

perf tools x86: Add support for recording and printing XMM registers

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
