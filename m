Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF945C010CF
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B501721D71
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388921AbfKEMfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 07:35:44 -0500
Received: from inva021.nxp.com ([92.121.34.21]:41866 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388530AbfKEMe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 07:34:58 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 75E122004FE;
        Tue,  5 Nov 2019 13:34:56 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 675412004F1;
        Tue,  5 Nov 2019 13:34:56 +0100 (CET)
Received: from fsr-ub1464-137.ea.freescale.net (fsr-ub1464-137.ea.freescale.net [10.171.82.114])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 31822205ED;
        Tue,  5 Nov 2019 13:34:56 +0100 (CET)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     andrew@lunn.ch, f.fainelli@gmail.com,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 02/12] staging: dpaa2-ethsw: setup buffer pool for control traffic
Date:   Tue,  5 Nov 2019 14:34:25 +0200
Message-Id: <1572957275-23383-3-git-send-email-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1572957275-23383-1-git-send-email-ioana.ciornei@nxp.com>
References: <1572957275-23383-1-git-send-email-ioana.ciornei@nxp.com>
Reply-to: ioana.ciornei@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate and setup a buffer pool, needed on the Rx path of the control
interface. Also, define the Rx buffer size seen by the WRIOP from the
PAGE_SIZE buffers seeded.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h | 12 ++++
 drivers/staging/fsl-dpaa2/ethsw/dpsw.c     | 31 ++++++++++
 drivers/staging/fsl-dpaa2/ethsw/dpsw.h     | 26 +++++++++
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c    | 90 ++++++++++++++++++++++++++++++
 drivers/staging/fsl-dpaa2/ethsw/ethsw.h    | 10 ++++
 5 files changed, 169 insertions(+)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h b/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h
index 07a8178f4b37..0f1f2c787e99 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h
+++ b/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h
@@ -8,6 +8,8 @@
 #ifndef __FSL_DPSW_CMD_H
 #define __FSL_DPSW_CMD_H
 
+#include "dpsw.h"
+
 /* DPSW Version */
 #define DPSW_VER_MAJOR		8
 #define DPSW_VER_MINOR		1
@@ -70,6 +72,7 @@
 #define DPSW_CMDID_FDB_DUMP                 DPSW_CMD_ID(0x08A)
 
 #define DPSW_CMDID_CTRL_IF_GET_ATTR         DPSW_CMD_ID(0x0A0)
+#define DPSW_CMDID_CTRL_IF_SET_POOLS        DPSW_CMD_ID(0x0A1)
 
 /* Macros for accessing command fields smaller than 1byte */
 #define DPSW_MASK(field)        \
@@ -373,6 +376,15 @@ struct dpsw_rsp_ctrl_if_get_attr {
 	__le32 tx_err_conf_fqid;
 };
 
