Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA95C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E06D206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 09:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbfDZJnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 05:43:13 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7694 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726814AbfDZJnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 05:43:12 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EB7509B1CDB6AB2673E0;
        Fri, 26 Apr 2019 17:43:09 +0800 (CST)
Received: from linux-ioko.site (10.71.200.31) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Fri, 26 Apr 2019 17:42:59 +0800
From:   Jian Shen <shenjian15@huawei.com>
To:     <andrew@lunn.ch>, <f.fainelli@gmail.com>, <hkallweit1@gmail.com>,
        <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH topic-hns-5.1 3/3] {topost} net: hns3: add support for FEC encoding control
Date:   Fri, 26 Apr 2019 17:42:43 +0800
Message-ID: <1556271763-24142-4-git-send-email-shenjian15@huawei.com>
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

This patch adds support for FEC encoding control, user can change
FEC mode by command ethtool --set-fec, and get FEC mode by command
ethtool --show-fec. The fec capability is changed follow the port
speed. If autoneg on, the user configure fec mode will be overwritten
by autoneg result.

Signed-off-by: Jian Shen <shenjian15@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h        | 13 ++++
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h | 16 +++++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 78 ++--------------------
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h    |  2 +
 4 files changed, 38 insertions(+), 71 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index 010ba8a..6e67621 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -126,6 +126,12 @@ enum hnae3_module_type {
 
 };
 
