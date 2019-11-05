Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A31AC010A2
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 059822190F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388800AbfKEMfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 07:35:15 -0500
Received: from inva020.nxp.com ([92.121.34.13]:59550 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388551AbfKEMfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 07:35:01 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 94D6D1A0527;
        Tue,  5 Nov 2019 13:34:57 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 86C581A0524;
        Tue,  5 Nov 2019 13:34:57 +0100 (CET)
Received: from fsr-ub1464-137.ea.freescale.net (fsr-ub1464-137.ea.freescale.net [10.171.82.114])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 50DC0205ED;
        Tue,  5 Nov 2019 13:34:57 +0100 (CET)
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     andrew@lunn.ch, f.fainelli@gmail.com,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 06/12] staging: dpaa2-ethsw: add ACL entry to redirect STP to CPU
Date:   Tue,  5 Nov 2019 14:34:29 +0200
Message-Id: <1572957275-23383-7-git-send-email-ioana.ciornei@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1572957275-23383-1-git-send-email-ioana.ciornei@nxp.com>
References: <1572957275-23383-1-git-send-email-ioana.ciornei@nxp.com>
Reply-to: ioana.ciornei@nxp.com
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the moment, only STP is redirected to the CPU. Add the necessary
ACL entry to match on the destination MAC address of the protocol.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h | 50 ++++++++++++++++
 drivers/staging/fsl-dpaa2/ethsw/dpsw.c     | 81 +++++++++++++++++++++++++
 drivers/staging/fsl-dpaa2/ethsw/dpsw.h     | 94 ++++++++++++++++++++++++++++++
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c    | 83 +++++++++++++++++++++++++-
 drivers/staging/fsl-dpaa2/ethsw/ethsw.h    |  5 ++
 5 files changed, 311 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h b/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h
index 00244c6d39c9..7f8ad27f8db6 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h
+++ b/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h
@@ -73,6 +73,7 @@
 
 #define DPSW_CMDID_ACL_ADD                  DPSW_CMD_ID(0x090)
 #define DPSW_CMDID_ACL_REMOVE               DPSW_CMD_ID(0x091)
+#define DPSW_CMDID_ACL_ADD_ENTRY            DPSW_CMD_ID(0x092)
 #define DPSW_CMDID_ACL_ADD_IF               DPSW_CMD_ID(0x094)
 #define DPSW_CMDID_ACL_REMOVE_IF            DPSW_CMD_ID(0x095)
 
@@ -418,6 +419,55 @@ struct dpsw_cmd_acl_remove {
 	__le16 acl_id;
 };
 
