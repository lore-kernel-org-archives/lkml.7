Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9EFC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 23:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 109CE2183F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 23:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SrwuDJ3A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387677AbfDQXCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 19:02:16 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:50721 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729079AbfDQXCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 19:02:14 -0400
Received: by mail-pg1-f202.google.com with SMTP id 33so77479pgv.17
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 16:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6boVZoHFi8CqfTk8kAtjefSBF8UemwCKpOBEIchoJQ8=;
        b=SrwuDJ3Ac8e5GTrnlBjwR8NO+Fj76UGcn2RCFYsvPyQSxyjLn1DAIpc81cB/ddaZNg
         O8+ngY88MWtcBTdLQvR0RQKKaUBmitxVtaN9KTiG1MFdr9nfzWrs+cIq/F4u6fraD5xX
         Yk81GpW4LELtU6q4AZJ/v9k6gtWFPma8qfRD6+YPHCs1DtyQ1AH0r4FHANY1T0FwGYJV
         vj7/YEijWhfY2YQZFn8/8w2PIP6JyXbWSbYPIuMPf0qH7NiLCkTv1dkIqcUi1aHFDb5d
         vuEJ5GAH9rIH3Ah00Jd96gG9QqaNvDGfzzVuo7U8v6b2TA+X+HfDwXfXwH9WGrVLiSvN
         k3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6boVZoHFi8CqfTk8kAtjefSBF8UemwCKpOBEIchoJQ8=;
        b=i52xZfBMMP8E3h4noanRHkqB+rNfCWQvAUgBi7YiwqoXyEZNg9fa0SHrEvVCiIuxv3
         8xlVIZEGtoF/4N4oDbu7IBPMIb5MN1F6MJbg2Dek8SpHPzMMh8HvwmypRafr/dz6A27r
         FZPN2vPc6PbjA7HOsH9h1Ohy/TlSp1wBsY6OD/nWdr1RlWcz7TVp8rzKvbAevKhTHN2S
         b5pCmjuCAuibFYKVbU5nRSsk+THg50Qez/EqgkSCbHO0hA244/VUq3bU+/0Ux3e89NcH
         dd2u1umBpdH7qb48blvVWL7L1An6D1JS4IWorgv44RWw5wbEB09Fxf910k4ZY12PWQ9b
         C3SQ==
X-Gm-Message-State: APjAAAXDTFmjOAR1DlCM4frEGlyafLOeixfrLuDD1SVR6lWjXTpS60Jt
        xX+n/LQpcAvoY5/kZKh/PmP0ep4R6WRx
X-Google-Smtp-Source: APXvYqwarpx4DtRJAtV8u5l6h7ufOGANGAmvtDd6pYJh+gRTR2oeOx2btYZNitmV73NYwIkvC6fiCIPEZdet
X-Received: by 2002:a65:4341:: with SMTP id k1mr86280746pgq.88.1555542133894;
 Wed, 17 Apr 2019 16:02:13 -0700 (PDT)
Date:   Wed, 17 Apr 2019 16:01:55 -0700
In-Reply-To: <20190417230155.5282-1-rajatja@google.com>
Message-Id: <20190417230155.5282-3-rajatja@google.com>
Mime-Version: 1.0
References: <20190313222124.229371-1-rajatja@google.com> <20190417230155.5282-1-rajatja@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v6 3/3] platform/x86: intel_pmc_core: Attach using APCI HID "INT33A1"
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

Most modern platforms already have the ACPI device "INT33A1" that could
be used to attach to the driver. Switch the driver to using that and
thus make the intel_pmc_core.c a pure platform_driver.

Some of the legacy platforms though, may still not have this ACPI device
in their ACPI tables. Thus for such platforms, move the code to manually
instantiate a platform_device into a new file of its own. This would
instantiate the intel_pmc_core platform device and thus attach to
the driver, if the ACPI device for the same ("INT33A1") is not present
in a system where it should be. This was discussed here:
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1966991.html

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v6: Squash some of the changes of first patch into this patch to work
    around the bisectability issue.
v5: Remove the gerrit id from commit log
v4: Rename file, remove dummy arg, 1 conditional per if statement,
    simplify init / exit calls..
v3: (first version of *this* patch -to go with rest of v3 patchset)
v2: (does not exist)
v1: (does not exist)

 drivers/platform/x86/Makefile                 |  2 +-
 drivers/platform/x86/intel_pmc_core.c         | 40 +++----------
 .../platform/x86/intel_pmc_core_plat_drv.c    | 60 +++++++++++++++++++
 3 files changed, 69 insertions(+), 33 deletions(-)
 create mode 100644 drivers/platform/x86/intel_pmc_core_plat_drv.c

diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 86cb76677bc8..7041a88c34c7 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -89,7 +89,7 @@ obj-$(CONFIG_INTEL_BXTWC_PMIC_TMU)	+= intel_bxtwc_tmu.o
 obj-$(CONFIG_INTEL_TELEMETRY)	+= intel_telemetry_core.o \
 				   intel_telemetry_pltdrv.o \
 				   intel_telemetry_debugfs.o