+#define DPSW_BACKUP_POOL(val, order)	(((val) & 0x1) << (order))
+struct dpsw_cmd_ctrl_if_set_pools {
+	u8 num_dpbp;
+	u8 backup_pool_mask;
+	__le16 pad;
+	__le32 dpbp_id[DPSW_MAX_DPBP];
+	__le16 buffer_size[DPSW_MAX_DPBP];
+};
+
 struct dpsw_rsp_get_api_version {
 	__le16 version_major;
 	__le16 version_minor;
diff --git a/drivers/staging/fsl-dpaa2/ethsw/dpsw.c b/drivers/staging/fsl-dpaa2/ethsw/dpsw.c
index f093d622a0de..bed7537efee5 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/dpsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/dpsw.c
@@ -1214,6 +1214,37 @@ int dpsw_ctrl_if_get_attributes(struct fsl_mc_io *mc_io, u32 cmd_flags,
 }
 
 /**
+ * dpsw_ctrl_if_set_pools() - Set control interface buffer pools
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPSW object
+ * @cfg:	Buffer pools configuration
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpsw_ctrl_if_set_pools(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
+			   const struct dpsw_ctrl_if_pools_cfg *cfg)
+{
+	struct dpsw_cmd_ctrl_if_set_pools *cmd_params;
+	struct fsl_mc_command cmd = { 0 };
+	int i;
+
+	cmd.header = mc_encode_cmd_header(DPSW_CMDID_CTRL_IF_SET_POOLS,
+					  cmd_flags, token);
+	cmd_params = (struct dpsw_cmd_ctrl_if_set_pools *)cmd.params;
+	cmd_params->num_dpbp = cfg->num_dpbp;
+	for (i = 0; i < DPSW_MAX_DPBP; i++) {
+		cmd_params->dpbp_id[i] = cpu_to_le32(cfg->pools[i].dpbp_id);
+		cmd_params->buffer_size[i] =
+			cpu_to_le16(cfg->pools[i].buffer_size);
+		cmd_params->backup_pool_mask |=
+			DPSW_BACKUP_POOL(cfg->pools[i].backup_pool, i);
+	}
+
+	return mc_send_command(mc_io, &cmd);
+}
+
+/**
  * dpsw_get_api_version() - Get Data Path Switch API version
  * @mc_io:	Pointer to MC portal's I/O object
  * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
diff --git a/drivers/staging/fsl-dpaa2/ethsw/dpsw.h b/drivers/staging/fsl-dpaa2/ethsw/dpsw.h
index cae69e20490c..9596d0ebe921 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/dpsw.h
+++ b/drivers/staging/fsl-dpaa2/ethsw/dpsw.h
@@ -197,6 +197,32 @@ enum dpsw_queue_type {
 };
 
 /**
+ * Maximum number of DPBP
+ */
+#define DPSW_MAX_DPBP     8
+
+/**
+ * struct dpsw_ctrl_if_pools_cfg - Control interface buffer pools configuration
+ * @num_dpbp: Number of DPBPs
+ * @pools: Array of buffer pools parameters; The number of valid entries
+ *	must match 'num_dpbp' value
+ * @pools.dpbp_id: DPBP object ID
+ * @pools.buffer_size: Buffer size
+ * @pools.backup_pool: Backup pool
+ */
+struct dpsw_ctrl_if_pools_cfg {
+	u8 num_dpbp;
+	struct {
+		int dpbp_id;
+		u16 buffer_size;
+		int backup_pool;
+	} pools[DPSW_MAX_DPBP];
+};
+
+int dpsw_ctrl_if_set_pools(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
+			   const struct dpsw_ctrl_if_pools_cfg *cfg);
+
+/**
  * enum dpsw_action - Action selection for special/control frames
  * @DPSW_ACTION_DROP: Drop frame
  * @DPSW_ACTION_REDIRECT: Redirect frame to control port
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index 633eff42b996..4ed335af2cc8 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -1382,6 +1382,83 @@ static int ethsw_setup_fqs(struct ethsw_core *ethsw)
 	return 0;
 }
 
+static int ethsw_setup_dpbp(struct ethsw_core *ethsw)
+{
+	struct dpsw_ctrl_if_pools_cfg dpsw_ctrl_if_pools_cfg = { 0 };
+	struct device *dev = ethsw->dev;
+	struct fsl_mc_device *dpbp_dev;
+	struct dpbp_attr dpbp_attrs;
+	int err;
+
+	err = fsl_mc_object_allocate(to_fsl_mc_device(dev), FSL_MC_POOL_DPBP,
+				     &dpbp_dev);
+	if (err) {
+		if (err == -ENXIO)
+			err = -EPROBE_DEFER;
+		else
+			dev_err(dev, "DPBP device allocation failed\n");
+		return err;
+	}
+	ethsw->dpbp_dev = dpbp_dev;
+
+	err = dpbp_open(ethsw->mc_io, 0, dpbp_dev->obj_desc.id,
+			&dpbp_dev->mc_handle);
+	if (err) {
+		dev_err(dev, "dpbp_open() failed\n");
+		goto err_open;
+	}
+
+	err = dpbp_reset(ethsw->mc_io, 0, dpbp_dev->mc_handle);
+	if (err) {
+		dev_err(dev, "dpbp_reset() failed\n");
+		goto err_reset;
+	}
+
+	err = dpbp_enable(ethsw->mc_io, 0, dpbp_dev->mc_handle);
+	if (err) {
+		dev_err(dev, "dpbp_enable() failed\n");
+		goto err_enable;
+	}
+
+	err = dpbp_get_attributes(ethsw->mc_io, 0, dpbp_dev->mc_handle,
+				  &dpbp_attrs);
+	if (err) {
+		dev_err(dev, "dpbp_get_attributes() failed\n");
+		goto err_get_attr;
+	}
+
+	dpsw_ctrl_if_pools_cfg.num_dpbp = 1;
+	dpsw_ctrl_if_pools_cfg.pools[0].dpbp_id = dpbp_attrs.id;
+	dpsw_ctrl_if_pools_cfg.pools[0].buffer_size = DPAA2_ETHSW_RX_BUF_SIZE;
+	dpsw_ctrl_if_pools_cfg.pools[0].backup_pool = 0;
+
+	err = dpsw_ctrl_if_set_pools(ethsw->mc_io, 0, ethsw->dpsw_handle,
+				     &dpsw_ctrl_if_pools_cfg);
+	if (err) {
+		dev_err(dev, "dpsw_ctrl_if_set_pools() failed\n");
+		goto err_get_attr;
+	}
+	ethsw->bpid = dpbp_attrs.id;
+
+	return 0;
+
+err_get_attr:
+	dpbp_disable(ethsw->mc_io, 0, dpbp_dev->mc_handle);
+err_enable:
+err_reset:
+	dpbp_close(ethsw->mc_io, 0, dpbp_dev->mc_handle);
+err_open:
+	fsl_mc_object_free(dpbp_dev);
+	return err;
+}
+
+static void ethsw_free_dpbp(struct ethsw_core *ethsw)
+{
+	dpbp_disable(ethsw->mc_io, 0, ethsw->dpbp_dev->mc_handle);
+	dpbp_close(ethsw->mc_io, 0, ethsw->dpbp_dev->mc_handle);
+	fsl_mc_object_free(ethsw->dpbp_dev);
+}
+
 static int ethsw_ctrl_if_setup(struct ethsw_core *ethsw)
 {
 	int err;
@@ -1391,6 +1468,11 @@ static int ethsw_ctrl_if_setup(struct ethsw_core *ethsw)
 	if (err)
 		return err;
 
+	/* setup the buffer poll needed on the Rx path */
+	err = ethsw_setup_dpbp(ethsw);
+	if (err)
+		return err;
+
 	return 0;
 }
 
