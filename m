Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A28C4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 08:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BD3F21670
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 08:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561798487;
	bh=LHwQT3Sb/Hvzgbh6gsNCkopDmMdWEljKkcySC3sZHxA=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=2Txg+vJppJ7wvAQl4ZoGSGrFNi+/t4/51lE3xLHucvx8MUZNDqFr0rqYzv96E7ANJ
	 sBQZOv6ONbOB9wVeYNFy8DEgJUUVLPyCR7EsNH9t15ljMn20LE7yarjTW7FgrLV7Ul
	 viplHCjw5irj2BTSXy0J7H3Ex8xHNoPl0s8+heT4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfF2Iyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 04:54:46 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44472 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbfF2Iyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 04:54:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id r16so6711793wrl.11
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2019 01:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=3nkomZUBVqLAG4FSXGchxjRb3GTYmQO/+xZVkknWTQE=;
        b=qJyLB+eLZoUv5I7V2C32IwLUsiG2d4z3HFF9mR6YQZ2VD5MEiL7zo52XwgJ8h/Xf+K
         JuRl5GRvVLHOx5WOadrlJ4gz6eMDo4cWX7CQiwgUytJgPN1W8ivws4inuX+g1nhi8ApV
         nE64KCcTqY8XJT3KHQvdZlzFibiEW6f4TftrMLe5shZQG1xCTSlCx6kX/YvYXVm87Xpi
         5JMjWlhqo1ngDYVw9ixM4HE3J66yq04a9Q3QsOpE1t1fjbRwLcZajrijN+n4Kiv9wFzZ
         Jcoglc/LhFCAhD+cOIIco0iO4MOtMFZa0dPcdCc7yaV0GaTmzeqvA+6hUXJbUAyPeH0b
         thNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=3nkomZUBVqLAG4FSXGchxjRb3GTYmQO/+xZVkknWTQE=;
        b=LWc6hFaZ8H7ADbjURtcgklkErGKK0mP0YjJCnfnw5C4hiPFST4N4ZC/JBFlGI89a5J
         il6/r5Ucdkz3YhjnEgk90mnPm7BaXuZnzeJ8jbK0Vi1bHsnzJyM2oUCXu0fyRjhcm8pp
         rjnW+KuRxZGxdaGUtoL2nm5RHdpFsPT6MevXemyCddsKLiSyKZPfCbt/FxohWjdyRxAe
         f8XPTjPudX6CBHN6d4kQxxHqlG3Gck65x7XqbfmmS1L9/X1sTBUwfaGQy+gM+K9zvDYe
         gAUcKd25Qa4wi+vx006Gc0tgLZ0twlGovC3dUC/CG4uwgPWA0z0v8RTRn/wjSYm50iww
         jeUg==
X-Gm-Message-State: APjAAAVu50uEm+ZctK4vP8r4S5zZdu1hWSq8JDxiSFz5750HiGuJGvXb
        31xLpSMYWc3RgqnDOyDdkE9+lq9d
X-Google-Smtp-Source: APXvYqxokZFED9xGa1sMnO7Gn6RW8yCmFhgQ/vULBAWXMX/BWZVnMss5RDYY9iCK0vxnnpWmmZBpnQ==
X-Received: by 2002:adf:df91:: with SMTP id z17mr11545340wrl.336.1561798481770;
        Sat, 29 Jun 2019 01:54:41 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id r79sm4116658wme.2.2019.06.29.01.54.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 29 Jun 2019 01:54:41 -0700 (PDT)
Date:   Sat, 29 Jun 2019 10:54:39 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf fixes
Message-ID: <20190629085439.GA123694@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-for-linus

   # HEAD: 8b12b812f5367c2469fb937da7e28dd321ad8d7b perf/x86/regs: Use PERF_REG_EXTENDED_MASK

Various fixes, most of them related to bugs perf fuzzing found in the x86 
code.

 Thanks,

	Ingo

------------------>
Kan Liang (5):
      perf/x86: Disable extended registers for non-supported PMUs
      perf/x86/regs: Check reserved bits
      perf/x86: Clean up PEBS_XMM_REGS
      perf/x86: Remove pmu->pebs_no_xmm_regs
      perf/x86/regs: Use PERF_REG_EXTENDED_MASK

Peter Zijlstra (1):
      perf/core: Fix perf_sample_regs_user() mm check