+struct dpsw_prep_acl_entry {
+	u8 match_l2_dest_mac[ETH_ALEN];
+	__le16 match_l2_tpid;
+
+	u8 match_l2_source_mac[ETH_ALEN];
+	__le16 match_l2_vlan_id;
+
+	__le32 match_l3_dest_ip;
+	__le32 match_l3_source_ip;
+
+	__le16 match_l4_dest_port;
+	__le16 match_l4_source_port;
+	__le16 match_l2_ether_type;
+	u8 match_l2_pcp_dei;
+	u8 match_l3_dscp;
+
+	u8 mask_l2_dest_mac[ETH_ALEN];
+	__le16 mask_l2_tpid;
+
+	u8 mask_l2_source_mac[ETH_ALEN];
+	__le16 mask_l2_vlan_id;
+
+	__le32 mask_l3_dest_ip;
+	__le32 mask_l3_source_ip;
+
+	__le16 mask_l4_dest_port;
+	__le16 mask_l4_source_port;
+	__le16 mask_l2_ether_type;
+	u8 mask_l2_pcp_dei;
+	u8 mask_l3_dscp;
+
+	u8 match_l3_protocol;
+	u8 mask_l3_protocol;
+};
+
+#define DPSW_RESULT_ACTION_SHIFT	0
+#define DPSW_RESULT_ACTION_SIZE		4
+
+struct dpsw_cmd_acl_entry {
+	__le16 acl_id;
+	__le16 result_if_id;
+	__le32 precedence;
+	/* from LSB only the first 4 bits */
+	u8 result_action;
+	u8 pad[7];
+	__le64 pad2[4];
+	__le64 key_iova;
+};
+
 struct dpsw_cmd_acl_if {
 	/* cmd word 0 */
 	__le16 acl_id;
diff --git a/drivers/staging/fsl-dpaa2/ethsw/dpsw.c b/drivers/staging/fsl-dpaa2/ethsw/dpsw.c
index d9e27f0e9edb..024da81226cd 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/dpsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/dpsw.c
@@ -1336,6 +1336,87 @@ int dpsw_acl_remove(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 }
 
 /**
+ * dpsw_acl_prepare_entry_cfg() - Prepare an ACL entry
+ * @key:		Key
+ * @entry_cfg_buf:	Zeroed 256 bytes of memory before mapping it to DMA
+ *
+ * This function has to be called before adding or removing an ACL entry
+ */
+void dpsw_acl_prepare_entry_cfg(const struct dpsw_acl_key *key,
+				u8 *entry_cfg_buf)
+{
+	struct dpsw_prep_acl_entry *entry;
+	int i;
+
+	entry = (struct dpsw_prep_acl_entry *)entry_cfg_buf;
+
+	for (i = 0; i < ETH_ALEN; i++) {
+		entry->match_l2_dest_mac[i] =
+			key->match.l2_dest_mac[ETH_ALEN - 1 - i];
+		entry->match_l2_source_mac[i] =
+			key->match.l2_source_mac[ETH_ALEN - 1 - i];
+		entry->mask_l2_dest_mac[i] =
+			key->mask.l2_dest_mac[ETH_ALEN - 1 - i];
+		entry->mask_l2_source_mac[i] =
+			key->mask.l2_source_mac[ETH_ALEN - 1 - i];
+	}
+
+	entry->match_l2_tpid = cpu_to_le16(key->match.l2_tpid);
+	entry->match_l2_vlan_id = cpu_to_le16(key->match.l2_vlan_id);
+	entry->match_l3_dest_ip = cpu_to_le32(key->match.l3_dest_ip);
+	entry->match_l3_source_ip = cpu_to_le32(key->match.l3_source_ip);
+	entry->match_l4_dest_port = cpu_to_le16(key->match.l4_dest_port);
+	entry->match_l4_source_port = cpu_to_le16(key->match.l4_source_port);
+	entry->match_l2_ether_type = cpu_to_le16(key->match.l2_ether_type);
+	entry->match_l2_pcp_dei = key->match.l2_pcp_dei;
+	entry->match_l3_dscp = key->match.l3_dscp;
+	entry->match_l3_protocol = key->match.l3_protocol;
+
+	entry->mask_l2_tpid = cpu_to_le16(key->mask.l2_tpid);
+	entry->mask_l2_vlan_id = cpu_to_le16(key->mask.l2_vlan_id);
+	entry->mask_l3_dest_ip = cpu_to_le32(key->mask.l3_dest_ip);
+	entry->mask_l3_source_ip = cpu_to_le32(key->mask.l3_source_ip);
+	entry->mask_l4_dest_port = cpu_to_le16(key->mask.l4_dest_port);
+	entry->mask_l4_source_port = cpu_to_le16(key->mask.l4_source_port);
+	entry->mask_l2_ether_type = cpu_to_le16(key->mask.l2_ether_type);
+	entry->mask_l2_pcp_dei = key->mask.l2_pcp_dei;
+	entry->mask_l3_dscp = key->mask.l3_dscp;
+	entry->mask_l3_protocol = key->mask.l3_protocol;
+}
+
+/**
+ * dpsw_acl_add_entry() - Add an entry to an ACL table
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPSW object
+ * @acl_id:	ACL ID
+ * @cfg:	Entry configuration
+ *
+ * Warning: This function has to be called after dpsw_acl_set_entry_cfg()
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpsw_acl_add_entry(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
+		       u16 acl_id, const struct dpsw_acl_entry_cfg *cfg)
+{
+	struct dpsw_cmd_acl_entry *cmd_params;
+	struct fsl_mc_command cmd = { 0 };
+
+	cmd.header = mc_encode_cmd_header(DPSW_CMDID_ACL_ADD_ENTRY,
+					  cmd_flags,
+					  token);
+	cmd_params = (struct dpsw_cmd_acl_entry *)cmd.params;
+	cmd_params->acl_id = cpu_to_le16(acl_id);
+	cmd_params->result_if_id = cpu_to_le16(cfg->result.if_id);
+	cmd_params->precedence = cpu_to_le32(cfg->precedence);
+	dpsw_set_field(cmd_params->result_action, RESULT_ACTION,
+		       cfg->result.action);
+	cmd_params->key_iova = cpu_to_le64(cfg->key_iova);
+
+	return mc_send_command(mc_io, &cmd);
+}
+
+/**
  * dpsw_acl_add_if() - Associate interface/interfaces with ACL.
  * @mc_io:	Pointer to MC portal's I/O object
  * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
diff --git a/drivers/staging/fsl-dpaa2/ethsw/dpsw.h b/drivers/staging/fsl-dpaa2/ethsw/dpsw.h
index 0726a5313c4e..beacd5a56553 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/dpsw.h
+++ b/drivers/staging/fsl-dpaa2/ethsw/dpsw.h
@@ -8,6 +8,8 @@
 #ifndef __FSL_DPSW_H
 #define __FSL_DPSW_H
 
+#include <linux/if_ether.h>
+
 /* Data Path L2-Switch API
  * Contains API for handling DPSW topology and functionality
  */
@@ -656,9 +658,101 @@ struct dpsw_acl_cfg {
 int dpsw_acl_add(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 		 u16 *acl_id, const struct dpsw_acl_cfg *cfg);
 
+/**
+ * struct dpsw_acl_fields - ACL fields.
+ * @l2_dest_mac: Destination MAC address: Multicast, Broadcast, Unicast,
+ *	slow protocols (MVRP, STP)
+ * @l2_source_mac: Source MAC address
+ * @l2_tpid: Layer 2 (Ethernet) protocol type, used to identify the following
+ *	protocols: MPLS, PTP, PFC, ARP, Jumbo frames, LLDP, IEEE802.1ae,
+ *	Q-in-Q, IPv4, IPv6, PPPoE
+ * @l2_pcp_dei: indicate which protocol is encapsulated in the payload
+ * @l2_vlan_id: layer 2 VLAN ID
+ * @l2_ether_type: layer 2 Ethernet type
+ * @l3_dscp: Layer 3 differentiated services code point
+ * @l3_protocol: Tells the Network layer at the destination host, to which
+ *	Protocol this packet belongs to. The following protocol are
+ *	supported: ICMP, IGMP, IPv4 (encapsulation), TCP, IPv6
+ *	(encapsulation), GRE, PTP
+ * @l3_source_ip: Source IPv4 IP
+ * @l3_dest_ip: Destination IPv4 IP
+ * @l4_source_port: Source TCP/UDP Port
+ * @l4_dest_port: Destination TCP/UDP Port
+ */
+struct dpsw_acl_fields {
+	u8 l2_dest_mac[ETH_ALEN];
+	u8 l2_source_mac[ETH_ALEN];
+	u16 l2_tpid;
+	u8 l2_pcp_dei;
+	u16 l2_vlan_id;
+	u16 l2_ether_type;
+	u8 l3_dscp;
+	u8 l3_protocol;
+	u32 l3_source_ip;
+	u32 l3_dest_ip;
+	u16 l4_source_port;
+	u16 l4_dest_port;
+};
+
+/**
+ * struct dpsw_acl_key - ACL key
+ * @match: Match fields
+ * @mask: Mask: b'1 - valid, b'0 don't care
+ */
+struct dpsw_acl_key {
+	struct dpsw_acl_fields match;
+	struct dpsw_acl_fields mask;
+};
+
+/**
+ * enum dpsw_acl_action
+ * @DPSW_ACL_ACTION_DROP: Drop frame
+ * @DPSW_ACL_ACTION_REDIRECT: Redirect to certain port
+ * @DPSW_ACL_ACTION_ACCEPT: Accept frame
+ * @DPSW_ACL_ACTION_REDIRECT_TO_CTRL_IF: Redirect to control interface
+ */
+enum dpsw_acl_action {
+	DPSW_ACL_ACTION_DROP,
+	DPSW_ACL_ACTION_REDIRECT,
+	DPSW_ACL_ACTION_ACCEPT,
+	DPSW_ACL_ACTION_REDIRECT_TO_CTRL_IF
+};
+
+/**
+ * struct dpsw_acl_result - ACL action
+ * @action: Action should be taken when ACL entry hit
+ * @if_id:  Interface IDs to redirect frame.
+ *	Valid only if DPSW_ACL_ACTION_REDIRECT selected as action
+ */
+struct dpsw_acl_result {
+	enum dpsw_acl_action action;
+	u16 if_id;
+};
+
+/**
+ * struct dpsw_acl_entry_cfg - ACL entry
+ * @key_iova: I/O virtual address of DMA-able memory filled with key after call
+ *	to dpsw_acl_prepare_entry_cfg()
+ * @result: Required action when entry hit occurs
+ * @precedence: Precedence inside ACL. 0 is lowest. This priority can not change
+ *	during the lifetime of a policy. It is user responsibility to
+ *	space the priorities according to consequent rule additions.
+ */
+struct dpsw_acl_entry_cfg {
+	u64 key_iova;
+	struct dpsw_acl_result result;
+	int precedence;
+};
+
 int dpsw_acl_remove(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 		    u16 acl_id);
 
+void dpsw_acl_prepare_entry_cfg(const struct dpsw_acl_key *key,
+				u8 *entry_cfg_buf);
+
+int dpsw_acl_add_entry(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
+		       u16 acl_id, const struct dpsw_acl_entry_cfg *cfg);
+
 /**
  * struct dpsw_acl_if_cfg - List of interfaces to associate with ACL table
  * @num_ifs: Number of interfaces
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index f3e339c5e9a1..72c6f6c6e66f 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -1681,6 +1681,78 @@ static int ethsw_init(struct fsl_mc_device *sw_dev)
 	return err;
 }
 
+/* Add an ACL to redirect frames with specific destination MAC address to
+ * control interface
+ */
+static int ethsw_acl_mac_to_ctr_if(struct ethsw_port_priv *port_priv,
+				   const char *mac)
+{
+	struct device *dev = port_priv->netdev->dev.parent;
+	struct net_device *netdev = port_priv->netdev;
+	struct dpsw_acl_entry_cfg acl_entry_cfg;
+	struct dpsw_acl_fields *acl_h, *acl_m;
+	struct dpsw_acl_key acl_key;
+	u8 *cmd_buff;
+	int err = 0;
+
+	acl_h = &acl_key.match;
+	acl_m = &acl_key.mask;
+
+	if (port_priv->acl_cnt >= DPAA2_ETHSW_PORT_MAX_ACL_ENTRIES) {
+		netdev_err(netdev, "ACL table full\n");
+		return -ENOMEM;
+	}
+
+	/* Match destination MAC address */
+	memset(&acl_key, 0, sizeof(acl_key));
+	ether_addr_copy(acl_h->l2_dest_mac, mac);
+	eth_broadcast_addr(acl_m->l2_dest_mac);
+
+	cmd_buff = kzalloc(DPAA2_ETHSW_PORT_ACL_KEY_SIZE, GFP_KERNEL);
+	if (!cmd_buff)
+		return -ENOMEM;
+	dpsw_acl_prepare_entry_cfg(&acl_key, cmd_buff);
+
+	/* Add entry */
+	memset(&acl_entry_cfg, 0, sizeof(acl_entry_cfg));
+	acl_entry_cfg.precedence = port_priv->acl_cnt;
+	acl_entry_cfg.result.action = DPSW_ACL_ACTION_REDIRECT_TO_CTRL_IF;
+
+	acl_entry_cfg.key_iova = dma_map_single(dev, cmd_buff,
+						DPAA2_ETHSW_PORT_ACL_KEY_SIZE,
+						DMA_TO_DEVICE);
+	if (unlikely(dma_mapping_error(dev, acl_entry_cfg.key_iova))) {
+		netdev_err(netdev, "DMA mapping failed\n");
+		err = -EFAULT;
+		goto err_map_key;
+	}
+
+	err = dpsw_acl_add_entry(port_priv->ethsw_data->mc_io, 0,
+				 port_priv->ethsw_data->dpsw_handle,
+				 port_priv->acl_id, &acl_entry_cfg);
+	if (err) {
+		netdev_err(netdev, "dpsw_acl_add_entry() failed %d\n", err);
+		goto err_add_entry;
+	}
+
+	port_priv->acl_cnt++;
+
+err_add_entry:
+	dma_unmap_single(dev, acl_entry_cfg.key_iova,
+			 DPAA2_ETHSW_PORT_ACL_KEY_SIZE, DMA_TO_DEVICE);
+err_map_key:
+	kfree(cmd_buff);
+
+	return err;
+}
+
+static int ethsw_port_set_ctrl_if_acl(struct ethsw_port_priv *port_priv)
+{
+	const char stp_mac[ETH_ALEN] = {0x01, 0x80, 0xC2, 0x00, 0x00, 0x00};
+
+	return ethsw_acl_mac_to_ctr_if(port_priv, stp_mac);
+}
+
 static int ethsw_port_init(struct ethsw_port_priv *port_priv, u16 port)
 {
 	struct ethsw_core *ethsw = port_priv->ethsw_data;
@@ -1728,12 +1800,19 @@ static int ethsw_port_init(struct ethsw_port_priv *port_priv, u16 port)
 			      port_priv->acl_id, &acl_if_cfg);
 	if (err) {
 		netdev_err(netdev, "dpsw_acl_add_if err %d\n", err);
-		goto err_acl_add;
+		goto err_remove_acl;
 	}
 
+	err = ethsw_port_set_ctrl_if_acl(port_priv);
+	if (err)
+		goto err_remove_acl_if;
+
 	return 0;
 
-err_acl_add:
+err_remove_acl_if:
+	dpsw_acl_remove_if(ethsw->mc_io, 0, ethsw->dpsw_handle,
+			   port_priv->acl_id, &acl_if_cfg);
+err_remove_acl:
 	dpsw_acl_remove(ethsw->mc_io, 0, ethsw->dpsw_handle,
 			port_priv->acl_id);
 
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.h b/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
index 3e1da3de0ca6..dfb8ce905250 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.h
@@ -21,6 +21,7 @@
 
 #include <soc/fsl/dpaa2-io.h>
 
+#include "dpsw-cmd.h"
 #include "dpsw.h"
 
 /* Number of IRQs supported */
@@ -53,7 +54,10 @@
 /* Dequeue store size */
 #define DPAA2_ETHSW_STORE_SIZE		16
 
+/* ACL related configuration points */
 #define DPAA2_ETHSW_PORT_MAX_ACL_ENTRIES	16
+#define DPAA2_ETHSW_PORT_ACL_KEY_SIZE \
+	sizeof(struct dpsw_prep_acl_entry)
 
 extern const struct ethtool_ops ethsw_port_ethtool_ops;
 
@@ -80,6 +84,7 @@ struct ethsw_port_priv {
 	u16			pvid;
 	struct net_device	*bridge_dev;
 	u16			acl_id;
+	u8			acl_cnt;
 };
 
 /* Switch data */
-- 
1.9.1

