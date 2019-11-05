Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC50C010CF
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ED2F217F4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388778AbfKEMfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 07:35:07 -0500
Received: from inva020.nxp.com ([92.121.34.13]:59592 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388638AbfKEMfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 07:35:01 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 11DEF1A051F;
        Tue,  5 Nov 2019 13:34:59 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 040381A01E9;
        Tue,  5 Nov 2019 13:34:59 +0100 (CET)
Received: from fsr-ub1464-137.ea.freescale.net (fsr-ub1464-137.ea.freescale.net [10.171.82.114])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id B4A7C205ED;
        Tue,  5 Nov 2019 13:34:58 +0100 (CET)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     andrew@lunn.ch, f.fainelli@gmail.com,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 11/12] staging: dpaa2-ethsw: enable the control interface
Date:   Tue,  5 Nov 2019 14:34:34 +0200
Message-Id: <1572957275-23383-12-git-send-email-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1572957275-23383-1-git-send-email-ioana.ciornei@nxp.com>
References: <1572957275-23383-1-git-send-email-ioana.ciornei@nxp.com>
Reply-to: ioana.ciornei@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the CTRL_IF of the switch object, now that all the pieces are in
place (buffer and queue management, interrupts, NAPI instances etc).

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h |  2 ++
 drivers/staging/fsl-dpaa2/ethsw/dpsw.c     | 37 ++++++++++++++++++++++++++++++
 drivers/staging/fsl-dpaa2/ethsw/dpsw.h     |  5 ++++
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c    |  9 ++++++++
 4 files changed, 53 insertions(+)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h b/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h
index 4eab09fb2488..736795dcd9f5 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h
+++ b/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h
@@ -81,6 +81,8 @@
 
 #define DPSW_CMDID_CTRL_IF_GET_ATTR         DPSW_CMD_ID(0x0A0)
 #define DPSW_CMDID_CTRL_IF_SET_POOLS        DPSW_CMD_ID(0x0A1)
+#define DPSW_CMDID_CTRL_IF_ENABLE           DPSW_CMD_ID(0x0A2)
+#define DPSW_CMDID_CTRL_IF_DISABLE          DPSW_CMD_ID(0x0A3)
 #define DPSW_CMDID_CTRL_IF_SET_QUEUE        DPSW_CMD_ID(0x0A6)
 
 /* Macros for accessing command fields smaller than 1byte */
diff --git a/drivers/staging/fsl-dpaa2/ethsw/dpsw.c b/drivers/staging/fsl-dpaa2/ethsw/dpsw.c
index aebf2a0f4e03..62919fe24d49 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/dpsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/dpsw.c
@@ -1319,6 +1319,43 @@ int dpsw_ctrl_if_set_queue(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 }
 
 /**
+ * dpsw_ctrl_if_enable() - Enable control interface
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPSW object
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpsw_ctrl_if_enable(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token)
+{
+	struct fsl_mc_command cmd = { 0 };
+
+	cmd.header = mc_encode_cmd_header(DPSW_CMDID_CTRL_IF_ENABLE, cmd_flags,
+					  token);
+
+	return mc_send_command(mc_io, &cmd);
+}
+
+/**
+ * dpsw_ctrl_if_disable() - Function disables control interface
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPSW object
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpsw_ctrl_if_disable(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token)
+{
+	struct fsl_mc_command cmd = { 0 };
+
+	cmd.header = mc_encode_cmd_header(DPSW_CMDID_CTRL_IF_DISABLE,
+					  cmd_flags,
+					  token);
+
+	return mc_send_command(mc_io, &cmd);
+}
+
+/**
  * dpsw_acl_add() - Adds ACL to L2 switch.
  * @mc_io:	Pointer to MC portal's I/O object
  * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
diff --git a/drivers/staging/fsl-dpaa2/ethsw/dpsw.h b/drivers/staging/fsl-dpaa2/ethsw/dpsw.h
index f22f5ad4448a..a9ee8594df5b 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/dpsw.h
+++ b/drivers/staging/fsl-dpaa2/ethsw/dpsw.h
@@ -247,6 +247,11 @@ struct dpsw_ctrl_if_queue_cfg {
 int dpsw_ctrl_if_set_queue(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 			   enum dpsw_queue_type qtype,
 			   const struct dpsw_ctrl_if_queue_cfg *cfg);
+
+int dpsw_ctrl_if_enable(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token);
+
+int dpsw_ctrl_if_disable(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token);
+
 /**
  * enum dpsw_action - Action selection for special/control frames
  * @DPSW_ACTION_DROP: Drop frame
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index df9d81be242b..4b0a367bc308 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -2099,8 +2099,16 @@ static int ethsw_ctrl_if_setup(struct ethsw_core *ethsw)
 	if (err)
 		goto err_destroy_rings;
 
+	err = dpsw_ctrl_if_enable(ethsw->mc_io, 0, ethsw->dpsw_handle);
+	if (err) {
+		dev_err(ethsw->dev, "dpsw_ctrl_if_enable err %d\n", err);
+		goto err_deregister_dpio;
+	}
+
 	return 0;
 
+err_deregister_dpio:
+	ethsw_free_dpio(ethsw);
 err_destroy_rings:
 	ethsw_destroy_rings(ethsw);
 err_drain_dpbp:
@@ -2412,6 +2420,7 @@ static void ethsw_takedown(struct fsl_mc_device *sw_dev)
 
 static void ethsw_ctrl_if_teardown(struct ethsw_core *ethsw)
 {
+	dpsw_ctrl_if_disable(ethsw->mc_io, 0, ethsw->dpsw_handle);
 	ethsw_free_dpio(ethsw);
 	ethsw_destroy_rings(ethsw);
 	ethsw_drain_bp(ethsw);
-- 
1.9.1

