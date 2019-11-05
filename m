Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357B0C010CF
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F35F42190F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388817AbfKEMfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 07:35:20 -0500
Received: from inva021.nxp.com ([92.121.34.21]:41950 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388632AbfKEMfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 07:35:01 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7A124200519;
        Tue,  5 Nov 2019 13:34:58 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 61BFF2004F1;
        Tue,  5 Nov 2019 13:34:58 +0100 (CET)
Received: from fsr-ub1464-137.ea.freescale.net (fsr-ub1464-137.ea.freescale.net [10.171.82.114])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 2BB8E205ED;
        Tue,  5 Nov 2019 13:34:58 +0100 (CET)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     andrew@lunn.ch, f.fainelli@gmail.com,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 09/12] staging: dpaa2-ethsw: add .ndo_start_xmit() callback
Date:   Tue,  5 Nov 2019 14:34:32 +0200
Message-Id: <1572957275-23383-10-git-send-email-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1572957275-23383-1-git-send-email-ioana.ciornei@nxp.com>
References: <1572957275-23383-1-git-send-email-ioana.ciornei@nxp.com>
Reply-to: ioana.ciornei@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the .ndo_start_xmit() callback for the switch port interfaces.
For each of the switch ports, gather the corresponding queue
destination ID (QDID) necessary for Tx enqueueing.

We'll reserve 64 bytes for software annotations, where we keep a skb
backpointer used on the Tx confirmation side for releasing the allocated
memory. At the moment, we only support linear skbs.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h |  24 +++++
 drivers/staging/fsl-dpaa2/ethsw/dpsw.c     |  41 ++++++++
 drivers/staging/fsl-dpaa2/ethsw/dpsw.h     |  27 ++++++
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c    | 144 ++++++++++++++++++++++++++---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.h    |  14 +++
 5 files changed, 236 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h b/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h
index 7f8ad27f8db6..4eab09fb2488 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h
+++ b/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h
@@ -45,6 +45,8 @@
 #define DPSW_CMDID_IF_ENABLE                DPSW_CMD_ID(0x03D)
 #define DPSW_CMDID_IF_DISABLE               DPSW_CMD_ID(0x03E)
 
+#define DPSW_CMDID_IF_GET_ATTR              DPSW_CMD_ID(0x042)
+
 #define DPSW_CMDID_IF_SET_MAX_FRAME_LENGTH  DPSW_CMD_ID(0x044)
 
 #define DPSW_CMDID_IF_GET_LINK_STATE        DPSW_CMD_ID(0x046)
@@ -260,6 +262,28 @@ struct dpsw_cmd_if {
 	__le16 if_id;
 };
 