-obj-$(CONFIG_INTEL_PMC_CORE)    += intel_pmc_core.o
+obj-$(CONFIG_INTEL_PMC_CORE)    += intel_pmc_core.o intel_pmc_core_plat_drv.o
 obj-$(CONFIG_PMC_ATOM)		+= pmc_atom.o
 obj-$(CONFIG_MLX_PLATFORM)	+= mlx-platform.o
 obj-$(CONFIG_INTEL_TURBO_MAX_3) += intel_turbo_max_3.o
diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index 1d902230ba61..f20d08ad39ea 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -1023,47 +1023,23 @@ static const struct dev_pm_ops pmc_core_pm_ops = {
 	SET_LATE_SYSTEM_SLEEP_PM_OPS(pmc_core_suspend, pmc_core_resume)
 };
 
+static const struct acpi_device_id pmc_core_acpi_ids[] = {
+	{"INT33A1", 0}, /* _HID for Intel Power Engine, _CID PNP0D80*/
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, pmc_core_acpi_ids);
+
 static struct platform_driver pmc_core_driver = {
 	.driver = {
 		.name = "intel_pmc_core",
+		.acpi_match_table = ACPI_PTR(pmc_core_acpi_ids),
 		.pm = &pmc_core_pm_ops,
 	},
 	.probe = pmc_core_probe,
 	.remove = pmc_core_remove,
 };
 
-static struct platform_device pmc_core_device = {
-	.name = "intel_pmc_core",
-};
-
-static int __init pmc_core_init(void)
-{
-	int ret;
-
-	if (!x86_match_cpu(intel_pmc_core_ids))
-		return -ENODEV;
-
-	ret = platform_driver_register(&pmc_core_driver);
-	if (ret)
-		return ret;
-
-	ret = platform_device_register(&pmc_core_device);
-	if (ret) {
-		platform_driver_unregister(&pmc_core_driver);
-		return ret;
-	}
-
-	return 0;
-}
-
-static void __exit pmc_core_exit(void)
-{
-	platform_device_unregister(&pmc_core_device);
-	platform_driver_unregister(&pmc_core_driver);
-}
-
-module_init(pmc_core_init)
-module_exit(pmc_core_exit)
+module_platform_driver(pmc_core_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Intel PMC Core Driver");
diff --git a/drivers/platform/x86/intel_pmc_core_plat_drv.c b/drivers/platform/x86/intel_pmc_core_plat_drv.c
new file mode 100644
index 000000000000..20be3eaeb722
--- /dev/null
+++ b/drivers/platform/x86/intel_pmc_core_plat_drv.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Intel PMC Core platform init
+ * Copyright (c) 2019, Google Inc.
+ * Author - Rajat Jain
+ *
+ * This code instantiates platform devices for intel_pmc_core driver, only
+ * on supported platforms that may not have the ACPI devices in the ACPI tables.
+ * No new platforms should be added here, because we expect that new platforms
+ * should all have the ACPI device, which is the preferred way of enumeration.
+ */
+
+#include <linux/acpi.h>
+#include <linux/platform_device.h>
+
+#include <asm/cpu_device_id.h>
+#include <asm/intel-family.h>
+
+static struct platform_device pmc_core_device = {
+	.name = "intel_pmc_core",
+};
+
+/*
+ * intel_pmc_core_platform_ids is the list of platforms where we want to
+ * instantiate the platform_device if not already instantiated. This is
+ * different than intel_pmc_core_ids in intel_pmc_core.c which is the
+ * list of platforms that the driver supports for pmc_core device. The
+ * other list may grow, but this list should not.
+ */
+static const struct x86_cpu_id intel_pmc_core_platform_ids[] = {
+	INTEL_CPU_FAM6(SKYLAKE_MOBILE, pmc_core_device),
+	INTEL_CPU_FAM6(SKYLAKE_DESKTOP, pmc_core_device),
+	INTEL_CPU_FAM6(KABYLAKE_MOBILE, pmc_core_device),
+	INTEL_CPU_FAM6(KABYLAKE_DESKTOP, pmc_core_device),
+	INTEL_CPU_FAM6(CANNONLAKE_MOBILE, pmc_core_device),
+	INTEL_CPU_FAM6(ICELAKE_MOBILE, pmc_core_device),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, intel_pmc_core_platform_ids);
+
+static int __init pmc_core_platform_init(void)
+{
+	/* Skip creating the platform device if ACPI already has a device */
+	if (acpi_dev_present("INT33A1", NULL, -1))
+		return -ENODEV;
+
+	if (!x86_match_cpu(intel_pmc_core_platform_ids))
+		return -ENODEV;
+
+	return platform_device_register(&pmc_core_device);
+}
+
+static void __exit pmc_core_platform_exit(void)
+{
+	platform_device_unregister(&pmc_core_device);
+}
+
+module_init(pmc_core_platform_init);
+module_exit(pmc_core_platform_exit);
-- 
2.21.0.392.gf8f6787159e-goog

