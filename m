Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249AFC3A5A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 069EC233A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388590AbfHVOmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 10:42:38 -0400
Received: from foss.arm.com ([217.140.110.172]:47276 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732949AbfHVOmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 10:42:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA39215AB;
        Thu, 22 Aug 2019 07:42:35 -0700 (PDT)
Received: from e121650-lin.cambridge.arm.com (e121650-lin.cambridge.arm.com [10.1.196.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 64B853F706;
        Thu, 22 Aug 2019 07:42:34 -0700 (PDT)
From:   Raphael Gault <raphael.gault@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, acme@kernel.org, mark.rutland@arm.com,
        raph.gault+kdev@gmail.com, Raphael Gault <raphael.gault@arm.com>
Subject: [PATCH v4 3/7] arm64: cpufeature: Add feature to detect homogeneous systems
Date:   Thu, 22 Aug 2019 15:42:16 +0100
Message-Id: <20190822144220.27860-4-raphael.gault@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190822144220.27860-1-raphael.gault@arm.com>
References: <20190822144220.27860-1-raphael.gault@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This feature is required in order to enable PMU counters direct
access from userspace only when the system is homogeneous.
This feature checks the model of each CPU brought online and compares it
to the boot CPU. If it differs then it is heterogeneous.

This CPU feature doesn't prevent different models of CPUs from being
hotplugged on, however if such a scenario happens, it will turn off the
feature. There is no possibility for the feature to be turned on again
by hotplugging off CPUs though.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
---
 arch/arm64/include/asm/cpucaps.h    |  3 ++-
 arch/arm64/include/asm/cpufeature.h | 10 ++++++++++
 arch/arm64/kernel/cpufeature.c      | 28 ++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index f19fe4b9acc4..1cd73cf46116 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -52,7 +52,8 @@
 #define ARM64_HAS_IRQ_PRIO_MASKING		42
 #define ARM64_HAS_DCPODP			43
 #define ARM64_WORKAROUND_1463225		44
+#define ARM64_HAS_HOMOGENEOUS_PMU		45
 
-#define ARM64_NCAPS				45
+#define ARM64_NCAPS				46
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 407e2bf23676..c54a87896bbd 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -430,6 +430,16 @@ static inline void cpus_set_cap(unsigned int num)
 	}
 }
 
+static inline void cpus_unset_cap(unsigned int num)
+{
+	if (num >= ARM64_NCAPS) {
+		pr_warn("Attempt to unset an illegal CPU capability (%d >= %d)\n",
+			num, ARM64_NCAPS);
+	} else {
+		clear_bit(num, cpu_hwcaps);
+	}
+}
+
 static inline int __attribute_const__
 cpuid_feature_extract_signed_field_width(u64 features, int field, int width)
 {
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index f29f36a65175..07be444c1e31 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1248,6 +1248,23 @@ static bool can_use_gic_priorities(const struct arm64_cpu_capabilities *entry,
 }
 #endif
 
+static bool has_homogeneous_pmu(const struct arm64_cpu_capabilities *entry,
+				  int scope)
+{
+	u32 model = read_cpuid_id() & MIDR_CPU_MODEL_MASK;
+	struct cpuinfo_arm64 *boot = get_boot_cpu_data();
+
+	return  (boot->reg_midr & MIDR_CPU_MODEL_MASK) == model;
+}
+
+static void disable_homogeneous_cap(const struct arm64_cpu_capabilities *entry)
+{
+	if (!has_homogeneous_pmu(entry, entry->type)) {
+		pr_info("Disabling Homogeneous PMU (%d)", entry->capability);
+		cpus_unset_cap(entry->capability);
+	}
+}
+
 static const struct arm64_cpu_capabilities arm64_features[] = {
 	{
 		.desc = "GIC system register CPU interface",
@@ -1548,6 +1565,17 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.min_field_value = 1,
 	},
 #endif
+	{
+		/*
+		 * Detect whether the system is heterogeneous or
+		 * homogeneous
+		 */
+		.desc = "Homogeneous CPUs",
+		.capability = ARM64_HAS_HOMOGENEOUS_PMU,
+		.type = ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE,
+		.matches = has_homogeneous_pmu,
+		.cpu_enable = disable_homogeneous_cap,
+	},
 	{},
 };
 
-- 
2.17.1

