Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7133AC282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F7920674
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JGeVY0lz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbfDWNMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:12:15 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:58082 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbfDWNJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:09:24 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3ND9JaZ066389;
        Tue, 23 Apr 2019 08:09:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1556024959;
        bh=p2OrZYil6ydqqM9omhdDiPcEKL+sZ2MtUeiljSgYsk8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=JGeVY0lzj8DW5pR2rLrygq1038Kg/wi+nxl/WHMw6rfGcn39TBIe/r0JlDvZr2uER
         eTt0fMK0hLT3ZvNkEgu7eu3SmRYFF0JmPLXh3FCTdrsDbsQCq3uO0n3VWoZVLoyYK9
         AFlJf1UPD3ACJs7yocvAtMRg/6Z8oWt7woPc7Qbg=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3ND9JCo125861
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Apr 2019 08:09:19 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 23
 Apr 2019 08:09:18 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 23 Apr 2019 08:09:18 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3ND9HmN107107;
        Tue, 23 Apr 2019 08:09:18 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     <netdev@vger.kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
CC:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Sekhar Nori <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH net-next 03/19] net: ethernet: ti: cpsw: drop CONFIG_TI_CPSW_ALE config option
Date:   Tue, 23 Apr 2019 16:08:54 +0300
Message-ID: <1556024950-20752-4-git-send-email-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556024950-20752-1-git-send-email-grygorii.strashko@ti.com>
References: <1556024950-20752-1-git-send-email-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All TI drivers CPSW/NETCP can't work without ALE, hence simplify
build of those drivers by always linking cpsw_ale and drop
CONFIG_TI_CPSW_ALE config option.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/Kconfig    |  7 -------
 drivers/net/ethernet/ti/Makefile   |  5 ++---
 drivers/net/ethernet/ti/cpsw_ale.c | 14 --------------
 3 files changed, 2 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
index 46f253aadcdd..afbdc9744230 100644
--- a/drivers/net/ethernet/ti/Kconfig
+++ b/drivers/net/ethernet/ti/Kconfig
@@ -44,16 +44,10 @@ config TI_CPSW_PHY_SEL
 	  This driver supports configuring of the phy mode connected to
 	  the CPSW. DEPRECATED: use PHY_TI_GMII_SEL.
 
-config TI_CPSW_ALE
-	tristate "TI CPSW ALE Support"
-	---help---
-	  This driver supports TI's CPSW ALE module.
-
 config TI_CPSW
 	tristate "TI CPSW Switch Support"
 	depends on ARCH_DAVINCI || ARCH_OMAP2PLUS || COMPILE_TEST
 	select TI_DAVINCI_MDIO
-	select TI_CPSW_ALE
 	select MFD_SYSCON
 	select REGMAP
 	---help---
@@ -82,7 +76,6 @@ config TI_CPTS_MOD
 
 config TI_KEYSTONE_NETCP
 	tristate "TI Keystone NETCP Core Support"
-	select TI_CPSW_ALE
 	select TI_DAVINCI_MDIO
 	depends on OF
 	depends on KEYSTONE_NAVIGATOR_DMA && KEYSTONE_NAVIGATOR_QMSS
diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
index a763e1b27304..2f159a71f88e 100644
--- a/drivers/net/ethernet/ti/Makefile
+++ b/drivers/net/ethernet/ti/Makefile
@@ -12,12 +12,11 @@ obj-$(CONFIG_TI_DAVINCI_EMAC) += ti_davinci_emac.o
 ti_davinci_emac-y := davinci_emac.o davinci_cpdma.o
 obj-$(CONFIG_TI_DAVINCI_MDIO) += davinci_mdio.o
 obj-$(CONFIG_TI_CPSW_PHY_SEL) += cpsw-phy-sel.o
-obj-$(CONFIG_TI_CPSW_ALE) += cpsw_ale.o
 obj-$(CONFIG_TI_CPTS_MOD) += cpts.o
 obj-$(CONFIG_TI_CPSW) += ti_cpsw.o
-ti_cpsw-y := cpsw.o davinci_cpdma.o
+ti_cpsw-y := cpsw.o davinci_cpdma.o cpsw_ale.o
 
 obj-$(CONFIG_TI_KEYSTONE_NETCP) += keystone_netcp.o
-keystone_netcp-y := netcp_core.o
+keystone_netcp-y := netcp_core.o cpsw_ale.o
 obj-$(CONFIG_TI_KEYSTONE_NETCP_ETHSS) += keystone_netcp_ethss.o
 keystone_netcp_ethss-y := netcp_ethss.o netcp_sgmii.o netcp_xgbepcsr.o
diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
index 1142fcfce566..3ef5257c9bc7 100644
--- a/drivers/net/ethernet/ti/cpsw_ale.c
+++ b/drivers/net/ethernet/ti/cpsw_ale.c
@@ -289,7 +289,6 @@ int cpsw_ale_flush_multicast(struct cpsw_ale *ale, int port_mask, int vid)
 	}
 	return 0;
 }
