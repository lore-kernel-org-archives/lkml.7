Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA75C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31A6B2184E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfDKM1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:27:19 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6158 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726812AbfDKM0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 08:26:47 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 272E96AB55FE636DD07D;
        Thu, 11 Apr 2019 20:26:43 +0800 (CST)
Received: from localhost.localdomain (10.67.212.132) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.408.0; Thu, 11 Apr 2019 20:26:33 +0800
From:   Huazhong Tan <tanhuazhong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Jian Shen <shenjian15@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>
Subject: [PATCH net-next 03/12] net: hns3: fix set port based VLAN for PF
Date:   Thu, 11 Apr 2019 20:25:22 +0800
Message-ID: <1554985531-1827-4-git-send-email-tanhuazhong@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554985531-1827-1-git-send-email-tanhuazhong@huawei.com>
References: <1554985531-1827-1-git-send-email-tanhuazhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.132]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

In original codes, ndo_set_vf_vlan() in hns3 driver was implemented
wrong. It adds or removes VLAN into VLAN filter for VF, but VF is
unaware of it.

Indeed, ndo_set_vf_vlan() is expected to enable or disable port based
VLAN (hardware inserts a specified VLAN tag to all TX packets for a
specified VF) . When enable port base VLAN, we use port based VLAN id
as VLAN filter entry. When disable port based VLAN, we use VLAN id of
VLAN device.

This patch fixes it for PF, enable/disable port based VLAN when calls
ndo_set_vf_vlan().

Fixes: 46a3df9f9718 ("net: hns3: Add HNS3 Acceleration Engine & Compatibility Layer Support")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 193 +++++++++++++++++++--
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |   5 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c |   3 -
 3 files changed, 180 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 1f3c41d..da5d512 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -6590,23 +6590,29 @@ int hclge_set_vlan_filter(struct hnae3_handle *handle, __be16 proto,
 {
 	struct hclge_vport *vport = hclge_get_vport(handle);
 	struct hclge_dev *hdev = vport->back;
+	bool writen_to_tbl = false;
+	int ret = 0;
 
-	return hclge_set_vlan_filter_hw(hdev, proto, vport->vport_id, vlan_id,
-					0, is_kill);
-}
-
-static int hclge_set_vf_vlan_filter(struct hnae3_handle *handle, int vfid,
-				    u16 vlan, u8 qos, __be16 proto)
-{
-	struct hclge_vport *vport = hclge_get_vport(handle);
-	struct hclge_dev *hdev = vport->back;
-
-	if ((vfid >= hdev->num_alloc_vfs) || (vlan > 4095) || (qos > 7))
-		return -EINVAL;
-	if (proto != htons(ETH_P_8021Q))
-		return -EPROTONOSUPPORT;
+	/* when port base vlan enabled, we use port base vlan as the vlan
+	 * filter entry. In this case, we don't update vlan filter table
+	 * when user add new vlan or remove exist vlan, just update the vport
+	 * vlan list. The vlan id in vlan list won't be writen in vlan filter
+	 * table until port base vlan disabled
+	 */
+	if (handle->port_base_vlan_state == HNAE3_PORT_BASE_VLAN_DISABLE) {
+		ret = hclge_set_vlan_filter_hw(hdev, proto, vport->vport_id,
+					       vlan_id, 0, is_kill);
+		writen_to_tbl = true;
+	}
 
-	return hclge_set_vlan_filter_hw(hdev, proto, vfid, vlan, qos, false);
+	if (!ret) {
+		if (is_kill)
+			hclge_rm_vport_vlan_table(vport, vlan_id, false);
+		else
+			hclge_add_vport_vlan_table(vport, vlan_id,
+						   writen_to_tbl);
+	}
+	return ret;
 }
 
 static int hclge_set_vlan_tx_offload_cfg(struct hclge_vport *vport)
@@ -6832,7 +6838,8 @@ static int hclge_init_vlan_config(struct hclge_dev *hdev)
 	return hclge_set_vlan_filter(handle, htons(ETH_P_8021Q), 0, false);
 }
 
-void hclge_add_vport_vlan_table(struct hclge_vport *vport, u16 vlan_id)
+void hclge_add_vport_vlan_table(struct hclge_vport *vport, u16 vlan_id,
+				bool writen_to_tbl)
 {
 	struct hclge_vport_vlan_cfg *vlan;
 
@@ -6844,12 +6851,29 @@ void hclge_add_vport_vlan_table(struct hclge_vport *vport, u16 vlan_id)
 	if (!vlan)
 		return;
 
-	vlan->hd_tbl_status = true;
+	vlan->hd_tbl_status = writen_to_tbl;
 	vlan->vlan_id = vlan_id;
 
 	list_add_tail(&vlan->node, &vport->vlan_list);
 }
 
