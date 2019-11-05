Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C16C010A2
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3251421D71
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388906AbfKEMfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 07:35:39 -0500
Received: from inva021.nxp.com ([92.121.34.21]:41894 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388541AbfKEMe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 07:34:58 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0A8BE200506;
        Tue,  5 Nov 2019 13:34:57 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id F0C9D2004F1;
        Tue,  5 Nov 2019 13:34:56 +0100 (CET)
Received: from fsr-ub1464-137.ea.freescale.net (fsr-ub1464-137.ea.freescale.net [10.171.82.114])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id BAC65205ED;
        Tue,  5 Nov 2019 13:34:56 +0100 (CET)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     andrew@lunn.ch, f.fainelli@gmail.com,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 04/12] staging: dpaa2-ethsw: setup dpio
Date:   Tue,  5 Nov 2019 14:34:27 +0200
Message-Id: <1572957275-23383-5-git-send-email-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1572957275-23383-1-git-send-email-ioana.ciornei@nxp.com>
References: <1572957275-23383-1-git-send-email-ioana.ciornei@nxp.com>
Reply-to: ioana.ciornei@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setup interrupts on the control interface queues. We do not force an
exact affinity between the interrupts received from a specific queue and
a cpu.

Also, the DPSW object version is incremented since the
dpsw_ctrl_if_set_queue() API is introduced in the v8.4 object
(first seen in the MC 10.19.0 firmware).

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h | 17 +++++++-
 drivers/staging/fsl-dpaa2/ethsw/dpsw.c     | 33 +++++++++++++++
 drivers/staging/fsl-dpaa2/ethsw/dpsw.h     | 23 +++++++++++
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c    | 65 ++++++++++++++++++++++++++++++
 drivers/staging/fsl-dpaa2/ethsw/ethsw.h    |  1 +
 5 files changed, 138 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h b/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h
index 0f1f2c787e99..ad25872a10b7 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h
+++ b/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h
@@ -12,7 +12,7 @@
 
 /* DPSW Version */
 #define DPSW_VER_MAJOR		8
-#define DPSW_VER_MINOR		1
+#define DPSW_VER_MINOR		4
 
 #define DPSW_CMD_BASE_VERSION	1
 #define DPSW_CMD_ID_OFFSET	4
@@ -73,6 +73,7 @@
 
 #define DPSW_CMDID_CTRL_IF_GET_ATTR         DPSW_CMD_ID(0x0A0)
 #define DPSW_CMDID_CTRL_IF_SET_POOLS        DPSW_CMD_ID(0x0A1)
+#define DPSW_CMDID_CTRL_IF_SET_QUEUE        DPSW_CMD_ID(0x0A6)
 
 /* Macros for accessing command fields smaller than 1byte */
 #define DPSW_MASK(field)        \
@@ -385,6 +386,20 @@ struct dpsw_cmd_ctrl_if_set_pools {
 	__le16 buffer_size[DPSW_MAX_DPBP];
 };
 
