Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E84C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17109206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfDZJnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:43:14 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7695 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726173AbfDZJnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:43:12 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id F13C997FC6F297A7FB77;
        Fri, 26 Apr 2019 17:43:09 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Fri, 26 Apr 2019 17:42:59 +0800
From:   Jian Shen <shenjian15@huawei.com>
To:     <andrew@lunn.ch>, <f.fainelli@gmail.com>, <hkallweit1@gmail.com>,
        <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH topic-hns-5.1 1/3] {topost} net: hns3: add support for multiple media type
Date:   Fri, 26 Apr 2019 17:42:41 +0800
Message-ID: <1556271763-24142-2-git-send-email-shenjian15@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556271763-24142-1-git-send-email-shenjian15@huawei.com>
References: <1556271763-24142-1-git-send-email-shenjian15@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.71.200.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, we can only identify copper and fiber type. This
patch adds supports for multiple media types, include SR, LR
CR, KR. Driver needs to query the media type periodic, and
update the port information.

Signed-off-by: Jian Shen <shenjian15@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        |  18 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c |  13 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h |  14 +-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 231 +++++++++++++++++----
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |   9 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c |   7 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |  14 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h  |   1 +
 8 files changed, 242 insertions(+), 65 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index 0a7da02..926889a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -114,6 +114,18 @@ enum hnae3_media_type {
 	HNAE3_MEDIA_TYPE_NONE,
 };
 