Ravi Bangoria (1):
      perf/ioctl: Add check for the sample_period value


 arch/x86/events/core.c                      |  6 +++---
 arch/x86/events/intel/ds.c                  |  9 ++++-----
 arch/x86/events/perf_event.h                | 21 +--------------------
 arch/x86/include/uapi/asm/perf_regs.h       |  3 +++
 arch/x86/kernel/perf_regs.c                 |  7 +++++--
 include/linux/perf_event.h                  |  1 +
 include/linux/perf_regs.h                   |  8 ++++++++
 kernel/events/core.c                        | 23 ++++++++++++++++++-----
 tools/arch/x86/include/uapi/asm/perf_regs.h |  3 +++
 tools/perf/arch/x86/include/perf_regs.h     |  1 -
 tools/perf/arch/x86/util/perf_regs.c        |  4 ++--
 11 files changed, 48 insertions(+), 38 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index f315425d8468..52a97463cb24 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -561,14 +561,14 @@ int x86_pmu_hw_config(struct perf_event *event)
 	}
 
 	/* sample_regs_user never support XMM registers */
-	if (unlikely(event->attr.sample_regs_user & PEBS_XMM_REGS))
+	if (unlikely(event->attr.sample_regs_user & PERF_REG_EXTENDED_MASK))
 		return -EINVAL;
 	/*
 	 * Besides the general purpose registers, XMM registers may
 	 * be collected in PEBS on some platforms, e.g. Icelake
 	 */
