Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4E0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 22:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA97821019
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 22:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vxzpb319"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfCMWVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 18:21:35 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:47643 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfCMWVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 18:21:34 -0400
Received: by mail-vk1-f201.google.com with SMTP id y132so1243737vkd.14
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 15:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=N/8bTN+wgMZray1e0uHhmLK00Ub7CbzrJhnIjb/FwiA=;
        b=Vxzpb3191e4PQi2AYMtPoN/HMgrcaSIhwwScfsk+zKFIN3fQpNuTicDdGOY/jDNG7+
         YFcZujD7dAf0Acp40m2RWE77X46VtQczzObma4M/gBJj3mFIaF1EvCJkn6A931iBu30u
         yW6oFSDCnawGeNb5UWL9RMbvoao8oosxUNZ27SCZqFiUmHYXfzEqeKh8wAVUIoV4QK2U
         w+CRh05kbtuRpGpP1bLILORLWJID9swGib3pZvHlDjuXMkATOrN2CzQBxVVsHEmIcWrZ
         2TbyTqJANJUIozahl66CeQKeuu4j9tasPVuw8L63GiISC4IPA+EwivVerCMgwc7QSK3/
         Zx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=N/8bTN+wgMZray1e0uHhmLK00Ub7CbzrJhnIjb/FwiA=;
        b=L1ndsQTz1I3RgU221ACgnObaXsorAN2B/PXmMPtLvkEZPjYj62CjrwnQJ/DA5J6S4P
         DioILeQ5TvsoL/ufpdKYIAb9EOW0xlcy/VNG2pFPYFUmAGwI66RcVzDhV3Ua2Behsxuj
         DT2PTGxZhD4c6LS/L/593EYIrzKjekw899Hp86PrjcGChYEwFh8ch0uAx1pZwLkcTOHA
         bU2/C1q+Qd5sP+IJJgHSBpU8aYBgDNoLnMsfV4YiSwxBioDtfuuEcNEC8p9sglpvEzNI
         1gZ92BMU6w1ytdI/sp31FMadCccX81Xkm3KFtlT3hvBYLx2wRj8AGjLG0dH8tuvEwjQu
         lDPg==
X-Gm-Message-State: APjAAAUOOwSPQgGUJSCGyhh+Adj/XMBEyEx3HKFFc/f4/Xyr4mQnEHsP
        a4kO45cv+UJGIhCGkn3cLAUOLLc82wtZ
X-Google-Smtp-Source: APXvYqzgUFCdQGMisbk/9CVRiWYHDcanTKOtXrhc2j85eb1v3PAwS+dBvIiEi8aXTzNDKh1Q7uBEU5482FLv
X-Received: by 2002:ab0:22ce:: with SMTP id z14mr29223600uam.20.1552515693312;
 Wed, 13 Mar 2019 15:21:33 -0700 (PDT)
Date:   Wed, 13 Mar 2019 15:21:24 -0700
In-Reply-To: <20190313222124.229371-1-rajatja@google.com>
Message-Id: <20190313222124.229371-2-rajatja@google.com>
Mime-Version: 1.0
References: <20190313222124.229371-1-rajatja@google.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
Subject: [PATCH 2/2] platform/x86: intel_pmc_core: Allow to dump debug
 registers on S0ix failure
From:   Rajat Jain <rajatja@google.com>
To:     Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rajat Jain <rajatja@google.com>, furquan@google.com,
        evgreen@google.com, rajatxjain@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a module parameter which when enabled, will check on resume, if the
last S0ix attempt was successful. If not, the driver would provide
helpful debug information (which gets latched during the failed suspend
attempt) to debug the S0ix failure.

This information is very useful to debug S0ix failures. Specially since
the latched debug information will be lost (over-written) if the system
attempts to go into runtime (or imminent) S0ix again after that failed
suspend attempt.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
 drivers/platform/x86/intel_pmc_core.c | 86 +++++++++++++++++++++++++++
 drivers/platform/x86/intel_pmc_core.h |  7 +++
 2 files changed, 93 insertions(+)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index 55578d07610c..b1f4405a27ce 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -20,6 +20,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
+#include <linux/suspend.h>
 #include <linux/uaccess.h>
 
 #include <asm/cpu_device_id.h>
@@ -890,9 +891,94 @@ static int pmc_core_remove(struct platform_device *pdev)
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
+	if (warn_on_s0ix_failures &&
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
+const struct dev_pm_ops pmc_core_pm_ops = {
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(pmc_core_suspend, pmc_core_resume)
+};
+
 static struct platform_driver pmc_core_driver = {
 	.driver = {
 		.name = "pmc_core",
+		.pm = &pmc_core_pm_ops
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
2.21.0.360.g471c308f928-goog

