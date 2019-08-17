Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7BFC3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 06:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C1220880
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 06:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfHQGfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 02:35:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46911 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfHQGfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 02:35:10 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hysIu-0006v1-4l; Sat, 17 Aug 2019 06:35:08 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     joro@8bytes.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v2] iommu/amd: Override wrong IVRS IOAPIC on Raven Ridge systems
Date:   Sat, 17 Aug 2019 14:35:02 +0800
Message-Id: <20190817063502.27311-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190808101707.16783-1-kai.heng.feng@canonical.com>
References: <20190808101707.16783-1-kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Raven Ridge systems may have malfunction touchpad or hang at boot if
incorrect IVRS IOAPIC is provided by BIOS.

Users already found correct "ivrs_ioapic=" values, let's put them inside
kernel to workaround buggy BIOS.

BugLink: https://bugs.launchpad.net/bugs/1795292
BugLink: https://bugs.launchpad.net/bugs/1837688
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
Split the quirk to another file.

 drivers/iommu/Makefile           |  2 +-
 drivers/iommu/amd_iommu.h        | 14 +++++
 drivers/iommu/amd_iommu_init.c   |  5 +-
 drivers/iommu/amd_iommu_quirks.c | 90 ++++++++++++++++++++++++++++++++
 4 files changed, 109 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iommu/amd_iommu.h
 create mode 100644 drivers/iommu/amd_iommu_quirks.c

diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index f13f36ae1af6..c6a277e69848 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -10,7 +10,7 @@ obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
 obj-$(CONFIG_IOMMU_IOVA) += iova.o
 obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
 obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
-obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o
+obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o amd_iommu_quirks.o
 obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += amd_iommu_debugfs.o
 obj-$(CONFIG_AMD_IOMMU_V2) += amd_iommu_v2.o
 obj-$(CONFIG_ARM_SMMU) += arm-smmu.o
diff --git a/drivers/iommu/amd_iommu.h b/drivers/iommu/amd_iommu.h
new file mode 100644
index 000000000000..12d540d9b59b
--- /dev/null
+++ b/drivers/iommu/amd_iommu.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef AMD_IOMMU_H
+#define AMD_IOMMU_H
+
+int __init add_special_device(u8 type, u8 id, u16 *devid, bool cmd_line);
+
+#ifdef CONFIG_DMI
+void amd_iommu_apply_ivrs_quirks(void);
+#else
+static void amd_iommu_apply_ivrs_quirks(void) { }
+#endif
+
+#endif
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 4413aa67000e..568c52317757 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -32,6 +32,7 @@
 #include <asm/irq_remapping.h>
 
 #include <linux/crash_dump.h>
+#include "amd_iommu.h"
 #include "amd_iommu_proto.h"
 #include "amd_iommu_types.h"
 #include "irq_remapping.h"
@@ -1002,7 +1003,7 @@ static void __init set_dev_entry_from_acpi(struct amd_iommu *iommu,
 	set_iommu_for_device(iommu, devid);
 }
 
-static int __init add_special_device(u8 type, u8 id, u16 *devid, bool cmd_line)
+int __init add_special_device(u8 type, u8 id, u16 *devid, bool cmd_line)
 {
 	struct devid_map *entry;
 	struct list_head *list;
@@ -1153,6 +1154,8 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 	if (ret)
 		return ret;
 
+	amd_iommu_apply_ivrs_quirks();
+
 	/*
 	 * First save the recommended feature enable bits from ACPI
 	 */
diff --git a/drivers/iommu/amd_iommu_quirks.c b/drivers/iommu/amd_iommu_quirks.c
new file mode 100644
index 000000000000..14181f0f5c2a
--- /dev/null
+++ b/drivers/iommu/amd_iommu_quirks.c
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+/*
+ * Quirks for AMD IOMMU
+ *
+ * Copyright (C) 2019 Kai-Heng Feng <kai.heng.feng@canonical.com>
+ */
+
+#include <linux/dmi.h>
+
+#include "amd_iommu.h"
+
+#define IVHD_SPECIAL_IOAPIC		1
+
+struct ivrs_quirk_entry {
+	u8 id;
+	u16 devid;
+};
+
+enum {
+	DELL_INSPIRON_7375 = 0,
+	DELL_LATITUDE_5495,
+	LENOVO_IDEAPAD_330S_15ARR,
+};
+
+static const struct ivrs_quirk_entry ivrs_ioapic_quirks[][3] __initconst = {
+	/* ivrs_ioapic[4]=00:14.0 ivrs_ioapic[5]=00:00.2 */
+	[DELL_INSPIRON_7375] = {
+		{ .id = 4, .devid = 0xa0 },
+		{ .id = 5, .devid = 0x2 },
+		{}
+	},
+	/* ivrs_ioapic[4]=00:14.0 */
+	[DELL_LATITUDE_5495] = {
+		{ .id = 4, .devid = 0xa0 },
+		{}
+	},
+	/* ivrs_ioapic[32]=00:14.0 */
+	[LENOVO_IDEAPAD_330S_15ARR] = {
+		{ .id = 32, .devid = 0xa0 },
+		{}
+	},
+	{}
+};
+
+static int __init ivrs_ioapic_quirk_cb(const struct dmi_system_id *d)
+{
+	const struct ivrs_quirk_entry *i;
+
+	for (i = d->driver_data; i->id != 0 && i->devid != 0; i++)
+		add_special_device(IVHD_SPECIAL_IOAPIC, i->id, (u16 *)&i->devid, 0);
+
+	return 0;
+}
+
+static const struct dmi_system_id ivrs_quirks[] __initconst = {
+	{
+		.callback = ivrs_ioapic_quirk_cb,
+		.ident = "Dell Inspiron 7375",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 7375"),
+		},
+		.driver_data = (void *)&ivrs_ioapic_quirks[DELL_INSPIRON_7375],
+	},
+	{
+		.callback = ivrs_ioapic_quirk_cb,
+		.ident = "Dell Latitude 5495",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Latitude 5495"),
+		},
+		.driver_data = (void *)&ivrs_ioapic_quirks[DELL_LATITUDE_5495],
+	},
+	{
+		.callback = ivrs_ioapic_quirk_cb,
+		.ident = "Lenovo ideapad 330S-15ARR",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "81FB"),
+		},
+		.driver_data = (void *)&ivrs_ioapic_quirks[LENOVO_IDEAPAD_330S_15ARR],
+	},
+	{}
+};
+
+void __init amd_iommu_apply_ivrs_quirks(void)
+{
+	dmi_check_system(ivrs_quirks);
+}
-- 
2.17.1