+/* must be consistent with definition in firmware */
+enum hnae3_module_type {
+	HNAE3_MODULE_TYPE_UNKNOWN	= 0x00,
+	HNAE3_MODULE_TYPE_FIBRE_LR	= 0x01,
+	HNAE3_MODULE_TYPE_FIBRE_SR	= 0x02,
+	HNAE3_MODULE_TYPE_AOC		= 0x03,
+	HNAE3_MODULE_TYPE_CR		= 0x04,
+	HNAE3_MODULE_TYPE_KR		= 0x05,
+	HNAE3_MODULE_TYPE_TP		= 0x06,
+
+};
+
 enum hnae3_reset_notify_type {
 	HNAE3_UP_CLIENT,
 	HNAE3_DOWN_CLIENT,
@@ -222,8 +234,6 @@ struct hnae3_ae_dev {
  *   non-ok
  * get_ksettings_an_result()
  *   Get negotiation status,speed and duplex
- * update_speed_duplex_h()
- *   Update hardware speed and duplex
  * get_media_type()
  *   Get media type of MAC
  * adjust_link()
@@ -336,11 +346,11 @@ struct hnae3_ae_ops {
 	void (*get_ksettings_an_result)(struct hnae3_handle *handle,
 					u8 *auto_neg, u32 *speed, u8 *duplex);
 
-	int (*update_speed_duplex_h)(struct hnae3_handle *handle);
 	int (*cfg_mac_speed_dup_h)(struct hnae3_handle *handle, int speed,
 				   u8 duplex);
 
-	void (*get_media_type)(struct hnae3_handle *handle, u8 *media_type);
+	void (*get_media_type)(struct hnae3_handle *handle, u8 *media_type,
+			       u8 *module_type);
 	void (*adjust_link)(struct hnae3_handle *handle, int speed, int duplex);
 	int (*set_loopback)(struct hnae3_handle *handle,
 			    enum hnae3_loop loop_mode, bool en);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index 824d1c6..fe387a4 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -629,12 +629,13 @@ static int hns3_get_link_ksettings(struct net_device *netdev,
 {
 	struct hnae3_handle *h = hns3_get_handle(netdev);
 	const struct hnae3_ae_ops *ops;
+	u8 module_type;
 	u8 media_type;
 	u8 link_stat;
 
 	ops = h->ae_algo->ops;
 	if (ops->get_media_type)
-		ops->get_media_type(h, &media_type);
+		ops->get_media_type(h, &media_type, &module_type);
 	else
 		return -EOPNOTSUPP;
 
@@ -644,7 +645,15 @@ static int hns3_get_link_ksettings(struct net_device *netdev,
 		hns3_get_ksettings(h, cmd);
 		break;
 	case HNAE3_MEDIA_TYPE_FIBER:
-		cmd->base.port = PORT_FIBRE;
+		if (module_type == HNAE3_MODULE_TYPE_CR)
+			cmd->base.port = PORT_DA;
+		else
+			cmd->base.port = PORT_FIBRE;
+
+		hns3_get_ksettings(h, cmd);
+		break;
+	case HNAE3_MEDIA_TYPE_BACKPLANE:
+		cmd->base.port = PORT_NONE;
 		hns3_get_ksettings(h, cmd);
 		break;
 	case HNAE3_MEDIA_TYPE_COPPER:
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
index 53aa94e..5c82e11 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
@@ -246,7 +246,7 @@ enum hclge_opcode_type {
 	HCLGE_OPC_QUERY_NCL_CONFIG	= 0x7011,
 
 	/* SFP command */
-	HCLGE_OPC_SFP_GET_SPEED		= 0x7104,
+	HCLGE_OPC_GET_SFP_INFO		= 0x7104,
 
 	/* Error INT commands */
 	HCLGE_MAC_COMMON_INT_EN		= 0x030E,
@@ -602,9 +602,15 @@ struct hclge_config_auto_neg_cmd {
 	u8      rsv[20];
 };
 
-struct hclge_sfp_speed_cmd {
-	__le32	sfp_speed;
-	u32	rsv[5];
+struct hclge_sfp_info_cmd {
+	__le32 speed;
+	u8 query_type; /* 0: sfp speed, 1: active speed */
+	u8 active_fec;
+	u8 autoneg; /* autoneg state */
+	u8 autoneg_ability; /* whether support autoneg */
+	__le32 speed_ability; /* speed ability for current media */
+	__le32 module_type;
+	u8 rsv[8];
 };
 
 #define HCLGE_MAC_UPLINK_PORT		0x100
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index b957c92..c0f969e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -843,37 +843,112 @@ static int hclge_parse_speed(int speed_cmd, int *speed)
 	return 0;
 }
 
-static void hclge_parse_fiber_link_mode(struct hclge_dev *hdev,
-					u8 speed_ability)
+static void hclge_convert_setting_sr(struct hclge_mac *mac, u8 speed_ability)
 {
-	unsigned long *supported = hdev->hw.mac.supported;
-
-	if (speed_ability & HCLGE_SUPPORT_1G_BIT)
-		linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseX_Full_BIT,
-				 supported);
-
 	if (speed_ability & HCLGE_SUPPORT_10G_BIT)
 		linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseSR_Full_BIT,
-				 supported);
-
+				 mac->supported);
 	if (speed_ability & HCLGE_SUPPORT_25G_BIT)
 		linkmode_set_bit(ETHTOOL_LINK_MODE_25000baseSR_Full_BIT,
-				 supported);
-
+				 mac->supported);
 	if (speed_ability & HCLGE_SUPPORT_40G_BIT)
 		linkmode_set_bit(ETHTOOL_LINK_MODE_40000baseSR4_Full_BIT,
-				 supported);
-
+				 mac->supported);
 	if (speed_ability & HCLGE_SUPPORT_50G_BIT)
 		linkmode_set_bit(ETHTOOL_LINK_MODE_50000baseSR2_Full_BIT,
-				 supported);
-
+				 mac->supported);
 	if (speed_ability & HCLGE_SUPPORT_100G_BIT)
 		linkmode_set_bit(ETHTOOL_LINK_MODE_100000baseSR4_Full_BIT,
-				 supported);
+				 mac->supported);
+}
 
