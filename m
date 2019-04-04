Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F443C10F0D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 641B920855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbfDDIrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:47:31 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6246 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727641AbfDDIrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:47:06 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AE2651BAF0C6C8CCB7E2;
        Thu,  4 Apr 2019 16:47:03 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.408.0; Thu, 4 Apr 2019 16:46:54 +0800
From:   Yonglong Liu <liuyonglong@huawei.com>
To:     <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <salil.mehta@huawei.com>,
        <yisen.zhuang@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH net 6/6] net: hns: Fix sparse: some warnings in HNS drivers
Date:   Thu, 4 Apr 2019 16:46:47 +0800
Message-ID: <1554367607-130891-7-git-send-email-liuyonglong@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1554367607-130891-1-git-send-email-liuyonglong@huawei.com>
References: <1554367607-130891-1-git-send-email-liuyonglong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some sparse warnings in the HNS drivers:

warning: incorrect type in assignment (different address spaces)
    expected void [noderef] <asn:2> *io_base
    got void *vaddr
warning: cast removes address space '<asn:2>' of expression
[...]

Add __iomem and change all the u8 __iomem to void __iomem to
fix these kind of  warnings.

warning: incorrect type in argument 1 (different address spaces)
    expected void [noderef] <asn:2> *base
    got unsigned char [usertype] *base_addr
warning: cast to restricted __le16
warning: incorrect type in assignment (different base types)
    expected unsigned int [usertype] tbl_tcam_data_high
    got restricted __le32 [usertype]
warning: cast to restricted __le32
[...]

These variables used u32/u16 as their type, and finally as a
parameter of writel(), writel() will do the cpu_to_le32 coversion
so remove the little endian covert code to fix these kind of warnings.

Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns/hnae.h          |  2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c  |  2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.h  |  4 ++--
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c | 20 ++++++--------------
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h |  2 ++
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c |  2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c  |  6 +++---
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.h  |  4 ++--
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c  |  4 ++--
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_reg.h  | 12 ++++++------
 drivers/net/ethernet/hisilicon/hns_mdio.c          | 18 +++++++-----------
 11 files changed, 33 insertions(+), 43 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hnae.h b/drivers/net/ethernet/hisilicon/hns/hnae.h
