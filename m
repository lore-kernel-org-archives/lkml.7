Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD4FC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 18:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6B94204EC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 18:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbfEGShT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 14:37:19 -0400
Received: from mga14.intel.com ([192.55.52.115]:41333 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbfEGShR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 14:37:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 May 2019 11:37:16 -0700
X-ExtLoop1: 1
Received: from marshy.an.intel.com ([10.122.105.159])
  by fmsmga004.fm.intel.com with ESMTP; 07 May 2019 11:37:16 -0700
From:   richard.gong@linux.intel.com
To:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        mark.rutland@arm.com, dinguyen@kernel.org, atull@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        richard.gong@linux.intel.com, Richard Gong <richard.gong@intel.com>
Subject: [PATCHv2 1/4] firmware: stratix10-svc: extend svc to support RSU notify and WD features
Date:   Tue,  7 May 2019 13:46:36 -0500
Message-Id: <1557254799-7416-2-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557254799-7416-1-git-send-email-richard.gong@linux.intel.com>
References: <1557254799-7416-1-git-send-email-richard.gong@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Entend Intel Stratix10 service layer driver to support RSU notify and
watchdog timeout features.

RSU is used to provide our customers with protection against loading bad
bitstream onto their devices when those devices are booting from flash

RSU notifies provides users with an API to notify the firmware of the
state of hard processor system.

RSU instructs firmware what to do when rebooting due to a watchdog timer
expiration, the firmware can reboot with the current running image or
reboot with the normal RSU flow.

Signed-off-by: Richard Gong <richard.gong@intel.com>
Reviewed-by: Alan Tull <atull@kernel.org>
---
v2: changed to add intel stratix10 RSU device
    changed to support RSU in handling a watchdog timeout
---
 drivers/firmware/stratix10-svc.c                   | 74 +++++++++++++++++++++-
 include/linux/firmware/intel/stratix10-smc.h       | 48 ++++++++++++--
 .../linux/firmware/intel/stratix10-svc-client.h    | 12 +++-
 3 files changed, 124 insertions(+), 10 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 6e65148..89e2849 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -38,6 +38,9 @@
 #define FPGA_CONFIG_DATA_CLAIM_TIMEOUT_MS	200
 #define FPGA_CONFIG_STATUS_TIMEOUT_SEC		30
 
+/* stratix10 service layer clients */
+#define STRATIX10_RSU				"stratix10-rsu"
+
 typedef void (svc_invoke_fn)(unsigned long, unsigned long, unsigned long,
 			     unsigned long, unsigned long, unsigned long,
 			     unsigned long, unsigned long,
@@ -45,6 +48,14 @@ typedef void (svc_invoke_fn)(unsigned long, unsigned long, unsigned long,
 struct stratix10_svc_chan;
 
 /**
+ * struct stratix10_svc - svc private data
+ * @stratix10_svc_rsu: pointer to stratix10 RSU device
+ */
+struct stratix10_svc {
+	struct platform_device *stratix10_svc_rsu;
+};
+
+/**
  * struct stratix10_svc_sh_memory - service shared memory structure
  * @sync_complete: state for a completion
  * @addr: physical address of shared memory block
@@ -295,7 +306,10 @@ static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
 	case COMMAND_RECONFIG_STATUS:
 		cb_data->status = BIT(SVC_STATUS_RECONFIG_COMPLETED);
 		break;
+	case COMMAND_RSU_STATUS:
 	case COMMAND_RSU_UPDATE:
+	case COMMAND_RSU_NOTIFY:
+	case COMMAND_RSU_WD:
 		cb_data->status = BIT(SVC_STATUS_RSU_OK);
 		break;
 	default:
@@ -386,6 +400,16 @@ static int svc_normal_to_secure_thread(void *data)
 			a1 = pdata->arg[0];
 			a2 = 0;
 			break;
+		case COMMAND_RSU_NOTIFY:
+			a0 = INTEL_SIP_SMC_RSU_NOTIFY;
+			a1 = pdata->arg[0];
+			a2 = 0;
+			break;
+		case COMMAND_RSU_WD:
+			a0 = INTEL_SIP_SMC_RSU_WD;
+			a1 = pdata->arg[0];
+			a2 = 0;
+			break;
 		default:
 			pr_warn("it shouldn't happen\n");
 			break;
@@ -438,7 +462,28 @@ static int svc_normal_to_secure_thread(void *data)
 			pr_debug("%s: STATUS_REJECTED\n", __func__);
 			break;
 		case INTEL_SIP_SMC_FPGA_CONFIG_STATUS_ERROR:
+		case INTEL_SIP_SMC_RSU_ERROR:
 			pr_err("%s: STATUS_ERROR\n", __func__);
+			switch (pdata->command) {
+			/* for FPGA mgr */
+			case COMMAND_RECONFIG_DATA_CLAIM:
+			case COMMAND_RECONFIG:
+			case COMMAND_RECONFIG_DATA_SUBMIT:
+			case COMMAND_RECONFIG_STATUS:
+				cbdata->status =
+					BIT(SVC_STATUS_RECONFIG_ERROR);
+				break;
+
+			/* for RSU */
+			case COMMAND_RSU_STATUS:
+			case COMMAND_RSU_UPDATE:
+			case COMMAND_RSU_NOTIFY:
+			case COMMAND_RSU_WD:
+				cbdata->status =
+					BIT(SVC_STATUS_RSU_ERROR);
+				break;
+			}
+
 			cbdata->status = BIT(SVC_STATUS_RECONFIG_ERROR);
 			cbdata->kaddr1 = NULL;
 			cbdata->kaddr2 = NULL;
@@ -530,7 +575,7 @@ static int svc_get_sh_memory(struct platform_device *pdev,
 
 	if (!sh_memory->addr || !sh_memory->size) {
 		dev_err(dev,
-			"fails to get shared memory info from secure world\n");
+			"failed to get shared memory info from secure world\n");
 		return -ENOMEM;
 	}
 
@@ -768,7 +813,7 @@ int stratix10_svc_send(struct stratix10_svc_chan *chan, void *msg)
 					      "svc_smc_hvc_thread");
 			if (IS_ERR(chan->ctrl->task)) {
 				dev_err(chan->ctrl->dev,
-					"fails to create svc_smc_hvc_thread\n");
+					"failed to create svc_smc_hvc_thread\n");
 				kfree(p_data);
 				return -EINVAL;
 			}
