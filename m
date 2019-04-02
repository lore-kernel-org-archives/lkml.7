Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B31C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 17:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92B4C205F4
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 17:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIp6z4V8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731499AbfDBRHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 13:07:20 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42627 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfDBRHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 13:07:19 -0400
Received: by mail-wr1-f67.google.com with SMTP id g3so17602728wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 10:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Cg4dx0tjV2Muf9uGnEdzSLVCZYfJq6hIc6wt2tASncM=;
        b=MIp6z4V8pZ91KvcDHIJbaf8BZJKAqLcbSF12uprGEHXicLsuu801l/5smiplB6A6kK
         sqkkCL49Um/kmFyUqM9LOq1Qt4UIwNYPYamcv2oO6dOQK9fTDOU2Cnz/Phagu5Fe+1+M
         z338GnIoxASgMGnFJi2OIt4hPMGSNct3Xy9hob544P1VVGYm5MVBkjbTaJYLLkZLujWU
         GBiF5rgsKVNJOeI+n10ZvNTXYVm+rcmfQR1gRx4bRjjmSkorUwf9ItX52zNT1B88lc9W
         eWay4ZVIrtCwI4C7/Lo9jWl6/UnM7XtFyMcPX+bEzaGT7w5kl2s3lLLkCmiPeU7APBf+
         NRhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Cg4dx0tjV2Muf9uGnEdzSLVCZYfJq6hIc6wt2tASncM=;
        b=kICnh8ux6EYs71nIBUZjTPAwQt/5g+MgKf61rHNh5g6MImUbKNxHaXJMbSbWu/MIwA
         1MS+laFcSU+czZUnA11RyK/ePnP4dAItyjVXDvJrIKW2/pwQp+znygZFNGB23nthQOGR
         bDY8+XWSZhpG5uDgoQQ3uRtugzkGW2X2q0pU/aYWHrxuAnvSQXnDpWvZsz0HIYRPMyGA
         PJs+1f1LbUT8+cAvEAJdefbzxOXJwaEGfC+NTClXwNPcJajjvvnq01MObU7jhB/KGh98
         Za3ZDiymbKyE2vX2/yQ2kcgLijrftED659qboSNNgx4XgsBFcJHFQALbv8evSZKmR7e/
         AkyA==
X-Gm-Message-State: APjAAAWz9kFSa2mMadNMdM1bv1Mj8zItZVDc6KuzCEegchbeGU9XCrpi
        nxeHzMWQtrRdra2lUtTHU7pJwT/w
X-Google-Smtp-Source: APXvYqyBQz3/XSKsgzrVChW+E0uEtNebwuL9Q3Bu0imrc9AO5gBWOH4168OxLWlgYOQhpnIrU+5Xyg==
X-Received: by 2002:a5d:6291:: with SMTP id k17mr14981822wru.223.1554224837011;
        Tue, 02 Apr 2019 10:07:17 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id e9sm22098922wrp.35.2019.04.02.10.07.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 10:07:16 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Omer Shpigelman <oshpigelman@habana.ai>
Subject: [PATCH v2 2/3] habanalabs: add new IOCTL for debug, tracing and profiling
Date:   Tue,  2 Apr 2019 20:07:08 +0300
Message-Id: <20190402170709.29562-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190402170709.29562-1-oded.gabbay@gmail.com>
References: <20190402170709.29562-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omer Shpigelman <oshpigelman@habana.ai>

Habanalabs ASICs use the ARM coresight infrastructure to support debug,
tracing and profiling of neural networks topologies.