-	linkmode_set_bit(ETHTOOL_LINK_MODE_FIBRE_BIT, supported);
-	linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT, supported);
+static void hclge_convert_setting_lr(struct hclge_mac *mac, u8 speed_ability)
+{
+	if (speed_ability & HCLGE_SUPPORT_10G_BIT)
+		linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseLR_Full_BIT,
+				 mac->supported);
+	if (speed_ability & HCLGE_SUPPORT_25G_BIT)
+		linkmode_set_bit(ETHTOOL_LINK_MODE_25000baseSR_Full_BIT,
+				 mac->supported);
+	if (speed_ability & HCLGE_SUPPORT_50G_BIT)
+		linkmode_set_bit(ETHTOOL_LINK_MODE_50000baseLR_ER_FR_Full_BIT,
+				 mac->supported);
+	if (speed_ability & HCLGE_SUPPORT_40G_BIT)
+		linkmode_set_bit(ETHTOOL_LINK_MODE_40000baseLR4_Full_BIT,
+				 mac->supported);
+	if (speed_ability & HCLGE_SUPPORT_100G_BIT)
+		linkmode_set_bit(ETHTOOL_LINK_MODE_100000baseLR4_ER4_Full_BIT,
+				 mac->supported);
+}
+
+static void hclge_convert_setting_cr(struct hclge_mac *mac, u8 speed_ability)
+{
+	if (speed_ability & HCLGE_SUPPORT_10G_BIT)
+		linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseCR_Full_BIT,
+				 mac->supported);
+	if (speed_ability & HCLGE_SUPPORT_25G_BIT)
+		linkmode_set_bit(ETHTOOL_LINK_MODE_25000baseCR_Full_BIT,
+				 mac->supported);
+	if (speed_ability & HCLGE_SUPPORT_40G_BIT)
+		linkmode_set_bit(ETHTOOL_LINK_MODE_40000baseCR4_Full_BIT,
+				 mac->supported);
+	if (speed_ability & HCLGE_SUPPORT_50G_BIT)
+		linkmode_set_bit(ETHTOOL_LINK_MODE_50000baseCR2_Full_BIT,
+				 mac->supported);
+	if (speed_ability & HCLGE_SUPPORT_100G_BIT)
+		linkmode_set_bit(ETHTOOL_LINK_MODE_100000baseCR4_Full_BIT,
+				 mac->supported);
+}
+
+static void hclge_convert_setting_kr(struct hclge_mac *mac, u8 speed_ability)
+{
+	if (speed_ability & HCLGE_SUPPORT_1G_BIT)
+		linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseKX_Full_BIT,
+				 mac->supported);
+	if (speed_ability & HCLGE_SUPPORT_10G_BIT)
+		linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseKR_Full_BIT,
+				 mac->supported);
+	if (speed_ability & HCLGE_SUPPORT_25G_BIT)
+		linkmode_set_bit(ETHTOOL_LINK_MODE_25000baseKR_Full_BIT,
+				 mac->supported);
+	if (speed_ability & HCLGE_SUPPORT_40G_BIT)
+		linkmode_set_bit(ETHTOOL_LINK_MODE_40000baseKR4_Full_BIT,
+				 mac->supported);
+	if (speed_ability & HCLGE_SUPPORT_50G_BIT)
+		linkmode_set_bit(ETHTOOL_LINK_MODE_50000baseKR2_Full_BIT,
+				 mac->supported);
+	if (speed_ability & HCLGE_SUPPORT_100G_BIT)
+		linkmode_set_bit(ETHTOOL_LINK_MODE_100000baseKR4_Full_BIT,
+				 mac->supported);
+}
+
+static void hclge_parse_fiber_link_mode(struct hclge_dev *hdev,
+					u8 speed_ability)
+{
+	struct hclge_mac *mac = &hdev->hw.mac;
+
+	if (speed_ability & HCLGE_SUPPORT_1G_BIT)
+		linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseX_Full_BIT,
+				 mac->supported);
+
+	hclge_convert_setting_sr(mac, speed_ability);
+	hclge_convert_setting_lr(mac, speed_ability);
+	hclge_convert_setting_cr(mac, speed_ability);
+
+	linkmode_set_bit(ETHTOOL_LINK_MODE_FIBRE_BIT, mac->supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT, mac->supported);
+	linkmode_copy(mac->advertising, mac->supported);
+}
+
+static void hclge_parse_backplane_link_mode(struct hclge_dev *hdev,
+					    u8 speed_ability)
+{
+	struct hclge_mac *mac = &hdev->hw.mac;
+
+	hclge_convert_setting_kr(mac, speed_ability);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_Backplane_BIT, mac->supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT, mac->supported);
+	linkmode_copy(mac->advertising, mac->supported);
 }
 
 static void hclge_parse_copper_link_mode(struct hclge_dev *hdev,
@@ -914,6 +989,8 @@ static void hclge_parse_link_mode(struct hclge_dev *hdev, u8 speed_ability)
 		hclge_parse_fiber_link_mode(hdev, speed_ability);
 	else if (media_type == HNAE3_MEDIA_TYPE_COPPER)
 		hclge_parse_copper_link_mode(hdev, speed_ability);
+	else if (media_type == HNAE3_MEDIA_TYPE_BACKPLANE)
+		hclge_parse_backplane_link_mode(hdev, speed_ability);
 }
 
 static void hclge_parse_cfg(struct hclge_cfg *cfg, struct hclge_desc *desc)
