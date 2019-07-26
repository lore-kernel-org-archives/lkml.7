Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14C9C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 23:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9106922BEF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 23:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbfGZXRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 19:17:46 -0400
Received: from linux.microsoft.com ([13.77.154.182]:44596 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbfGZXRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 19:17:44 -0400
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id E7576202DEE5;
        Fri, 26 Jul 2019 16:17:42 -0700 (PDT)
From:   Nuno Das Neves <nudasnev@microsoft.com>
To:     nudasnev@microsoft.com, gregkh@linuxfoundation.org,
        sthemmin@microsoft.com, Alexander.Levin@microsoft.com,
        haiyangz@microsoft.com, kys@microsoft.com, mikelley@microsoft.com
Cc:     linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] sys-hypervisor: /sys/hypervisor/type for Hyper-V
Date:   Fri, 26 Jul 2019 16:17:25 -0700
Message-Id: <1564183046-128211-2-git-send-email-nudasnev@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1564183046-128211-1-git-send-email-nudasnev@microsoft.com>
References: <1564183046-128211-1-git-send-email-nudasnev@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Populate /sys/hypervisor with entries for Hyper-V.
This patch adds /sys/hypervisor/type which contains "Hyper-V".

Signed-off-by: Nuno Das Neves <nudasnev@microsoft.com>
---
 .../ABI/stable/sysfs-hypervisor-hyperv        |  7 ++++
 drivers/hv/Kconfig                            | 10 +++++
 drivers/hv/Makefile                           |  7 ++--
 drivers/hv/sys-hypervisor.c                   | 41 +++++++++++++++++++
 4 files changed, 62 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/ABI/stable/sysfs-hypervisor-hyperv
 create mode 100644 drivers/hv/sys-hypervisor.c

diff --git a/Documentation/ABI/stable/sysfs-hypervisor-hyperv b/Documentation/ABI/stable/sysfs-hypervisor-hyperv
new file mode 100644
index 000000000000..58380ea81315
--- /dev/null
+++ b/Documentation/ABI/stable/sysfs-hypervisor-hyperv
@@ -0,0 +1,7 @@
+What:		/sys/hypervisor/type
+Date:		July 2019
+KernelVersion:	5.2.1
+Contact:	linux-hyperv@vger.kernel.org
+Description:	If running under Hyper-V:
+		Type of hypervisor:
+		"Hyper-V": Hyper-V hypervisor
diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 1c1a2514d6f3..e693adf0b77f 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -25,4 +25,14 @@ config HYPERV_BALLOON
 	help
 	  Select this option to enable Hyper-V Balloon driver.
 
+config HYPERV_SYS_HYPERVISOR
+	bool "Create Hyper-V entries under /sys/hypervisor"
+	depends on HYPERV && SYSFS
+	select SYS_HYPERVISOR
+	default y
+	help
+	  Create Hyper-V entries under /sys/hypervisor (e.g., type). When running
+	  native or on another hypervisor, /sys/hypervisor may still be
+	  present, but it will have no Hyper-V entries.
+
 endmenu
diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
index a1eec7177c2d..87f569659555 100644
--- a/drivers/hv/Makefile
+++ b/drivers/hv/Makefile
@@ -1,7 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_HYPERV)		+= hv_vmbus.o
-obj-$(CONFIG_HYPERV_UTILS)	+= hv_utils.o
-obj-$(CONFIG_HYPERV_BALLOON)	+= hv_balloon.o
+obj-$(CONFIG_HYPERV)			+= hv_vmbus.o
+obj-$(CONFIG_HYPERV_UTILS)		+= hv_utils.o
+obj-$(CONFIG_HYPERV_BALLOON)		+= hv_balloon.o
+obj-$(CONFIG_HYPERV_SYS_HYPERVISOR)	+= sys-hypervisor.o
 
 CFLAGS_hv_trace.o = -I$(src)
 CFLAGS_hv_balloon.o = -I$(src)
diff --git a/drivers/hv/sys-hypervisor.c b/drivers/hv/sys-hypervisor.c
new file mode 100644
index 000000000000..eb3d2a6502c4
--- /dev/null
+++ b/drivers/hv/sys-hypervisor.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (C) 2019, Microsoft, Inc.
+ *
+ * Authored by: Nuno Das Neves <nudasnev@microsoft.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/kobject.h>
+#include <linux/err.h>
+
+#include <asm/hypervisor.h>
+
+static ssize_t type_show(struct kobject *obj,
+			struct kobj_attribute *attr,
+			char *buf)
+{
+	return sprintf(buf, "Hyper-V\n");
+}
+
+static struct kobj_attribute type_attr = __ATTR_RO(type);
+
+static int __init hyperv_sysfs_type_init(void)
+{
+	return sysfs_create_file(hypervisor_kobj, &type_attr.attr);
+}
+
+static int __init hyper_sysfs_init(void)
+{
+	int ret;
+
+	if (!hypervisor_is_type(X86_HYPER_MS_HYPERV))
+		return -ENODEV;
+
+	ret = hyperv_sysfs_type_init();
+
+	return ret;
+}
+device_initcall(hyper_sysfs_init);
-- 
2.17.1