@@ -1567,6 +1649,11 @@ static void ethsw_takedown(struct fsl_mc_device *sw_dev)
 		dev_warn(dev, "dpsw_close err %d\n", err);
 }
 
+static void ethsw_ctrl_if_teardown(struct ethsw_core *ethsw)
+{
+	ethsw_free_dpbp(ethsw);
+}
+
 static int ethsw_remove(struct fsl_mc_device *sw_dev)
 {
 	struct ethsw_port_priv *port_priv;
@@ -1577,6 +1664,9 @@ static int ethsw_remove(struct fsl_mc_device *sw_dev)
 	dev = &sw_dev->dev;
 	ethsw = dev_get_drvdata(dev);
 
+	if (ethsw_has_ctrl_if(ethsw))
+		ethsw_ctrl_if_teardown(ethsw);
+
 	ethsw_teardown_irqs(sw_dev);
 
 	destroy_workqueue(ethsw_owq);
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.h b/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
index 3ce4ac4e84fc..c3cfd08c21c7 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
@@ -17,6 +17,7 @@
 #include <uapi/linux/if_bridge.h>
 #include <net/switchdev.h>
 #include <linux/if_bridge.h>
+#include <linux/fsl/mc.h>
 
 #include "dpsw.h"
 
@@ -40,6 +41,13 @@
 /* Number of receive queues (one RX and one TX_CONF) */
 #define ETHSW_RX_NUM_FQS		2
 
+/* Hardware requires alignment for ingress/egress buffer addresses */
+#define DPAA2_ETHSW_RX_BUF_RAW_SIZE	PAGE_SIZE
+#define DPAA2_ETHSW_RX_BUF_TAILROOM \
+	SKB_DATA_ALIGN(sizeof(struct skb_shared_info))
+#define DPAA2_ETHSW_RX_BUF_SIZE \
+	(DPAA2_ETHSW_RX_BUF_RAW_SIZE - DPAA2_ETHSW_RX_BUF_TAILROOM)
+
 extern const struct ethtool_ops ethsw_port_ethtool_ops;
 
 struct ethsw_core;
@@ -77,6 +85,8 @@ struct ethsw_core {
 	bool				learning;
 
 	struct ethsw_fq			fq[ETHSW_RX_NUM_FQS];
+	struct fsl_mc_device		*dpbp_dev;
+	u16				bpid;
 };
 
 static inline bool ethsw_has_ctrl_if(struct ethsw_core *ethsw)
-- 
1.9.1