+#define DPSW_ADMIT_UNTAGGED_SHIFT	0
+#define DPSW_ADMIT_UNTAGGED_SIZE	4
+#define DPSW_ENABLED_SHIFT		5
+#define DPSW_ENABLED_SIZE		1
+#define DPSW_ACCEPT_ALL_VLAN_SHIFT	6
+#define DPSW_ACCEPT_ALL_VLAN_SIZE	1
+
+struct dpsw_rsp_if_get_attr {
+	/* cmd word 0 */
+	/* from LSB: admit_untagged:4 enabled:1 accept_all_vlan:1 */
+	u8 conf;
+	u8 pad1;
+	u8 num_tcs;
+	u8 pad2;
+	__le16 qdid;
+	/* cmd word 1 */
+	__le32 options;
+	__le32 pad3;
+	/* cmd word 2 */
+	__le32 rate;
+};
+
 struct dpsw_cmd_if_set_max_frame_length {
 	__le16 if_id;
 	__le16 frame_length;
diff --git a/drivers/staging/fsl-dpaa2/ethsw/dpsw.c b/drivers/staging/fsl-dpaa2/ethsw/dpsw.c
index 024da81226cd..aebf2a0f4e03 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/dpsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/dpsw.c
@@ -705,6 +705,47 @@ int dpsw_if_disable(struct fsl_mc_io *mc_io,
 }
 
 /**
+ * dpsw_if_get_attributes() - Function obtains attributes of interface
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPSW object
+ * @if_id:	Interface Identifier
+ * @attr:	Returned interface attributes
+ *
+ * Return:	Completion status. '0' on Success; Error code otherwise.
+ */
+int dpsw_if_get_attributes(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
+			   u16 if_id, struct dpsw_if_attr *attr)
+{
+	struct dpsw_rsp_if_get_attr *rsp_params;
+	struct fsl_mc_command cmd = { 0 };
+	struct dpsw_cmd_if *cmd_params;
+	int err;
+
+	cmd.header = mc_encode_cmd_header(DPSW_CMDID_IF_GET_ATTR, cmd_flags,
+					  token);
+	cmd_params = (struct dpsw_cmd_if *)cmd.params;
+	cmd_params->if_id = cpu_to_le16(if_id);
+
+	err = mc_send_command(mc_io, &cmd);
+	if (err)
+		return err;
+
+	rsp_params = (struct dpsw_rsp_if_get_attr *)cmd.params;
+	attr->num_tcs = rsp_params->num_tcs;
+	attr->rate = le32_to_cpu(rsp_params->rate);
+	attr->options = le32_to_cpu(rsp_params->options);
+	attr->qdid = le16_to_cpu(rsp_params->qdid);
+	attr->enabled = dpsw_get_field(rsp_params->conf, ENABLED);
+	attr->accept_all_vlan = dpsw_get_field(rsp_params->conf,
+					       ACCEPT_ALL_VLAN);
+	attr->admit_untagged = dpsw_get_field(rsp_params->conf,
+					      ADMIT_UNTAGGED);
+
+	return 0;
+}
+
+/**
  * dpsw_if_set_max_frame_length() - Set Maximum Receive frame length.
  * @mc_io:		Pointer to MC portal's I/O object
  * @cmd_flags:		Command flags; one or more of 'MC_CMD_FLAG_'
diff --git a/drivers/staging/fsl-dpaa2/ethsw/dpsw.h b/drivers/staging/fsl-dpaa2/ethsw/dpsw.h
index beacd5a56553..f22f5ad4448a 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/dpsw.h
+++ b/drivers/staging/fsl-dpaa2/ethsw/dpsw.h
@@ -441,6 +441,33 @@ int dpsw_if_disable(struct fsl_mc_io *mc_io,
 		    u32 cmd_flags,
 		    u16 token,
 		    u16 if_id);
+/**
+ * struct dpsw_if_attr - Structure representing DPSW interface attributes
+ * @num_tcs: Number of traffic classes
+ * @rate: Transmit rate in bits per second
+ * @options: Interface configuration options (bitmap)
+ * @enabled: Indicates if interface is enabled
+ * @accept_all_vlan: The device discards/accepts incoming frames
+ *		for VLANs that do not include this interface
+ * @admit_untagged: When set to 'DPSW_ADMIT_ONLY_VLAN_TAGGED', the device
+ *		discards untagged frames or priority-tagged frames received on
+ *		this interface;
+ *		When set to 'DPSW_ADMIT_ALL', untagged frames or priority-
+ *		tagged frames received on this interface are accepted
+ * @qdid: control frames transmit qdid
+ */
+struct dpsw_if_attr {
+	u8 num_tcs;
+	u32 rate;
+	u32 options;
+	int enabled;
+	int accept_all_vlan;
+	enum dpsw_accepted_frames admit_untagged;
+	u16 qdid;
+};
+
+int dpsw_if_get_attributes(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
+			   u16 if_id, struct dpsw_if_attr *attr);
 
 int dpsw_if_set_max_frame_length(struct fsl_mc_io *mc_io,
 				 u32 cmd_flags,
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index 75e4b3b8c84c..abe920f8a665 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -455,6 +455,7 @@ static int port_change_mtu(struct net_device *netdev, int mtu)
 static int port_carrier_state_sync(struct net_device *netdev)
 {
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
+	struct ethsw_core *ethsw = port_priv->ethsw_data;
 	struct dpsw_link_state state;
 	int err;
 
@@ -469,10 +470,15 @@ static int port_carrier_state_sync(struct net_device *netdev)
 	WARN_ONCE(state.up > 1, "Garbage read into link_state");
 
 	if (state.up != port_priv->link_state) {
-		if (state.up)
+		if (state.up) {
 			netif_carrier_on(netdev);
-		else
+			if (ethsw_has_ctrl_if(ethsw))
+				netif_tx_start_all_queues(netdev);
+		} else {
 			netif_carrier_off(netdev);
+			if (ethsw_has_ctrl_if(ethsw))
+				netif_tx_stop_all_queues(netdev);
+		}
 		port_priv->link_state = state.up;
 	}
 	return 0;
@@ -525,8 +531,10 @@ static int port_open(struct net_device *netdev)
 	struct ethsw_core *ethsw = port_priv->ethsw_data;
 	int err;
 
-	/* No need to allow Tx as control interface is disabled */
-	netif_tx_stop_all_queues(netdev);
+	if (!ethsw_has_ctrl_if(port_priv->ethsw_data)) {
+		/* No need to allow Tx as control interface is disabled */
+		netif_tx_stop_all_queues(netdev);
+	}
 
 	err = dpsw_if_enable(port_priv->ethsw_data->mc_io, 0,
 			     port_priv->ethsw_data->dpsw_handle,
@@ -574,15 +582,6 @@ static int port_stop(struct net_device *netdev)
 	return 0;
 }
 
-static netdev_tx_t port_dropframe(struct sk_buff *skb,
-				  struct net_device *netdev)
-{
-	/* we don't support I/O for now, drop the frame */
-	dev_kfree_skb_any(skb);
-
-	return NETDEV_TX_OK;
-}
-
 static int swdev_get_port_parent_id(struct net_device *dev,
 				    struct netdev_phys_item_id *ppid)
 {
@@ -759,6 +758,114 @@ static void ethsw_free_fd(const struct ethsw_core *ethsw,
 	dev_kfree_skb(skb);
 }
 
+static int ethsw_build_single_fd(struct ethsw_core *ethsw,
+				 struct sk_buff *skb,
+				 struct dpaa2_fd *fd)
+{
+	struct device *dev = ethsw->dev;
+	struct sk_buff **skbh;
+	dma_addr_t addr;
+	u8 *buff_start;
+	void *hwa;
+
+	buff_start = PTR_ALIGN(skb->data - DPAA2_ETHSW_TX_DATA_OFFSET -
+			       DPAA2_ETHSW_TX_BUF_ALIGN,
+			       DPAA2_ETHSW_TX_BUF_ALIGN);
+
+	/* Clear FAS to have consistent values for TX confirmation. It is
+	 * located in the first 8 bytes of the buffer's hardware annotation
+	 * area
+	 */
+	hwa = buff_start + DPAA2_ETHSW_SWA_SIZE;
+	memset(hwa, 0, 8);
+
+	/* Store a backpointer to the skb at the beginning of the buffer
+	 * (in the private data area) such that we can release it
+	 * on Tx confirm
+	 */
+	skbh = (struct sk_buff **)buff_start;
+	*skbh = skb;
+
+	addr = dma_map_single(dev, buff_start,
+			      skb_tail_pointer(skb) - buff_start,
+			      DMA_TO_DEVICE);
+	if (unlikely(dma_mapping_error(dev, addr)))
+		return -ENOMEM;
+
+	/* Setup the FD fields */
+	memset(fd, 0, sizeof(*fd));
+
+	dpaa2_fd_set_addr(fd, addr);
+	dpaa2_fd_set_offset(fd, (u16)(skb->data - buff_start));
+	dpaa2_fd_set_len(fd, skb->len);
+	dpaa2_fd_set_format(fd, dpaa2_fd_single);
+
+	return 0;
+}
+
+static netdev_tx_t ethsw_port_tx(struct sk_buff *skb,
+				 struct net_device *net_dev)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(net_dev);
+	struct ethsw_core *ethsw = port_priv->ethsw_data;
+	int retries = DPAA2_ETHSW_SWP_BUSY_RETRIES;
+	struct dpaa2_fd fd;
+	int err;
+
+	if (!ethsw_has_ctrl_if(ethsw))
+		goto err_free_skb;
+
+	if (unlikely(skb_headroom(skb) < DPAA2_ETHSW_NEEDED_HEADROOM)) {
+		struct sk_buff *ns;
+
+		ns = skb_realloc_headroom(skb, DPAA2_ETHSW_NEEDED_HEADROOM);
+		if (unlikely(!ns)) {
+			netdev_err(net_dev, "Error reallocating skb headroom\n");
+			goto err_free_skb;
+		}
+		dev_kfree_skb(skb);
+		skb = ns;
+	}
+
+	/* We'll be holding a back-reference to the skb until Tx confirmation */
+	skb = skb_unshare(skb, GFP_ATOMIC);
+	if (unlikely(!skb)) {
+		/* skb_unshare() has already freed the skb */
+		netdev_err(net_dev, "Error copying the socket buffer\n");
+		goto err_exit;
+	}
+
+	if (skb_is_nonlinear(skb)) {
+		netdev_err(net_dev, "No support for non-linear SKBs!\n");
+		goto err_free_skb;
+	}
+
+	err = ethsw_build_single_fd(ethsw, skb, &fd);
+	if (unlikely(err)) {
+		netdev_err(net_dev, "ethsw_build_*_fd() %d\n", err);
+		goto err_free_skb;
+	}
+
+	do {
+		err = dpaa2_io_service_enqueue_qd(NULL,
+						  port_priv->tx_qdid,
+						  8, 0, &fd);
+		retries--;
+	} while (err == -EBUSY && retries);
+
+	if (unlikely(err < 0)) {
+		ethsw_free_fd(ethsw, &fd);
+		goto err_exit;
+	}
+
+	return NETDEV_TX_OK;
+
+err_free_skb:
+	dev_kfree_skb(skb);
+err_exit:
+	return NETDEV_TX_OK;
+}
+
 static const struct net_device_ops ethsw_port_ops = {
 	.ndo_open		= port_open,
 	.ndo_stop		= port_stop,
@@ -772,7 +879,7 @@ static void ethsw_free_fd(const struct ethsw_core *ethsw,
 	.ndo_fdb_del		= port_fdb_del,
 	.ndo_fdb_dump		= port_fdb_dump,
 
-	.ndo_start_xmit		= port_dropframe,
+	.ndo_start_xmit		= ethsw_port_tx,
 	.ndo_get_port_parent_id	= swdev_get_port_parent_id,
 	.ndo_get_phys_port_name = port_get_phys_name,
 };
@@ -2185,6 +2292,7 @@ static int ethsw_port_init(struct ethsw_port_priv *port_priv, u16 port)
 	struct ethsw_core *ethsw = port_priv->ethsw_data;
 	struct net_device *netdev = port_priv->netdev;
 	struct dpsw_acl_if_cfg acl_if_cfg;
+	struct dpsw_if_attr dpsw_if_attr;
 	struct dpsw_vlan_if_cfg vcfg;
 	struct dpsw_acl_cfg acl_cfg;
 	int err;
@@ -2234,6 +2342,14 @@ static int ethsw_port_init(struct ethsw_port_priv *port_priv, u16 port)
 	if (err)
 		goto err_remove_acl_if;
 
+	err = dpsw_if_get_attributes(ethsw->mc_io, 0, ethsw->dpsw_handle,
+				     port_priv->idx, &dpsw_if_attr);
+	if (err) {
+		netdev_err(netdev, "dpsw_if_get_attributes err %d\n", err);
+		goto err_remove_acl_if;
+	}
+	port_priv->tx_qdid = dpsw_if_attr.qdid;
+
 	return 0;
 
 err_remove_acl_if:
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.h b/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
index b585d06be105..747a4e15d28a 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
@@ -72,6 +72,19 @@
  */
 #define DPAA2_ETHSW_SWP_BUSY_RETRIES	1000
 
+/* Hardware annotation buffer size */
+#define DPAA2_ETHSW_HWA_SIZE		64
+/* Software annotation buffer size */
+#define DPAA2_ETHSW_SWA_SIZE		64
+
+#define DPAA2_ETHSW_TX_BUF_ALIGN	64
+
+#define DPAA2_ETHSW_TX_DATA_OFFSET \
+	(DPAA2_ETHSW_HWA_SIZE + DPAA2_ETHSW_SWA_SIZE)
+
+#define DPAA2_ETHSW_NEEDED_HEADROOM \
+	(DPAA2_ETHSW_TX_DATA_OFFSET + DPAA2_ETHSW_TX_BUF_ALIGN)
+
 extern const struct ethtool_ops ethsw_port_ethtool_ops;
 
 struct ethsw_core;
@@ -100,6 +113,7 @@ struct ethsw_port_priv {
 	struct net_device	*bridge_dev;
 	u16			acl_id;
 	u8			acl_cnt;
+	u16			tx_qdid;
 };
 
 /* Switch data */
-- 
1.9.1

