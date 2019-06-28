Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE0BC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 03:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6370E2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 03:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PwesdFUO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfF1DeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 23:34:21 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:50024 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfF1DeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 23:34:20 -0400
Received: by mail-pl1-f202.google.com with SMTP id 65so2662580plf.16
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 20:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=x2lR1+VKuekhcKFQw7fZ2YlVIcSiByakmpDYjmQbEXk=;
        b=PwesdFUOPQJ9cEAbu+/p4E4ND9Tg0NkVn+IXm60NR2gBNe3l6N93IOlxvzt7OQPRog
         QWNan4NAdLr+Mg3R0RxOmI59h0X2nDusBqEI1nuo+XlN28oaq+X6qLak1j8VgDRL+TCq
         LsTxMNQ5jCw7+IyvxMQFPMGfCsxTxb73z5aVa00YPG9blbRefWSX2E3ntsKstC0BuiMf
         HHnmqTAHGiHvvFP3EkVTkJsVXXIUBpjgdjA24iH4IpKkwJnCK7Gh1m7rfXNCdKMlcp3Z
         XcW2dVDimXOFKQB9w2Xj5e/tgbB6SoTk4rxyWO/Xgw5kxAvY2sLfJiPfUj4aPNNRHP3M
         xjRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=x2lR1+VKuekhcKFQw7fZ2YlVIcSiByakmpDYjmQbEXk=;
        b=nCf3ESMI9J74U4SftR9taWEGC+JGG6RyTOgSrEE5BBSBEXKhpeJbe7uDxeSNWDAhFD
         zh8t1MWBicKGDoT2d6pDkYsysa/SrLfelgUTDUyxIjOhvfEAvCC02R9WGA3MwYLrmnTC
         FBTOI0G9bDNWeE5lAtULeNeesf5nJtUXBSCVRoCH9XaR6PNx/kbDwUxWvCVOYeT98PIe
         c54vmU96xRdmp/MD5xRcbruuUi3kt8buc6EokZJAmJ+C45/Lsw6rdUWcFEqPsIE/qcMh
         hJbm90pr84adtpMybbX3JWTpv7fFUqy0TsyduMUO/rtJXDX3qaUMjShOvb2Mo1HWsT4E
         UEug==
X-Gm-Message-State: APjAAAVPeIM//7k2rtIS7ksqaFacY6ScGgcDmtonOr6X2oyw0fdbnigd
        AQ14Jw+mf9dxvK4y0+WG+YR5mun1v+zr
X-Google-Smtp-Source: APXvYqx6mDDUGTy9zOUnSsVtOhvKVEtagJvSOHG0t7Ri895e3PGP2h3+HTw7XHUmV26/K3XLxtEhCdHVYpgi
X-Received: by 2002:a63:610e:: with SMTP id v14mr7097001pgb.221.1561692859737;
 Thu, 27 Jun 2019 20:34:19 -0700 (PDT)
Date:   Thu, 27 Jun 2019 20:34:13 -0700
In-Reply-To: <CAHp75Ver=TNKxh8rdJs1xQYSLNsRLfEoFtcGG6hViug=cF6s_g@mail.gmail.com>
Message-Id: <20190628033413.8058-1-rajatja@google.com>
Mime-Version: 1.0
References: <CAHp75Ver=TNKxh8rdJs1xQYSLNsRLfEoFtcGG6hViug=cF6s_g@mail.gmail.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v7] platform/x86: intel_pmc_core: Attach using APCI HID "INT33A1"
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
v7: Include module.h and add MODULE_LICENSE()
v6: was here: https://patchwork.kernel.org/patch/10906387/
    (The patchset was accepted, but this particular patch was later
     dropped becasue it created some warnings in certain kernel
     configurations: https://www.spinics.net/lists/linux-next/msg47611.html)

 drivers/platform/x86/Makefile                 |  2 +-
 drivers/platform/x86/intel_pmc_core.c         | 40 +++---------
 .../platform/x86/intel_pmc_core_plat_drv.c    | 62 +++++++++++++++++++
 3 files changed, 71 insertions(+), 33 deletions(-)
 create mode 100644 drivers/platform/x86/intel_pmc_core_plat_drv.c

diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 87b0069bd781..4ba707111c27 100644
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
index 000000000000..a8754a6db1b8
--- /dev/null
+++ b/drivers/platform/x86/intel_pmc_core_plat_drv.c
@@ -0,0 +1,62 @@
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
+#include <linux/module.h>
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
+MODULE_LICENSE("GPL v2");
-- 
2.22.0.410.gd8fdbe21b5-goog

