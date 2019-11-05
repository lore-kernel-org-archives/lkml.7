Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C91FC010CF
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C64421D7F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388861AbfKEMfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 07:35:25 -0500
Received: from inva020.nxp.com ([92.121.34.13]:59536 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388543AbfKEMfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 07:35:00 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4F4E81A0522;
        Tue,  5 Nov 2019 13:34:57 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 421111A01E9;
        Tue,  5 Nov 2019 13:34:57 +0100 (CET)
Received: from fsr-ub1464-137.ea.freescale.net (fsr-ub1464-137.ea.freescale.net [10.171.82.114])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 0B232205ED;
        Tue,  5 Nov 2019 13:34:57 +0100 (CET)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     andrew@lunn.ch, f.fainelli@gmail.com,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 05/12] staging: dpaa2-ethsw: add ACL table at port probe
Date:   Tue,  5 Nov 2019 14:34:28 +0200
Message-Id: <1572957275-23383-6-git-send-email-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1572957275-23383-1-git-send-email-ioana.ciornei@nxp.com>
References: <1572957275-23383-1-git-send-email-ioana.ciornei@nxp.com>
Reply-to: ioana.ciornei@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For each of the switch ports, an ACL table is created and initialized at
port probe. These tables will be used to add ACL entries to redirect
control traffic to the CPU.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h |  27 +++++++
 drivers/staging/fsl-dpaa2/ethsw/dpsw.c     | 111 +++++++++++++++++++++++++++++
 drivers/staging/fsl-dpaa2/ethsw/dpsw.h     |  30 ++++++++
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c    |  44 +++++++++++-
 drivers/staging/fsl-dpaa2/ethsw/ethsw.h    |   3 +
 5 files changed, 214 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h b/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h
index ad25872a10b7..00244c6d39c9 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h
+++ b/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h
@@ -71,6 +71,11 @@
 #define DPSW_CMDID_FDB_SET_LEARNING_MODE    DPSW_CMD_ID(0x088)
 #define DPSW_CMDID_FDB_DUMP                 DPSW_CMD_ID(0x08A)
 
+#define DPSW_CMDID_ACL_ADD                  DPSW_CMD_ID(0x090)
+#define DPSW_CMDID_ACL_REMOVE               DPSW_CMD_ID(0x091)
+#define DPSW_CMDID_ACL_ADD_IF               DPSW_CMD_ID(0x094)
+#define DPSW_CMDID_ACL_REMOVE_IF            DPSW_CMD_ID(0x095)
+
 #define DPSW_CMDID_CTRL_IF_GET_ATTR         DPSW_CMD_ID(0x0A0)
 #define DPSW_CMDID_CTRL_IF_SET_POOLS        DPSW_CMD_ID(0x0A1)
 #define DPSW_CMDID_CTRL_IF_SET_QUEUE        DPSW_CMD_ID(0x0A6)
@@ -400,6 +405,28 @@ struct dpsw_cmd_ctrl_if_set_queue {
 	__le32 options;
 };
 
