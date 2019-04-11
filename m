Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4989DC10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 00:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E6D5217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 00:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l+RfuE2p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfDKAh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 20:37:57 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:43472 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbfDKAhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 20:37:55 -0400
Received: by mail-pf1-f201.google.com with SMTP id i14so3009805pfd.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 17:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oLvu2mT5i1BpEbySl7Fp8s1jOl3qOBFGY/Az2WC0VvQ=;
        b=l+RfuE2psMafhnwq8brXACkbqChBSMMzAXtaDK29pQho4kjn9v5FIm3FBvblZSG23d
         lKcPVA2PNIxyBDbHfShCghdoAH7I8tnV3ev4cFODFGPYW3pUh0FQ507Wg3X2tBhizVXT
         KdaM46XRfvHYR0wVKwkgW0eQPjxXyf1KUbP5LlbyZpcP7GYnus0iOkj9wKdctadWGsuw
         6YgYL1WV3R0xsJbzMbde/eFXC3/1CVa4kzSsfjtaw5EW/MYN+UfQuqnKO8vdg976ojPM
         mPl5oKmcKLila5wMzcwxva6Fh1Qdj8cPmRXcmWB9rwbS7pZPkHVoZzo6L9Ly12F0FRVm
         t70Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oLvu2mT5i1BpEbySl7Fp8s1jOl3qOBFGY/Az2WC0VvQ=;
        b=CmYA0cls+32aTGkw8B6pWAsQec4XMMU6TWo2MLBLOXk32SDxVBLXMu3Njj2YJPVKgl
         7nkNmsb89rB3JhCYLHolMvcUcEyvWuPy0WANO/xYpVNwvMgBmGXGiK67aq3Ds2sBK5Ux
         ASmgDPu5JRj+keiwLx5iU0vqwCmCa4n37UVPvHVfYVGqkF+w0LWPbuGSSKvYJGMqyOnY
         IFQoXNt9AvrK4gdiCcBOQjGFLljVkr46SPEDkjgeZdOl2nnVqZvTbSCr/8Kaa6rwfI4F
         J3AQbsn0KqxlnspzEFSj81fwLf4nfLbmRzBkzy5Rqp+HaOVqTsJWyowNoc++WB+DEExt
         glvA==
X-Gm-Message-State: APjAAAVFnys7S6cgm0fPy/ihogDJ/dnh42ipMIJwyQ8drJLAhPMGrDV7
        nDVUfLwDLP7ekqFAGbxQhtKIoiD/xV9a
X-Google-Smtp-Source: APXvYqyQ8rsdf/VmcDTluedaSx/wBKHduVhQpZemB/a9JmcVcgP1FWFY0dLRkwqH3GNy8nQb5BVvSL6lOgCb
X-Received: by 2002:a17:902:6b8c:: with SMTP id p12mr181045plk.37.1554943074511;
 Wed, 10 Apr 2019 17:37:54 -0700 (PDT)
Date:   Wed, 10 Apr 2019 17:37:38 -0700
In-Reply-To: <20190411003738.55073-1-rajatja@google.com>
Message-Id: <20190411003738.55073-3-rajatja@google.com>
Mime-Version: 1.0
References: <20190313222124.229371-1-rajatja@google.com> <20190411003738.55073-1-rajatja@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v5 3/3] platform/x86: intel_pmc_core: Instantiate pmc_core
 device on legacy platforms
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

Add code to instantiate the pmc_core platform device and thus attach to
the driver, if the ACPI device for the same ("INT33A1") is not present
in a system where it should be. This was discussed here:
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1966991.html

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v5: Remove the gerrit id from commit log
v4: Rename file, remove dummy arg, 1 conditional per if statement,
    simplify init / exit calls..
v3: (first version of *this* patch -to go with rest of v3 patchset)
v2: (does not exist)
v1: (does not exist)

 drivers/platform/x86/Makefile                 |  2 +-
 .../platform/x86/intel_pmc_core_plat_drv.c    | 60 +++++++++++++++++++
 2 files changed, 61 insertions(+), 1 deletion(-)
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
diff --git a/drivers/platform/x86/intel_pmc_core_plat_drv.c b/drivers/platform/x86/intel_pmc_core_plat_drv.c
new file mode 100644
index 000000000000..7f5af5bd7f1f
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
+	.name = "pmc_core",
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

