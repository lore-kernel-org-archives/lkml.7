Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61137C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18BE52146F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ds46Nhqp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfDEUgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 16:36:11 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:56784 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfDEUgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 16:36:11 -0400
Received: by mail-vk1-f201.google.com with SMTP id m191so3057975vka.23
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 13:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PzhxsO5C8VAumTpC620MRnJ/3CH/08+LiMhF3Cljj4U=;
        b=ds46NhqpGq98UjovpZxd9KePNLqEP6B8nkaCouY9JP/0OcMazHuvlDAfepV429u0Iw
         sbewhxOYmmM71oXlmvPmcRDBp2/of6wEcp/QDHM66zSI/jsFgv1zihxTDH5RMNOEDcW1
         ov1PAJaIcXyU6ufDvKVrX+XOTaVeNXDN7q3qvkAUA5r4cI5sYKK+yHklGkzajwXeJbI1
         PhV5zGEcJo7gFK48+RP6M6qK0asqBylPGkBnJyXHmyboXRYnysVYaaBfoIklspDsHQ8b
         yZSKmyxez+Ss8x0L6fbZ6/auXl8whPyaJkMenidQFUgVEh2XzhlCIXwGOiyDuwy9maTR
         /63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PzhxsO5C8VAumTpC620MRnJ/3CH/08+LiMhF3Cljj4U=;
        b=Dj/2v1oSTX3waqRYXZWAky8hanUIs7XLff4BrGcAC+Ah1zoe7Pu9PUrBh+Hal+Tf9c
         LVOTcGTw4lAmAwlkDOxF12fpPDUhX7VK2LohBcFrg45l/GvpB9jX2XdUshSsJbPC4Zs/
         yADeTjDrIAE7REfCkRGj3wp7fbD1n5wfzWOGhDiHN2zD5aY+nTbchedCmSb/4ch/cLCX
         0eV6RAwVNfGBORW2yN/AYPWVTIkOPrvdkKB/kGQR3HNKHihuz6/fhMoGWNuP4GhYgNnd
         rj14oM6xNIqa5LUcCYNGOl+gPU0VPFRtVLQqgY8qfyVt1zm3VQTiDVvVzwv5Q2GrXZTk
         Izcw==
X-Gm-Message-State: APjAAAW1yVUvFmMwAH7OQkQ2VBUgwJ+a4GP6Ep62CKpCmTLvme1K2I3u
        SZ5sCAkG0Bc4258wuQit2mwVvzW2wxBF
X-Google-Smtp-Source: APXvYqz1cawYrGDygbqIDlyN/RQ/GVRAlrKTjh2VXN4ovphmpSi39DVS5RGNhePUvz3xolbSCXvgwUQGCM09
X-Received: by 2002:a67:8013:: with SMTP id b19mr1755710vsd.28.1554496569667;
 Fri, 05 Apr 2019 13:36:09 -0700 (PDT)
Date:   Fri,  5 Apr 2019 13:35:57 -0700
In-Reply-To: <20190405203558.19160-1-rajatja@google.com>
Message-Id: <20190405203558.19160-2-rajatja@google.com>
Mime-Version: 1.0
References: <20190313222124.229371-1-rajatja@google.com> <20190405203558.19160-1-rajatja@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v3 2/3] platform/x86: intel_pmc_core: Allow to dump debug
 registers on S0ix failure
From:   Rajat Jain <rajatja@google.com>
To:     Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wysocki@google.com, Rafael J <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Rajat Jain <rajatja@google.com>, furquan@google.com,
        evgreen@google.com, rajatxjain@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a module parameter which when enabled, will check on resume, if the
last S0ix attempt was successful. If not, the driver would warn and provide
helpful debug information (which gets latched during the failed suspend
attempt) to debug the S0ix failure.

This information is very useful to debug S0ix failures. Specially since
the latched debug information will be lost (over-written) if the system
attempts to go into runtime (or imminent) S0ix again after that failed
suspend attempt.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v3: No changes
v2: Use pm_suspend_via_firmware() to enable the check only for S0ix

 drivers/platform/x86/intel_pmc_core.c | 86 +++++++++++++++++++++++++++
 drivers/platform/x86/intel_pmc_core.h |  7 +++
 2 files changed, 93 insertions(+)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index 331889a57f73..d9561a1c620d 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -20,6 +20,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
+#include <linux/suspend.h>
 #include <linux/uaccess.h>
 
 #include <asm/cpu_device_id.h>
