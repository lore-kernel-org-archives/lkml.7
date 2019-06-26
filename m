Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCE3C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 22:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 488532177B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 22:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfFZWjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 18:39:35 -0400
Received: from mga11.intel.com ([192.55.52.93]:10648 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbfFZWjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 18:39:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 15:39:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,421,1557212400"; 
   d="scan'208";a="313574975"
Received: from spandruv-mobl.amr.corp.intel.com ([10.251.133.109])
  by orsmga004.jf.intel.com with ESMTP; 26 Jun 2019 15:38:59 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     dvhart@infradead.org, andy@infradead.org,
        andriy.shevchenko@intel.com, corbet@lwn.net
Cc:     rjw@rjwysocki.net, alan@linux.intel.com, lenb@kernel.org,
        prarit@redhat.com, darcari@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 03/10] platform/x86: ISST: Store per CPU information
Date:   Wed, 26 Jun 2019 15:38:44 -0700
Message-Id: <20190626223851.19138-4-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190626223851.19138-1-srinivas.pandruvada@linux.intel.com>
References: <20190626223851.19138-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two per CPU data needs to be stored and cached to avoid repeated
MSR readings for accessing them later:

- Physical to logical CPU conversion
The PUNIT uses a different CPU numbering scheme which is not APIC id based.
So we need to establish relationship between PUNIT CPU number and Linux
logical CPU numbering which is based on APIC id. There is an MSR 0x53
(MSR_THREAD_ID), which gets physical CPU number for the local CPU where it
is read. Also the CPU mask in some messages will inform which CPUs needs
to be online/offline for a TDP level. During TDP switch if user offlined
some CPUs, then the physical CPU mask can't be converted as we can't
read MSR on an offlined CPU to go to a lower TDP level by onlining more
CPUs. So the mapping needs to be established at the boot up time.

- Bus number corresponding to a CPU
A group of CPUs are in a control of a PUNIT. The PUNIT device is exported
as PCI device. To do operation on a PUNIT for a CPU, we need to find out
to which PCI device it is related to. This is done by reading MSR 0x128
(MSR_CPU_BUS_NUMBER).

So during CPU online stages the above MSRs are read and stored. Later
this stored information is used to process IOCTLs request from the user
space.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../intel_speed_select_if/isst_if_common.c    | 114 +++++++++++++++++-
 .../intel_speed_select_if/isst_if_common.h    |   1 +
 2 files changed, 114 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel_speed_select_if/isst_if_common.c b/drivers/platform/x86/intel_speed_select_if/isst_if_common.c
index ab2bb4862dc8..0e16cbf685d0 100644
--- a/drivers/platform/x86/intel_speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel_speed_select_if/isst_if_common.c
@@ -7,14 +7,22 @@
  * Author: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
  */
 
+#include <linux/cpufeature.h>
+#include <linux/cpuhotplug.h>
 #include <linux/fs.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/sched/signal.h>
+#include <linux/slab.h>
 #include <linux/uaccess.h>
 #include <uapi/linux/isst_if.h>
 
 #include "isst_if_common.h"
 
+#define MSR_THREAD_ID_INFO	0x53
+#define MSR_CPU_BUS_NUMBER	0x128
+
 static struct isst_if_cmd_cb punit_callbacks[ISST_IF_DEV_MAX];
 
 static int isst_if_get_platform_info(void __user *argp)
@@ -33,6 +41,99 @@ static int isst_if_get_platform_info(void __user *argp)
 	return 0;
 }
 
