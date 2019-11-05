Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DCDC010CF
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D20221E6F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388662AbfKEMfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 07:35:00 -0500
Received: from inva020.nxp.com ([92.121.34.13]:59518 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388526AbfKEMe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 07:34:58 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2E7EA1A051F;
        Tue,  5 Nov 2019 13:34:56 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 21AB51A01E9;
        Tue,  5 Nov 2019 13:34:56 +0100 (CET)
Received: from fsr-ub1464-137.ea.freescale.net (fsr-ub1464-137.ea.freescale.net [10.171.82.114])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id E0378205ED;
        Tue,  5 Nov 2019 13:34:55 +0100 (CET)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     andrew@lunn.ch, f.fainelli@gmail.com,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 01/12] staging: dpaa2-ethsw: get control interface attributes
Date:   Tue,  5 Nov 2019 14:34:24 +0200
Message-Id: <1572957275-23383-2-git-send-email-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1572957275-23383-1-git-send-email-ioana.ciornei@nxp.com>
References: <1572957275-23383-1-git-send-email-ioana.ciornei@nxp.com>
Reply-to: ioana.ciornei@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a new structure to hold all necessary info related to an RX
queue for the control interface and populate the FQ IDs.
We only have one Rx queue and one Tx confirmation queue on the control
interface, both shared by all the switch ports.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h |  9 +++++++
 drivers/staging/fsl-dpaa2/ethsw/dpsw.c     | 31 +++++++++++++++++++++
 drivers/staging/fsl-dpaa2/ethsw/dpsw.h     | 21 +++++++++++++++
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c    | 43 ++++++++++++++++++++++++++++++
 drivers/staging/fsl-dpaa2/ethsw/ethsw.h    | 15 +++++++++++
 5 files changed, 119 insertions(+)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h b/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h
index 5e1339daa7c7..07a8178f4b37 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h
+++ b/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h
@@ -69,6 +69,8 @@
 #define DPSW_CMDID_FDB_SET_LEARNING_MODE    DPSW_CMD_ID(0x088)
 #define DPSW_CMDID_FDB_DUMP                 DPSW_CMD_ID(0x08A)
 