@@ -913,6 +958,8 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 	struct stratix10_svc_chan *chans;
 	struct gen_pool *genpool;
 	struct stratix10_svc_sh_memory *sh_memory;
+	struct stratix10_svc *svc;
+
 	svc_invoke_fn *invoke_fn;
 	size_t fifo_size;
 	int ret;
@@ -957,7 +1004,7 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 	fifo_size = sizeof(struct stratix10_svc_data) * SVC_NUM_DATA_IN_FIFO;
 	ret = kfifo_alloc(&controller->svc_fifo, fifo_size, GFP_KERNEL);
 	if (ret) {
-		dev_err(dev, "fails to allocate FIFO\n");
+		dev_err(dev, "failed to allocate FIFO\n");
 		return ret;
 	}
 	spin_lock_init(&controller->svc_fifo_lock);
@@ -975,6 +1022,24 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 	list_add_tail(&controller->node, &svc_ctrl);
 	platform_set_drvdata(pdev, controller);
 
+	/* add svc client device(s) */
+	svc = devm_kzalloc(dev, sizeof(*svc), GFP_KERNEL);
+	if (!svc)
+		return -ENOMEM;
+
+	svc->stratix10_svc_rsu = platform_device_alloc(STRATIX10_RSU, 0);
+	if (!svc->stratix10_svc_rsu) {
+		dev_err(dev, "failed to allocate %s device\n", STRATIX10_RSU);
+		return -ENOMEM;
+	}
+
+	ret = platform_device_add(svc->stratix10_svc_rsu);
+	if (ret) {
+		platform_device_put(svc->stratix10_svc_rsu);
+		return ret;
+	}
+	dev_set_drvdata(dev, svc);
+
 	pr_info("Intel Service Layer Driver Initialized\n");
 
 	return ret;