+
+struct isst_if_cpu_info {
+	/* For BUS 0 and BUS 1 only, which we need for PUNIT interface */
+	int bus_info[2];
+	int punit_cpu_id;
+};
+
+static struct isst_if_cpu_info *isst_cpu_info;
+
+/**
+ * isst_if_get_pci_dev() - Get the PCI device instance for a CPU
+ * @cpu: Logical CPU number.
+ * @bus_number: The bus number assigned by the hardware.
+ * @dev: The device number assigned by the hardware.
+ * @fn: The function number assigned by the hardware.
+ *
+ * Using cached bus information, find out the PCI device for a bus number,
+ * device and function.
+ *
+ * Return: Return pci_dev pointer or NULL.
+ */
+struct pci_dev *isst_if_get_pci_dev(int cpu, int bus_no, int dev, int fn)
+{
+	int bus_number;
+
+	if (bus_no < 0 || bus_no > 1 || cpu < 0 || cpu >= nr_cpu_ids ||
+	    cpu >= num_possible_cpus())
+		return NULL;
+
+	bus_number = isst_cpu_info[cpu].bus_info[bus_no];
+	if (bus_number < 0)
+		return NULL;
+
+	return pci_get_domain_bus_and_slot(0, bus_number, PCI_DEVFN(dev, fn));
+}
+EXPORT_SYMBOL_GPL(isst_if_get_pci_dev);
+
+static int isst_if_cpu_online(unsigned int cpu)
+{
+	u64 data;
+	int ret;
+
+	ret = rdmsrl_safe(MSR_CPU_BUS_NUMBER, &data);
+	if (ret) {
+		/* This is not a fatal error on MSR mailbox only I/F */
+		isst_cpu_info[cpu].bus_info[0] = -1;
+		isst_cpu_info[cpu].bus_info[1] = -1;
+	} else {
+		isst_cpu_info[cpu].bus_info[0] = data & 0xff;
+		isst_cpu_info[cpu].bus_info[1] = (data >> 8) & 0xff;
+	}
+
+	ret = rdmsrl_safe(MSR_THREAD_ID_INFO, &data);
+	if (ret) {
+		isst_cpu_info[cpu].punit_cpu_id = -1;
+		return ret;
+	}
+	isst_cpu_info[cpu].punit_cpu_id = data;
+
+	return 0;
+}
+
+static int isst_if_online_id;
+
+static int isst_if_cpu_info_init(void)
+{
+	int ret;
+
+	isst_cpu_info = kcalloc(num_possible_cpus(),
+				sizeof(*isst_cpu_info),
+				GFP_KERNEL);
+	if (!isst_cpu_info)
+		return -ENOMEM;
+
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
+				"platform/x86/isst-if:online",
+				isst_if_cpu_online, NULL);
+	if (ret < 0) {
+		kfree(isst_cpu_info);
+		return ret;
+	}
+
+	isst_if_online_id = ret;
+
+	return 0;
+}
+
+static void isst_if_cpu_info_exit(void)
+{
+	cpuhp_remove_state(isst_if_online_id);
+	kfree(isst_cpu_info);
+};
+
 static long isst_if_def_ioctl(struct file *file, unsigned int cmd,
 			      unsigned long arg)
 {
@@ -145,9 +246,18 @@ int isst_if_cdev_register(int device_type, struct isst_if_cmd_cb *cb)
 		return -EAGAIN;
 	}
 	if (!misc_usage_count) {
+		int ret;
+
 		misc_device_ret = misc_register(&isst_if_char_driver);
 		if (misc_device_ret)
 			goto unlock_exit;
+
+		ret = isst_if_cpu_info_init();
+		if (ret) {
+			misc_deregister(&isst_if_char_driver);
+			misc_device_ret = ret;
+			goto unlock_exit;
+		}
 	}
 	memcpy(&punit_callbacks[device_type], cb, sizeof(*cb));
 	punit_callbacks[device_type].registered = 1;
@@ -173,8 +283,10 @@ void isst_if_cdev_unregister(int device_type)
 	mutex_lock(&punit_misc_dev_lock);
 	misc_usage_count--;
 	punit_callbacks[device_type].registered = 0;
-	if (!misc_usage_count && !misc_device_ret)
+	if (!misc_usage_count && !misc_device_ret) {
 		misc_deregister(&isst_if_char_driver);
+		isst_if_cpu_info_exit();
+	}
 	mutex_unlock(&punit_misc_dev_lock);
 }
 EXPORT_SYMBOL_GPL(isst_if_cdev_unregister);
diff --git a/drivers/platform/x86/intel_speed_select_if/isst_if_common.h b/drivers/platform/x86/intel_speed_select_if/isst_if_common.h
index 11f339226fb4..dade77c58b22 100644
--- a/drivers/platform/x86/intel_speed_select_if/isst_if_common.h
+++ b/drivers/platform/x86/intel_speed_select_if/isst_if_common.h
@@ -57,4 +57,5 @@ struct isst_if_cmd_cb {
 /* Internal interface functions */
 int isst_if_cdev_register(int type, struct isst_if_cmd_cb *cb);
 void isst_if_cdev_unregister(int type);
+struct pci_dev *isst_if_get_pci_dev(int cpu, int bus, int dev, int fn);
 #endif
-- 
2.17.2