+struct dpsw_cmd_acl_add {
+	__le16 pad;
+	__le16 max_entries;
+};
+
+struct dpsw_rsp_acl_add {
+	__le16 acl_id;
+};
+
+struct dpsw_cmd_acl_remove {
+	__le16 acl_id;
+};
+
+struct dpsw_cmd_acl_if {
+	/* cmd word 0 */
+	__le16 acl_id;
+	__le16 num_ifs;
+	__le32 pad;
+	/* cmd word 1 */
+	__le64 if_id[4];
+};
+
 struct dpsw_rsp_get_api_version {
 	__le16 version_major;
 	__le16 version_minor;
diff --git a/drivers/staging/fsl-dpaa2/ethsw/dpsw.c b/drivers/staging/fsl-dpaa2/ethsw/dpsw.c
index 6f4d63b9f02e..d9e27f0e9edb 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/dpsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/dpsw.c
@@ -1278,6 +1278,117 @@ int dpsw_ctrl_if_set_queue(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 }
 
 /**
+ * dpsw_acl_add() - Adds ACL to L2 switch.
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPSW object
+ * @acl_id:	Returned ACL ID, for the future reference
+ * @cfg:	ACL configuration
+ *
+ * Create Access Control List. Multiple ACLs can be created and
+ * co-exist in L2 switch
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpsw_acl_add(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
+		 u16 *acl_id, const struct dpsw_acl_cfg *cfg)
+{
+	struct dpsw_cmd_acl_add *cmd_params;
+	struct dpsw_rsp_acl_add *rsp_params;
+	struct fsl_mc_command cmd = { 0 };
+	int err;
+
+	cmd.header = mc_encode_cmd_header(DPSW_CMDID_ACL_ADD, cmd_flags, token);
+	cmd_params = (struct dpsw_cmd_acl_add *)cmd.params;
+	cmd_params->max_entries = cpu_to_le16(cfg->max_entries);
+
+	err = mc_send_command(mc_io, &cmd);
+	if (err)
+		return err;
+
+	rsp_params = (struct dpsw_rsp_acl_add *)cmd.params;
+	*acl_id = le16_to_cpu(rsp_params->acl_id);
+
+	return 0;
+}
+
+/**
+ * dpsw_acl_remove() - Removes ACL from L2 switch.
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPSW object
+ * @acl_id:	ACL ID
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpsw_acl_remove(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
+		    u16 acl_id)
+{
+	struct dpsw_cmd_acl_remove *cmd_params;
+	struct fsl_mc_command cmd = { 0 };
+
+	cmd.header = mc_encode_cmd_header(DPSW_CMDID_ACL_REMOVE, cmd_flags,
+					  token);
+	cmd_params = (struct dpsw_cmd_acl_remove *)cmd.params;
+	cmd_params->acl_id = cpu_to_le16(acl_id);
+
+	return mc_send_command(mc_io, &cmd);
+}
+
+/**
+ * dpsw_acl_add_if() - Associate interface/interfaces with ACL.
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPSW object
+ * @acl_id:	ACL ID
+ * @cfg:	Interfaces list
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpsw_acl_add_if(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
+		    u16 acl_id, const struct dpsw_acl_if_cfg *cfg)
+{
+	struct dpsw_cmd_acl_if *cmd_params;
+	struct fsl_mc_command cmd = { 0 };
+
+	cmd.header = mc_encode_cmd_header(DPSW_CMDID_ACL_ADD_IF, cmd_flags,
+					  token);
+	cmd_params = (struct dpsw_cmd_acl_if *)cmd.params;
+	cmd_params->acl_id = cpu_to_le16(acl_id);
+	cmd_params->num_ifs = cpu_to_le16(cfg->num_ifs);
+	build_if_id_bitmap(cmd_params->if_id, cfg->if_id, cfg->num_ifs);
+
+	return mc_send_command(mc_io, &cmd);
+}
+
+/**
+ * dpsw_acl_remove_if() - De-associate interface/interfaces from ACL.
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPSW object
+ * @acl_id:	ACL ID
+ * @cfg:	Interfaces list
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpsw_acl_remove_if(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
+		       u16 acl_id, const struct dpsw_acl_if_cfg *cfg)
+{
+	struct fsl_mc_command cmd = { 0 };
+	struct dpsw_cmd_acl_if *cmd_params;
+
+	cmd.header = mc_encode_cmd_header(DPSW_CMDID_ACL_REMOVE_IF,
+					  cmd_flags,
+					  token);
+	cmd_params = (struct dpsw_cmd_acl_if *)cmd.params;
+	cmd_params->acl_id = cpu_to_le16(acl_id);
+	cmd_params->num_ifs = cpu_to_le16(cfg->num_ifs);
+	build_if_id_bitmap(cmd_params->if_id, cfg->if_id, cfg->num_ifs);
+
+	return mc_send_command(mc_io, &cmd);
+}
+
+/**
  * dpsw_get_api_version() - Get Data Path Switch API version
  * @mc_io:	Pointer to MC portal's I/O object
  * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
diff --git a/drivers/staging/fsl-dpaa2/ethsw/dpsw.h b/drivers/staging/fsl-dpaa2/ethsw/dpsw.h
index 55b5bbac9fbd..0726a5313c4e 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/dpsw.h
+++ b/drivers/staging/fsl-dpaa2/ethsw/dpsw.h
@@ -645,6 +645,36 @@ struct dpsw_fdb_attr {
 	u16 max_fdb_mc_groups;
 };
 
+/**
+ * struct dpsw_acl_cfg - ACL Configuration
+ * @max_entries: Number of FDB entries
+ */
+struct dpsw_acl_cfg {
+	u16 max_entries;
+};
+
+int dpsw_acl_add(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
+		 u16 *acl_id, const struct dpsw_acl_cfg *cfg);
+
+int dpsw_acl_remove(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
+		    u16 acl_id);
+
+/**
+ * struct dpsw_acl_if_cfg - List of interfaces to associate with ACL table
+ * @num_ifs: Number of interfaces
+ * @if_id: List of interfaces
+ */
+struct dpsw_acl_if_cfg {
+	u16 num_ifs;
+	u16 if_id[DPSW_MAX_IF];
+};
+
+int dpsw_acl_add_if(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
+		    u16 acl_id, const struct dpsw_acl_if_cfg *cfg);
+
+int dpsw_acl_remove_if(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
+		       u16 acl_id, const struct dpsw_acl_if_cfg *cfg);
+
 int dpsw_get_api_version(struct fsl_mc_io *mc_io,
 			 u32 cmd_flags,
 			 u16 *major_ver,
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index 125fd6ce669e..f3e339c5e9a1 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -1683,9 +1683,11 @@ static int ethsw_init(struct fsl_mc_device *sw_dev)
 
 static int ethsw_port_init(struct ethsw_port_priv *port_priv, u16 port)
 {
-	struct net_device *netdev = port_priv->netdev;
 	struct ethsw_core *ethsw = port_priv->ethsw_data;
+	struct net_device *netdev = port_priv->netdev;
+	struct dpsw_acl_if_cfg acl_if_cfg;
 	struct dpsw_vlan_if_cfg vcfg;
+	struct dpsw_acl_cfg acl_cfg;
 	int err;
 
 	/* Switch starts with all ports configured to VLAN 1. Need to
@@ -1711,6 +1713,30 @@ static int ethsw_port_init(struct ethsw_port_priv *port_priv, u16 port)
 	if (err)
 		netdev_err(netdev, "dpsw_vlan_remove_if err %d\n", err);
 
+	/* create the ACL table for this particular interface */
+	acl_cfg.max_entries = DPAA2_ETHSW_PORT_MAX_ACL_ENTRIES,
+	err = dpsw_acl_add(ethsw->mc_io, 0, ethsw->dpsw_handle,
+			   &port_priv->acl_id, &acl_cfg);
+	if (err) {
+		netdev_err(netdev, "dpsw_acl_add err %d\n", err);
+		return err;
+	}
+
+	acl_if_cfg.num_ifs = 1;
+	acl_if_cfg.if_id[0] = port_priv->idx;
+	err = dpsw_acl_add_if(ethsw->mc_io, 0, ethsw->dpsw_handle,
+			      port_priv->acl_id, &acl_if_cfg);
+	if (err) {
+		netdev_err(netdev, "dpsw_acl_add_if err %d\n", err);
+		goto err_acl_add;
+	}
+
+	return 0;
+
+err_acl_add:
+	dpsw_acl_remove(ethsw->mc_io, 0, ethsw->dpsw_handle,
+			port_priv->acl_id);
+
 	return err;
 }
 
@@ -1756,6 +1782,21 @@ static void ethsw_ctrl_if_teardown(struct ethsw_core *ethsw)
 	ethsw_free_dpbp(ethsw);
 }
 
+static void ethsw_port_takedown(struct ethsw_port_priv *port_priv)
+{
+	struct dpsw_acl_if_cfg acl_if_cfg;
+
+	acl_if_cfg.num_ifs = 1,
+	acl_if_cfg.if_id[0] = port_priv->idx;
+	dpsw_acl_remove_if(port_priv->ethsw_data->mc_io, 0,
+			   port_priv->ethsw_data->dpsw_handle,
+			   port_priv->acl_id, &acl_if_cfg);
+
+	dpsw_acl_remove(port_priv->ethsw_data->mc_io, 0,
+			port_priv->ethsw_data->dpsw_handle,
+			port_priv->acl_id);
+}
+
 static int ethsw_remove(struct fsl_mc_device *sw_dev)
 {
 	struct ethsw_port_priv *port_priv;
@@ -1778,6 +1819,7 @@ static int ethsw_remove(struct fsl_mc_device *sw_dev)
 	for (i = 0; i < ethsw->sw_attr.num_ifs; i++) {
 		port_priv = ethsw->ports[i];
 		unregister_netdev(port_priv->netdev);
+		ethsw_port_takedown(port_priv);
 		free_netdev(port_priv->netdev);
 	}
 	kfree(ethsw->ports);
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.h b/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
index e9a80cf185d7..3e1da3de0ca6 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
@@ -53,6 +53,8 @@
 /* Dequeue store size */
 #define DPAA2_ETHSW_STORE_SIZE		16
 
+#define DPAA2_ETHSW_PORT_MAX_ACL_ENTRIES	16
+
 extern const struct ethtool_ops ethsw_port_ethtool_ops;
 
 struct ethsw_core;
@@ -77,6 +79,7 @@ struct ethsw_port_priv {
 	u8			vlans[VLAN_VID_MASK + 1];
 	u16			pvid;
 	struct net_device	*bridge_dev;
+	u16			acl_id;
 };
 
 /* Switch data */
-- 
1.9.1