@@ -2252,14 +2329,33 @@ static void hclge_update_link_status(struct hclge_dev *hdev)
 	}
 }
 
+static void hclge_update_port_capability(struct hclge_mac *mac)
+{
+	/* firmware can not identify back plane type, the media type
+	 * read from configuration can help deal it
+	 */
+	if (mac->media_type == HNAE3_MEDIA_TYPE_BACKPLANE &&
+	    mac->module_type == HNAE3_MODULE_TYPE_UNKNOWN)
+		mac->module_type = HNAE3_MODULE_TYPE_KR;
+	else if (mac->media_type == HNAE3_MEDIA_TYPE_COPPER)
+		mac->module_type = HNAE3_MODULE_TYPE_TP;
+
+	if (mac->autoneg == AUTONEG_ENABLE)
+		linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, mac->supported);
+	else
+		linkmode_clear_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
+				   mac->supported);
+	linkmode_copy(mac->advertising, mac->supported);
+}
+
 static int hclge_get_sfp_speed(struct hclge_dev *hdev, u32 *speed)
 {
-	struct hclge_sfp_speed_cmd *resp;
+	struct hclge_sfp_info_cmd *resp;
 	struct hclge_desc desc;
 	int ret;
 
-	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_SFP_GET_SPEED, true);
-	resp = (struct hclge_sfp_speed_cmd *)desc.data;
+	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_GET_SFP_INFO, true);
+	resp = (struct hclge_sfp_info_cmd *)desc.data;
 	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
 	if (ret == -EOPNOTSUPP) {
 		dev_warn(&hdev->pdev->dev,
@@ -2270,28 +2366,67 @@ static int hclge_get_sfp_speed(struct hclge_dev *hdev, u32 *speed)
 		return ret;
 	}
 
-	*speed = resp->sfp_speed;
+	*speed = le32_to_cpu(resp->speed);
 
 	return 0;
 }
 