Because the coresight is configured using register writes and reads, and
some of the registers hold sensitive information (e.g. the address in
the device's DRAM where the trace data is written to), the user must go
through the kernel driver to configure this mechanism.

This patch implements the common code of the IOCTL and calls the
ASIC-specific function for the actual H/W configuration.

The IOCTL supports configuration of seven coresight components:
ETR, ETF, STM, FUNNEL, BMON, SPMU and TIMESTAMP

The user specifies which component he wishes to configure and provides a
pointer to a structure (located in its process space) that contains the
relevant configuration.

The common code copies the relevant data from the user-space to kernel
space and then calls the ASIC-specific function to do the H/W
configuration.

After the configuration is done, which is usually composed
of several IOCTL calls depending on what the user wanted to trace, the
user can start executing the topology. The trace data will be written to
the user's area in the device's DRAM.

After the tracing operation is complete, and user will call the IOCTL
again to disable the tracing operation. The user also need to read
values from registers for some of the components (e.g. the size of the
trace data in the device's DRAM). In that case, the user will provide a
pointer to an "output" structure in user-space, which the IOCTL code will
fill according the to selected component.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
Changes in v2:
  - remove change that was unrelated to this feature
 
 drivers/misc/habanalabs/goya/Makefile         |   3 +-
 drivers/misc/habanalabs/goya/goya.c           |   1 +
 drivers/misc/habanalabs/goya/goyaP.h          |   1 +
 drivers/misc/habanalabs/goya/goya_coresight.c |  13 ++
 drivers/misc/habanalabs/habanalabs.h          |  25 ++++
 drivers/misc/habanalabs/habanalabs_ioctl.c    | 123 +++++++++++++++++-
 include/uapi/misc/habanalabs.h                | 116 ++++++++++++++++-
 7 files changed, 279 insertions(+), 3 deletions(-)
 create mode 100644 drivers/misc/habanalabs/goya/goya_coresight.c

diff --git a/drivers/misc/habanalabs/goya/Makefile b/drivers/misc/habanalabs/goya/Makefile
index e458e5ba500b..131432f677e2 100644
--- a/drivers/misc/habanalabs/goya/Makefile
+++ b/drivers/misc/habanalabs/goya/Makefile
@@ -1,3 +1,4 @@
 subdir-ccflags-y += -I$(src)
 
-HL_GOYA_FILES :=  goya/goya.o goya/goya_security.o goya/goya_hwmgr.o
+HL_GOYA_FILES :=  goya/goya.o goya/goya_security.o goya/goya_hwmgr.o \
+	goya/goya_coresight.o
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 5fdc8c3cf141..0c2a902facb6 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -4814,6 +4814,7 @@ static const struct hl_asic_funcs goya_funcs = {
 	.send_heartbeat = goya_send_heartbeat,
 	.enable_clock_gating = goya_init_clock_gating,
 	.disable_clock_gating = goya_disable_clock_gating,
+	.debug_coresight = goya_debug_coresight,
 	.is_device_idle = goya_is_device_idle,
 	.soft_reset_late_init = goya_soft_reset_late_init,
 	.hw_queues_lock = goya_hw_queues_lock,
diff --git a/drivers/misc/habanalabs/goya/goyaP.h b/drivers/misc/habanalabs/goya/goyaP.h
index b99d92f197eb..6f1f7715075d 100644
--- a/drivers/misc/habanalabs/goya/goyaP.h
+++ b/drivers/misc/habanalabs/goya/goyaP.h
@@ -175,6 +175,7 @@ void goya_add_device_attr(struct hl_device *hdev,
 			struct attribute_group *dev_attr_grp);
 int goya_armcp_info_get(struct hl_device *hdev);
 void goya_init_security(struct hl_device *hdev);
+int goya_debug_coresight(struct hl_device *hdev, void *data);
 u64 goya_get_max_power(struct hl_device *hdev);
 void goya_set_max_power(struct hl_device *hdev, u64 value);
 
diff --git a/drivers/misc/habanalabs/goya/goya_coresight.c b/drivers/misc/habanalabs/goya/goya_coresight.c
new file mode 100644
index 000000000000..8957b8b1c0d6
--- /dev/null
+++ b/drivers/misc/habanalabs/goya/goya_coresight.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2016-2019 HabanaLabs, Ltd.
+ * All Rights Reserved.
+ */
+
+#include "goyaP.h"
+
+int goya_debug_coresight(struct hl_device *hdev, void *data)
+{
+	return -ENOTTY;
+}
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index fd7fcdf7050f..18a03657780a 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -483,6 +483,7 @@ enum hl_pll_frequency {
  * @send_heartbeat: send is-alive packet to ArmCP and verify response.
  * @enable_clock_gating: enable clock gating for reducing power consumption.
  * @disable_clock_gating: disable clock for accessing registers on HBW.
+ * @debug_coresight: perform certain actions on Coresight for debugging.
  * @is_device_idle: return true if device is idle, false otherwise.
  * @soft_reset_late_init: perform certain actions needed after soft reset.
  * @hw_queues_lock: acquire H/W queues lock.
@@ -557,6 +558,7 @@ struct hl_asic_funcs {
 	int (*send_heartbeat)(struct hl_device *hdev);
 	void (*enable_clock_gating)(struct hl_device *hdev);
 	void (*disable_clock_gating)(struct hl_device *hdev);
+	int (*debug_coresight)(struct hl_device *hdev, void *data);
 	bool (*is_device_idle)(struct hl_device *hdev, char *buf, size_t size);
 	int (*soft_reset_late_init)(struct hl_device *hdev);
 	void (*hw_queues_lock)(struct hl_device *hdev);
@@ -867,6 +869,29 @@ struct hl_vm {
 	u8			init_done;
 };
 
+
+/*
+ * DEBUG, PROFILING STRUCTURE
+ */
+
+/**
+ * struct hl_debug_params - Coresight debug parameters.
+ * @input: pointer to component specific input parameters.
+ * @output: pointer to component specific output parameters.
+ * @output_size: size of output buffer.
+ * @reg_idx: relevant register ID.
+ * @op: component operation to execute.
+ * @enable: true if to enable component debugging, false otherwise.
+ */
+struct hl_debug_params {
+	void *input;
+	void *output;
+	u32 output_size;
+	u32 reg_idx;
+	u32 op;
+	bool enable;
+};
+
 /*
  * FILE PRIVATE STRUCTURE
  */
diff --git a/drivers/misc/habanalabs/habanalabs_ioctl.c b/drivers/misc/habanalabs/habanalabs_ioctl.c
index 9000ff615805..74cadd817473 100644
--- a/drivers/misc/habanalabs/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/habanalabs_ioctl.c
@@ -12,6 +12,17 @@
 #include <linux/uaccess.h>
 #include <linux/slab.h>
 
+static u32 hl_debug_struct_size[HL_DEBUG_OP_TIMESTAMP + 1] = {
+	[HL_DEBUG_OP_ETR] = sizeof(struct hl_debug_params_etr),
+	[HL_DEBUG_OP_ETF] = sizeof(struct hl_debug_params_etf),
+	[HL_DEBUG_OP_STM] = sizeof(struct hl_debug_params_stm),
+	[HL_DEBUG_OP_FUNNEL] = 0,
+	[HL_DEBUG_OP_BMON] = sizeof(struct hl_debug_params_bmon),
+	[HL_DEBUG_OP_SPMU] = sizeof(struct hl_debug_params_spmu),
+	[HL_DEBUG_OP_TIMESTAMP] = 0
+
+};
+
 static int device_status_info(struct hl_device *hdev, struct hl_info_args *args)
 {
 	struct hl_info_device_status dev_stat = {0};
@@ -114,6 +125,76 @@ static int hw_idle(struct hl_device *hdev, struct hl_info_args *args)
 		min((size_t) max_size, sizeof(hw_idle))) ? -EFAULT : 0;
 }
 
+static int debug_coresight(struct hl_device *hdev, struct hl_debug_args *args)
+{
+	struct hl_debug_params *params;
+	void *input = NULL, *output = NULL;
+	int rc;
+
+	params = kzalloc(sizeof(*params), GFP_KERNEL);
+	if (!params)
+		return -ENOMEM;
+
+	params->reg_idx = args->reg_idx;
+	params->enable = args->enable;
+	params->op = args->op;
+
+	if (args->input_ptr && args->input_size) {
+		input = kzalloc(args->input_size, GFP_KERNEL);
+		if (!input) {
+			rc = -ENOMEM;
+			goto out;
+		}
+
+		if (copy_from_user(input,
+				(void __user *) (uintptr_t) args->input_ptr,
+				args->input_size)) {
+			dev_err(hdev->dev,
+				"copy from user failed in debug ioctl\n");
+			rc = -EFAULT;
+			goto out;
+		}
+
+		params->input = input;
+	}
+
+	if (args->output_ptr && args->output_size) {
+		output = kzalloc(args->output_size, GFP_KERNEL);
+		if (!output) {
+			rc = -ENOMEM;
+			goto out;
+		}
+
+		params->output = output;
+		params->output_size = args->output_size;
+	}
+
+	rc = hdev->asic_funcs->debug_coresight(hdev, params);
+	if (rc) {
+		dev_err(hdev->dev,
+			"debug coresight operation failed %d\n", rc);
+		goto out;
+	}
+
+	if (output) {
+		if (copy_to_user((void __user *) (uintptr_t) args->output_ptr,
+					output,
+					args->output_size)) {
+			dev_err(hdev->dev,
+				"copy to user failed in debug ioctl\n");
+			rc = -EFAULT;
+			goto out;
+		}
+	}
+
+out:
+	kfree(params);
+	kfree(output);
+	kfree(input);
+
+	return rc;
+}
+
 static int hl_info_ioctl(struct hl_fpriv *hpriv, void *data)
 {
 	struct hl_info_args *args = data;
@@ -156,6 +237,45 @@ static int hl_info_ioctl(struct hl_fpriv *hpriv, void *data)
 	return rc;
 }
 
+static int hl_debug_ioctl(struct hl_fpriv *hpriv, void *data)
+{
+	struct hl_debug_args *args = data;
+	struct hl_device *hdev = hpriv->hdev;
+	int rc = 0;
+
+	if (hdev->hard_reset_pending) {
+		dev_crit(hdev->dev,
+			"Device HARD reset pending !!! Please close FD\n");
+		return -ENODEV;
+	}
+
+	if ((hdev->disabled) || (atomic_read(&hdev->in_reset))) {
+		dev_err(hdev->dev,
+			"Device is disabled or in reset !!! Can't execute DEBUG IOCTL\n");
+		return -EBUSY;
+	}
+
+	switch (args->op) {
+	case HL_DEBUG_OP_ETR:
+	case HL_DEBUG_OP_ETF:
+	case HL_DEBUG_OP_STM:
+	case HL_DEBUG_OP_FUNNEL:
+	case HL_DEBUG_OP_BMON:
+	case HL_DEBUG_OP_SPMU:
+	case HL_DEBUG_OP_TIMESTAMP:
+		args->input_size =
+			min(args->input_size, hl_debug_struct_size[args->op]);
+		rc = debug_coresight(hdev, args);
+		break;
+	default:
+		dev_err(hdev->dev, "Invalid request %d\n", args->op);
+		rc = -ENOTTY;
+		break;
+	}
+
+	return rc;
+}
+
 #define HL_IOCTL_DEF(ioctl, _func) \
 	[_IOC_NR(ioctl)] = {.cmd = ioctl, .func = _func}
 
@@ -164,7 +284,8 @@ static const struct hl_ioctl_desc hl_ioctls[] = {
 	HL_IOCTL_DEF(HL_IOCTL_CB, hl_cb_ioctl),
 	HL_IOCTL_DEF(HL_IOCTL_CS, hl_cs_ioctl),
 	HL_IOCTL_DEF(HL_IOCTL_WAIT_CS, hl_cs_wait_ioctl),
-	HL_IOCTL_DEF(HL_IOCTL_MEMORY, hl_mem_ioctl)
+	HL_IOCTL_DEF(HL_IOCTL_MEMORY, hl_mem_ioctl),
+	HL_IOCTL_DEF(HL_IOCTL_DEBUG, hl_debug_ioctl)
 };
 
 #define HL_CORE_IOCTL_COUNT	ARRAY_SIZE(hl_ioctls)
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 993a79edad73..7704fe08c3ad 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -335,6 +335,107 @@ union hl_mem_args {
 	struct hl_mem_out out;
 };
 
+#define HL_DEBUG_MAX_AUX_VALUES		10
+
+struct hl_debug_params_etr {
+	/* Address in memory to allocate buffer */
+	__u64 buffer_address;
+
+	/* Size of buffer to allocate */
+	__u64 buffer_size;
+
+	/* Sink operation mode: SW fifo, HW fifo, Circular buffer */
+	__u32 sink_mode;
+	__u32 pad;
+};
+
+struct hl_debug_params_etf {
+	/* Address in memory to allocate buffer */
+	__u64 buffer_address;
+
+	/* Size of buffer to allocate */
+	__u64 buffer_size;
+
+	/* Sink operation mode: SW fifo, HW fifo, Circular buffer */
+	__u32 sink_mode;
+	__u32 pad;
+};
+
+struct hl_debug_params_stm {
+	/* Two bit masks for HW event and Stimulus Port */
+	__u64 he_mask;
+	__u64 sp_mask;
+
+	/* Trace source ID */
+	__u32 id;
+
+	/* Frequency for the timestamp register */
+	__u32 frequency;
+};
+
+struct hl_debug_params_bmon {
+	/* Transaction address filter */
+	__u64 addr_range0;
+	__u64 addr_range1;
+
+	/* Capture window configuration */
+	__u32 bw_win;
+	__u32 win_capture;
+
+	/* Trace source ID */
+	__u32 id;
+	__u32 pad;
+};
+
+struct hl_debug_params_spmu {
+	/* Event types selection */
+	__u64 event_types[HL_DEBUG_MAX_AUX_VALUES];
+
+	/* Number of event types selection */
+	__u32 event_types_num;
+	__u32 pad;
+};
+
+/* Opcode for ETR component */
+#define HL_DEBUG_OP_ETR		0
+/* Opcode for ETF component */
+#define HL_DEBUG_OP_ETF		1
+/* Opcode for STM component */
+#define HL_DEBUG_OP_STM		2
+/* Opcode for FUNNEL component */
+#define HL_DEBUG_OP_FUNNEL	3
+/* Opcode for BMON component */
+#define HL_DEBUG_OP_BMON	4
+/* Opcode for SPMU component */
+#define HL_DEBUG_OP_SPMU	5
+/* Opcode for timestamp */
+#define HL_DEBUG_OP_TIMESTAMP	6
+
+struct hl_debug_args {
+	/*
+	 * Pointer to user input structure.
+	 * This field is relevant to specific opcodes.
+	 */
+	__u64 input_ptr;
+	/* Pointer to user output structure */
+	__u64 output_ptr;
+	/* Size of user input structure */
+	__u32 input_size;
+	/* Size of user output structure */
+	__u32 output_size;
+	/* HL_DEBUG_OP_* */
+	__u32 op;
+	/*
+	 * Register index in the component, taken from the debug_regs_index enum
+	 * in the various ASIC header files
+	 */
+	__u32 reg_idx;
+	/* Enable/disable */
+	__u32 enable;
+	/* Context ID - Currently not in use */
+	__u32 ctx_id;
+};
+
 /*
  * Various information operations such as:
  * - H/W IP information
@@ -459,7 +560,20 @@ union hl_mem_args {
 #define HL_IOCTL_MEMORY		\
 		_IOWR('H', 0x05, union hl_mem_args)
 
+/*
+ * Debug
+ * - Enable/disable the ETR/ETF/FUNNEL/STM/BMON/SPMU debug traces
+ *
+ * This IOCTL allows the user to get debug traces from the chip.
+ *
+ * The user needs to provide the register index and essential data such as
+ * buffer address and size.
+ *
+ */
+#define HL_IOCTL_DEBUG		\
+		_IOWR('H', 0x06, struct hl_debug_args)
+
 #define HL_COMMAND_START	0x01
-#define HL_COMMAND_END		0x06
+#define HL_COMMAND_END		0x07
 
 #endif /* HABANALABS_H_ */
-- 
2.17.1

