Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5F6C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 23:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05B972184B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 23:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FLp7f/Mc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387620AbfDQXCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 19:02:07 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:44147 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729079AbfDQXCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 19:02:06 -0400
Received: by mail-pf1-f202.google.com with SMTP id v16so129553pfn.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 16:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AW27o0HP+cyrArj4H0V+gm1HNI3PxlU2rfA1IzSZc1g=;
        b=FLp7f/Mco2iTE08Gph2vFpyu0koLvmczvpGUMFYCzXId4aQzBg174KKiYZB3tPkdi+
         tlaO6jOeUOxxumX8aZf3nKpDtleF+VBpezFQgDBQc6BQNiY/QCv4b8H6ZrNr1X1r1dE5
         qfGwnhis51c+3reTXtSvv6nw3smE1lxi3CNNX6kINHoxWx5lQAU1DGuqJZRIVBGcvJ8a
         5kM86cRjN3seCMV2KPvFYLIfV+XYnQvvM94/wVrBLiDURFj+zu7F3X9QSG+/qi/SSe3b
         ffnBZuhK1/ZH0U9QBxGCF9NshU2siSMfb6MKtpd8q3Yk2xRCH+mlwYmhQsP6yoUxeE3h
         MfOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AW27o0HP+cyrArj4H0V+gm1HNI3PxlU2rfA1IzSZc1g=;
        b=XjfrG2gSIU8N0MjnloGGVgRW1c/gXERjgD4YBBsUWNvu5BWuktyhhT/0NDyMV0RE1t
         TgFUD76Zsxylw5NHk/2uAgRekw1TI8G0QgdJkcKOU/2JUdCkFvo0/1qeLzGb1FGHXhHa
         VPcChr7NZ5AcrBEC/OErAuR2exyScYQN9VJTmh1sIHqnIQ/bR6jbnSNQY0RZ4/pZlxXZ
         37sBp02EDMg+z8slPGWla5mlyyENnSM1eEwe46jdXKKZJmuAJIaJNLVoAzvgcyzw/Y0N
         Fn9WLCbjqk4ZG4LWaqm2ffk4HcVVKpE3axWkGjAHl35Dchqip/I+fKYjomK4EjeZylyg
         sXzw==
X-Gm-Message-State: APjAAAXHUYq7gSbjjjzH3onsqNSvvlyPdf7UuVGaIXAEfvYcU0mUZb1Z
        SKtErXbt1czmiHPlbABVqKoZ2n7UoH2x
X-Google-Smtp-Source: APXvYqyd3vVpVq7KQzD/8q62DNM0a/p7OI9U71zXPn3/OgJIS/19MAGX0EnFQ3KO1cEXtwyIJsNE9JH8QYQt
X-Received: by 2002:a63:2983:: with SMTP id p125mr86811321pgp.262.1555542125849;
 Wed, 17 Apr 2019 16:02:05 -0700 (PDT)
Date:   Wed, 17 Apr 2019 16:01:53 -0700
In-Reply-To: <20190313222124.229371-1-rajatja@google.com>
Message-Id: <20190417230155.5282-1-rajatja@google.com>
Mime-Version: 1.0
References: <20190313222124.229371-1-rajatja@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v6 1/3] platform/x86: intel_pmc_core: Convert to a platform_driver
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

Convert the intel_pmc_core driver to a platform driver. There is no
functional change to the driver, or to the way the devices are
instantiated.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v6: Let the way devices are instantiated exactly the same as before this
    patch (so no functional change other than converting to a platform
    device). Use "intel_pmc_core" platform device (no ACPI
    instantiation)
v5: Remove the gerrit ID from commit log
v4: put back the x86_match_cpu() method.
v3: Don't instantiate the platform_device. Use ACPI enumeration.
v2: Rephrase the commit log. No code changes.

 drivers/platform/x86/intel_pmc_core.c | 65 +++++++++++++++++++++++----
 1 file changed, 57 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index 9908d233305e..153e79cc4d5b 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -19,6 +19,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/platform_device.h>
 #include <linux/uaccess.h>
 
 #include <asm/cpu_device_id.h>
@@ -854,13 +855,17 @@ static const struct dmi_system_id pmc_core_dmi_table[]  = {
 	{}
 };
 
-static int __init pmc_core_probe(void)
+static int pmc_core_probe(struct platform_device *pdev)
 {
+	static bool device_initialized;
 	struct pmc_dev *pmcdev = &pmc;
 	const struct x86_cpu_id *cpu_id;
 	u64 slp_s0_addr;
 	int err;
 
+	if (device_initialized)
+		return -ENODEV;
+
 	cpu_id = x86_match_cpu(intel_pmc_core_ids);
 	if (!cpu_id)
 		return -ENODEV;
@@ -886,30 +891,74 @@ static int __init pmc_core_probe(void)
 		return -ENOMEM;
 
 	mutex_init(&pmcdev->lock);
+	platform_set_drvdata(pdev, pmcdev);
 	pmcdev->pmc_xram_read_bit = pmc_core_check_read_lock_bit();
+	dmi_check_system(pmc_core_dmi_table);
 
 	err = pmc_core_dbgfs_register(pmcdev);
 	if (err < 0) {
-		pr_warn(" debugfs register failed.\n");
+		dev_warn(&pdev->dev, "debugfs register failed.\n");
 		iounmap(pmcdev->regbase);
 		return err;
 	}
 
-	dmi_check_system(pmc_core_dmi_table);
-	pr_info(" initialized\n");
+	device_initialized = true;
+	dev_info(&pdev->dev, " initialized\n");
+
 	return 0;
 }
-module_init(pmc_core_probe)
 
-static void __exit pmc_core_remove(void)
+static int pmc_core_remove(struct platform_device *pdev)
 {
-	struct pmc_dev *pmcdev = &pmc;
+	struct pmc_dev *pmcdev = platform_get_drvdata(pdev);
 
 	pmc_core_dbgfs_unregister(pmcdev);
+	platform_set_drvdata(pdev, NULL);
 	mutex_destroy(&pmcdev->lock);
 	iounmap(pmcdev->regbase);
+	return 0;
+}
+
+static struct platform_driver pmc_core_driver = {
+	.driver = {
+		.name = "intel_pmc_core",
+	},
+	.probe = pmc_core_probe,
+	.remove = pmc_core_remove,
+};
+
+static struct platform_device pmc_core_device = {
+	.name = "intel_pmc_core",
+};
+
+static int __init pmc_core_init(void)
+{
+	int ret;
+
+	if (!x86_match_cpu(intel_pmc_core_ids))
+		return -ENODEV;
+
+	ret = platform_driver_register(&pmc_core_driver);
+	if (ret)
+		return ret;
+
+	ret = platform_device_register(&pmc_core_device);
+	if (ret) {
+		platform_driver_unregister(&pmc_core_driver);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void __exit pmc_core_exit(void)
+{
+	platform_device_unregister(&pmc_core_device);
+	platform_driver_unregister(&pmc_core_driver);
 }
-module_exit(pmc_core_remove)
+
+module_init(pmc_core_init)
+module_exit(pmc_core_exit)
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Intel PMC Core Driver");
-- 
2.21.0.392.gf8f6787159e-goog

