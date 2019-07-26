Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA36C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 23:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A8922BE8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 23:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbfGZXRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 19:17:48 -0400
Received: from linux.microsoft.com ([13.77.154.182]:44592 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfGZXRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 19:17:44 -0400
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id EA8D1202DEE6;
        Fri, 26 Jul 2019 16:17:42 -0700 (PDT)
From:   Nuno Das Neves <nudasnev@microsoft.com>
To:     nudasnev@microsoft.com, gregkh@linuxfoundation.org,
        sthemmin@microsoft.com, Alexander.Levin@microsoft.com,
        haiyangz@microsoft.com, kys@microsoft.com, mikelley@microsoft.com
Cc:     linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] sys-hypervisor: version information for Hyper-V
Date:   Fri, 26 Jul 2019 16:17:26 -0700
Message-Id: <1564183046-128211-3-git-send-email-nudasnev@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1564183046-128211-1-git-send-email-nudasnev@microsoft.com>
References: <1564183046-128211-1-git-send-email-nudasnev@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the /sys/hypervisor/version directory, which contains
files with version information about the underlying Windows hypervisor, namely:
major, minor, build_number, service_number, service_pack, service_branch

Signed-off-by: Nuno Das Neves <nudasnev@microsoft.com>
---
 .../ABI/stable/sysfs-hypervisor-hyperv        |  54 ++++++++++
 drivers/hv/sys-hypervisor.c                   | 102 ++++++++++++++++++
 2 files changed, 156 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-hypervisor-hyperv b/Documentation/ABI/stable/sysfs-hypervisor-hyperv
index 58380ea81315..9bb50e37b083 100644
--- a/Documentation/ABI/stable/sysfs-hypervisor-hyperv
+++ b/Documentation/ABI/stable/sysfs-hypervisor-hyperv
@@ -5,3 +5,57 @@ Contact:	linux-hyperv@vger.kernel.org
 Description:	If running under Hyper-V:
 		Type of hypervisor:
 		"Hyper-V": Hyper-V hypervisor
+
+What:		/sys/hypervisor/version/major
+Date:		July 2019
+KernelVersion:	5.2.1
+Contact:	linux-hyperv@vger.kernel.org
+Description:	If running under Hyper-V:
+		The Hyper-V version is in the format:
+		<major>.<minor>.<build_number>.<service_number>-<service_pack>-<service_branch>
+		This is the <major> part of it.
+
+What:		/sys/hypervisor/version/minor
+Date:		July 2019
+KernelVersion:	5.2.1
+Contact:	linux-hyperv@vger.kernel.org
+Description:	If running under Hyper-V:
+		The Hyper-V version is in the format:
+		<major>.<minor>.<build_number>.<service_number>-<service_pack>-<service_branch>
+		This is the <minor> part of it.
+
+What:		/sys/hypervisor/version/build_number
+Date:		July 2019
+KernelVersion:	5.2.1
+Contact:	linux-hyperv@vger.kernel.org
+Description:	If running under Hyper-V:
+		The Hyper-V version is in the format:
+		<major>.<minor>.<build_number>.<service_number>-<service_pack>-<service_branch>
+		This is the <build_number> part of it.
+
+What:		/sys/hypervisor/version/service_number
+Date:		July 2019
+KernelVersion:	5.2.1
+Contact:	linux-hyperv@vger.kernel.org
+Description:	If running under Hyper-V:
+		The Hyper-V version is in the format:
+		<major>.<minor>.<build_number>.<service_number>-<service_pack>-<service_branch>
+		This is the <service_number> part of it.
+
+What:		/sys/hypervisor/version/service_pack
+Date:		July 2019
+KernelVersion:	5.2.1
+Contact:	linux-hyperv@vger.kernel.org
+Description:	If running under Hyper-V:
+		The Hyper-V version is in the format:
+		<major>.<minor>.<build_number>.<service_number>-<service_pack>-<service_branch>
+		This is the <service_pack> part of it.
+
+What:		/sys/hypervisor/version/service_branch
+Date:		July 2019
+KernelVersion:	5.2.1
+Contact:	linux-hyperv@vger.kernel.org
+Description:	If running under Hyper-V:
+		The Hyper-V version is in the format:
+		<major>.<minor>.<build_number>.<service_number>-<service_pack>-<service_branch>
+		This is the <service_branch> part of it.
diff --git a/drivers/hv/sys-hypervisor.c b/drivers/hv/sys-hypervisor.c
index eb3d2a6502c4..d157636c2db9 100644
--- a/drivers/hv/sys-hypervisor.c
+++ b/drivers/hv/sys-hypervisor.c
@@ -10,7 +10,9 @@
 #include <linux/init.h>
 #include <linux/kobject.h>
 #include <linux/err.h>
