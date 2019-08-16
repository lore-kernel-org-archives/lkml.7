Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD11C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 02:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E6B0206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 02:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfHPCdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 22:33:22 -0400
Received: from mga09.intel.com ([134.134.136.24]:24701 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbfHPCdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 22:33:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 19:33:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,391,1559545200"; 
   d="scan'208";a="194894538"
Received: from genxtest-ykzhao.sh.intel.com ([10.239.143.71])
  by fmsmga001.fm.intel.com with ESMTP; 15 Aug 2019 19:33:17 -0700
From:   Zhao Yakui <yakui.zhao@intel.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Cc:     Zhao Yakui <yakui.zhao@intel.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Mingqiang Chi <mingqiang.chi@intel.com>,
        Liu Shuo <shuo.a.liu@intel.com>
Subject: [RFC PATCH 12/15] drivers/acrn: add driver-specific IRQ handle to dispatch IO_REQ request
Date:   Fri, 16 Aug 2019 10:25:53 +0800
Message-Id: <1565922356-4488-13-git-send-email-yakui.zhao@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565922356-4488-1-git-send-email-yakui.zhao@intel.com>
References: <1565922356-4488-1-git-send-email-yakui.zhao@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After ACRN hypervisor captures the io_request(mmio, IO, PCI access) from
guest OS, it will send the IRQ interrupt to SOS system.
The HYPERVISOR_CALLBACK_VECTOR ISR handler will be executed and it
needs to call the driver-specific ISR handler to dispatch emulated
io_request.
After the emulation of ioreq request is finished, the ACRN hypervisor
is notified and then can resume the execution of guest OS.

Co-developed-by: Jason Chen CJ <jason.cj.chen@intel.com>
Signed-off-by: Jason Chen CJ <jason.cj.chen@intel.com>
Co-developed-by: Mingqiang Chi <mingqiang.chi@intel.com>
Signed-off-by: Mingqiang Chi <mingqiang.chi@intel.com>
Co-developed-by: Liu Shuo <shuo.a.liu@intel.com>
Signed-off-by: Liu Shuo <shuo.a.liu@intel.com>
Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
 drivers/staging/acrn/acrn_dev.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/staging/acrn/acrn_dev.c b/drivers/staging/acrn/acrn_dev.c
index 28258fb..93f45e3 100644
--- a/drivers/staging/acrn/acrn_dev.c
+++ b/drivers/staging/acrn/acrn_dev.c
@@ -18,6 +18,7 @@
 #include <linux/kdev_t.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/mm.h>
 #include <linux/module.h>
@@ -41,6 +42,7 @@ static int	acrn_hsm_inited;
 static int	major;
 static struct class	*acrn_class;
 static struct device	*acrn_device;
+static struct tasklet_struct acrn_io_req_tasklet;
 
 static
 int acrn_dev_open(struct inode *inodep, struct file *filep)
@@ -416,6 +418,16 @@ long acrn_dev_ioctl(struct file *filep,
 		break;
 	}
 	case IC_CLEAR_VM_IOREQ: {
+		/*
+		 * we need to flush the current pending ioreq dispatch
+		 * tasklet and finish it before clearing all ioreq of this VM.
+		 * With tasklet_kill, there still be a very rare race which
+		 * might lost one ioreq tasklet for other VMs. So arm one after
+		 * the clearing. It's harmless.
+		 */
+		tasklet_schedule(&acrn_io_req_tasklet);
+		tasklet_kill(&acrn_io_req_tasklet);
+		tasklet_schedule(&acrn_io_req_tasklet);
 		acrn_ioreq_clear_request(vm);
 		break;
 	}
@@ -449,6 +461,28 @@ static int acrn_dev_release(struct inode *inodep, struct file *filep)
 	return 0;
 }
 
+static void io_req_tasklet(unsigned long data)
+{
+	struct acrn_vm *vm;
+	/* This is already in tasklet. Use read_lock for list_lock */
+
+	read_lock(&acrn_vm_list_lock);
+	list_for_each_entry(vm, &acrn_vm_list, list) {
+		if (!vm || !vm->req_buf)
+			break;
+
+		get_vm(vm);
+		acrn_ioreq_distribute_request(vm);
+		put_vm(vm);
+	}
+	read_unlock(&acrn_vm_list_lock);
+}
+
+static void acrn_intr_handler(void)
+{
+	tasklet_schedule(&acrn_io_req_tasklet);
+}
+
 static const struct file_operations fops = {
 	.open = acrn_dev_open,
 	.release = acrn_dev_release,
@@ -462,6 +496,7 @@ static const struct file_operations fops = {
 
 static int __init acrn_init(void)
 {
+	unsigned long flag;
 	struct api_version *api_version;
 	acrn_hsm_inited = 0;
 	if (x86_hyper_type != X86_HYPER_ACRN)
@@ -518,6 +553,10 @@ static int __init acrn_init(void)
 		return PTR_ERR(acrn_device);
 	}
 
+	tasklet_init(&acrn_io_req_tasklet, io_req_tasklet, 0);
+	local_irq_save(flag);
+	acrn_setup_intr_irq(acrn_intr_handler);
+	local_irq_restore(flag);
 	acrn_ioreq_driver_init();
 	pr_info("acrn: ACRN Hypervisor service module initialized\n");
 	acrn_hsm_inited = 1;
@@ -529,6 +568,8 @@ static void __exit acrn_exit(void)
 	if (!acrn_hsm_inited)
 		return;
 
+	tasklet_kill(&acrn_io_req_tasklet);
+	acrn_remove_intr_irq();
 	device_destroy(acrn_class, MKDEV(major, 0));
 	class_unregister(acrn_class);
 	class_destroy(acrn_class);
-- 
2.7.4

