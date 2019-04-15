Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7A9C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 21:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31F5D2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 21:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfDOVWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 17:22:04 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42952 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728043AbfDOVVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 17:21:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90DB01688;
        Mon, 15 Apr 2019 14:21:43 -0700 (PDT)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.29.246])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E94713F68F;
        Mon, 15 Apr 2019 14:21:42 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, marc.zyngier@arm.com,
        suzuki.poulose@arm.com, Dave.Martin@arm.com,
        shankerd@codeaurora.org, julien.thierry@arm.com,
        mlangsdo@redhat.com, stefan.wahren@i2se.com,
        Andre.Przywara@arm.com, linux-kernel@vger.kernel.org,
        Jeremy Linton <jeremy.linton@arm.com>,
        Andre Przywara <andre.przywara@arm.com>
Subject: [v8 07/10] arm64: add sysfs vulnerability show for spectre v2
Date:   Mon, 15 Apr 2019 16:21:26 -0500
Message-Id: <20190415212129.1112-8-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190415212129.1112-1-jeremy.linton@arm.com>
References: <20190415212129.1112-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add code to track whether all the cores in the machine are
vulnerable, and whether all the vulnerable cores have been
mitigated.

Once we have that information we can add the sysfs stub and
provide an accurate view of what is known about the machine.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm64/kernel/cpu_errata.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index bd2cdd22da99..e51ddcb197c0 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -512,6 +512,10 @@ cpu_enable_cache_maint_trap(const struct arm64_cpu_capabilities *__unused)
 	.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,			\
 	CAP_MIDR_RANGE_LIST(midr_list)
 
+/* Track overall mitigation state. We are only mitigated if all cores are ok */
+static bool __hardenbp_enab = true;
+static bool __spectrev2_safe = true;
+
 /*
  * List of CPUs that do not need any Spectre-v2 mitigation at all.
  */
@@ -522,6 +526,10 @@ static const struct midr_range spectre_v2_safe_list[] = {
 	{ /* sentinel */ }
 };
 
+/*
+ * Track overall bp hardening for all heterogeneous cores in the machine.
+ * We are only considered "safe" if all booted cores are known safe.
+ */
 static bool __maybe_unused
 check_branch_predictor(const struct arm64_cpu_capabilities *entry, int scope)
 {
@@ -543,19 +551,25 @@ check_branch_predictor(const struct arm64_cpu_capabilities *entry, int scope)
 	if (!need_wa)
 		return false;
 
+	__spectrev2_safe = false;
+
 	if (!IS_ENABLED(CONFIG_HARDEN_BRANCH_PREDICTOR)) {
 		pr_warn_once("spectrev2 mitigation disabled by configuration\n");
+		__hardenbp_enab = false;
 		return false;
 	}
 
 	/* forced off */
 	if (__nospectre_v2) {
 		pr_info_once("spectrev2 mitigation disabled by command line option\n");
+		__hardenbp_enab = false;
 		return false;
 	}
 
-	if (need_wa < 0)
+	if (need_wa < 0) {
 		pr_warn_once("ARM_SMCCC_ARCH_WORKAROUND_1 missing from firmware\n");
+		__hardenbp_enab = false;
+	}
 
 	return (need_wa > 0);
 }
@@ -778,3 +792,15 @@ ssize_t cpu_show_spectre_v1(struct device *dev, struct device_attribute *attr,
 {
 	return sprintf(buf, "Mitigation: __user pointer sanitization\n");
 }
+
+ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	if (__spectrev2_safe)
+		return sprintf(buf, "Not affected\n");
+
+	if (__hardenbp_enab)
+		return sprintf(buf, "Mitigation: Branch predictor hardening\n");
+
+	return sprintf(buf, "Vulnerable\n");
+}
-- 
2.20.1