+#include <linux/processor.h>
 
+#include <asm/hyperv-tlfs.h>
 #include <asm/hypervisor.h>
 
 static ssize_t type_show(struct kobject *obj,
@@ -27,6 +29,95 @@ static int __init hyperv_sysfs_type_init(void)
 	return sysfs_create_file(hypervisor_kobj, &type_attr.attr);
 }
 
+/* version info */
+
+static ssize_t major_show(struct kobject *obj,
+			struct kobj_attribute *attr,
+			char *buf)
+{
+	unsigned int hv_host_info_ebx = cpuid_ebx(HYPERV_CPUID_VERSION);
+
+	return sprintf(buf, "%u\n", hv_host_info_ebx >> 16);
+}
+
+static struct kobj_attribute major_attr = __ATTR_RO(major);
+
+static ssize_t minor_show(struct kobject *obj,
+			struct kobj_attribute *attr,
+			char *buf)
+{
+	unsigned int hv_host_info_ebx = cpuid_ebx(HYPERV_CPUID_VERSION);
+
+	return sprintf(buf, "%u\n", hv_host_info_ebx & 0xFFFF);
+}
+
+static struct kobj_attribute minor_attr = __ATTR_RO(minor);
+
+static ssize_t build_number_show(struct kobject *obj,
+			struct kobj_attribute *attr,
+			char *buf)
+{
+	unsigned int hv_host_info_eax = cpuid_eax(HYPERV_CPUID_VERSION);
+
+	return sprintf(buf, "%u\n", hv_host_info_eax);
+}
+
+static struct kobj_attribute build_number_attr = __ATTR_RO(build_number);
+
+static ssize_t service_number_show(struct kobject *obj,
+			struct kobj_attribute *attr,
+			char *buf)
+{
+	unsigned int hv_host_info_edx = cpuid_edx(HYPERV_CPUID_VERSION);
+
+	return sprintf(buf, "%u\n", hv_host_info_edx & 0xFFFFFF);
+}
+
+static struct kobj_attribute service_number_attr = __ATTR_RO(service_number);
+
+static ssize_t service_pack_show(struct kobject *obj,
+			struct kobj_attribute *attr,
+			char *buf)
+{
+	unsigned int hv_host_info_ecx = cpuid_ecx(HYPERV_CPUID_VERSION);
+
+	return sprintf(buf, "%u\n", hv_host_info_ecx);
+}
+
+static struct kobj_attribute service_pack_attr = __ATTR_RO(service_pack);
+
+static ssize_t service_branch_show(struct kobject *obj,
+			struct kobj_attribute *attr,
+			char *buf)
+{
+	unsigned int hv_host_info_edx = cpuid_edx(HYPERV_CPUID_VERSION);
+
+	return sprintf(buf, "%u\n", hv_host_info_edx >> 24);
+}
+
+static struct kobj_attribute service_branch_attr = __ATTR_RO(service_branch);
+
+static struct attribute *version_attrs[] = {
+	&major_attr.attr,
+	&minor_attr.attr,
+	&build_number_attr.attr,
+	&service_number_attr.attr,
+	&service_pack_attr.attr,
+	&service_branch_attr.attr,
+	NULL
+};
+
+static const struct attribute_group version_group = {
+	.name = "version",
+	.attrs = version_attrs,
+};
+
+static int __init hyperv_sysfs_version_init(void)
+{
+	return sysfs_create_group(hypervisor_kobj, &version_group);
+}
+
+
 static int __init hyper_sysfs_init(void)
 {
 	int ret;
@@ -35,7 +126,18 @@ static int __init hyper_sysfs_init(void)
 		return -ENODEV;
 
 	ret = hyperv_sysfs_type_init();
+	if (ret)
+		goto out;
+
+	ret = hyperv_sysfs_version_init();
+	if (ret)
+		goto version_out;
+
+	goto out;
 
+version_out:
+	sysfs_remove_file(hypervisor_kobj, &type_attr.attr);
+out:
 	return ret;
 }
 device_initcall(hyper_sysfs_init);
-- 
2.17.1

