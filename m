Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F55C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 22:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABBC1217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 22:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfFZWjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 18:39:13 -0400
Received: from mga11.intel.com ([192.55.52.93]:10648 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726606AbfFZWjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 18:39:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 15:39:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,421,1557212400"; 
   d="scan'208";a="313575009"
Received: from spandruv-mobl.amr.corp.intel.com ([10.251.133.109])
  by orsmga004.jf.intel.com with ESMTP; 26 Jun 2019 15:39:03 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     dvhart@infradead.org, andy@infradead.org,
        andriy.shevchenko@intel.com, corbet@lwn.net
Cc:     rjw@rjwysocki.net, alan@linux.intel.com, lenb@kernel.org,
        prarit@redhat.com, darcari@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 07/10] platform/x86: ISST: Add Intel Speed Select mailbox interface via MSRs
Date:   Wed, 26 Jun 2019 15:38:48 -0700
Message-Id: <20190626223851.19138-8-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190626223851.19138-1-srinivas.pandruvada@linux.intel.com>
References: <20190626223851.19138-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an IOCTL to send mailbox commands to PUNIT using PUNIT MSRs for
mailbox. Some CPU models don't have PCI device, so need to use MSRs.
A limited set of mailbox commands can be sent to PUNIT.

This MMIO interface is used by the intel-speed-select tool under
tools/x86/power to enumerate and control Intel Speed Select features.
The MBOX commands ids and semantics of the message can be checked from
the source code of the tool.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../x86/intel_speed_select_if/Makefile        |   1 +
 .../intel_speed_select_if/isst_if_mbox_msr.c  | 180 ++++++++++++++++++
 2 files changed, 181 insertions(+)
 create mode 100644 drivers/platform/x86/intel_speed_select_if/isst_if_mbox_msr.c

diff --git a/drivers/platform/x86/intel_speed_select_if/Makefile b/drivers/platform/x86/intel_speed_select_if/Makefile
index 8dec8c858649..856076206f35 100644
--- a/drivers/platform/x86/intel_speed_select_if/Makefile
+++ b/drivers/platform/x86/intel_speed_select_if/Makefile
@@ -7,3 +7,4 @@
 obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE) += isst_if_common.o
 obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE) += isst_if_mmio.o
 obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE) += isst_if_mbox_pci.o
