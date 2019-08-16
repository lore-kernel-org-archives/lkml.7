Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E9AC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 02:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5712021721
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 02:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfHPCdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 22:33:12 -0400
Received: from mga09.intel.com ([134.134.136.24]:24671 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbfHPCdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 22:33:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Aug 2019 19:33:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,391,1559545200"; 
   d="scan'208";a="194894511"
Received: from genxtest-ykzhao.sh.intel.com ([10.239.143.71])
  by fmsmga001.fm.intel.com with ESMTP; 15 Aug 2019 19:33:09 -0700
From:   Zhao Yakui <yakui.zhao@intel.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Cc:     Zhao Yakui <yakui.zhao@intel.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Liu Shuo <shuo.a.liu@intel.com>
Subject: [RFC PATCH 07/15] drivers/acrn: add acrn vm/vcpu management for ACRN_HSM char device
Date:   Fri, 16 Aug 2019 10:25:48 +0800
Message-Id: <1565922356-4488-8-git-send-email-yakui.zhao@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565922356-4488-1-git-send-email-yakui.zhao@intel.com>
References: <1565922356-4488-1-git-send-email-yakui.zhao@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VM management is one important role of acrn module. It is used to
manage another VM based on the user-space ioctls. It includes the
following VM operation: CREATE/START/PAUSE/DESTROY VM, CREATE_VCPU,
IC_SET_VCPU_REGS.
acrn_ioctl is provided so that the user of /dev/acrn_hsm can manage
the VM for the given guest. After the ioctl is called, the hypercall
is then called so that the ACRN hypervisor can help to manage the
corresponding VM and create the required VCPU.

As ACRN is mainly used for embedded IOT usage, no interface is provided
to destroy the vcpu explicitly. When the VM is destroyed, the low-level
ACRN hypervisor will free the corresponding vcpu implicitly.

Co-developed-by: Jason Chen CJ <jason.cj.chen@intel.com>
Signed-off-by: Jason Chen CJ <jason.cj.chen@intel.com>
Co-developed-by: Liu Shuo <shuo.a.liu@intel.com>
Signed-off-by: Liu Shuo <shuo.a.liu@intel.com>
Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
---
 drivers/staging/acrn/Makefile             |   3 +-
 drivers/staging/acrn/acrn_dev.c           | 169 +++++++++++++++++++++++++++++-
 drivers/staging/acrn/acrn_drv_internal.h  |  74 +++++++++++++
 drivers/staging/acrn/acrn_vm_mngt.c       |  72 +++++++++++++
 include/uapi/linux/acrn/acrn_ioctl_defs.h | 126 ++++++++++++++++++++++
 5 files changed, 442 insertions(+), 2 deletions(-)
 create mode 100644 drivers/staging/acrn/acrn_drv_internal.h
 create mode 100644 drivers/staging/acrn/acrn_vm_mngt.c

diff --git a/drivers/staging/acrn/Makefile b/drivers/staging/acrn/Makefile
index a58b0d1..426d6e8 100644
--- a/drivers/staging/acrn/Makefile
+++ b/drivers/staging/acrn/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_ACRN_HSM)	:= acrn.o
 acrn-y := acrn_dev.o \
-	  acrn_hypercall.o
+	  acrn_hypercall.o \
+	  acrn_vm_mngt.o
diff --git a/drivers/staging/acrn/acrn_dev.c b/drivers/staging/acrn/acrn_dev.c
index 57cd2bb..7372316 100644
--- a/drivers/staging/acrn/acrn_dev.c
+++ b/drivers/staging/acrn/acrn_dev.c
@@ -27,6 +27,7 @@
 #include <linux/acrn/acrn_ioctl_defs.h>
 
 #include "acrn_hypercall.h"
+#include "acrn_drv_internal.h"
 
 #define  DEVICE_NAME "acrn_hsm"
 #define  CLASS_NAME  "acrn"