+static void hclge_add_vport_all_vlan_table(struct hclge_vport *vport)
+{
+	struct hclge_vport_vlan_cfg *vlan, *tmp;
+	struct hclge_dev *hdev = vport->back;
+
+	list_for_each_entry_safe(vlan, tmp, &vport->vlan_list, node) {
+		if (!vlan->hd_tbl_status)
+			hclge_set_vlan_filter_hw(hdev,
+						 htons(ETH_P_8021Q),
+						 vport->vport_id,
+						 vlan->vlan_id, 0,
+						 false);
+
+		vlan->hd_tbl_status = true;
+	}
+}
+
 void hclge_rm_vport_vlan_table(struct hclge_vport *vport, u16 vlan_id,
 			       bool is_write_tbl)
 {
@@ -6928,6 +6952,141 @@ int hclge_en_hw_strip_rxvtag(struct hnae3_handle *handle, bool enable)
 	return hclge_set_vlan_rx_offload_cfg(vport);
 }
 
+static int hclge_update_vlan_filter_entries(struct hclge_vport *vport,
+					    u16 port_base_vlan_state,
+					    struct hclge_vlan_info *new_info,
+					    struct hclge_vlan_info *old_info)
+{
+	struct hclge_dev *hdev = vport->back;
+	int ret;
+
+	if (port_base_vlan_state == HNAE3_PORT_BASE_VLAN_ENABLE) {
+		hclge_rm_vport_all_vlan_table(vport, false);
+		return hclge_set_vlan_filter_hw(hdev,
+						 htons(new_info->vlan_proto),
+						 vport->vport_id,
+						 new_info->vlan_tag,
+						 new_info->qos, false);
+
+	} else {
+		ret = hclge_set_vlan_filter_hw(hdev,
+					       htons(old_info->vlan_proto),
+					       vport->vport_id,
+					       old_info->vlan_tag,
+					       old_info->qos, true);
+		if (ret)
+			return ret;
+
+		hclge_add_vport_all_vlan_table(vport);
+		return 0;
+	}
+}
+
+int hclge_update_port_base_vlan_cfg(struct hclge_vport *vport, u16 state,
+				    struct hclge_vlan_info *vlan_info)
+{
+	struct hnae3_handle *nic = &vport->nic;
+	struct hclge_vlan_info *old_vlan_info;
+	struct hclge_dev *hdev = vport->back;
+	int ret;
+
+	old_vlan_info = &vport->port_base_vlan_cfg.vlan_info;
+
+	ret = hclge_vlan_offload_cfg(vport, state, vlan_info->vlan_tag);
+	if (ret)
+		return ret;
+
+	if (state == HNAE3_PORT_BASE_VLAN_MODIFY) {
+		hclge_set_vlan_filter_hw(hdev, old_vlan_info->vlan_proto,
+					 vport->vport_id,
+					 old_vlan_info->vlan_tag,
+					 old_vlan_info->qos, true);
+		hclge_set_vlan_filter_hw(hdev, vlan_info->vlan_proto,
+					 vport->vport_id, vlan_info->vlan_tag,
+					 vlan_info->qos, false);
+		goto update;
+	}
+
+	ret = hclge_update_vlan_filter_entries(vport, state, vlan_info,
+					       old_vlan_info);
+	if (ret)
+		return ret;
+
+	/* update state only when disable/enable port base vlan */
+	vport->port_base_vlan_cfg.state = state;
+	if (state == HNAE3_PORT_BASE_VLAN_DISABLE)
+		nic->port_base_vlan_state = HNAE3_PORT_BASE_VLAN_DISABLE;
+	else
+		nic->port_base_vlan_state = HNAE3_PORT_BASE_VLAN_ENABLE;
+
+update:
+	vport->port_base_vlan_cfg.vlan_info.vlan_tag = vlan_info->vlan_tag;
+	vport->port_base_vlan_cfg.vlan_info.qos = vlan_info->qos;
+	vport->port_base_vlan_cfg.vlan_info.vlan_proto = vlan_info->vlan_proto;
+
+	return 0;
+}
+
+static u16 hclge_get_port_base_vlan_state(struct hclge_vport *vport,
+					  enum hnae3_port_base_vlan_state state,
+					  u16 vlan)
+{
+	if (state == HNAE3_PORT_BASE_VLAN_DISABLE) {
+		if (!vlan)
+			return HNAE3_PORT_BASE_VLAN_NOCHANGE;
+		else
+			return HNAE3_PORT_BASE_VLAN_ENABLE;
+	} else {
+		if (!vlan)
+			return HNAE3_PORT_BASE_VLAN_DISABLE;
+		else if (vport->port_base_vlan_cfg.vlan_info.vlan_tag == vlan)
+			return HNAE3_PORT_BASE_VLAN_NOCHANGE;
+		else
+			return HNAE3_PORT_BASE_VLAN_MODIFY;
+	}
+}
+
+static int hclge_set_vf_vlan_filter(struct hnae3_handle *handle, int vfid,
+				    u16 vlan, u8 qos, __be16 proto)
+{
+	struct hclge_vport *vport = hclge_get_vport(handle);
+	struct hclge_dev *hdev = vport->back;
+	struct hclge_vlan_info vlan_info;
+	u16 state;
+	int ret;
+
+	if (hdev->pdev->revision == 0x20)
+		return -EOPNOTSUPP;
+
+	/* qos is a 3 bits value, so can not be bigger than 7 */
+	if (vfid >= hdev->num_alloc_vfs || vlan > VLAN_N_VID - 1 || qos > 7)
+		return -EINVAL;
+	if (proto != htons(ETH_P_8021Q))
+		return -EPROTONOSUPPORT;
+
+	vport = &hdev->vport[vfid];
+	state = hclge_get_port_base_vlan_state(vport,
+					       vport->port_base_vlan_cfg.state,
+					       vlan);
+	if (state == HNAE3_PORT_BASE_VLAN_NOCHANGE)
+		return 0;
+
+	vlan_info.vlan_tag = vlan;
+	vlan_info.qos = qos;
+	vlan_info.vlan_proto = ntohs(proto);
+
+	/* update port base vlan for pf */
+	if (!vfid) {
+		hclge_notify_client(hdev, HNAE3_DOWN_CLIENT);
+		ret = hclge_update_port_base_vlan_cfg(vport, state, &vlan_info);
+		hclge_notify_client(hdev, HNAE3_UP_CLIENT);
+
+		return ret;
+	}
+
+	return -EOPNOTSUPP;
+}
+
 static int hclge_set_mac_mtu(struct hclge_dev *hdev, int new_mps)
 {
 	struct hclge_config_max_frm_size_cmd *req;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index 4c7ea9f..cc2ef52 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -937,9 +937,12 @@ void hclge_rm_vport_mac_table(struct hclge_vport *vport, const u8 *mac_addr,
 void hclge_rm_vport_all_mac_table(struct hclge_vport *vport, bool is_del_list,
 				  enum HCLGE_MAC_ADDR_TYPE mac_type);
 void hclge_uninit_vport_mac_table(struct hclge_dev *hdev);
-void hclge_add_vport_vlan_table(struct hclge_vport *vport, u16 vlan_id);
+void hclge_add_vport_vlan_table(struct hclge_vport *vport, u16 vlan_id,
+				bool writen_to_tbl);
 void hclge_rm_vport_vlan_table(struct hclge_vport *vport, u16 vlan_id,
 			       bool is_write_tbl);
 void hclge_rm_vport_all_vlan_table(struct hclge_vport *vport, bool is_del_list);
 void hclge_uninit_vport_vlan_table(struct hclge_dev *hdev);
+int hclge_update_port_base_vlan_cfg(struct hclge_vport *vport, u16 state,
+				    struct hclge_vlan_info *vlan_info);
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
index 9aa9c64..fddbbca 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
@@ -305,9 +305,6 @@ static int hclge_set_vf_vlan_cfg(struct hclge_vport *vport,
 		memcpy(&proto, &mbx_req->msg[5], sizeof(proto));
 		status = hclge_set_vlan_filter(handle, cpu_to_be16(proto),
 					       vlan, is_kill);
-		if (!status)
-			is_kill ? hclge_rm_vport_vlan_table(vport, vlan, false)
-			: hclge_add_vport_vlan_table(vport, vlan);
 	} else if (mbx_req->msg[1] == HCLGE_MBX_VLAN_RX_OFF_CFG) {
 		struct hnae3_handle *handle = &vport->nic;
 		bool en = mbx_req->msg[2] ? true : false;
-- 
2.7.4

