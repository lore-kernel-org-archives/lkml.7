Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC47C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9633B2146F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pHHnS/3q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbfDEUgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 16:36:17 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:40904 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfDEUgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 16:36:14 -0400
Received: by mail-pf1-f201.google.com with SMTP id f7so5178070pfd.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 13:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yWu1RUjcfHwzrSUGeytCPVbvT10jIUq0a7fK+aORuH8=;
        b=pHHnS/3qolS+LTmPIPuK54JaaZYV1CijFMFfIWlQ4cPIIrF8atlQG2EPAu/oxTl+V9
         GBhOtTFzO7TLv+yRQLOVCkrS6xlpeM3IManrPHaROLMEVBvAfMcXHXc8yoY8cn1pHTOF
         5NRx0IkQqhfWkQdEdFrDU0gwjeCYXnHNfGnnfFLa8YbnxnAPLXzSxC9QAOMOQbWAxyl+
         iWJGftcjXPEDR+WMZwKfN0DkcV9HEX9f2FGhHU4ZbR4aayhb1v9E6Am25oJ22KrJ+M1o
         8nThxaUIkLUeyaE3jG/LMfWw6K6+y0V2lb0WFgJDS4UA0PpxQzEyLn4ge8obcscddUoN
         GDXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yWu1RUjcfHwzrSUGeytCPVbvT10jIUq0a7fK+aORuH8=;
        b=uLngKfHMtuDVKRgjJaqmToXPUpdZXmk1nNs9Ok3qSUYH34uG4T/CNzQx+tr6eUOXu3
         Ci8MsHfbL8ipiWl9xeJNUh7xxpu4Y3pZLm4TgBNn2FsuBblO3IeNvCPabfmwcdzHHD01
         pSZyEdyXUhjcFVEmTuunXyOGh1t3nSlU91KZ4kV3xpLj5a/XAEEaNkO/aCRflLCFYc6P
         ssrkamyB9Z4EpfuzVwowcg+SvQPznU4BDK+l5ZuoVcnJw2+KNwKyMn27lraPd/f6nMDQ
         V4uJWdokwWsg76XrZMIhcwpkWFFkj4kbmQoyenb81wEiZLhySYUkY4Gss9vP3yb4e/Cz
         +wFg==
X-Gm-Message-State: APjAAAXbFOoe7eLMv0o+DwjillhArxi6ASbAuAQWtmj6TgvgDrDuw/BO
        4ndK3x8E6i+Qvfg5IHjiLKN5iwYhBRnp
X-Google-Smtp-Source: APXvYqwe19MR+4izfsWOiIwvNcVDwkPcmmFxYGaTf4Y3uUbmho5ugm/2xN3d9OzKlR54VDbG3m00pRC1rxQp
X-Received: by 2002:aa7:8099:: with SMTP id v25mr564414pff.68.1554496573301;
 Fri, 05 Apr 2019 13:36:13 -0700 (PDT)
Date:   Fri,  5 Apr 2019 13:35:58 -0700
In-Reply-To: <20190405203558.19160-1-rajatja@google.com>
Message-Id: <20190405203558.19160-3-rajatja@google.com>
Mime-Version: 1.0
References: <20190313222124.229371-1-rajatja@google.com> <20190405203558.19160-1-rajatja@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v3 3/3] platform/x86: intel_pmc_core: Instantiate pmc_core
 device on legacy platforms
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

Add code to instantiate the pmc_core platform device and thus attach to
the driver, if the ACPI device for the same ("INT33A1") is not present
in a system where it should be. This was discussed here:
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1966991.html

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v3: (first version of *this* patch -to go with rest of v3 patchset)
v2: (does not exist)
v1: (does not exist)

 drivers/platform/x86/Makefile                 |  2 +-
 .../platform/x86/intel_pmc_core_plat_init.c   | 64 +++++++++++++++++++
 2 files changed, 65 insertions(+), 1 deletion(-)
 create mode 100644 drivers/platform/x86/intel_pmc_core_plat_init.c

diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 86cb76677bc8..83d0bb9a14bb 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -89,7 +89,7 @@ obj-$(CONFIG_INTEL_BXTWC_PMIC_TMU)	+= intel_bxtwc_tmu.o
 obj-$(CONFIG_INTEL_TELEMETRY)	+= intel_telemetry_core.o \
 				   intel_telemetry_pltdrv.o \
 				   intel_telemetry_debugfs.o
-obj-$(CONFIG_INTEL_PMC_CORE)    += intel_pmc_core.o
+obj-$(CONFIG_INTEL_PMC_CORE)    += intel_pmc_core.o intel_pmc_core_plat_init.o
 obj-$(CONFIG_PMC_ATOM)		+= pmc_atom.o
 obj-$(CONFIG_MLX_PLATFORM)	+= mlx-platform.o
 obj-$(CONFIG_INTEL_TURBO_MAX_3) += intel_turbo_max_3.o
diff --git a/drivers/platform/x86/intel_pmc_core_plat_init.c b/drivers/platform/x86/intel_pmc_core_plat_init.c
new file mode 100644
index 000000000000..45be89e7586c
--- /dev/null
+++ b/drivers/platform/x86/intel_pmc_core_plat_init.c
@@ -0,0 +1,64 @@
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
+	.name = "pmc_core",
+};
+
+static int dummy;
+/*
+ * INTEL_CPU_FAM6 macro won't take NULL for driver_data (uses &driver_data),
+ * thus provide a dummy driver_data.
+ */
+static const struct x86_cpu_id intel_pmc_core_ids[] = {
+	INTEL_CPU_FAM6(SKYLAKE_MOBILE, dummy),
+	INTEL_CPU_FAM6(SKYLAKE_DESKTOP, dummy),
+	INTEL_CPU_FAM6(KABYLAKE_MOBILE, dummy),
+	INTEL_CPU_FAM6(KABYLAKE_DESKTOP, dummy),
+	INTEL_CPU_FAM6(CANNONLAKE_MOBILE, dummy),
+	INTEL_CPU_FAM6(ICELAKE_MOBILE, dummy),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, intel_pmc_core_ids);
+
+static int __init pmc_core_platform_init(void)
+{
+	int ret;
+
+	/* Skip creating the platform device if ACPI already has a device */
+	if (acpi_dev_present("INT33A1", NULL, -1) ||
+	    !x86_match_cpu(intel_pmc_core_ids))
+		return -ENODEV;
+
+	ret = platform_device_register(&pmc_core_device);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void __exit pmc_core_platform_exit(void)
+{
+	if (!acpi_dev_present("INT33A1", NULL, -1) &&
+	    x86_match_cpu(intel_pmc_core_ids))
+		platform_device_unregister(&pmc_core_device);
+}
+
+module_init(pmc_core_platform_init);
+module_exit(pmc_core_platform_exit);
-- 
2.21.0.392.gf8f6787159e-goog