-static int hclge_update_speed_duplex(struct hclge_dev *hdev)
+static int hclge_get_sfp_info(struct hclge_dev *hdev, struct hclge_mac *mac)
 {
-	struct hclge_mac mac = hdev->hw.mac;
-	int speed;
+	struct hclge_sfp_info_cmd *resp;
+	struct hclge_desc desc;
 	int ret;
 
-	/* get the speed from SFP cmd when phy
-	 * doesn't exit.
+	hclge_cmd_setup_basic_desc(&desc, HCLGE_OPC_GET_SFP_INFO, true);
+	resp = (struct hclge_sfp_info_cmd *)desc.data;
+
+	resp->query_type = QUERY_ACTIVE_SPEED;
+
+	ret = hclge_cmd_send(&hdev->hw, &desc, 1);
+	if (ret == -EOPNOTSUPP) {
+		dev_warn(&hdev->pdev->dev,
+			 "IMP does not support get SFP info %d\n", ret);
+		return ret;
+	} else if (ret) {
+		dev_err(&hdev->pdev->dev, "get sfp info failed %d\n", ret);
+		return ret;
+	}
+
+	mac->speed = le32_to_cpu(resp->speed);
+	/* if resp->speed_ability is 0, it means it's an old version
+	 * firmware, do not update these params
 	 */
-	if (mac.phydev)
+	if (resp->speed_ability) {
+		mac->module_type = le32_to_cpu(resp->module_type);
+		mac->speed_ability = le32_to_cpu(resp->speed_ability);
+		mac->autoneg = resp->autoneg;
+		mac->support_autoneg = resp->autoneg_ability;
+	} else {
+		mac->speed_type = QUERY_SFP_SPEED;
+	}
+
+	return 0;
+}
+
+static int hclge_update_port_info(struct hclge_dev *hdev)
+{
+	struct hclge_mac *mac = &hdev->hw.mac;
+	int speed = HCLGE_MAC_SPEED_UNKNOWN;
+	int ret;
+
+	/* get the port info from SFP cmd if not copper port */
+	if (mac->media_type == HNAE3_MEDIA_TYPE_COPPER)
 		return 0;
 
-	/* if IMP does not support get SFP/qSFP speed, return directly */
+	/* if IMP does not support get SFP/qSFP info, return directly */
 	if (!hdev->support_sfp_query)
 		return 0;
 
-	ret = hclge_get_sfp_speed(hdev, &speed);
+	if (hdev->pdev->revision >= 0x21)
+		ret = hclge_get_sfp_info(hdev, mac);
+	else
+		ret = hclge_get_sfp_speed(hdev, &speed);
+
 	if (ret == -EOPNOTSUPP) {
 		hdev->support_sfp_query = false;
 		return ret;
@@ -2299,19 +2434,20 @@ static int hclge_update_speed_duplex(struct hclge_dev *hdev)
 		return ret;
 	}
 
-	if (speed == HCLGE_MAC_SPEED_UNKNOWN)
-		return 0; /* do nothing if no SFP */
-
-	/* must config full duplex for SFP */
-	return hclge_cfg_mac_speed_dup(hdev, speed, HCLGE_MAC_FULL);
-}
-
-static int hclge_update_speed_duplex_h(struct hnae3_handle *handle)
-{
-	struct hclge_vport *vport = hclge_get_vport(handle);
-	struct hclge_dev *hdev = vport->back;
+	if (hdev->pdev->revision >= 0x21) {
+		if (mac->speed_type == QUERY_ACTIVE_SPEED) {
+			hclge_update_port_capability(mac);
+			return 0;
+		}
+		return hclge_cfg_mac_speed_dup(hdev, mac->speed,
+					       HCLGE_MAC_FULL);
+	} else {
+		if (speed == HCLGE_MAC_SPEED_UNKNOWN)
+			return 0; /* do nothing if no SFP */
 
-	return hclge_update_speed_duplex(hdev);
+		/* must config full duplex for SFP */
+		return hclge_cfg_mac_speed_dup(hdev, speed, HCLGE_MAC_FULL);
+	}
 }
 
 static int hclge_get_status(struct hnae3_handle *handle)
@@ -3222,7 +3358,7 @@ static void hclge_service_task(struct work_struct *work)
 		hdev->hw_stats.stats_timer = 0;
 	}
 
-	hclge_update_speed_duplex(hdev);
+	hclge_update_port_info(hdev);
 	hclge_update_link_status(hdev);
 	hclge_update_vport_alive(hdev);
 	hclge_sync_vlan_filter(hdev);
@@ -7832,13 +7968,17 @@ static void hclge_get_ksettings_an_result(struct hnae3_handle *handle,
 		*auto_neg = hdev->hw.mac.autoneg;
 }
 