+#define DPSW_DEST_TYPE_SHIFT	0
+#define DPSW_DEST_TYPE_SIZE	4
+
+struct dpsw_cmd_ctrl_if_set_queue {
+	__le32 dest_id;
+	u8 dest_priority;
+	u8 pad;
+	/* from LSB: dest_type:4 */
+	u8 dest_type;
+	u8 qtype;
+	__le64 user_ctx;
+	__le32 options;
+};
+
 struct dpsw_rsp_get_api_version {
 	__le16 version_major;
 	__le16 version_minor;
diff --git a/drivers/staging/fsl-dpaa2/ethsw/dpsw.c b/drivers/staging/fsl-dpaa2/ethsw/dpsw.c
index bed7537efee5..6f4d63b9f02e 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/dpsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/dpsw.c
@@ -1245,6 +1245,39 @@ int dpsw_ctrl_if_set_pools(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 }
 
 /**
+ * dpsw_ctrl_if_set_queue() - Set Rx queue configuration
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of dpsw object
+ * @qtype:	dpsw_queue_type of the targeted queue
+ * @cfg:	Rx queue configuration
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpsw_ctrl_if_set_queue(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
+			   enum dpsw_queue_type qtype,
+			   const struct dpsw_ctrl_if_queue_cfg *cfg)
+{
+	struct dpsw_cmd_ctrl_if_set_queue *cmd_params;
+	struct fsl_mc_command cmd = { 0 };
+
+	cmd.header = mc_encode_cmd_header(DPSW_CMDID_CTRL_IF_SET_QUEUE,
+					  cmd_flags,
+					  token);
+	cmd_params = (struct dpsw_cmd_ctrl_if_set_queue *)cmd.params;
+	cmd_params->dest_id = cpu_to_le32(cfg->dest_cfg.dest_id);
+	cmd_params->dest_priority = cfg->dest_cfg.priority;
+	cmd_params->qtype = qtype;
+	cmd_params->user_ctx = cpu_to_le64(cfg->user_ctx);
+	cmd_params->options = cpu_to_le32(cfg->options);
+	dpsw_set_field(cmd_params->dest_type,
+		       DEST_TYPE,
+		       cfg->dest_cfg.dest_type);
+
+	return mc_send_command(mc_io, &cmd);
+}
+
+/**
  * dpsw_get_api_version() - Get Data Path Switch API version
  * @mc_io:	Pointer to MC portal's I/O object
  * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
diff --git a/drivers/staging/fsl-dpaa2/ethsw/dpsw.h b/drivers/staging/fsl-dpaa2/ethsw/dpsw.h
index 9596d0ebe921..55b5bbac9fbd 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/dpsw.h
+++ b/drivers/staging/fsl-dpaa2/ethsw/dpsw.h
@@ -222,6 +222,29 @@ struct dpsw_ctrl_if_pools_cfg {
 int dpsw_ctrl_if_set_pools(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 			   const struct dpsw_ctrl_if_pools_cfg *cfg);
 
+#define DPSW_CTRL_IF_QUEUE_OPT_USER_CTX		0x00000001
+#define DPSW_CTRL_IF_QUEUE_OPT_DEST		0x00000002
+
+enum dpsw_ctrl_if_dest {
+	DPSW_CTRL_IF_DEST_NONE = 0,
+	DPSW_CTRL_IF_DEST_DPIO = 1,
+};
+
+struct dpsw_ctrl_if_dest_cfg {
+	enum dpsw_ctrl_if_dest dest_type;
+	int dest_id;
+	u8 priority;
+};
+
+struct dpsw_ctrl_if_queue_cfg {
+	u32 options;
+	u64 user_ctx;
+	struct dpsw_ctrl_if_dest_cfg dest_cfg;
+};
+
+int dpsw_ctrl_if_set_queue(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
+			   enum dpsw_queue_type qtype,
+			   const struct dpsw_ctrl_if_queue_cfg *cfg);
 /**
  * enum dpsw_action - Action selection for special/control frames
  * @DPSW_ACTION_DROP: Drop frame
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index 7b68eb22a951..125fd6ce669e 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -1486,6 +1486,64 @@ static void ethsw_destroy_rings(struct ethsw_core *ethsw)
 		dpaa2_io_store_destroy(ethsw->fq[i].store);
 }
 
+static int ethsw_setup_dpio(struct ethsw_core *ethsw)
+{
+	struct dpsw_ctrl_if_queue_cfg queue_cfg;
+	struct dpaa2_io_notification_ctx *nctx;
+	int err, i, j;
+
+	for (i = 0; i < ETHSW_RX_NUM_FQS; i++) {
+		nctx = &ethsw->fq[i].nctx;
+
+		/* Register a new software context for the FQID.
+		 * By using NULL as the first parameter, we specify that we do
+		 * not care on which cpu are interrupts received for this queue
+		 */
+		nctx->is_cdan = 0;
+		nctx->id = ethsw->fq[i].fqid;
+		nctx->desired_cpu = DPAA2_IO_ANY_CPU;
+		err = dpaa2_io_service_register(NULL, nctx, ethsw->dev);
+		if (err) {
+			err = -EPROBE_DEFER;
+			goto err_register;
+		}
+
+		queue_cfg.options = DPSW_CTRL_IF_QUEUE_OPT_DEST |
+				    DPSW_CTRL_IF_QUEUE_OPT_USER_CTX;
+		queue_cfg.dest_cfg.dest_type = DPSW_CTRL_IF_DEST_DPIO;
+		queue_cfg.dest_cfg.dest_id = nctx->dpio_id;
+		queue_cfg.dest_cfg.priority = 0;
+		queue_cfg.user_ctx = nctx->qman64;
+
+		err = dpsw_ctrl_if_set_queue(ethsw->mc_io, 0,
+					     ethsw->dpsw_handle,
+					     ethsw->fq[i].type,
+					     &queue_cfg);
+		if (err)
+			goto err_set_queue;
+	}
+
+	return 0;
+
+err_set_queue:
+	dpaa2_io_service_deregister(NULL, nctx, ethsw->dev);
+err_register:
+	for (j = 0; j < i; j++)
+		dpaa2_io_service_deregister(NULL, &ethsw->fq[j].nctx,
+					    ethsw->dev);
+
+	return err;
+}
+
+static void ethsw_free_dpio(struct ethsw_core *ethsw)
+{
+	int i;
+
+	for (i = 0; i < ETHSW_RX_NUM_FQS; i++)
+		dpaa2_io_service_deregister(NULL, &ethsw->fq[i].nctx,
+					    ethsw->dev);
+}
+
 static int ethsw_ctrl_if_setup(struct ethsw_core *ethsw)
 {
 	int err;
@@ -1504,8 +1562,14 @@ static int ethsw_ctrl_if_setup(struct ethsw_core *ethsw)
 	if (err)
 		goto err_free_dpbp;
 
+	err = ethsw_setup_dpio(ethsw);
+	if (err)
+		goto err_destroy_rings;
+
 	return 0;
 
+err_destroy_rings:
+	ethsw_destroy_rings(ethsw);
 err_free_dpbp:
 	ethsw_free_dpbp(ethsw);
 
@@ -1687,6 +1751,7 @@ static void ethsw_takedown(struct fsl_mc_device *sw_dev)
 
 static void ethsw_ctrl_if_teardown(struct ethsw_core *ethsw)
 {
+	ethsw_free_dpio(ethsw);
 	ethsw_destroy_rings(ethsw);
 	ethsw_free_dpbp(ethsw);
 }
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.h b/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
index a1ca30c615d5..e9a80cf185d7 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
@@ -60,6 +60,7 @@
 struct ethsw_fq {
 	struct ethsw_core *ethsw;
 	enum dpsw_queue_type type;
+	struct dpaa2_io_notification_ctx nctx;
 	struct dpaa2_io_store *store;
 	u32 fqid;
 };
-- 
1.9.1

