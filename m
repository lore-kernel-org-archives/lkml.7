Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301A7C282DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 21:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 085CE2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 21:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbfDOVV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 17:21:56 -0400
Received: from foss.arm.com ([217.140.101.70]:42926 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728055AbfDOVVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 17:21:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA729374;
        Mon, 15 Apr 2019 14:21:44 -0700 (PDT)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.29.246])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 47CD83F68F;
        Mon, 15 Apr 2019 14:21:44 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, marc.zyngier@arm.com,
        suzuki.poulose@arm.com, Dave.Martin@arm.com,
        shankerd@codeaurora.org, julien.thierry@arm.com,
        mlangsdo@redhat.com, stefan.wahren@i2se.com,
        Andre.Przywara@arm.com, linux-kernel@vger.kernel.org,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: [v8 09/10] arm64: add sysfs vulnerability show for speculative store bypass
Date:   Mon, 15 Apr 2019 16:21:28 -0500
Message-Id: <20190415212129.1112-10-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190415212129.1112-1-jeremy.linton@arm.com>
References: <20190415212129.1112-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return status based on ssbd_state and __ssb_safe. If the
mitigation is disabled, or the firmware isn't responding then
return the expected machine state based on a whitelist of known
good cores.

Given a heterogeneous machine, the overall machine vulnerability
defaults to safe but is reset to unsafe when we miss the whitelist
and the firmware doesn't explicitly tell us the core is safe.
In order to make that work we delay transitioning to vulnerable
until we know the firmware isn't responding to avoid a case
where we miss the whitelist, but the firmware goes ahead and
reports the core is not vulnerable. If all the cores in the
machine have SSBS, then __ssb_safe will remain true.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/kernel/cpu_errata.c | 42 ++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 5814645afd73..91e551e0ad28 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -278,6 +278,7 @@ static int detect_harden_bp_fw(void)
 DEFINE_PER_CPU_READ_MOSTLY(u64, arm64_ssbd_callback_required);
 
 int ssbd_state __read_mostly = ARM64_SSBD_KERNEL;
+static bool __ssb_safe = true;
 
 static const struct ssbd_options {
 	const char	*str;
@@ -383,6 +384,7 @@ static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities *entry,
 	struct arm_smccc_res res;
 	bool required = true;
 	s32 val;
+	bool this_cpu_safe = false;
 
 	WARN_ON(scope != SCOPE_LOCAL_CPU || preemptible());
 
@@ -391,8 +393,14 @@ static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities *entry,
 		goto out_printmsg;
 	}
 
+	/* delay setting __ssb_safe until we get a firmware response */
+	if (is_midr_in_range_list(read_cpuid_id(), entry->midr_range_list))
+		this_cpu_safe = true;
+
 	if (psci_ops.smccc_version == SMCCC_VERSION_1_0) {
 		ssbd_state = ARM64_SSBD_UNKNOWN;
+		if (!this_cpu_safe)
+			__ssb_safe = false;
 		return false;
 	}
 
@@ -409,6 +417,8 @@ static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities *entry,
 
 	default:
 		ssbd_state = ARM64_SSBD_UNKNOWN;
+		if (!this_cpu_safe)
+			__ssb_safe = false;
 		return false;
 	}
 
@@ -417,14 +427,18 @@ static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities *entry,
 	switch (val) {
 	case SMCCC_RET_NOT_SUPPORTED:
 		ssbd_state = ARM64_SSBD_UNKNOWN;
+		if (!this_cpu_safe)
+			__ssb_safe = false;
 		return false;
 
+	/* machines with mixed mitigation requirements must not return this */
 	case SMCCC_RET_NOT_REQUIRED:
 		pr_info_once("%s mitigation not required\n", entry->desc);
 		ssbd_state = ARM64_SSBD_MITIGATED;
 		return false;
 
 	case SMCCC_RET_SUCCESS:
+		__ssb_safe = false;
 		required = true;
 		break;
 
@@ -434,6 +448,8 @@ static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities *entry,
 
 	default:
 		WARN_ON(1);
+		if (!this_cpu_safe)
+			__ssb_safe = false;
 		return false;
 	}
 
@@ -474,6 +490,14 @@ static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities *entry,
 	return required;
 }
 
+/* known invulnerable cores */
+static const struct midr_range arm64_ssb_cpus[] = {
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A35),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A53),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A55),
+	{},
+};
+
 static void __maybe_unused
 cpu_enable_cache_maint_trap(const struct arm64_cpu_capabilities *__unused)
 {
@@ -769,6 +793,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		.capability = ARM64_SSBD,
 		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
 		.matches = has_ssbd_mitigation,
+		.midr_range_list = arm64_ssb_cpus,
 	},
 #ifdef CONFIG_ARM64_ERRATUM_1188873
 	{
@@ -807,3 +832,20 @@ ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr,
 
 	return sprintf(buf, "Vulnerable\n");
 }
+
+ssize_t cpu_show_spec_store_bypass(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	if (__ssb_safe)
+		return sprintf(buf, "Not affected\n");
+
+	switch (ssbd_state) {
+	case ARM64_SSBD_KERNEL:
+	case ARM64_SSBD_FORCE_ENABLE:
+		if (IS_ENABLED(CONFIG_ARM64_SSBD))
+			return sprintf(buf,
+			    "Mitigation: Speculative Store Bypass disabled via prctl\n");
+	}
+
+	return sprintf(buf, "Vulnerable\n");
+}
-- 
2.20.1

