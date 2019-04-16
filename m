Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F025C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C77C42077C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbfDPLei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:34:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60027 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfDPLei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:34:38 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3GBYLTr3428165
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 16 Apr 2019 04:34:21 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3GBYLa23428162;
        Tue, 16 Apr 2019 04:34:21 -0700
Date:   Tue, 16 Apr 2019 04:34:21 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-878068ea270ea82767ff1d26c91583263c81fba0@git.kernel.org>
Cc:     eranian@google.com, jolsa@redhat.com, tglx@linutronix.de,
        hpa@zytor.com, peterz@infradead.org, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, kan.liang@linux.intel.com,
        vincent.weaver@maine.edu, mingo@kernel.org,
        torvalds@linux-foundation.org, acme@redhat.com,
        linux-kernel@vger.kernel.org
Reply-To: mingo@kernel.org, torvalds@linux-foundation.org,
          vincent.weaver@maine.edu, acme@redhat.com,
          linux-kernel@vger.kernel.org, jolsa@redhat.com,
          eranian@google.com, peterz@infradead.org, tglx@linutronix.de,
          hpa@zytor.com, kan.liang@linux.intel.com,
          alexander.shishkin@linux.intel.com, ak@linux.intel.com
In-Reply-To: <20190402194509.2832-3-kan.liang@linux.intel.com>
References: <20190402194509.2832-3-kan.liang@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86: Support outputting XMM registers
Git-Commit-ID: 878068ea270ea82767ff1d26c91583263c81fba0
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

Commit-ID:  878068ea270ea82767ff1d26c91583263c81fba0
Gitweb:     https://git.kernel.org/tip/878068ea270ea82767ff1d26c91583263c81fba0
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Tue, 2 Apr 2019 12:44:59 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 16 Apr 2019 12:19:36 +0200

perf/x86: Support outputting XMM registers

Starting from Icelake, XMM registers can be collected in PEBS record.
But current code only output the pt_regs.

Add a new struct x86_perf_regs for both pt_regs and xmm_regs. The
xmm_regs will be used later to keep a pointer to PEBS record which has
XMM information.

XMM registers are 128 bit. To simplify the code, they are handled like
two different registers, which means setting two bits in the register
bitmap. This also allows only sampling the lower 64bit bits in XMM.

The index of XMM registers starts from 32. There are 16 XMM registers.
So all reserved space for regs are used. Remove REG_RESERVED.

Add PERF_REG_X86_XMM_MAX, which stands for the max number of all x86
regs including both GPRs and XMM.

Add REG_NOSUPPORT for 32bit to exclude unsupported registers.

Previous platforms can not collect XMM information in PEBS record.
Adding pebs_no_xmm_regs to indicate the unsupported platforms.

The common code still validates the supported registers. However, it
cannot check model specific registers, e.g. XMM. Add extra check in
x86_pmu_hw_config() to reject invalid config of regs_user and regs_intr.
The regs_user never supports XMM collection.
The regs_intr only supports XMM collection when sampling PEBS event on
icelake and later platforms.

Originally-by: Andi Kleen <ak@linux.intel.com>
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: acme@kernel.org
Cc: jolsa@kernel.org
Link: https://lkml.kernel.org/r/20190402194509.2832-3-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/core.c                | 15 +++++++++++++++
 arch/x86/events/intel/ds.c            |  4 +++-
 arch/x86/events/perf_event.h          | 21 ++++++++++++++++++++-
 arch/x86/include/asm/perf_event.h     |  5 +++++
 arch/x86/include/uapi/asm/perf_regs.h | 23 ++++++++++++++++++++++-
 arch/x86/kernel/perf_regs.c           | 27 ++++++++++++++++++++-------
 6 files changed, 85 insertions(+), 10 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index fdd106267fd2..de1a924a4914 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -560,6 +560,21 @@ int x86_pmu_hw_config(struct perf_event *event)
 			return -EINVAL;
 	}
 
