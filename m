Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE39AC3A589
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 02:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC7A0206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 02:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfHPCdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 22:33:33 -0400
Received: from mga09.intel.com ([134.134.136.24]:24751 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726757AbfHPCdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 22:33:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 19:33:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,391,1559545200"; 
   d="scan'208";a="194894553"
Received: from genxtest-ykzhao.sh.intel.com ([10.239.143.71])
  by fmsmga001.fm.intel.com with ESMTP; 15 Aug 2019 19:33:22 -0700
From:   Zhao Yakui <yakui.zhao@intel.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Cc:     Zhao Yakui <yakui.zhao@intel.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>
Subject: [RFC PATCH 15/15] drivers/acrn: add the support of offline SOS cpu
Date:   Fri, 16 Aug 2019 10:25:56 +0800
Message-Id: <1565922356-4488-16-git-send-email-yakui.zhao@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565922356-4488-1-git-send-email-yakui.zhao@intel.com>
References: <1565922356-4488-1-git-send-email-yakui.zhao@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ACRN-hypervisor works in partition mode. In such case the guest OS
and domain0 kernel will run in the different CPUs.  In course of booting
domain0 kernel, it can use all the available CPUs,which can accelerate
the booting. But after the booting is finished, it needs to offline the
other CPUs so that they can be allocated to the guest OS.

add sysfs with attr "offline_cpu", use
	echo cpu_id > /sys/class/acrn/acrn_hsm/offline_cpu
to do the hypercall offline/destroy according vcpu.
before doing it, It will offline cpu by using the below cmd:
	echo 0 > /sys/devices/system/cpu/cpuX/online

Currently this is mainly used in user-space device model before
booting other ACRN guest.

Co-developed-by: Jason Chen CJ <jason.cj.chen@intel.com>
Signed-off-by: Jason Chen CJ <jason.cj.chen@intel.com>
Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
 drivers/staging/acrn/acrn_dev.c | 45 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/staging/acrn/acrn_dev.c b/drivers/staging/acrn/acrn_dev.c
index 0602125..6868003 100644
--- a/drivers/staging/acrn/acrn_dev.c
+++ b/drivers/staging/acrn/acrn_dev.c
@@ -588,6 +588,41 @@ static const struct file_operations fops = {
 #define SUPPORT_HV_API_VERSION_MAJOR	1
 #define SUPPORT_HV_API_VERSION_MINOR	0
 
+static ssize_t
+offline_cpu_store(struct device *dev,
+			struct device_attribute *attr,
+			const char *buf, size_t count)
+{
+#ifdef CONFIG_X86
+	u64 cpu, lapicid;
+
+	if (kstrtoull(buf, 0, &cpu) < 0)
+		return -EINVAL;
+
+	if (cpu_possible(cpu)) {
+		lapicid = cpu_data(cpu).apicid;
+		pr_info("acrn: try to offline cpu %lld with lapicid %lld\n",
+				cpu, lapicid);
+		if (hcall_sos_offline_cpu(lapicid) < 0) {
+			pr_err("acrn: failed to offline cpu from Hypervisor!\n");
+			return -EINVAL;
+		}
+	}
+#endif
+	return count;
+}
+
+static DEVICE_ATTR(offline_cpu, 00200, NULL, offline_cpu_store);
+
+static struct attribute *acrn_attrs[] = {
+	&dev_attr_offline_cpu.attr,
+	NULL
+};
+
+static struct attribute_group acrn_attr_group = {
+	.attrs = acrn_attrs,
+};
+
 static int __init acrn_init(void)
 {
 	unsigned long flag;
@@ -647,6 +682,15 @@ static int __init acrn_init(void)
 		return PTR_ERR(acrn_device);
 	}
 
+	if (sysfs_create_group(&acrn_device->kobj, &acrn_attr_group)) {
+		pr_warn("acrn: sysfs create failed\n");
+		device_destroy(acrn_class, MKDEV(major, 0));
+		class_unregister(acrn_class);
+		class_destroy(acrn_class);
+		unregister_chrdev(major, DEVICE_NAME);
+		return -EINVAL;
+	}
+
 	tasklet_init(&acrn_io_req_tasklet, io_req_tasklet, 0);
 	local_irq_save(flag);
 	acrn_setup_intr_irq(acrn_intr_handler);
@@ -664,6 +708,7 @@ static void __exit acrn_exit(void)
 
 	tasklet_kill(&acrn_io_req_tasklet);
 	acrn_remove_intr_irq();
+	sysfs_remove_group(&acrn_device->kobj, &acrn_attr_group);
 	device_destroy(acrn_class, MKDEV(major, 0));
 	class_unregister(acrn_class);
 	class_destroy(acrn_class);
-- 
2.7.4

