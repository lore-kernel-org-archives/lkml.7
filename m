Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB5DC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AD4920663
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfDHKyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 06:54:13 -0400
Received: from mga04.intel.com ([192.55.52.120]:31118 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfDHKyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 06:54:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 03:54:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,325,1549958400"; 
   d="scan'208";a="147454405"
Received: from wubinbin-desk.sh.intel.com ([10.239.143.112])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Apr 2019 03:54:11 -0700
From:   Binbin Wu <binbin.wu@intel.com>
To:     mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     binbin.wu@intel.com
Subject: [PATCH] pinctrl: pinctrl-intel: move gpio suspend/resume to noirq phase
Date:   Mon,  8 Apr 2019 18:49:26 +0800
Message-Id: <1554720566-29103-1-git-send-email-binbin.wu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In current driver, SET_LATE_SYSTEM_SLEEP_PM_OPS is used to install the
callbacks for suspend/resume.
GPIO pin may be used as the interrupt pin by some device. However, using
SET_LATE_SYSTEM_SLEEP_PM_OPS() to install the callbacks, the resume
callback is called after resume_device_irqs(). Unintended interrupts may
arrive due to resuming device irqs first, but the GPIO controller is not
properly restored.

Normally, for a SMP system, there are multiple cores, so even when there are
unintended interrupts, BSP gets the chance to init the gpio chip soon.
But when there is only 1 core is active (other cores are offlined or
single core) during resume, it is more easily to observe the unintended
interrupts.

This patch renames the suspend/resume function by adding suffix "_noirq",
and installs the callbacks using SET_NOIRQ_SYSTEM_SLEEP_PM_OPS().

Signed-off-by: Binbin Wu <binbin.wu@intel.com>
---
 drivers/pinctrl/intel/pinctrl-intel.c |  8 ++++----
 drivers/pinctrl/intel/pinctrl-intel.h | 11 ++++++-----
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index 3b18181..70638b7 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -1466,7 +1466,7 @@ static bool intel_pinctrl_should_save(struct intel_pinctrl *pctrl, unsigned int
 	return false;
 }
 
-int intel_pinctrl_suspend(struct device *dev)
+int intel_pinctrl_suspend_noirq(struct device *dev)
 {
 	struct intel_pinctrl *pctrl = dev_get_drvdata(dev);
 	struct intel_community_context *communities;
@@ -1505,7 +1505,7 @@ int intel_pinctrl_suspend(struct device *dev)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(intel_pinctrl_suspend);
+EXPORT_SYMBOL_GPL(intel_pinctrl_suspend_noirq);
 
 static void intel_gpio_irq_init(struct intel_pinctrl *pctrl)
 {
@@ -1527,7 +1527,7 @@ static void intel_gpio_irq_init(struct intel_pinctrl *pctrl)
 	}
 }
 
-int intel_pinctrl_resume(struct device *dev)
+int intel_pinctrl_resume_noirq(struct device *dev)
 {
 	struct intel_pinctrl *pctrl = dev_get_drvdata(dev);
 	const struct intel_community_context *communities;
@@ -1589,7 +1589,7 @@ int intel_pinctrl_resume(struct device *dev)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(intel_pinctrl_resume);
+EXPORT_SYMBOL_GPL(intel_pinctrl_resume_noirq);
 #endif
 
 MODULE_AUTHOR("Mathias Nyman <mathias.nyman@linux.intel.com>");
diff --git a/drivers/pinctrl/intel/pinctrl-intel.h b/drivers/pinctrl/intel/pinctrl-intel.h
index b8a07d37..a8e958f 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.h
+++ b/drivers/pinctrl/intel/pinctrl-intel.h
@@ -177,13 +177,14 @@ int intel_pinctrl_probe_by_hid(struct platform_device *pdev);
 int intel_pinctrl_probe_by_uid(struct platform_device *pdev);
 
 #ifdef CONFIG_PM_SLEEP
-int intel_pinctrl_suspend(struct device *dev);
-int intel_pinctrl_resume(struct device *dev);
+int intel_pinctrl_suspend_noirq(struct device *dev);
+int intel_pinctrl_resume_noirq(struct device *dev);
 #endif
 
-#define INTEL_PINCTRL_PM_OPS(_name)						  \
-const struct dev_pm_ops _name = {						  \
-	SET_LATE_SYSTEM_SLEEP_PM_OPS(intel_pinctrl_suspend, intel_pinctrl_resume) \
+#define INTEL_PINCTRL_PM_OPS(_name)					\
+const struct dev_pm_ops _name = {					\
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(intel_pinctrl_suspend_noirq,	\
+				      intel_pinctrl_resume_noirq)	\
 }
 
 #endif /* PINCTRL_INTEL_H */
-- 
2.7.4