@@ -928,6 +929,90 @@ static int pmc_core_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+
+static bool warn_on_s0ix_failures;
+module_param(warn_on_s0ix_failures, bool, 0644);
+MODULE_PARM_DESC(warn_on_s0ix_failures, "Check and warn for S0ix failures");
+
+static int pmc_core_suspend(struct device *dev)
+{
+	struct pmc_dev *pmcdev = dev_get_drvdata(dev);
+
+	/* Save PC10 and S0ix residency for checking later */
+	if (warn_on_s0ix_failures && !pm_suspend_via_firmware() &&
+	    !rdmsrl_safe(MSR_PKG_C10_RESIDENCY, &pmcdev->pc10_counter) &&
+	    !pmc_core_dev_state_get(pmcdev, &pmcdev->s0ix_counter))
+		pmcdev->check_counters = true;
+	else
+		pmcdev->check_counters = false;
+
+	return 0;
+}
+
+static inline bool pc10_failed(struct pmc_dev *pmcdev)
+{
+	u64 pc10_counter;
+
+	if (!rdmsrl_safe(MSR_PKG_C10_RESIDENCY, &pc10_counter) &&
+	    pc10_counter == pmcdev->pc10_counter)
+		return true;
+	else
+		return false;
+}
+
+static inline bool s0ix_failed(struct pmc_dev *pmcdev)
+{
+	u64 s0ix_counter;
+
+	if (!pmc_core_dev_state_get(pmcdev, &s0ix_counter) &&
+	    s0ix_counter == pmcdev->s0ix_counter)
+		return true;
+	else
+		return false;
+}
+
+static int pmc_core_resume(struct device *dev)
+{
+	struct pmc_dev *pmcdev = dev_get_drvdata(dev);
+
+	if (!pmcdev->check_counters)
+		return 0;
+
+	if (pc10_failed(pmcdev)) {
+		dev_info(dev, "PC10 entry had failed (PC10 cnt=0x%llx)\n",
+			 pmcdev->pc10_counter);
+	} else if (s0ix_failed(pmcdev)) {
+
+		const struct pmc_bit_map **maps = pmcdev->map->slps0_dbg_maps;
+		const struct pmc_bit_map *map;
+		int offset = pmcdev->map->slps0_dbg_offset;
+		u32 data;
+
+		dev_warn(dev, "S0ix entry had failed (S0ix cnt=%llu)\n",
+			 pmcdev->s0ix_counter);
+		while (*maps) {
+			map = *maps;
+			data = pmc_core_reg_read(pmcdev, offset);
+			offset += 4;
+			while (map->name) {
+				dev_warn(dev, "SLP_S0_DBG: %-32s\tState: %s\n",
+					 map->name,
+					 data & map->bit_mask ? "Yes" : "No");
+				++map;
+			}
+			++maps;
+		}
+	}
+	return 0;
+}
+
+#endif
+
+static const struct dev_pm_ops pmc_core_pm_ops = {
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(pmc_core_suspend, pmc_core_resume)
+};
+
 static const struct acpi_device_id pmc_core_acpi_ids[] = {
 	{"INT33A1", 0}, /* _HID for Intel Power Engine, _CID PNP0D80*/
 	{ }
@@ -938,6 +1023,7 @@ static struct platform_driver pmc_core_driver = {
 	.driver = {
 		.name = "pmc_core",
 		.acpi_match_table = ACPI_PTR(pmc_core_acpi_ids),
+		.pm = &pmc_core_pm_ops,
 	},
 	.probe = pmc_core_probe,
 	.remove = pmc_core_remove,
diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel_pmc_core.h
index 88d9c0653a5f..fdee5772e532 100644
--- a/drivers/platform/x86/intel_pmc_core.h
+++ b/drivers/platform/x86/intel_pmc_core.h
@@ -241,6 +241,9 @@ struct pmc_reg_map {
  * @pmc_xram_read_bit:	flag to indicate whether PMC XRAM shadow registers
  *			used to read MPHY PG and PLL status are available
  * @mutex_lock:		mutex to complete one transcation
+ * @check_counters:	On resume, check if counters are getting incremented
+ * @pc10_counter:	PC10 residency counter
+ * @s0ix_counter:	S0ix residency (step adjusted)
  *
  * pmc_dev contains info about power management controller device.
  */
@@ -253,6 +256,10 @@ struct pmc_dev {
 #endif /* CONFIG_DEBUG_FS */
 	int pmc_xram_read_bit;
 	struct mutex lock; /* generic mutex lock for PMC Core */
+
+	bool check_counters; /* Check for counter increments on resume */
+	u64 pc10_counter;
+	u64 s0ix_counter;
 };
 
 #endif /* PMC_CORE_H */
-- 
2.21.0.392.gf8f6787159e-goog