@@ -982,8 +1047,11 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
 
 static int stratix10_svc_drv_remove(struct platform_device *pdev)
 {
+	struct stratix10_svc *svc = dev_get_drvdata(&pdev->dev);
 	struct stratix10_svc_controller *ctrl = platform_get_drvdata(pdev);
 
+	platform_device_unregister(svc->stratix10_svc_rsu);
+
 	kfifo_free(&ctrl->svc_fifo);
 	if (ctrl->task) {
 		kthread_stop(ctrl->task);
diff --git a/include/linux/firmware/intel/stratix10-smc.h b/include/linux/firmware/intel/stratix10-smc.h
index 01684d9..6096738 100644
--- a/include/linux/firmware/intel/stratix10-smc.h
+++ b/include/linux/firmware/intel/stratix10-smc.h
@@ -210,7 +210,7 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
 #define INTEL_SIP_SMC_FPGA_CONFIG_LOOPBACK \
 	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_LOOPBACK)
 
-/*
+/**
  * Request INTEL_SIP_SMC_REG_READ
  *
  * Read a protected register at EL3
@@ -229,7 +229,7 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
 #define INTEL_SIP_SMC_REG_READ \
 	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_REG_READ)
 
-/*
+/**
  * Request INTEL_SIP_SMC_REG_WRITE
  *
  * Write a protected register at EL3
@@ -248,7 +248,7 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
 #define INTEL_SIP_SMC_REG_WRITE \
 	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_REG_WRITE)
 
-/*
+/**
  * Request INTEL_SIP_SMC_FUNCID_REG_UPDATE
  *
  * Update one or more bits in a protected register at EL3 using a
@@ -269,7 +269,7 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
 #define INTEL_SIP_SMC_REG_UPDATE \
 	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_REG_UPDATE)
 
-/*
+/**
  * Request INTEL_SIP_SMC_RSU_STATUS
  *
  * Request remote status update boot log, call is synchronous.
@@ -292,7 +292,7 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
 #define INTEL_SIP_SMC_RSU_STATUS \
 	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_RSU_STATUS)
 
-/*
+/**
  * Request INTEL_SIP_SMC_RSU_UPDATE
  *
  * Request to set the offset of the bitstream to boot after reboot, call
@@ -310,7 +310,7 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
 #define INTEL_SIP_SMC_RSU_UPDATE \
 	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_RSU_UPDATE)
 
-/*
+/**
  * Request INTEL_SIP_SMC_ECC_DBE
  *
  * Sync call used by service driver at EL1 to alert EL3 that a Double
@@ -329,3 +329,39 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
 	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_ECC_DBE)
 
 #endif
+
+/**
+ * Request INTEL_SIP_SMC_RSU_NOTIFY
+ *
+ * Sync call used by service driver at EL1 to report hard processor
+ * system state to firmware
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_RSU_NOTIFY
+ * a1 32bit value representing hard processor system state
+ * a2-7 not used
+ *
+ * Return status
+ * a0 INTEL_SIP_SMC_STATUS_OK
+ */
+#define INTEL_SIP_SMC_FUNCID_RSU_NOTIFY 14
+#define INTEL_SIP_SMC_RSU_NOTIFY \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_RSU_NOTIFY)
+
+/**
+ * Request INTEL_SIP_SMC_RSU_WD
+ *
+ * Sync call used by service driver at EL1 to instruct firmware what to
+ * do when rebooting due to a watchdog timer expiration
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_RSU_WD
+ * a1 32bit value indicating action for firmware to take
+ * a2-7 not used
+ *
+ * Return status
+ * a0 INTEL_SIP_SMC_STATUS_OK
+ */
+#define INTEL_SIP_SMC_FUNCID_RSU_WD 15
+#define INTEL_SIP_SMC_RSU_WD \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_RSU_WD)
diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
index e521f17..ea7604b 100644
--- a/include/linux/firmware/intel/stratix10-svc-client.h
+++ b/include/linux/firmware/intel/stratix10-svc-client.h
@@ -95,6 +95,14 @@ struct stratix10_svc_chan;
  *
  * @COMMAND_RSU_UPDATE: set the offset of the bitstream to boot after reboot,
  * return status is SVC_STATUS_RSU_OK or SVC_STATUS_RSU_ERROR
+ *
+ * @COMMAND_RSU_NOTIFY: report the status of hard processor system
+ * software to firmware, return status is SVC_STATUS_RSU_OK or
+ * SVC_STATUS_RSU_ERROR
+ *
+ * @COMMAND_RSU_WD: instruct firmware what to do when rebooting due to a
+ * watchdog timer expiration, return status is SVC_STATUS_RSU_OK or
+ * SVC_STATUS_RSU_ERROR
  */
 enum stratix10_svc_command_code {
 	COMMAND_NOOP = 0,
@@ -103,7 +111,9 @@ enum stratix10_svc_command_code {
 	COMMAND_RECONFIG_DATA_CLAIM,
 	COMMAND_RECONFIG_STATUS,
 	COMMAND_RSU_STATUS,
-	COMMAND_RSU_UPDATE
+	COMMAND_RSU_UPDATE,
+	COMMAND_RSU_NOTIFY,
+	COMMAND_RSU_WD,
 };
 
 /**
-- 
2.7.4

