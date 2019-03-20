Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC66DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9399D2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gnl9Jl8/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbfCTBEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 21:04:42 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:53901 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbfCTBEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 21:04:40 -0400
Received: by mail-vk1-f201.google.com with SMTP id 5so362125vkg.20
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 18:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FjGKF+9fQR3oX5+16IJIymH9iLuHR5HxuJmit6BGji4=;
        b=gnl9Jl8/gtPJurfj/iCHxxyc0bx2lUu/PcCqjIDRhZbnYRgLk+8zyS/8KrkkKblMHd
         v2EibdcN9ZeLZgb9awwOBj+Df9NpnszHMJm097kawu1oI0oYE/mSOhX7yn0QrrG07rQU
         AKhiUzCFXPspxqyKJAotRQgsxfPV7eK5bzz52paQZiSzFo9E1GPj2Gch58WNYgydUSiJ
         oy9A/TpjHZhv3URruRlV554Xd7AqRHiemm2N6AyfqdQQB2JmTpPE0G7U0xYVr0xwdMc6
         1rphiPrIjX8dbK4kFO0ZPLw0/YwrlbpE+avMzVF2ttQ9s5iwGpJv+BR7y8LpsNqKW0Ux
         N8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FjGKF+9fQR3oX5+16IJIymH9iLuHR5HxuJmit6BGji4=;
        b=f2eugK1gI/bU8k4Uj8uMD+EqWd0bGxVswWJ2uhrBaxNvXt15YaILetvOQHf3gPKuXy
         j0+6mtJwiA47yxIt5phnj8NcgmzK3q5PEnMWiGMeph5uqfM78k3t+w7NefbRtEKQ1gnq
         nRhS9dj3NOByj+n7KzTtVKszp7zQrnAAWquA+DIzSkoDbFyymv0xtJHuVS1fXzalN6qt
         uZ9UrzsuUID3N07GrpZbrWvnrlb+9DL7VGjhL5/gwYJ8M1prA040uOC3bZ6FYfbvEmFg
         d+kBkOAb3SxTlAJiF6FpUFEeIqAR/SFMPNWrWdDXVUSAufJwUyG5lhg4IjmRc0sPVSi3
         dXyA==
X-Gm-Message-State: APjAAAW/nzKdXxTjcaKgBhnleJBZb42m+UDCKJpA+FBT/6rtxOE0ykXl
        lCVhbYb8gAQWdyBOvbmTUXt6M8aG7xuG
X-Google-Smtp-Source: APXvYqyKznbiWjVODxukg+J3yydSECtZCA1O07wXT1X1G1UO+IEvahOfPwOQWsr/u85sTxMxZGrFbgiQ2GiQ
X-Received: by 2002:ab0:641a:: with SMTP id x26mr1504316uao.12.1553043879468;
 Tue, 19 Mar 2019 18:04:39 -0700 (PDT)
Date:   Tue, 19 Mar 2019 18:04:31 -0700
In-Reply-To: <20190320010431.19833-1-rajatja@google.com>
Message-Id: <20190320010431.19833-2-rajatja@google.com>
Mime-Version: 1.0
References: <20190313222124.229371-1-rajatja@google.com> <20190320010431.19833-1-rajatja@google.com>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
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
last S0ix attempt was successful. If not, the driver would warn and provide
helpful debug information (which gets latched during the failed suspend
attempt) to debug the S0ix failure.

This information is very useful to debug S0ix failures. Specially since
the latched debug information will be lost (over-written) if the system
attempts to go into runtime (or imminent) S0ix again after that failed
suspend attempt.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v2: Use pm_suspend_via_firmware() to enable the check only for S0ix
    (I think).

 drivers/platform/x86/intel_pmc_core.c | 86 +++++++++++++++++++++++++++
 drivers/platform/x86/intel_pmc_core.h |  7 +++
 2 files changed, 93 insertions(+)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index 55578d07610c..0ab893fac4bb 100644
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
2.21.0.225.g810b269d1ac-goog

