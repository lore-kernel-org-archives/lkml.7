Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7297FC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 343D1212F5
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="o7OxlEuJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfDZRPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 13:15:54 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:47728 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfDZRM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 13:12:56 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3QHCpwj072428;
        Fri, 26 Apr 2019 12:12:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1556298771;
        bh=ORshg6D3GnzPuvSTG3xEhxMyHGdfxb7d5ulNDx3QVOw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=o7OxlEuJ8Gl+9+CkngkK18igCTLzWWkteVDf7lno0isFz2JRjO7APAprmhWmALuZO
         5pYwM8tSpdUp6rtJ2B2Lm0vzaua5jbcIRAUXebsmFxEVgTNrWKcpKU8H1ouL/TM4v9
         4hkiOCy+l27VMKR1glrQDLtJbX0CBYWFDYxVWVsY=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3QHCpPJ129690
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 26 Apr 2019 12:12:51 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 26
 Apr 2019 12:12:51 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 26 Apr 2019 12:12:51 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3QHCoF6113089;
        Fri, 26 Apr 2019 12:12:50 -0500
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
Subject: [PATCH net-next v2 03/20] net: ethernet: ti: cpsw: drop CONFIG_TI_CPSW_ALE config option
Date:   Fri, 26 Apr 2019 20:12:25 +0300
Message-ID: <1556298762-8632-4-git-send-email-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556298762-8632-1-git-send-email-grygorii.strashko@ti.com>
References: <1556298762-8632-1-git-send-email-grygorii.strashko@ti.com>
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
changes in v2:
 - dropped MODULE_x defines

 drivers/net/ethernet/ti/Kconfig    |  7 -------
 drivers/net/ethernet/ti/Makefile   |  5 ++---
 drivers/net/ethernet/ti/cpsw_ale.c | 18 ------------------
 3 files changed, 2 insertions(+), 28 deletions(-)

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
index 1142fcfce566..d6ee344e1fe1 100644
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
@@ -883,8 +870,3 @@ void cpsw_ale_dump(struct cpsw_ale *ale, u32 *data)
 		data += ALE_ENTRY_WORDS;
 	}
 }
-EXPORT_SYMBOL_GPL(cpsw_ale_dump);
-
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("TI CPSW ALE driver");
-MODULE_AUTHOR("Texas Instruments");
-- 
2.17.1