-EXPORT_SYMBOL_GPL(cpsw_ale_flush_multicast);
 
 static inline void cpsw_ale_set_vlan_entry_type(u32 *ale_entry,
 						int flags, u16 vid)
@@ -327,7 +326,6 @@ int cpsw_ale_add_ucast(struct cpsw_ale *ale, const u8 *addr, int port,
 	cpsw_ale_write(ale, idx, ale_entry);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(cpsw_ale_add_ucast);
 
 int cpsw_ale_del_ucast(struct cpsw_ale *ale, const u8 *addr, int port,
 		       int flags, u16 vid)
@@ -343,7 +341,6 @@ int cpsw_ale_del_ucast(struct cpsw_ale *ale, const u8 *addr, int port,
 	cpsw_ale_write(ale, idx, ale_entry);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(cpsw_ale_del_ucast);
 
 int cpsw_ale_add_mcast(struct cpsw_ale *ale, const u8 *addr, int port_mask,
 		       int flags, u16 vid, int mcast_state)
@@ -377,7 +374,6 @@ int cpsw_ale_add_mcast(struct cpsw_ale *ale, const u8 *addr, int port_mask,
 	cpsw_ale_write(ale, idx, ale_entry);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(cpsw_ale_add_mcast);
 
 int cpsw_ale_del_mcast(struct cpsw_ale *ale, const u8 *addr, int port_mask,
 		       int flags, u16 vid)
@@ -400,7 +396,6 @@ int cpsw_ale_del_mcast(struct cpsw_ale *ale, const u8 *addr, int port_mask,
 	cpsw_ale_write(ale, idx, ale_entry);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(cpsw_ale_del_mcast);
 
 /* ALE NetCP NU switch specific vlan functions */
 static void cpsw_ale_set_vlan_mcast(struct cpsw_ale *ale, u32 *ale_entry,
@@ -451,7 +446,6 @@ int cpsw_ale_add_vlan(struct cpsw_ale *ale, u16 vid, int port, int untag,
 	cpsw_ale_write(ale, idx, ale_entry);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(cpsw_ale_add_vlan);
 
 int cpsw_ale_del_vlan(struct cpsw_ale *ale, u16 vid, int port_mask)
 {
@@ -473,7 +467,6 @@ int cpsw_ale_del_vlan(struct cpsw_ale *ale, u16 vid, int port_mask)
 	cpsw_ale_write(ale, idx, ale_entry);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(cpsw_ale_del_vlan);
 
 void cpsw_ale_set_allmulti(struct cpsw_ale *ale, int allmulti)
 {
@@ -506,7 +499,6 @@ void cpsw_ale_set_allmulti(struct cpsw_ale *ale, int allmulti)
 		cpsw_ale_write(ale, idx, ale_entry);
 	}
 }
-EXPORT_SYMBOL_GPL(cpsw_ale_set_allmulti);
 
 struct ale_control_info {
 	const char	*name;
@@ -732,7 +724,6 @@ int cpsw_ale_control_set(struct cpsw_ale *ale, int port, int control,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(cpsw_ale_control_set);
 
 int cpsw_ale_control_get(struct cpsw_ale *ale, int port, int control)
 {
@@ -756,7 +747,6 @@ int cpsw_ale_control_get(struct cpsw_ale *ale, int port, int control)
 	tmp = readl_relaxed(ale->params.ale_regs + offset) >> shift;
 	return tmp & BITMASK(info->bits);
 }
-EXPORT_SYMBOL_GPL(cpsw_ale_control_get);
 
 static void cpsw_ale_timer(struct timer_list *t)
 {
@@ -781,14 +771,12 @@ void cpsw_ale_start(struct cpsw_ale *ale)
 		add_timer(&ale->timer);
 	}
 }
-EXPORT_SYMBOL_GPL(cpsw_ale_start);
 
 void cpsw_ale_stop(struct cpsw_ale *ale)
 {
 	del_timer_sync(&ale->timer);
 	cpsw_ale_control_set(ale, 0, ALE_ENABLE, 0);
 }
-EXPORT_SYMBOL_GPL(cpsw_ale_stop);
 
 struct cpsw_ale *cpsw_ale_create(struct cpsw_ale_params *params)
 {
@@ -872,7 +860,6 @@ struct cpsw_ale *cpsw_ale_create(struct cpsw_ale_params *params)
 
 	return ale;
 }
-EXPORT_SYMBOL_GPL(cpsw_ale_create);
 
 void cpsw_ale_dump(struct cpsw_ale *ale, u32 *data)
 {
@@ -883,7 +870,6 @@ void cpsw_ale_dump(struct cpsw_ale *ale, u32 *data)
 		data += ALE_ENTRY_WORDS;
 	}
 }
-EXPORT_SYMBOL_GPL(cpsw_ale_dump);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("TI CPSW ALE driver");
-- 
2.17.1

