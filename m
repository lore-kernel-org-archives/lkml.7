Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9359FC10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 00:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D89B217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 00:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YcOfaefS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfDKAhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 20:37:53 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:40484 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfDKAhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 20:37:52 -0400
Received: by mail-pf1-f201.google.com with SMTP id f7so3018732pfd.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 17:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sjT6DpYQBJJsmTdMcmaumUE9gKAmThJGm77LVwpquRY=;
        b=YcOfaefSzIGtjAzsICexlH/tE/Yrz0TsAy7DYC4/vds8sa5CDEUnYECL4lXluuvabv
         UGFKkV6i92vKW/qJxJwaQ/3c+6aTquMr2pG+nHY08dnCL3Jx33e6ZzU2wyNw3TKq72Hb
         eWNI9T0MJF2wzX/+ggZBTVvqww1w5RHAaHm8xl8CgxZjFh5fNpTben3u9DVlYyDTa8vK
         1vWVtNwvL9TynMpQaiFEXtOfYKoimKYbrqIIkfPh7HHcopQ+Ox8iiWQU6Riuy2eZHuy7
         0qxcTpo5IwsvEl9Cv/Msz1vMBfj1a0tCzmo3v/oYvC2+qtzCuqanT/2T2kgwVph3K8Cb
         Hu3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sjT6DpYQBJJsmTdMcmaumUE9gKAmThJGm77LVwpquRY=;
        b=g41Dn7pzd3y0aE6dOma76Qdj6hPRE5taLQv/P+0XLjAUZpTO4ay5ahGiDcMJRd06PP
         yP/MKjm+PPYVH0O3Nj4YuhSMXb8B+YDfIONCBhYPHyNCyw4neslifI+zDJSO+B8kvTYs
         M4n4TRowni1j44EP4hVZ8GPAB3wUmxLCAHXj7peErCGuWNZctf8nvmtdgZsfHZUWmunG
         qS9ReOkUHC9yXHR2q2aDTbnrHMGNXMugHQlXxiYCOnTLS/PBnWjw4lbXrQfP3EExx0jm
         EO1xUC4upqaY+Vw1Abf+nOZxWKxqrOMv6ZOsueM+dEkOZe+ih7rRp1MUwJugSj6NpRUT
         Uv9w==
X-Gm-Message-State: APjAAAV8ppkXJEllQmrUN7QgMeVVm6vaVJzLwFLwGA8d5FK1GKPt4qN+
        hLOnm409QgnzOrWkaCjk3x9HeVJ1vUVJ
X-Google-Smtp-Source: APXvYqwvjgloPKcxsL0dvH9X1D10OuR44FqgdnKpSKYIciLLjbjrqPyiM6HKDhaNdE0But0XwSxZg2yPWp29
X-Received: by 2002:a63:e509:: with SMTP id r9mr1021666pgh.72.1554943071064;
 Wed, 10 Apr 2019 17:37:51 -0700 (PDT)
Date:   Wed, 10 Apr 2019 17:37:37 -0700
In-Reply-To: <20190411003738.55073-1-rajatja@google.com>
Message-Id: <20190411003738.55073-2-rajatja@google.com>
Mime-Version: 1.0
References: <20190313222124.229371-1-rajatja@google.com> <20190411003738.55073-1-rajatja@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v5 2/3] platform/x86: intel_pmc_core: Allow to dump debug
 registers on S0ix failure
From:   Rajat Jain <rajatja@google.com>
To:     Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>,
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
v5: Remove the gerrit id from commit log
v4: Use 1 condition per if statement, rename some functions.
v3: No changes
v2: Use pm_suspend_via_firmware() to enable the check only for S0ix

 drivers/platform/x86/intel_pmc_core.c | 93 +++++++++++++++++++++++++++
 drivers/platform/x86/intel_pmc_core.h |  7 ++
 2 files changed, 100 insertions(+)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index 8da886e17681..b1f099de5cb3 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -20,6 +20,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
+#include <linux/suspend.h>
 #include <linux/uaccess.h>
 
 #include <asm/cpu_device_id.h>
@@ -920,6 +921,97 @@ static int pmc_core_remove(struct platform_device *pdev)
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
+	pmcdev->check_counters = false;
+
+	/* No warnings on S0ix failures */
+	if (!warn_on_s0ix_failures)
+		return 0;
+
+	/* Check if the syspend will actually use S0ix */
+	if (pm_suspend_via_firmware())
+		return 0;
+
+	/* Save PC10 and S0ix residency for checking later */
+	if (!rdmsrl_safe(MSR_PKG_C10_RESIDENCY, &pmcdev->pc10_counter) &&
+	    !pmc_core_dev_state_get(pmcdev, &pmcdev->s0ix_counter))
+		pmcdev->check_counters = true;
+
+	return 0;
+}
+
+static inline bool pmc_core_is_pc10_failed(struct pmc_dev *pmcdev)
+{
+	u64 pc10_counter;
+
+	if (!rdmsrl_safe(MSR_PKG_C10_RESIDENCY, &pc10_counter) &&
+	    pc10_counter == pmcdev->pc10_counter)
+		return true;
+
+	return false;
+}
+
+static inline bool pmc_core_is_s0ix_failed(struct pmc_dev *pmcdev)
+{
+	u64 s0ix_counter;
+
+	if (!pmc_core_dev_state_get(pmcdev, &s0ix_counter) &&
+	    s0ix_counter == pmcdev->s0ix_counter)
+		return true;
+
+	return false;
+}
+
+static int pmc_core_resume(struct device *dev)
+{
+	struct pmc_dev *pmcdev = dev_get_drvdata(dev);
+
+	if (!pmcdev->check_counters)
+		return 0;
+
+	if (pmc_core_is_pc10_failed(pmcdev)) {
+		dev_info(dev, "PC10 entry had failed (PC10 cnt=0x%llx)\n",
+			 pmcdev->pc10_counter);
+	} else if (pmc_core_is_s0ix_failed(pmcdev)) {
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
@@ -930,6 +1022,7 @@ static struct platform_driver pmc_core_driver = {
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