+	/* sample_regs_user never support XMM registers */
+	if (unlikely(event->attr.sample_regs_user & PEBS_XMM_REGS))
+		return -EINVAL;
+	/*
+	 * Besides the general purpose registers, XMM registers may
+	 * be collected in PEBS on some platforms, e.g. Icelake
+	 */
+	if (unlikely(event->attr.sample_regs_intr & PEBS_XMM_REGS)) {
+		if (x86_pmu.pebs_no_xmm_regs)
+			return -EINVAL;
+
+		if (!event->attr.precise_ip)
+			return -EINVAL;
+	}
+
 	return x86_setup_perfctr(event);
 }
 
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 10c99ce1fead..f57e6cb7fd99 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1628,8 +1628,10 @@ void __init intel_ds_init(void)
 	x86_pmu.bts  = boot_cpu_has(X86_FEATURE_BTS);
 	x86_pmu.pebs = boot_cpu_has(X86_FEATURE_PEBS);
 	x86_pmu.pebs_buffer_size = PEBS_BUFFER_SIZE;
-	if (x86_pmu.version <= 4)
+	if (x86_pmu.version <= 4) {
 		x86_pmu.pebs_no_isolation = 1;
+		x86_pmu.pebs_no_xmm_regs = 1;
+	}
 	if (x86_pmu.pebs) {
 		char pebs_type = x86_pmu.intel_cap.pebs_trap ?  '+' : '-';
 		int format = x86_pmu.intel_cap.pebs_format;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 9e474a5f3b86..7abfadb4f202 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -115,6 +115,24 @@ struct amd_nb {
 	 (1ULL << PERF_REG_X86_R14)   | \
 	 (1ULL << PERF_REG_X86_R15))
 
+#define PEBS_XMM_REGS                   \
+	((1ULL << PERF_REG_X86_XMM0)  | \
+	 (1ULL << PERF_REG_X86_XMM1)  | \
+	 (1ULL << PERF_REG_X86_XMM2)  | \
+	 (1ULL << PERF_REG_X86_XMM3)  | \
+	 (1ULL << PERF_REG_X86_XMM4)  | \
+	 (1ULL << PERF_REG_X86_XMM5)  | \
+	 (1ULL << PERF_REG_X86_XMM6)  | \
+	 (1ULL << PERF_REG_X86_XMM7)  | \
+	 (1ULL << PERF_REG_X86_XMM8)  | \
+	 (1ULL << PERF_REG_X86_XMM9)  | \
+	 (1ULL << PERF_REG_X86_XMM10) | \
+	 (1ULL << PERF_REG_X86_XMM11) | \
+	 (1ULL << PERF_REG_X86_XMM12) | \
+	 (1ULL << PERF_REG_X86_XMM13) | \
+	 (1ULL << PERF_REG_X86_XMM14) | \
+	 (1ULL << PERF_REG_X86_XMM15))
+
 /*
  * Per register state.
  */
@@ -612,7 +630,8 @@ struct x86_pmu {
 			pebs_broken		:1,
 			pebs_prec_dist		:1,
 			pebs_no_tlb		:1,
-			pebs_no_isolation	:1;
+			pebs_no_isolation	:1,
+			pebs_no_xmm_regs	:1;
 	int		pebs_record_size;
 	int		pebs_buffer_size;
 	void		(*drain_pebs)(struct pt_regs *regs);
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 8bdf74902293..d9f5bbe44b3c 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -248,6 +248,11 @@ extern void perf_events_lapic_init(void);
 #define PERF_EFLAGS_VM		(1UL << 5)
 
 struct pt_regs;
+struct x86_perf_regs {
+	struct pt_regs	regs;
+	u64		*xmm_regs;
+};
+
 extern unsigned long perf_instruction_pointer(struct pt_regs *regs);
 extern unsigned long perf_misc_flags(struct pt_regs *regs);
 #define perf_misc_flags(regs)	perf_misc_flags(regs)
diff --git a/arch/x86/include/uapi/asm/perf_regs.h b/arch/x86/include/uapi/asm/perf_regs.h
index f3329cabce5c..ac67bbea10ca 100644
--- a/arch/x86/include/uapi/asm/perf_regs.h
+++ b/arch/x86/include/uapi/asm/perf_regs.h
@@ -27,8 +27,29 @@ enum perf_event_x86_regs {
 	PERF_REG_X86_R13,
 	PERF_REG_X86_R14,
 	PERF_REG_X86_R15,
-
+	/* These are the limits for the GPRs. */
 	PERF_REG_X86_32_MAX = PERF_REG_X86_GS + 1,
 	PERF_REG_X86_64_MAX = PERF_REG_X86_R15 + 1,
+
+	/* These all need two bits set because they are 128bit */
+	PERF_REG_X86_XMM0  = 32,
+	PERF_REG_X86_XMM1  = 34,
+	PERF_REG_X86_XMM2  = 36,
+	PERF_REG_X86_XMM3  = 38,
+	PERF_REG_X86_XMM4  = 40,
+	PERF_REG_X86_XMM5  = 42,
+	PERF_REG_X86_XMM6  = 44,
+	PERF_REG_X86_XMM7  = 46,
+	PERF_REG_X86_XMM8  = 48,
+	PERF_REG_X86_XMM9  = 50,
+	PERF_REG_X86_XMM10 = 52,
+	PERF_REG_X86_XMM11 = 54,
+	PERF_REG_X86_XMM12 = 56,
+	PERF_REG_X86_XMM13 = 58,
+	PERF_REG_X86_XMM14 = 60,
+	PERF_REG_X86_XMM15 = 62,
+
+	/* These include both GPRs and XMMX registers */
+	PERF_REG_X86_XMM_MAX = PERF_REG_X86_XMM15 + 2,
 };
 #endif /* _ASM_X86_PERF_REGS_H */
diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index c06c4c16c6b6..07c30ee17425 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -59,18 +59,34 @@ static unsigned int pt_regs_offset[PERF_REG_X86_MAX] = {
 
 u64 perf_reg_value(struct pt_regs *regs, int idx)
 {
+	struct x86_perf_regs *perf_regs;
+
+	if (idx >= PERF_REG_X86_XMM0 && idx < PERF_REG_X86_XMM_MAX) {
+		perf_regs = container_of(regs, struct x86_perf_regs, regs);
+		if (!perf_regs->xmm_regs)
+			return 0;
+		return perf_regs->xmm_regs[idx - PERF_REG_X86_XMM0];
+	}
+
 	if (WARN_ON_ONCE(idx >= ARRAY_SIZE(pt_regs_offset)))
 		return 0;
 
 	return regs_get_register(regs, pt_regs_offset[idx]);
 }
 
-#define REG_RESERVED (~((1ULL << PERF_REG_X86_MAX) - 1ULL))
-
 #ifdef CONFIG_X86_32
+#define REG_NOSUPPORT ((1ULL << PERF_REG_X86_R8) | \
+		       (1ULL << PERF_REG_X86_R9) | \
+		       (1ULL << PERF_REG_X86_R10) | \
+		       (1ULL << PERF_REG_X86_R11) | \
+		       (1ULL << PERF_REG_X86_R12) | \
+		       (1ULL << PERF_REG_X86_R13) | \
+		       (1ULL << PERF_REG_X86_R14) | \
+		       (1ULL << PERF_REG_X86_R15))
+
 int perf_reg_validate(u64 mask)
 {
-	if (!mask || mask & REG_RESERVED)
+	if (!mask || (mask & REG_NOSUPPORT))
 		return -EINVAL;
 
 	return 0;
@@ -96,10 +112,7 @@ void perf_get_regs_user(struct perf_regs *regs_user,
 
 int perf_reg_validate(u64 mask)
 {
-	if (!mask || mask & REG_RESERVED)
-		return -EINVAL;
-
-	if (mask & REG_NOSUPPORT)
+	if (!mask || (mask & REG_NOSUPPORT))
 		return -EINVAL;
 
 	return 0;