-static void hclge_get_media_type(struct hnae3_handle *handle, u8 *media_type)
+static void hclge_get_media_type(struct hnae3_handle *handle, u8 *media_type,
+				 u8 *module_type)
 {
 	struct hclge_vport *vport = hclge_get_vport(handle);
 	struct hclge_dev *hdev = vport->back;
 
 	if (media_type)
 		*media_type = hdev->hw.mac.media_type;
+
+	if (module_type)
+		*module_type = hdev->hw.mac.module_type;
 }
 
 static void hclge_get_mdix_mode(struct hnae3_handle *handle,
@@ -8934,7 +9074,6 @@ static int hclge_gro_en(struct hnae3_handle *handle, bool enable)
 	.client_stop = hclge_client_stop,
 	.get_status = hclge_get_status,
 	.get_ksettings_an_result = hclge_get_ksettings_an_result,
-	.update_speed_duplex_h = hclge_update_speed_duplex_h,
 	.cfg_mac_speed_dup_h = hclge_cfg_mac_speed_dup_h,
 	.get_media_type = hclge_get_media_type,
 	.get_rss_key_size = hclge_get_rss_key_size,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index 7c38acd..50d6ad0 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -240,14 +240,21 @@ enum HCLGE_MAC_DUPLEX {
 	HCLGE_MAC_FULL
 };
 
+#define QUERY_SFP_SPEED		0
+#define QUERY_ACTIVE_SPEED	1
+
 struct hclge_mac {
 	u8 phy_addr;
 	u8 flag;
-	u8 media_type;
+	u8 media_type;	/* port media type, e.g. fibre/copper/backplane */
 	u8 mac_addr[ETH_ALEN];
 	u8 autoneg;
 	u8 duplex;
+	u8 support_autoneg;
+	u8 speed_type;	/* 0: sfp speed, 1: active speed */
 	u32 speed;
+	u32 speed_ability; /* speed ability supported by current media */
+	u32 module_type; /* sub media type, e.g. kr/cr/sr/lr */
 	int link;	/* store the link status of mac & phy (if phy exit) */
 	struct phy_device *phydev;
 	struct mii_bus *mdio_bus;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
index 1122c99..2a7de3a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
@@ -413,10 +413,11 @@ static int hclge_get_vf_media_type(struct hclge_vport *vport,
 				   struct hclge_mbx_vf_to_pf_cmd *mbx_req)
 {
 	struct hclge_dev *hdev = vport->back;
-	u8 resp_data;
+	u8 resp_data[2];
 
-	resp_data = hdev->hw.mac.media_type;
-	return hclge_gen_resp_to_vf(vport, mbx_req, 0, &resp_data,
+	resp_data[0] = hdev->hw.mac.media_type;
+	resp_data[1] = hdev->hw.mac.module_type;
+	return hclge_gen_resp_to_vf(vport, mbx_req, 0, resp_data,
 				    sizeof(resp_data));
 }
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index d952384..5da522c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -328,11 +328,11 @@ static u16 hclgevf_get_qid_global(struct hnae3_handle *handle, u16 queue_id)
 
 static int hclgevf_get_pf_media_type(struct hclgevf_dev *hdev)
 {
-	u8 resp_msg;
+	u8 resp_msg[2];
 	int ret;
 
 	ret = hclgevf_send_mbx_msg(hdev, HCLGE_MBX_GET_MEDIA_TYPE, 0, NULL, 0,
-				   true, &resp_msg, sizeof(resp_msg));
+				   true, resp_msg, sizeof(resp_msg));
 	if (ret) {
 		dev_err(&hdev->pdev->dev,
 			"VF request to get the pf port media type failed %d",
@@ -340,7 +340,8 @@ static int hclgevf_get_pf_media_type(struct hclgevf_dev *hdev)
 		return ret;
 	}
 
-	hdev->hw.mac.media_type = resp_msg;
+	hdev->hw.mac.media_type = resp_msg[0];
+	hdev->hw.mac.module_type = resp_msg[1];
 
 	return 0;
 }
@@ -2793,13 +2794,16 @@ static int hclgevf_gro_en(struct hnae3_handle *handle, bool enable)
 	return hclgevf_config_gro(hdev, enable);
 }
 
-static void hclgevf_get_media_type(struct hnae3_handle *handle,
-				  u8 *media_type)
+static void hclgevf_get_media_type(struct hnae3_handle *handle, u8 *media_type,
+				   u8 *module_type)
 {
 	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
 
 	if (media_type)
 		*media_type = hdev->hw.mac.media_type;
+
+	if (module_type)
+		*module_type = hdev->hw.mac.module_type;
 }
 
 static bool hclgevf_get_hw_reset_stat(struct hnae3_handle *handle)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
index 6caaa63..f2e0fba 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
@@ -151,6 +151,7 @@ enum hclgevf_states {
 
 struct hclgevf_mac {
 	u8 media_type;
+	u8 module_type;
 	u8 mac_addr[ETH_ALEN];
 	int link;
 	u8 duplex;
-- 
1.9.1