+enum hnae3_fec_mode {
+	HNAE3_FEC_AUTO = 0,
+	HNAE3_FEC_BASER,
+	HNAE3_FEC_RS,
+};
+
 enum hnae3_reset_notify_type {
 	HNAE3_UP_CLIENT,
 	HNAE3_DOWN_CLIENT,
@@ -238,6 +244,10 @@ struct hnae3_ae_dev {
  *   Get media type of MAC
  * check_port_speed()
  *   Check target speed whether is supported
+ * get_fec()
+ *   Get fec ability and fec mode
+ * set_fec()
+ *   Set fec
  * adjust_link()
  *   Adjust link status
  * set_loopback()
@@ -356,6 +366,9 @@ struct hnae3_ae_ops {
 	void (*get_media_type)(struct hnae3_handle *handle, u8 *media_type,
 			       u8 *module_type);
 	int (*check_port_speed)(struct hnae3_handle *handle, u32 speed);
+	void (*get_fec)(struct hnae3_handle *handle, u8 *fec_ability,
+			u8 *fec_mode);
+	int (*set_fec)(struct hnae3_handle *handle, u32 fec_mode);
 	void (*adjust_link)(struct hnae3_handle *handle, int speed, int duplex);
 	int (*set_loopback)(struct hnae3_handle *handle,
 			    enum hnae3_loop loop_mode, bool en);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
index 5c82e11..67d1d97 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h
@@ -115,6 +115,7 @@ enum hclge_opcode_type {
 	HCLGE_OPC_MAC_TNL_INT_EN	= 0x0311,
 	HCLGE_OPC_CLEAR_MAC_TNL_INT	= 0x0312,
 	HCLGE_OPC_SERDES_LOOPBACK       = 0x0315,
+	HCLGE_OPC_CONFIG_FEC_MODE	= 0x031A,
 
 	/* PFC/Pause commands */
 	HCLGE_OPC_CFG_MAC_PAUSE_EN      = 0x0701,
@@ -613,6 +614,21 @@ struct hclge_sfp_info_cmd {
 	u8 rsv[8];
 };
 
+#define HCLGE_MAC_CFG_FEC_AUTO_EN_B	0
+#define HCLGE_MAC_CFG_FEC_MODE_S	1
+#define HCLGE_MAC_CFG_FEC_MODE_M	GENMASK(3, 1)
+#define HCLGE_MAC_CFG_FEC_SET_DEF_B	0
+#define HCLGE_MAC_CFG_FEC_CLR_DEF_B	1
+
+#define HCLGE_MAC_FEC_OFF		0
+#define HCLGE_MAC_FEC_BASER		1
+#define HCLGE_MAC_FEC_RS		2
+struct hclge_config_fec_cmd {
+	u8 fec_mode;
+	u8 default_config;
+	u8 rsv[22];
+};
+
 #define HCLGE_MAC_UPLINK_PORT		0x100
 
 struct hclge_config_max_frm_size_cmd {
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index ea3ac4c..58c0621 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -843,48 +843,6 @@ static int hclge_parse_speed(int speed_cmd, int *speed)
 	return 0;
 }
 
-static int hclge_check_port_speed(struct hnae3_handle *handle, u32 speed)
-{
-	struct hclge_vport *vport = hclge_get_vport(handle);
-	struct hclge_dev *hdev = vport->back;
-	u32 speed_ability = hdev->hw.mac.speed_ability;
-	u32 speed_bit = 0;
-
-	switch (speed) {
-	case HCLGE_MAC_SPEED_10M:
-		speed_bit = HCLGE_SUPPORT_10M_BIT;
-		break;
-	case HCLGE_MAC_SPEED_100M:
-		speed_bit = HCLGE_SUPPORT_100M_BIT;
-		break;
-	case HCLGE_MAC_SPEED_1G:
-		speed_bit = HCLGE_SUPPORT_1G_BIT;
-		break;
-	case HCLGE_MAC_SPEED_10G:
-		speed_bit = HCLGE_SUPPORT_10G_BIT;
-		break;
-	case HCLGE_MAC_SPEED_25G:
-		speed_bit = HCLGE_SUPPORT_25G_BIT;
-		break;
-	case HCLGE_MAC_SPEED_40G:
-		speed_bit = HCLGE_SUPPORT_40G_BIT;
-		break;
-	case HCLGE_MAC_SPEED_50G:
-		speed_bit = HCLGE_SUPPORT_50G_BIT;
-		break;
-	case HCLGE_MAC_SPEED_100G:
-		speed_bit = HCLGE_SUPPORT_100G_BIT;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	if (speed_bit & speed_ability)
-		return 0;
-
-	return -EINVAL;
-}
-
 static void hclge_convert_setting_sr(struct hclge_mac *mac, u8 speed_ability)
 {
 	if (speed_ability & HCLGE_SUPPORT_10G_BIT)
@@ -2232,16 +2190,6 @@ static int hclge_set_autoneg(struct hnae3_handle *handle, bool enable)
 	struct hclge_vport *vport = hclge_get_vport(handle);
 	struct hclge_dev *hdev = vport->back;
 
-	if (!hdev->hw.mac.support_autoneg) {
-		if (enable) {
-			dev_err(&hdev->pdev->dev,
-				"autoneg is not supported by current port\n");
-			return -EOPNOTSUPP;
-		} else {
-			return 0;
-		}
-	}
-
 	return hclge_set_autoneg_en(hdev, enable);
 }
 
@@ -2257,18 +2205,6 @@ static int hclge_get_autoneg(struct hnae3_handle *handle)
 	return hdev->hw.mac.autoneg;
 }
 
-static int hclge_restart_autoneg(struct hnae3_handle *handle)
-{
-	struct hclge_vport *vport = hclge_get_vport(handle);
-	struct hclge_dev *hdev = vport->back;
-	int ret;
-
-	ret = hclge_notify_client(hdev, HNAE3_DOWN_CLIENT);
-	if (ret)
-		return ret;
-	return hclge_notify_client(hdev, HNAE3_UP_CLIENT);
-}
-
 static int hclge_mac_init(struct hclge_dev *hdev)
 {
 	struct hclge_mac *mac = &hdev->hw.mac;
@@ -2465,6 +2401,8 @@ static int hclge_get_sfp_info(struct hclge_dev *hdev, struct hclge_mac *mac)
 		mac->speed_ability = le32_to_cpu(resp->speed_ability);
 		mac->autoneg = resp->autoneg;
 		mac->support_autoneg = resp->autoneg_ability;
+		mac->fec_mode = resp->active_fec ? BIT(resp->active_fec) : 0;
+
 	} else {
 		mac->speed_type = QUERY_SFP_SPEED;
 	}
@@ -8009,13 +7947,13 @@ static int hclge_set_pauseparam(struct hnae3_handle *handle, u32 auto_neg,
 	if (!fc_autoneg)
 		return hclge_cfg_pauseparam(hdev, rx_en, tx_en);
 
-	if (phydev)
-		return phy_start_aneg(phydev);
-
-	if (hdev->pdev->revision == 0x20)
+	/* Only support flow control negotiation for netdev with
+	 * phy attached for now.
+	 */
+	if (!phydev)
 		return -EOPNOTSUPP;
 
-	return hclge_restart_autoneg(handle);
+	return phy_start_aneg(phydev);
 }
 
 static void hclge_get_ksettings_an_result(struct hnae3_handle *handle,
@@ -9140,7 +9078,6 @@ static int hclge_gro_en(struct hnae3_handle *handle, bool enable)
 	.get_ksettings_an_result = hclge_get_ksettings_an_result,
 	.cfg_mac_speed_dup_h = hclge_cfg_mac_speed_dup_h,
 	.get_media_type = hclge_get_media_type,
-	.check_port_speed = hclge_check_port_speed,
 	.get_rss_key_size = hclge_get_rss_key_size,
 	.get_rss_indir_size = hclge_get_rss_indir_size,
 	.get_rss = hclge_get_rss,
@@ -9157,7 +9094,6 @@ static int hclge_gro_en(struct hnae3_handle *handle, bool enable)
 	.rm_mc_addr = hclge_rm_mc_addr,
 	.set_autoneg = hclge_set_autoneg,
 	.get_autoneg = hclge_get_autoneg,
-	.restart_autoneg = hclge_restart_autoneg,
 	.get_pauseparam = hclge_get_pauseparam,
 	.set_pauseparam = hclge_set_pauseparam,
 	.set_mtu = hclge_set_mtu,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index 50d6ad0..2928732 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -255,6 +255,8 @@ struct hclge_mac {
 	u32 speed;
 	u32 speed_ability; /* speed ability supported by current media */
 	u32 module_type; /* sub media type, e.g. kr/cr/sr/lr */
+	u32 fec_mode;
+	u32 fec_ability;
 	int link;	/* store the link status of mac & phy (if phy exit) */
 	struct phy_device *phydev;
 	struct mii_bus *mdio_bus;
-- 
1.9.1