+#define DPSW_CMDID_CTRL_IF_GET_ATTR         DPSW_CMD_ID(0x0A0)
+
 /* Macros for accessing command fields smaller than 1byte */
 #define DPSW_MASK(field)        \
 	GENMASK(DPSW_##field##_SHIFT + DPSW_##field##_SIZE - 1, \
@@ -364,6 +366,13 @@ struct dpsw_rsp_fdb_dump {
 	__le16 num_entries;
 };
 
+struct dpsw_rsp_ctrl_if_get_attr {
+	__le64 pad;
+	__le32 rx_fqid;
+	__le32 rx_err_fqid;
+	__le32 tx_err_conf_fqid;
+};
+
 struct dpsw_rsp_get_api_version {
 	__le16 version_major;
 	__le16 version_minor;
diff --git a/drivers/staging/fsl-dpaa2/ethsw/dpsw.c b/drivers/staging/fsl-dpaa2/ethsw/dpsw.c
index 56b0fa789a67..f093d622a0de 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/dpsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/dpsw.c
@@ -1183,6 +1183,37 @@ int dpsw_fdb_set_learning_mode(struct fsl_mc_io *mc_io,
 }
 
 /**
+ * dpsw_ctrl_if_get_attributes() - Obtain control interface attributes
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPSW object
+ * @attr:	Returned control interface attributes
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpsw_ctrl_if_get_attributes(struct fsl_mc_io *mc_io, u32 cmd_flags,
+				u16 token, struct dpsw_ctrl_if_attr *attr)
+{
+	struct dpsw_rsp_ctrl_if_get_attr *rsp_params;
+	struct fsl_mc_command cmd = { 0 };
+	int err;
+
+	cmd.header = mc_encode_cmd_header(DPSW_CMDID_CTRL_IF_GET_ATTR,
+					  cmd_flags, token);
+
+	err = mc_send_command(mc_io, &cmd);
+	if (err)
+		return err;
+
+	rsp_params = (struct dpsw_rsp_ctrl_if_get_attr *)cmd.params;
+	attr->rx_fqid = le32_to_cpu(rsp_params->rx_fqid);
+	attr->rx_err_fqid = le32_to_cpu(rsp_params->rx_err_fqid);
+	attr->tx_err_conf_fqid = le32_to_cpu(rsp_params->tx_err_conf_fqid);
+
+	return 0;
+}
+
+/**
  * dpsw_get_api_version() - Get Data Path Switch API version
  * @mc_io:	Pointer to MC portal's I/O object
  * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
diff --git a/drivers/staging/fsl-dpaa2/ethsw/dpsw.h b/drivers/staging/fsl-dpaa2/ethsw/dpsw.h
index 25b45850925c..cae69e20490c 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/dpsw.h
+++ b/drivers/staging/fsl-dpaa2/ethsw/dpsw.h
@@ -176,6 +176,27 @@ int dpsw_get_attributes(struct fsl_mc_io *mc_io,
 			struct dpsw_attr *attr);
 
 /**
+ * struct dpsw_ctrl_if_attr - Control interface attributes
+ * @rx_fqid:		Receive FQID
+ * @rx_err_fqid:	Receive error FQID
+ * @tx_err_conf_fqid:	Transmit error and confirmation FQID
+ */
+struct dpsw_ctrl_if_attr {
+	u32 rx_fqid;
+	u32 rx_err_fqid;
+	u32 tx_err_conf_fqid;
+};
+
+int dpsw_ctrl_if_get_attributes(struct fsl_mc_io *mc_io, u32 cmd_flags,
+				u16 token, struct dpsw_ctrl_if_attr *attr);
+
+enum dpsw_queue_type {
+	DPSW_QUEUE_RX,
+	DPSW_QUEUE_TX_ERR_CONF,
+	DPSW_QUEUE_RX_ERR,
+};
+
+/**
  * enum dpsw_action - Action selection for special/control frames
  * @DPSW_ACTION_DROP: Drop frame
  * @DPSW_ACTION_REDIRECT: Redirect frame to control port
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index 14a9eebf687e..633eff42b996 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -1357,6 +1357,43 @@ static int ethsw_register_notifier(struct device *dev)
 	return err;
 }
 
+static int ethsw_setup_fqs(struct ethsw_core *ethsw)
+{
+	struct dpsw_ctrl_if_attr ctrl_if_attr;
+	struct device *dev = ethsw->dev;
+	int i = 0;
+	int err;
+
+	err = dpsw_ctrl_if_get_attributes(ethsw->mc_io, 0, ethsw->dpsw_handle,
+					  &ctrl_if_attr);
+	if (err) {
+		dev_err(dev, "dpsw_ctrl_if_get_attributes() = %d\n", err);
+		return err;
+	}
+
+	ethsw->fq[i].fqid = ctrl_if_attr.rx_fqid;
+	ethsw->fq[i].ethsw = ethsw;
+	ethsw->fq[i++].type = DPSW_QUEUE_RX;
+
+	ethsw->fq[i].fqid = ctrl_if_attr.tx_err_conf_fqid;
+	ethsw->fq[i].ethsw = ethsw;
+	ethsw->fq[i++].type = DPSW_QUEUE_TX_ERR_CONF;
+
+	return 0;
+}
+
+static int ethsw_ctrl_if_setup(struct ethsw_core *ethsw)
+{
+	int err;
+
+	/* setup FQs for Rx and Tx Conf */
+	err = ethsw_setup_fqs(ethsw);
+	if (err)
+		return err;
+
+	return 0;
+}
+
 static int ethsw_init(struct fsl_mc_device *sw_dev)
 {
 	struct device *dev = &sw_dev->dev;
@@ -1442,6 +1479,12 @@ static int ethsw_init(struct fsl_mc_device *sw_dev)
 		goto err_close;
 	}
 
+	if (ethsw_has_ctrl_if(ethsw)) {
+		err = ethsw_ctrl_if_setup(ethsw);
+		if (err)
+			goto err_destroy_ordered_workqueue;
+	}
+
 	err = ethsw_register_notifier(dev);
 	if (err)
 		goto err_destroy_ordered_workqueue;
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.h b/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
index 3ea8a0ad8c10..3ce4ac4e84fc 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
@@ -37,10 +37,19 @@
 #define ETHSW_MAX_FRAME_LENGTH	(DPAA2_MFL - VLAN_ETH_HLEN - ETH_FCS_LEN)
 #define ETHSW_L2_MAX_FRM(mtu)	((mtu) + VLAN_ETH_HLEN + ETH_FCS_LEN)
 
+/* Number of receive queues (one RX and one TX_CONF) */
+#define ETHSW_RX_NUM_FQS		2
+
 extern const struct ethtool_ops ethsw_port_ethtool_ops;
 
 struct ethsw_core;
 
+struct ethsw_fq {
+	struct ethsw_core *ethsw;
+	enum dpsw_queue_type type;
+	u32 fqid;
+};
+
 /* Per port private data */
 struct ethsw_port_priv {
 	struct net_device	*netdev;
@@ -66,6 +75,12 @@ struct ethsw_core {
 
 	u8				vlans[VLAN_VID_MASK + 1];
 	bool				learning;
+
+	struct ethsw_fq			fq[ETHSW_RX_NUM_FQS];
 };
 
+static inline bool ethsw_has_ctrl_if(struct ethsw_core *ethsw)
+{
+	return !(ethsw->sw_attr.options & DPSW_OPT_CTRL_IF_DIS);
+}
 #endif	/* __ETHSW_H */
-- 
1.9.1