+obj-$(CONFIG_INTEL_SPEED_SELECT_INTERFACE) += isst_if_mbox_msr.o
diff --git a/drivers/platform/x86/intel_speed_select_if/isst_if_mbox_msr.c b/drivers/platform/x86/intel_speed_select_if/isst_if_mbox_msr.c
new file mode 100644
index 000000000000..a949ec436c73
--- /dev/null
+++ b/drivers/platform/x86/intel_speed_select_if/isst_if_mbox_msr.c
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Intel Speed Select Interface: Mbox via MSR Interface
+ * Copyright (c) 2019, Intel Corporation.
+ * All rights reserved.
+ *
+ * Author: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
+ */
+
+#include <linux/module.h>
+#include <linux/cpuhotplug.h>
+#include <linux/pci.h>
+#include <linux/sched/signal.h>
+#include <linux/slab.h>
+#include <linux/topology.h>
+#include <linux/uaccess.h>
+#include <uapi/linux/isst_if.h>
+#include <asm/cpu_device_id.h>
+#include <asm/intel-family.h>
+
+#include "isst_if_common.h"
+
+#define MSR_OS_MAILBOX_INTERFACE	0xB0
+#define MSR_OS_MAILBOX_DATA		0xB1
+#define MSR_OS_MAILBOX_BUSY_BIT		31
+
+/*
+ * Based on experiments count is never more than 1, as the MSR overhead
+ * is enough to finish the command. So here this is the worst case number.
+ */
+#define OS_MAILBOX_RETRY_COUNT		3
+
+static int isst_if_send_mbox_cmd(u8 command, u8 sub_command, u32 parameter,
+				 u32 command_data, u32 *response_data)
+{
+	u32 retries;
+	u64 data;
+	int ret;
+
+	/* Poll for rb bit == 0 */
+	retries = OS_MAILBOX_RETRY_COUNT;
+	do {
+		rdmsrl(MSR_OS_MAILBOX_INTERFACE, data);
+		if (data & BIT_ULL(MSR_OS_MAILBOX_BUSY_BIT)) {
+			ret = -EBUSY;
+			continue;
+		}
+		ret = 0;
+		break;
+	} while (--retries);
+
+	if (ret)
+		return ret;
+
+	/* Write DATA register */
+	wrmsrl(MSR_OS_MAILBOX_DATA, command_data);
+
+	/* Write command register */
+	data = BIT_ULL(MSR_OS_MAILBOX_BUSY_BIT) |
+		      (parameter & GENMASK_ULL(13, 0)) << 16 |
+		      (sub_command << 8) |
+		      command;
+	wrmsrl(MSR_OS_MAILBOX_INTERFACE, data);
+
+	/* Poll for rb bit == 0 */
+	retries = OS_MAILBOX_RETRY_COUNT;
+	do {
+		rdmsrl(MSR_OS_MAILBOX_INTERFACE, data);
+		if (data & BIT_ULL(MSR_OS_MAILBOX_BUSY_BIT)) {
+			ret = -EBUSY;
+			continue;
+		}
+
+		if (data & 0xff)
+			return -ENXIO;
+
+		if (response_data) {
+			rdmsrl(MSR_OS_MAILBOX_DATA, data);
+			*response_data = data;
+		}
+		ret = 0;
+		break;
+	} while (--retries);
+
+	return ret;
+}
+
+struct msrl_action {
+	int err;
+	struct isst_if_mbox_cmd *mbox_cmd;
+};
+
+/* revisit, smp_call_function_single should be enough for atomic mailbox! */
+static void msrl_update_func(void *info)
+{
+	struct msrl_action *act = info;
+
+	act->err = isst_if_send_mbox_cmd(act->mbox_cmd->command,
+					 act->mbox_cmd->sub_command,
+					 act->mbox_cmd->parameter,
+					 act->mbox_cmd->req_data,
+					 &act->mbox_cmd->resp_data);
+}
+
+static long isst_if_mbox_proc_cmd(u8 *cmd_ptr, int *write_only, int resume)
+{
+	struct msrl_action action;
+	int ret;
+
+	action.mbox_cmd = (struct isst_if_mbox_cmd *)cmd_ptr;
+
+	if (isst_if_mbox_cmd_invalid(action.mbox_cmd))
+		return -EINVAL;
+
+	if (isst_if_mbox_cmd_set_req(action.mbox_cmd) &&
+	    !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	/*
+	 * To complete mailbox command, we need to access two MSRs.
+	 * So we don't want race to complete a mailbox transcation.
+	 * Here smp_call ensures that msrl_update_func() has no race
+	 * and also with wait flag, wait for completion.
+	 * smp_call_function_single is using get_cpu() and put_cpu().
+	 */
+	ret = smp_call_function_single(action.mbox_cmd->logical_cpu,
+				       msrl_update_func, &action, 1);
+	if (ret)
+		return ret;
+
+	*write_only = 0;
+
+	return action.err;
+}
+
+#define ICPU(model)     { X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, }
+
+static const struct x86_cpu_id isst_if_cpu_ids[] = {
+	ICPU(INTEL_FAM6_SKYLAKE_X),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, isst_if_cpu_ids);
+
+static int __init isst_if_mbox_init(void)
+{
+	struct isst_if_cmd_cb cb;
+	const struct x86_cpu_id *id;
+	u64 data;
+	int ret;
+
+	id = x86_match_cpu(isst_if_cpu_ids);
+	if (!id)
+		return -ENODEV;
+
+	/* Check presence of mailbox MSRs */
+	ret = rdmsrl_safe(MSR_OS_MAILBOX_INTERFACE, &data);
+	if (ret)
+		return ret;
+
+	ret = rdmsrl_safe(MSR_OS_MAILBOX_DATA, &data);
+	if (ret)
+		return ret;
+
+	memset(&cb, 0, sizeof(cb));
+	cb.cmd_size = sizeof(struct isst_if_mbox_cmd);
+	cb.offset = offsetof(struct isst_if_mbox_cmds, mbox_cmd);
+	cb.cmd_callback = isst_if_mbox_proc_cmd;
+	cb.owner = THIS_MODULE;
+	return isst_if_cdev_register(ISST_IF_DEV_MBOX, &cb);
+}
+module_init(isst_if_mbox_init)
+
+static void __exit isst_if_mbox_exit(void)
+{
+	isst_if_cdev_unregister(ISST_IF_DEV_MBOX);
+}
+module_exit(isst_if_mbox_exit)
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Intel speed select interface mailbox driver");
-- 
2.17.2