-	if (unlikely(event->attr.sample_regs_intr & PEBS_XMM_REGS)) {
-		if (x86_pmu.pebs_no_xmm_regs)
+	if (unlikely(event->attr.sample_regs_intr & PERF_REG_EXTENDED_MASK)) {
+		if (!(event->pmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS))
 			return -EINVAL;
 
 		if (!event->attr.precise_ip)
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 7acc526b4ad2..505c73dc6a73 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -987,7 +987,7 @@ static u64 pebs_update_adaptive_cfg(struct perf_event *event)
 		pebs_data_cfg |= PEBS_DATACFG_GP;
 
 	if ((sample_type & PERF_SAMPLE_REGS_INTR) &&
-	    (attr->sample_regs_intr & PEBS_XMM_REGS))
+	    (attr->sample_regs_intr & PERF_REG_EXTENDED_MASK))
 		pebs_data_cfg |= PEBS_DATACFG_XMMS;
 
 	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
@@ -1964,10 +1964,9 @@ void __init intel_ds_init(void)
 	x86_pmu.bts  = boot_cpu_has(X86_FEATURE_BTS);
 	x86_pmu.pebs = boot_cpu_has(X86_FEATURE_PEBS);
 	x86_pmu.pebs_buffer_size = PEBS_BUFFER_SIZE;
-	if (x86_pmu.version <= 4) {
+	if (x86_pmu.version <= 4)
 		x86_pmu.pebs_no_isolation = 1;
-		x86_pmu.pebs_no_xmm_regs = 1;
-	}
+
 	if (x86_pmu.pebs) {
 		char pebs_type = x86_pmu.intel_cap.pebs_trap ?  '+' : '-';
 		char *pebs_qual = "";
@@ -2020,9 +2019,9 @@ void __init intel_ds_init(void)
 					PERF_SAMPLE_TIME;
 				x86_pmu.flags |= PMU_FL_PEBS_ALL;
 				pebs_qual = "-baseline";
+				x86_get_pmu()->capabilities |= PERF_PMU_CAP_EXTENDED_REGS;
 			} else {
 				/* Only basic record supported */
-				x86_pmu.pebs_no_xmm_regs = 1;
 				x86_pmu.large_pebs_flags &=
 					~(PERF_SAMPLE_ADDR |
 					  PERF_SAMPLE_TIME |
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index a6ac2f4f76fc..4e346856ee19 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -121,24 +121,6 @@ struct amd_nb {
 	 (1ULL << PERF_REG_X86_R14)   | \
 	 (1ULL << PERF_REG_X86_R15))
 
-#define PEBS_XMM_REGS                   \
-	((1ULL << PERF_REG_X86_XMM0)  | \
-	 (1ULL << PERF_REG_X86_XMM1)  | \
-	 (1ULL << PERF_REG_X86_XMM2)  | \
-	 (1ULL << PERF_REG_X86_XMM3)  | \
-	 (1ULL << PERF_REG_X86_XMM4)  | \
-	 (1ULL << PERF_REG_X86_XMM5)  | \
-	 (1ULL << PERF_REG_X86_XMM6)  | \
-	 (1ULL << PERF_REG_X86_XMM7)  | \
-	 (1ULL << PERF_REG_X86_XMM8)  | \
-	 (1ULL << PERF_REG_X86_XMM9)  | \
-	 (1ULL << PERF_REG_X86_XMM10) | \
-	 (1ULL << PERF_REG_X86_XMM11) | \
-	 (1ULL << PERF_REG_X86_XMM12) | \
-	 (1ULL << PERF_REG_X86_XMM13) | \
-	 (1ULL << PERF_REG_X86_XMM14) | \
-	 (1ULL << PERF_REG_X86_XMM15))
-
 /*
  * Per register state.
  */
@@ -668,8 +650,7 @@ struct x86_pmu {
 			pebs_broken		:1,
 			pebs_prec_dist		:1,
 			pebs_no_tlb		:1,
-			pebs_no_isolation	:1,
-			pebs_no_xmm_regs	:1;
+			pebs_no_isolation	:1;
 	int		pebs_record_size;
 	int		pebs_buffer_size;
 	int		max_pebs_events;
diff --git a/arch/x86/include/uapi/asm/perf_regs.h b/arch/x86/include/uapi/asm/perf_regs.h
index ac67bbea10ca..7c9d2bb3833b 100644
--- a/arch/x86/include/uapi/asm/perf_regs.h
+++ b/arch/x86/include/uapi/asm/perf_regs.h
@@ -52,4 +52,7 @@ enum perf_event_x86_regs {
 	/* These include both GPRs and XMMX registers */
 	PERF_REG_X86_XMM_MAX = PERF_REG_X86_XMM15 + 2,
 };
+
+#define PERF_REG_EXTENDED_MASK	(~((1ULL << PERF_REG_X86_XMM0) - 1))
+
 #endif /* _ASM_X86_PERF_REGS_H */
diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index 07c30ee17425..bb7e1132290b 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -74,6 +74,9 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 	return regs_get_register(regs, pt_regs_offset[idx]);
 }
 
+#define PERF_REG_X86_RESERVED	(((1ULL << PERF_REG_X86_XMM0) - 1) & \
+				 ~((1ULL << PERF_REG_X86_MAX) - 1))
+
 #ifdef CONFIG_X86_32
 #define REG_NOSUPPORT ((1ULL << PERF_REG_X86_R8) | \
 		       (1ULL << PERF_REG_X86_R9) | \
@@ -86,7 +89,7 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 
 int perf_reg_validate(u64 mask)
 {
-	if (!mask || (mask & REG_NOSUPPORT))
+	if (!mask || (mask & (REG_NOSUPPORT | PERF_REG_X86_RESERVED)))
 		return -EINVAL;
 
 	return 0;
@@ -112,7 +115,7 @@ void perf_get_regs_user(struct perf_regs *regs_user,
 
 int perf_reg_validate(u64 mask)
 {
-	if (!mask || (mask & REG_NOSUPPORT))
+	if (!mask || (mask & (REG_NOSUPPORT | PERF_REG_X86_RESERVED)))
 		return -EINVAL;
 
 	return 0;
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 0ab99c7b652d..2bca72f3028b 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -241,6 +241,7 @@ struct perf_event;
 #define PERF_PMU_CAP_NO_INTERRUPT		0x01
 #define PERF_PMU_CAP_NO_NMI			0x02
 #define PERF_PMU_CAP_AUX_NO_SG			0x04
+#define PERF_PMU_CAP_EXTENDED_REGS		0x08
 #define PERF_PMU_CAP_EXCLUSIVE			0x10
 #define PERF_PMU_CAP_ITRACE			0x20
 #define PERF_PMU_CAP_HETEROGENEOUS_CPUS		0x40
diff --git a/include/linux/perf_regs.h b/include/linux/perf_regs.h
index 476747456bca..2d12e97d5e7b 100644
--- a/include/linux/perf_regs.h
+++ b/include/linux/perf_regs.h
@@ -11,6 +11,11 @@ struct perf_regs {
 
 #ifdef CONFIG_HAVE_PERF_REGS
 #include <asm/perf_regs.h>
+
+#ifndef PERF_REG_EXTENDED_MASK
+#define PERF_REG_EXTENDED_MASK	0
+#endif
+
 u64 perf_reg_value(struct pt_regs *regs, int idx);
 int perf_reg_validate(u64 mask);
 u64 perf_reg_abi(struct task_struct *task);
@@ -18,6 +23,9 @@ void perf_get_regs_user(struct perf_regs *regs_user,
 			struct pt_regs *regs,
 			struct pt_regs *regs_user_copy);
 #else
+
+#define PERF_REG_EXTENDED_MASK	0
+
 static inline u64 perf_reg_value(struct pt_regs *regs, int idx)
 {
 	return 0;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index abbd4b3b96c2..f85929ce13be 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5005,6 +5005,9 @@ static int perf_event_period(struct perf_event *event, u64 __user *arg)
 	if (perf_event_check_period(event, value))
 		return -EINVAL;
 
+	if (!event->attr.freq && (value & (1ULL << 63)))
+		return -EINVAL;
+
 	event_function_call(event, __perf_event_period, &value);
 
 	return 0;
@@ -5923,7 +5926,7 @@ static void perf_sample_regs_user(struct perf_regs *regs_user,
 	if (user_mode(regs)) {
 		regs_user->abi = perf_reg_abi(current);
 		regs_user->regs = regs;
-	} else if (current->mm) {
+	} else if (!(current->flags & PF_KTHREAD)) {
 		perf_get_regs_user(regs_user, regs, regs_user_copy);
 	} else {
 		regs_user->abi = PERF_SAMPLE_REGS_ABI_NONE;
@@ -10033,6 +10036,12 @@ void perf_pmu_unregister(struct pmu *pmu)
 }
 EXPORT_SYMBOL_GPL(perf_pmu_unregister);
 
+static inline bool has_extended_regs(struct perf_event *event)
+{
+	return (event->attr.sample_regs_user & PERF_REG_EXTENDED_MASK) ||
+	       (event->attr.sample_regs_intr & PERF_REG_EXTENDED_MASK);
+}
+
 static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
 {
 	struct perf_event_context *ctx = NULL;
@@ -10064,12 +10073,16 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
 		perf_event_ctx_unlock(event->group_leader, ctx);
 
 	if (!ret) {
+		if (!(pmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS) &&
+		    has_extended_regs(event))
+			ret = -EOPNOTSUPP;
+
 		if (pmu->capabilities & PERF_PMU_CAP_NO_EXCLUDE &&
-				event_has_any_exclude_flag(event)) {
-			if (event->destroy)
-				event->destroy(event);
+		    event_has_any_exclude_flag(event))
 			ret = -EINVAL;
-		}
+
+		if (ret && event->destroy)
+			event->destroy(event);
 	}
 
 	if (ret)
diff --git a/tools/arch/x86/include/uapi/asm/perf_regs.h b/tools/arch/x86/include/uapi/asm/perf_regs.h
index ac67bbea10ca..7c9d2bb3833b 100644
--- a/tools/arch/x86/include/uapi/asm/perf_regs.h
+++ b/tools/arch/x86/include/uapi/asm/perf_regs.h
@@ -52,4 +52,7 @@ enum perf_event_x86_regs {
 	/* These include both GPRs and XMMX registers */
 	PERF_REG_X86_XMM_MAX = PERF_REG_X86_XMM15 + 2,
 };
+
+#define PERF_REG_EXTENDED_MASK	(~((1ULL << PERF_REG_X86_XMM0) - 1))
+
 #endif /* _ASM_X86_PERF_REGS_H */
diff --git a/tools/perf/arch/x86/include/perf_regs.h b/tools/perf/arch/x86/include/perf_regs.h
index b7cd91a9014f..b7321337d100 100644
--- a/tools/perf/arch/x86/include/perf_regs.h
+++ b/tools/perf/arch/x86/include/perf_regs.h
@@ -9,7 +9,6 @@
 void perf_regs_load(u64 *regs);
 
 #define PERF_REGS_MAX PERF_REG_X86_XMM_MAX
-#define PERF_XMM_REGS_MASK	(~((1ULL << PERF_REG_X86_XMM0) - 1))
 #ifndef HAVE_ARCH_X86_64_SUPPORT
 #define PERF_REGS_MASK ((1ULL << PERF_REG_X86_32_MAX) - 1)
 #define PERF_SAMPLE_REGS_ABI PERF_SAMPLE_REGS_ABI_32
diff --git a/tools/perf/arch/x86/util/perf_regs.c b/tools/perf/arch/x86/util/perf_regs.c
index 7886ca5263e3..3666c0076df9 100644
--- a/tools/perf/arch/x86/util/perf_regs.c
+++ b/tools/perf/arch/x86/util/perf_regs.c
@@ -277,7 +277,7 @@ uint64_t arch__intr_reg_mask(void)
 		.type			= PERF_TYPE_HARDWARE,
 		.config			= PERF_COUNT_HW_CPU_CYCLES,
 		.sample_type		= PERF_SAMPLE_REGS_INTR,
-		.sample_regs_intr	= PERF_XMM_REGS_MASK,
+		.sample_regs_intr	= PERF_REG_EXTENDED_MASK,
 		.precise_ip		= 1,
 		.disabled 		= 1,
 		.exclude_kernel		= 1,
@@ -293,7 +293,7 @@ uint64_t arch__intr_reg_mask(void)
 	fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
 	if (fd != -1) {
 		close(fd);
-		return (PERF_XMM_REGS_MASK | PERF_REGS_MASK);
+		return (PERF_REG_EXTENDED_MASK | PERF_REGS_MASK);
 	}
 
 	return PERF_REGS_MASK;