@@ -42,8 +43,22 @@ static struct device	*acrn_device;
 static
 int acrn_dev_open(struct inode *inodep, struct file *filep)
 {
-	pr_info("%s: opening device node\n", __func__);
+	struct acrn_vm *vm;
+
+	vm = kzalloc(sizeof(*vm), GFP_KERNEL);
+	if (!vm)
+		return -ENOMEM;
+
+	refcount_set(&vm->refcnt, 1);
+	vm->vmid = ACRN_INVALID_VMID;
+	vm->dev = acrn_device;
 
+	write_lock_bh(&acrn_vm_list_lock);
+	vm_list_add(&vm->list);
+	write_unlock_bh(&acrn_vm_list_lock);
+	filep->private_data = vm;
+
+	pr_info("%s: opening device node\n", __func__);
 	return 0;
 }
 
@@ -52,6 +67,15 @@ long acrn_dev_ioctl(struct file *filep,
 		    unsigned int ioctl_num, unsigned long ioctl_param)
 {
 	long ret = 0;
+	struct acrn_vm *vm;
+
+	pr_debug("[%s] ioctl_num=0x%x\n", __func__, ioctl_num);
+
+	vm = (struct acrn_vm *)filep->private_data;
+	if (!vm) {
+		pr_err("acrn: invalid VM !\n");
+		return -EFAULT;
+	}
 
 	if (ioctl_num == IC_GET_API_VERSION) {
 		struct api_version api_version;
@@ -66,11 +90,154 @@ long acrn_dev_ioctl(struct file *filep,
 		return 0;
 	}
 
+	if ((vm->vmid == ACRN_INVALID_VMID) && (ioctl_num != IC_CREATE_VM)) {
+		pr_err("acrn: invalid VM ID for IOCTL %x!\n", ioctl_num);
+		return -EFAULT;
+	}
+
+	switch (ioctl_num) {
+	case IC_CREATE_VM: {
+		struct acrn_create_vm *created_vm;
+
+		created_vm = kmalloc(sizeof(*created_vm), GFP_KERNEL);
+		if (!created_vm)
+			return -ENOMEM;
+
+		if (copy_from_user(created_vm, (void *)ioctl_param,
+				   sizeof(struct acrn_create_vm))) {
+			kfree(created_vm);
+			return -EFAULT;
+		}
+
+		ret = hcall_create_vm(virt_to_phys(created_vm));
+		if ((ret < 0) || (created_vm->vmid == ACRN_INVALID_VMID)) {
+			pr_err("acrn: failed to create VM from Hypervisor !\n");
+			kfree(created_vm);
+			return -EFAULT;
+		}
+
+		if (copy_to_user((void *)ioctl_param, created_vm,
+				 sizeof(struct acrn_create_vm))) {
+			kfree(created_vm);
+			return -EFAULT;
+		}
+
+		vm->vmid = created_vm->vmid;
+		atomic_set(&vm->vcpu_num, 0);
+
+		pr_info("acrn: VM %d created\n", created_vm->vmid);
+		kfree(created_vm);
+		break;
+	}
+
+	case IC_START_VM: {
+		ret = hcall_start_vm(vm->vmid);
+		if (ret < 0) {
+			pr_err("acrn: failed to start VM %d!\n", vm->vmid);
+			return -EFAULT;
+		}
+		break;
+	}
+
+	case IC_PAUSE_VM: {
+		ret = hcall_pause_vm(vm->vmid);
+		if (ret < 0) {
+			pr_err("acrn: failed to pause VM %d!\n", vm->vmid);
+			return -EFAULT;
+		}
+		break;
+	}
+
+	case IC_RESET_VM: {
+		ret = hcall_reset_vm(vm->vmid);
+		if (ret < 0) {
+			pr_err("acrn: failed to restart VM %d!\n", vm->vmid);
+			return -EFAULT;
+		}
+		break;
+	}
+
+	case IC_DESTROY_VM: {
+		ret = acrn_vm_destroy(vm);
+		break;
+	}
+
+	case IC_CREATE_VCPU: {
+		struct acrn_create_vcpu *cv;
+
+		cv = kmalloc(sizeof(*cv), GFP_KERNEL);
+		if (!cv)
+			return -ENOMEM;
+
+		if (copy_from_user(cv, (void *)ioctl_param,
+				   sizeof(struct acrn_create_vcpu))) {
+			kfree(cv);
+			return -EFAULT;
+		}
+
+		ret = hcall_create_vcpu(vm->vmid, virt_to_phys(cv));
+		if (ret < 0) {
+			pr_err("acrn: failed to create vcpu %d!\n",
+			       cv->vcpu_id);
+			kfree(cv);
+			return -EFAULT;
+		}
+		atomic_inc(&vm->vcpu_num);
+		kfree(cv);
+
+		return ret;
+	}
+
+	case IC_SET_VCPU_REGS: {
+		struct acrn_set_vcpu_regs *cpu_regs;
+
+		cpu_regs = kmalloc(sizeof(*cpu_regs), GFP_KERNEL);
+		if (!cpu_regs)
+			return -ENOMEM;
+
+		if (copy_from_user(cpu_regs, (void *)ioctl_param,
+				   sizeof(*cpu_regs))) {
+			kfree(cpu_regs);
+			return -EFAULT;
+		}
+
+		ret = hcall_set_vcpu_regs(vm->vmid, virt_to_phys(cpu_regs));
+		kfree(cpu_regs);
+		if (ret < 0) {
+			pr_err("acrn: failed to set bsp state of vm %d!\n",
+			       vm->vmid);
+			return -EFAULT;
+		}
+
+		return ret;
+	}
+
+	default:
+		pr_warn("Unknown IOCTL 0x%x\n", ioctl_num);
+		ret = -EFAULT;
+		break;
+	}
+
 	return ret;
 }
 
 static int acrn_dev_release(struct inode *inodep, struct file *filep)
 {
+	struct acrn_vm *vm = filep->private_data;
+
+	if (!vm) {
+		pr_err("acrn: invalid VM !\n");
+		return -EFAULT;
+	}
+	if (vm->vmid != ACRN_INVALID_VMID)
+		acrn_vm_destroy(vm);
+
+	write_lock_bh(&acrn_vm_list_lock);
+	list_del_init(&vm->list);
+	write_unlock_bh(&acrn_vm_list_lock);
+
+	put_vm(vm);
+	filep->private_data = NULL;
 	return 0;
 }
 
diff --git a/drivers/staging/acrn/acrn_drv_internal.h b/drivers/staging/acrn/acrn_drv_internal.h
new file mode 100644
index 0000000..6758dea
--- /dev/null
+++ b/drivers/staging/acrn/acrn_drv_internal.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause */
+/*
+ * ACRN_HSM : vm management header file.
+ *
+ */
+
+#ifndef __ACRN_VM_MNGT_H
+#define __ACRN_VM_MNGT_H
+
+#include <linux/types.h>
+#include <linux/list.h>
+#include <linux/refcount.h>
+
+#define ACRN_INVALID_VMID (-1)
+
+enum ACRN_VM_FLAGS {
+	ACRN_VM_DESTROYED = 0,
+};
+
+extern struct list_head acrn_vm_list;
+extern rwlock_t acrn_vm_list_lock;
+
+void vm_list_add(struct list_head *list);
+
+/**
+ * struct acrn_vm - data structure to track guest
+ *
+ * @dev: pointer to dev of linux device mode
+ * @list: list of acrn_vm
+ * @vmid: guest vmid
+ * @refcnt: reference count of guest
+ * @max_gfn: maximum guest page frame number
+ * @vcpu_num: vcpu number
+ * @flags: VM flag bits
+ */
+struct acrn_vm {
+	struct device *dev;
+	struct list_head list;
+	unsigned short vmid;
+	refcount_t refcnt;
+	int max_gfn;
+	atomic_t vcpu_num;
+	unsigned long flags;
+};
+
+int acrn_vm_destroy(struct acrn_vm *vm);
+
+/**
+ * find_get_vm() - find and keep guest acrn_vm based on the vmid
+ *
+ * @vmid: guest vmid
+ *
+ * Return: pointer to acrn_vm, NULL if can't find vm matching vmid
+ */
+struct acrn_vm *find_get_vm(unsigned short vmid);
+
+/**
+ * get_vm() - increase the refcnt of acrn_vm
+ * @vm: pointer to acrn_vm which identify specific guest
+ *
+ * Return:
+ */
+void get_vm(struct acrn_vm *vm);
+
+/**
+ * put_vm() - release acrn_vm of guest according to guest vmid
+ * If the latest reference count drops to zero, free acrn_vm as well
+ * @vm: pointer to acrn_vm which identify specific guest
+ *
+ * Return:
+ */
+void put_vm(struct acrn_vm *vm);
+
+#endif
diff --git a/drivers/staging/acrn/acrn_vm_mngt.c b/drivers/staging/acrn/acrn_vm_mngt.c
new file mode 100644
index 0000000..04c551d
--- /dev/null
+++ b/drivers/staging/acrn/acrn_vm_mngt.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
+/*
+ * ACRN_HSM: vm management
+
+ * Copyright (C) 2019 Intel Corporation. All rights reserved.
+ * Jason Chen CJ <jason.cj.chen@intel.com>
+ * Zhao Yakui <yakui.zhao@intel.com>
+ * Liu Shuo <shuo.a.liu@intel.com>
+ */
+
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/rwlock_types.h>
+
+#include "acrn_hypercall.h"
+#include "acrn_drv_internal.h"
+
+LIST_HEAD(acrn_vm_list);
+DEFINE_RWLOCK(acrn_vm_list_lock);
+
+struct acrn_vm *find_get_vm(unsigned short vmid)
+{
+	struct acrn_vm *vm;
+
+	read_lock_bh(&acrn_vm_list_lock);
+	list_for_each_entry(vm, &acrn_vm_list, list) {
+		if (vm->vmid == vmid) {
+			refcount_inc(&vm->refcnt);
+			read_unlock_bh(&acrn_vm_list_lock);
+			return vm;
+		}
+	}
+	read_unlock_bh(&acrn_vm_list_lock);
+	return NULL;
+}
+
+void get_vm(struct acrn_vm *vm)
+{
+	refcount_inc_checked(&vm->refcnt);
+}
+
+void put_vm(struct acrn_vm *vm)
+{
+	if (refcount_dec_and_test(&vm->refcnt)) {
+		kfree(vm);
+		pr_debug("hsm: freed vm\n");
+	}
+}
+
+void vm_list_add(struct list_head *list)
+{
+	list_add(list, &acrn_vm_list);
+}
+
+int acrn_vm_destroy(struct acrn_vm *vm)
+{
+	int ret;
+
+	if (test_and_set_bit(ACRN_VM_DESTROYED, &vm->flags))
+		return 0;
+
+	ret = hcall_destroy_vm(vm->vmid);
+	if (ret < 0) {
+		pr_warn("failed to destroy VM %d\n", vm->vmid);
+		clear_bit(ACRN_VM_DESTROYED, &vm->flags);
+		return -EFAULT;
+	}
+
+	vm->vmid = ACRN_INVALID_VMID;
+	return 0;
+}
diff --git a/include/uapi/linux/acrn/acrn_ioctl_defs.h b/include/uapi/linux/acrn/acrn_ioctl_defs.h
index 8dbf69a..ebcf812 100644
--- a/include/uapi/linux/acrn/acrn_ioctl_defs.h
+++ b/include/uapi/linux/acrn/acrn_ioctl_defs.h
@@ -19,6 +19,122 @@ struct api_version {
 	uint32_t minor_version;
 };
 
+/**
+ * @brief Info to create a VM, the parameter for HC_CREATE_VM hypercall
+ */
+struct acrn_create_vm {
+	/** created vmid return to ACRN. Keep it first field */
+	uint16_t vmid;
+
+	/** Reserved */
+	uint16_t reserved0;
+
+	/** VCPU numbers this VM want to create */
+	uint16_t vcpu_num;
+
+	/** Reserved */
+	uint16_t reserved1;
+
+	/** the GUID of this VM */
+	uint8_t	 GUID[16];
+
+	/* VM flag bits from Guest OS. */
+	uint64_t vm_flag;
+
+	/** guest physical address of VM request_buffer */
+	uint64_t req_buf;
+
+	/** Reserved for future use*/
+	uint8_t  reserved2[16];
+};
+
+/**
+ * @brief Info to create a VCPU
+ *
+ * the parameter for HC_CREATE_VCPU hypercall
+ */
+struct acrn_create_vcpu {
+	/** the virtual CPU ID for the VCPU created */
+	uint16_t vcpu_id;
+
+	/** the physical CPU ID for the VCPU created */
+	uint16_t pcpu_id;
+
+	/** Reserved for future use*/
+	uint8_t reserved[4];
+} __aligned(8);
+
+struct acrn_gp_regs {
+	uint64_t rax;
+	uint64_t rcx;
+	uint64_t rdx;
+	uint64_t rbx;
+	uint64_t rsp;
+	uint64_t rbp;
+	uint64_t rsi;
+	uint64_t rdi;
+	uint64_t r8;
+	uint64_t r9;
+	uint64_t r10;
+	uint64_t r11;
+	uint64_t r12;
+	uint64_t r13;
+	uint64_t r14;
+	uint64_t r15;
+};
+
+struct acrn_descriptor_ptr {
+	uint16_t limit;
+	uint64_t base;
+	uint16_t reserved[3];
+} __packed;
+
+struct acrn_vcpu_regs {
+	struct acrn_gp_regs gprs;
+	struct acrn_descriptor_ptr gdt;
+	struct acrn_descriptor_ptr idt;
+
+	uint64_t        rip;
+	uint64_t        cs_base;
+	uint64_t        cr0;
+	uint64_t        cr4;
+	uint64_t        cr3;
+	uint64_t        ia32_efer;
+	uint64_t        rflags;
+	uint64_t        reserved_64[4];
+
+	uint32_t        cs_ar;
+	uint32_t        reserved_32[4];
+
+	/* don't change the order of following sel */
+	uint16_t        cs_sel;
+	uint16_t        ss_sel;
+	uint16_t        ds_sel;
+	uint16_t        es_sel;
+	uint16_t        fs_sel;
+	uint16_t        gs_sel;
+	uint16_t        ldt_sel;
+	uint16_t        tr_sel;
+
+	uint16_t        reserved_16[4];
+};
+
+/**
+ * @brief Info to set vcpu state
+ *
+ * the pamameter for HC_SET_VCPU_REGS
+ */
+struct acrn_set_vcpu_regs {
+	/** the virtual CPU ID for the VCPU */
+	uint16_t vcpu_id;
+
+	/** reserved space to make cpu_state aligned to 8 bytes */
+	uint16_t reserved0[3];
+
+	/** the structure to hold vcpu state */
+	struct acrn_vcpu_regs vcpu_regs;
+};
+
 /*
  * Common IOCTL ID definition for DM
  */
@@ -29,4 +145,14 @@ struct api_version {
 #define IC_ID_GEN_BASE                  0x0UL
 #define IC_GET_API_VERSION             _IC_ID(IC_ID, IC_ID_GEN_BASE + 0x00)
 
+/* VM management */
+#define IC_ID_VM_BASE                  0x10UL
+#define IC_CREATE_VM                   _IC_ID(IC_ID, IC_ID_VM_BASE + 0x00)
+#define IC_DESTROY_VM                  _IC_ID(IC_ID, IC_ID_VM_BASE + 0x01)
+#define IC_START_VM                    _IC_ID(IC_ID, IC_ID_VM_BASE + 0x02)
+#define IC_PAUSE_VM                    _IC_ID(IC_ID, IC_ID_VM_BASE + 0x03)
+#define IC_CREATE_VCPU                 _IC_ID(IC_ID, IC_ID_VM_BASE + 0x04)
+#define IC_RESET_VM                    _IC_ID(IC_ID, IC_ID_VM_BASE + 0x05)
+#define IC_SET_VCPU_REGS               _IC_ID(IC_ID, IC_ID_VM_BASE + 0x06)
+
 #endif /* __ACRN_IOCTL_DEFS_H__ */
-- 
2.7.4