index 08a750f..d6fb8343 100644
--- a/drivers/net/ethernet/hisilicon/hns/hnae.h
+++ b/drivers/net/ethernet/hisilicon/hns/hnae.h
@@ -357,7 +357,7 @@ struct hnae_buf_ops {
 };
 
 struct hnae_queue {
-	void __iomem *io_base;
+	u8 __iomem *io_base;
 	phys_addr_t phy_base;
 	struct hnae_ae_dev *dev;	/* the device who use this queue */
 	struct hnae_ring rx_ring ____cacheline_internodealigned_in_smp;
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
index a97228c..6c05079 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
@@ -370,7 +370,7 @@ int hns_mac_clr_multicast(struct hns_mac_cb *mac_cb, int vfn)
 static void hns_mac_param_get(struct mac_params *param,
 			      struct hns_mac_cb *mac_cb)
 {
-	param->vaddr = (void *)mac_cb->vaddr;
+	param->vaddr = mac_cb->vaddr;
 	param->mac_mode = hns_get_enet_interface(mac_cb);
 	ether_addr_copy(param->addr, mac_cb->addr_entry_idx[0].addr);
 	param->mac_id = mac_cb->mac_id;
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.h b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.h
index fbc7534..2258979 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.h
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.h
@@ -187,7 +187,7 @@ struct mac_statistics {
 /*mac para struct ,mac get param from nic or dsaf when initialize*/
 struct mac_params {
 	char addr[ETH_ALEN];
-	void *vaddr; /*virtual address*/
+	u8 __iomem *vaddr; /*virtual address*/
 	struct device *dev;
 	u8 mac_id;
 	/**< Ethernet operation mode (MAC-PHY interface and speed) */
@@ -402,7 +402,7 @@ struct mac_driver {
 	enum mac_mode mac_mode;
 	u8 mac_id;
 	struct hns_mac_cb *mac_cb;
-	void __iomem *io_base;
+	u8 __iomem *io_base;
 	unsigned int mac_en_flg;/*you'd better don't enable mac twice*/
 	unsigned int virt_dev_num;
 	struct device *dev;
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
index f5ff07c..61eea6a 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
@@ -1602,8 +1602,6 @@ static void hns_dsaf_set_mac_key(
 		       DSAF_TBL_TCAM_KEY_VLAN_S, vlan_id);
 	dsaf_set_field(mac_key->low.bits.port_vlan, DSAF_TBL_TCAM_KEY_PORT_M,
 		       DSAF_TBL_TCAM_KEY_PORT_S, port);
-
-	mac_key->low.bits.port_vlan = le16_to_cpu(mac_key->low.bits.port_vlan);
 }
 
 /**
@@ -1663,8 +1661,8 @@ int hns_dsaf_set_mac_uc_entry(
 	/* default config dvc to 0 */
 	mac_data.tbl_ucast_dvc = 0;
 	mac_data.tbl_ucast_out_port = mac_entry->port_num;
-	tcam_data.tbl_tcam_data_high = cpu_to_le32(mac_key.high.val);
-	tcam_data.tbl_tcam_data_low = cpu_to_le32(mac_key.low.val);
+	tcam_data.tbl_tcam_data_high = mac_key.high.val;
+	tcam_data.tbl_tcam_data_low = mac_key.low.val;
 
 	hns_dsaf_tcam_uc_cfg(dsaf_dev, entry_index, &tcam_data, &mac_data);
 
@@ -1786,9 +1784,6 @@ int hns_dsaf_add_mac_mc_port(struct dsaf_device *dsaf_dev,
 				     0xff,
 				     mc_mask);
 
-		mask_key.high.val = le32_to_cpu(mask_key.high.val);
-		mask_key.low.val = le32_to_cpu(mask_key.low.val);
-
 		pmask_key = (struct dsaf_tbl_tcam_data *)(&mask_key);
 	}
 
@@ -1840,8 +1835,8 @@ int hns_dsaf_add_mac_mc_port(struct dsaf_device *dsaf_dev,
 		dsaf_dev->ae_dev.name, mac_key.high.val,
 		mac_key.low.val, entry_index);
 
-	tcam_data.tbl_tcam_data_high = cpu_to_le32(mac_key.high.val);
-	tcam_data.tbl_tcam_data_low = cpu_to_le32(mac_key.low.val);
+	tcam_data.tbl_tcam_data_high = mac_key.high.val;
+	tcam_data.tbl_tcam_data_low = mac_key.low.val;
 
 	/* config mc entry with mask */
 	hns_dsaf_tcam_mc_cfg(dsaf_dev, entry_index, &tcam_data,
@@ -1956,9 +1951,6 @@ int hns_dsaf_del_mac_mc_port(struct dsaf_device *dsaf_dev,
 		/* config key mask */
 		hns_dsaf_set_mac_key(dsaf_dev, &mask_key, 0x00, 0xff, mc_mask);
 
-		mask_key.high.val = le32_to_cpu(mask_key.high.val);
-		mask_key.low.val = le32_to_cpu(mask_key.low.val);
-
 		pmask_key = (struct dsaf_tbl_tcam_data *)(&mask_key);
 	}
 
@@ -2012,8 +2004,8 @@ int hns_dsaf_del_mac_mc_port(struct dsaf_device *dsaf_dev,
 		soft_mac_entry += entry_index;
 		soft_mac_entry->index = DSAF_INVALID_ENTRY_IDX;
 	} else { /* not zero, just del port, update */
-		tcam_data.tbl_tcam_data_high = cpu_to_le32(mac_key.high.val);
-		tcam_data.tbl_tcam_data_low = cpu_to_le32(mac_key.low.val);
+		tcam_data.tbl_tcam_data_high = mac_key.high.val;
+		tcam_data.tbl_tcam_data_low = mac_key.low.val;
 
 		hns_dsaf_tcam_mc_cfg(dsaf_dev, entry_index,
 				     &tcam_data,
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h
index 0e1cd99..76cc888 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h
@@ -467,4 +467,6 @@ int hns_dsaf_clr_mac_mc_port(struct dsaf_device *dsaf_dev,
 			     u8 mac_id, u8 port_num);
 int hns_dsaf_wait_pkt_clean(struct dsaf_device *dsaf_dev, int port);
 
+int hns_dsaf_roce_reset(struct fwnode_handle *dsaf_fwnode, bool dereset);
+
 #endif /* __HNS_DSAF_MAIN_H__ */
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c
index 16294cd..19b94879 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_misc.c
@@ -670,7 +670,7 @@ static int hns_mac_config_sds_loopback(struct hns_mac_cb *mac_cb, bool en)
 		dsaf_set_field(origin, 1ull << 10, 10, en);
 		dsaf_write_syscon(mac_cb->serdes_ctrl, reg_offset, origin);
 	} else {
-		u8 *base_addr = (u8 *)mac_cb->serdes_vaddr +
+		u8 __iomem *base_addr = mac_cb->serdes_vaddr +
 				(mac_cb->mac_id <= 3 ? 0x00280000 : 0x00200000);
 		dsaf_set_reg_field(base_addr, reg_offset, 1ull << 10, 10, en);
 	}
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c
index 3d07c8a..17c0191 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c
@@ -61,7 +61,7 @@ void hns_ppe_set_indir_table(struct hns_ppe_cb *ppe_cb,
 	}
 }
 
-static void __iomem *
+static u8 __iomem *
 hns_ppe_common_get_ioaddr(struct ppe_common_cb *ppe_common)
 {
 	return ppe_common->dsaf_dev->ppe_base + PPE_COMMON_REG_OFFSET;
@@ -111,8 +111,8 @@ hns_ppe_common_free_cfg(struct dsaf_device *dsaf_dev, u32 comm_index)
 	dsaf_dev->ppe_common[comm_index] = NULL;
 }
 
-static void __iomem *hns_ppe_get_iobase(struct ppe_common_cb *ppe_common,
-					int ppe_idx)
+static u8 __iomem *hns_ppe_get_iobase(struct ppe_common_cb *ppe_common,
+				      int ppe_idx)
 {
 	return ppe_common->dsaf_dev->ppe_base + ppe_idx * PPE_REG_OFFSET;
 }
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.h b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.h
index f670e63..110c6e8 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.h
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.h
@@ -80,7 +80,7 @@ struct hns_ppe_cb {
 	struct hns_ppe_hw_stats hw_stats;
 
 	u8 index;	/* index in a ppe common device */
-	void __iomem *io_base;
+	u8 __iomem *io_base;
 	int virq;
 	u32 rss_indir_table[HNS_PPEV2_RSS_IND_TBL_SIZE]; /*shadow indir tab */
 	u32 rss_key[HNS_PPEV2_RSS_KEY_NUM]; /* rss hash key */
@@ -89,7 +89,7 @@ struct hns_ppe_cb {
 struct ppe_common_cb {
 	struct device *dev;
 	struct dsaf_device *dsaf_dev;
-	void __iomem *io_base;
+	u8 __iomem *io_base;
 
 	enum ppe_common_mode ppe_mode;
 
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c
index 6bf346c..ac3518c 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c
@@ -458,7 +458,7 @@ static void hns_rcb_ring_get_cfg(struct hnae_queue *q, int ring_type)
 		mdnum_ppkt = HNS_RCB_RING_MAX_BD_PER_PKT;
 	} else {
 		ring = &q->tx_ring;
-		ring->io_base = (u8 __iomem *)ring_pair_cb->q.io_base +
+		ring->io_base = ring_pair_cb->q.io_base +
 			HNS_RCB_TX_REG_OFFSET;
 		irq_idx = HNS_RCB_IRQ_IDX_TX;
 		mdnum_ppkt = is_ver1 ? HNS_RCB_RING_MAX_TXBD_PER_PKT :
@@ -764,7 +764,7 @@ static int hns_rcb_get_ring_num(struct dsaf_device *dsaf_dev)
 	}
 }
 
-static void __iomem *hns_rcb_common_get_vaddr(struct rcb_common_cb *rcb_common)
+static u8 __iomem *hns_rcb_common_get_vaddr(struct rcb_common_cb *rcb_common)
 {
 	struct dsaf_device *dsaf_dev = rcb_common->dsaf_dev;
 
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_reg.h b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_reg.h
index b9733b0..b9e7f11 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_reg.h
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_reg.h
@@ -1018,7 +1018,7 @@
 #define XGMAC_PAUSE_CTL_RSP_MODE_B	2
 #define XGMAC_PAUSE_CTL_TX_XOFF_B	3
 
-static inline void dsaf_write_reg(void __iomem *base, u32 reg, u32 value)
+static inline void dsaf_write_reg(u8 __iomem *base, u32 reg, u32 value)
 {
 	writel(value, base + reg);
 }
@@ -1053,7 +1053,7 @@ static inline int dsaf_read_syscon(struct regmap *base, u32 reg, u32 *val)
 #define dsaf_set_bit(origin, shift, val) \
 	dsaf_set_field((origin), (1ull << (shift)), (shift), (val))
 
-static inline void dsaf_set_reg_field(void __iomem *base, u32 reg, u32 mask,
+static inline void dsaf_set_reg_field(u8 __iomem *base, u32 reg, u32 mask,
 				      u32 shift, u32 val)
 {
 	u32 origin = dsaf_read_reg(base, reg);
@@ -1073,7 +1073,7 @@ static inline void dsaf_set_reg_field(void __iomem *base, u32 reg, u32 mask,
 #define dsaf_get_bit(origin, shift) \
 	dsaf_get_field((origin), (1ull << (shift)), (shift))
 
-static inline u32 dsaf_get_reg_field(void __iomem *base, u32 reg, u32 mask,
+static inline u32 dsaf_get_reg_field(u8 __iomem *base, u32 reg, u32 mask,
 				     u32 shift)
 {
 	u32 origin;
@@ -1089,11 +1089,11 @@ static inline u32 dsaf_get_reg_field(void __iomem *base, u32 reg, u32 mask,
 	dsaf_get_reg_field((dev)->io_base, (reg), (1ull << (bit)), (bit))
 
 #define dsaf_write_b(addr, data)\
-	writeb((data), (__iomem unsigned char *)(addr))
+	writeb((data), (__iomem u8 *)(addr))
 #define dsaf_read_b(addr)\
-	readb((__iomem unsigned char *)(addr))
+	readb((__iomem u8 *)(addr))
 
 #define hns_mac_reg_read64(drv, offset) \
-	readq((__iomem void *)(((u8 *)(drv)->io_base + 0xc00 + (offset))))
+	readq((__iomem void *)(((drv)->io_base + 0xc00 + (offset))))
 
 #endif	/* _DSAF_REG_H */
diff --git a/drivers/net/ethernet/hisilicon/hns_mdio.c b/drivers/net/ethernet/hisilicon/hns_mdio.c
index baf5cc2..8b8a7d0 100644
--- a/drivers/net/ethernet/hisilicon/hns_mdio.c
+++ b/drivers/net/ethernet/hisilicon/hns_mdio.c
@@ -39,7 +39,7 @@ struct hns_mdio_sc_reg {
 };
 
 struct hns_mdio_device {
-	void *vbase;		/* mdio reg base address */
+	u8 __iomem *vbase;		/* mdio reg base address */
 	struct regmap *subctrl_vbase;
 	struct hns_mdio_sc_reg sc_reg;
 };
@@ -96,21 +96,17 @@ enum mdio_c45_op_seq {
 #define MDIO_SC_CLK_ST		0x531C
 #define MDIO_SC_RESET_ST	0x5A1C
 
-static void mdio_write_reg(void *base, u32 reg, u32 value)
+static void mdio_write_reg(u8 __iomem *base, u32 reg, u32 value)
 {
-	u8 __iomem *reg_addr = (u8 __iomem *)base;
-
-	writel_relaxed(value, reg_addr + reg);
+	writel_relaxed(value, base + reg);
 }
 
 #define MDIO_WRITE_REG(a, reg, value) \
 	mdio_write_reg((a)->vbase, (reg), (value))
 
-static u32 mdio_read_reg(void *base, u32 reg)
+static u32 mdio_read_reg(u8 __iomem *base, u32 reg)
 {
-	u8 __iomem *reg_addr = (u8 __iomem *)base;
-
-	return readl_relaxed(reg_addr + reg);
+	return readl_relaxed(base + reg);
 }
 
 #define mdio_set_field(origin, mask, shift, val) \
@@ -121,7 +117,7 @@ static u32 mdio_read_reg(void *base, u32 reg)
 
 #define mdio_get_field(origin, mask, shift) (((origin) >> (shift)) & (mask))
 
-static void mdio_set_reg_field(void *base, u32 reg, u32 mask, u32 shift,
+static void mdio_set_reg_field(u8 __iomem *base, u32 reg, u32 mask, u32 shift,
 			       u32 val)
 {
 	u32 origin = mdio_read_reg(base, reg);
@@ -133,7 +129,7 @@ static void mdio_set_reg_field(void *base, u32 reg, u32 mask, u32 shift,
 #define MDIO_SET_REG_FIELD(dev, reg, mask, shift, val) \
 	mdio_set_reg_field((dev)->vbase, (reg), (mask), (shift), (val))
 
-static u32 mdio_get_reg_field(void *base, u32 reg, u32 mask, u32 shift)
+static u32 mdio_get_reg_field(u8 __iomem *base, u32 reg, u32 mask, u32 shift)
 {
 	u32 origin;
 
-- 
2.8.1

