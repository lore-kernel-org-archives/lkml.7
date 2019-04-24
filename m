Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077A2C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF64620878
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AQQQiZgP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388737AbfDXWZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 18:25:34 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:50662 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387724AbfDXWYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 18:24:55 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3OMOni7107941;
        Wed, 24 Apr 2019 17:24:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1556144689;
        bh=X+12KDZnoceKHwdNTi3dw8z2TXnNG+1hPks+5cSO13I=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=AQQQiZgPMJPMn1wlqAyGVidQjCzcIz3I+az8sE2Mc/HSoSuL7ApuVfBfMsYpSBjl7
         z7FY5gsXJRD6xvOFkOwzfctfIMyjWOhlWtx/H7kUmbHkuag3YjD10G+RVUtS/xrs4t
         5EJ5NSnGO4dKle5OR4eg3W1IKt6w/rA87uoul7KU=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3OMOnTW064621
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 24 Apr 2019 17:24:49 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 24
 Apr 2019 17:24:49 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 24 Apr 2019 17:24:49 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3OMOmgY035507;
        Wed, 24 Apr 2019 17:24:49 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     <netdev@vger.kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Jiri Pirko <jiri@resnulli.us>
CC:     Florian Fainelli <f.fainelli@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Ivan Vecera <ivecera@redhat.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [RFC PATCH v3 net-next 08/11] net: ethernet: ti: cpsw: fix build of cpsw drivers
Date:   Thu, 25 Apr 2019 01:24:24 +0300
Message-ID: <1556144667-27997-9-git-send-email-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556144667-27997-1-git-send-email-grygorii.strashko@ti.com>
References: <1556144667-27997-1-git-send-email-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now there is dependency between CPSW switchdev and CPSW legacy drivers
related to for_each_slave() and cpsw_slave_index() - they can be compiled
both, but one of them will be not functional depending in Kconfig settings
due to duffrences in Slave indexes calculation.

To fix this make for_each_slave() local (it's used now only by legacy
driver) and convert cpsw_slave_index() to be a fucntion pointer which is
assigned in probe. Driver to start is defined by DT.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/cpsw.c      | 27 ++++++++++++++++++
 drivers/net/ethernet/ti/cpsw_new.c  | 14 ++++++++++
 drivers/net/ethernet/ti/cpsw_priv.c |  2 ++
 drivers/net/ethernet/ti/cpsw_priv.h | 43 +----------------------------
 4 files changed, 44 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 86e23468c51f..46febf13524c 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -60,6 +60,31 @@ static int descs_pool_size = CPSW_CPDMA_DESCS_POOL_SIZE_DEFAULT;
 module_param(descs_pool_size, int, 0444);
 MODULE_PARM_DESC(descs_pool_size, "Number of CPDMA CPPI descriptors in pool");
 
+#define for_each_slave(priv, func, arg...)				\
+	do {								\
+		struct cpsw_slave *slave;				\
+		struct cpsw_common *cpsw = (priv)->cpsw;		\
+		int n;							\
+		if (cpsw->data.dual_emac)				\
+			(func)((cpsw)->slaves + priv->emac_port, ##arg);\
+		else							\
+			for (n = cpsw->data.slaves,			\
+					slave = cpsw->slaves;		\
+					n; n--)				\
+				(func)(slave++, ##arg);			\
+	} while (0)
+
+static int cpsw_slave_index_priv(struct cpsw_common *cpsw,
+				 struct cpsw_priv *priv)
+{
+	return cpsw->data.dual_emac ? priv->emac_port : cpsw->data.active_slave;
+}
+
+static int cpsw_get_slave_port(u32 slave_num)
+{
+	return slave_num + 1;
+}
+
 static int cpsw_ndo_vlan_rx_add_vid(struct net_device *ndev,
 				    __be16 proto, u16 vid);
 
@@ -1791,6 +1816,8 @@ static int cpsw_probe(struct platform_device *pdev)
 	if (!cpsw)
 		return -ENOMEM;
 
+	cpsw_slave_index = cpsw_slave_index_priv;
+
 	cpsw->dev = dev;
 
 	mode = devm_gpiod_get_array_optional(dev, "mode", GPIOD_OUT_LOW);
diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index 4ea28f722136..f27fb319bf3d 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -55,6 +55,18 @@ struct cpsw_switchdev_event_work {
 	unsigned long event;
 };
 
+/* struct cpsw_common is not needed, kept here for compatibility
+ * reasons witrh the old driver
+ */
+static int cpsw_slave_index_priv(struct cpsw_common *cpsw,
+				 struct cpsw_priv *priv)
+{
+	if (priv->emac_port == HOST_PORT_NUM)
+		return -1;
+
+	return priv->emac_port - 1;
+}
+
 static void cpsw_set_promiscious(struct net_device *ndev, bool enable)
 {
 	struct cpsw_common *cpsw = ndev_to_cpsw(ndev);
@@ -1696,6 +1708,8 @@ static int cpsw_probe(struct platform_device *pdev)
 	if (!cpsw)
 		return -ENOMEM;
 
+	cpsw_slave_index = cpsw_slave_index_priv;
+
 	cpsw->dev = dev;
 
 	cpsw->slaves = devm_kcalloc(dev,
diff --git a/drivers/net/ethernet/ti/cpsw_priv.c b/drivers/net/ethernet/ti/cpsw_priv.c
index 62ba53f9bf8a..d7087650ac6d 100644
--- a/drivers/net/ethernet/ti/cpsw_priv.c
+++ b/drivers/net/ethernet/ti/cpsw_priv.c
@@ -22,6 +22,8 @@
 #include "cpsw_sl.h"
 #include "davinci_cpdma.h"
 
+int (*cpsw_slave_index)(struct cpsw_common *cpsw, struct cpsw_priv *priv);
+
 void cpsw_intr_enable(struct cpsw_common *cpsw)
 {
 	writel_relaxed(0xFF, &cpsw->wr_regs->tx_en);
diff --git a/drivers/net/ethernet/ti/cpsw_priv.h b/drivers/net/ethernet/ti/cpsw_priv.h
index 98817e14c878..c9f5528f41e4 100644
--- a/drivers/net/ethernet/ti/cpsw_priv.h
+++ b/drivers/net/ethernet/ti/cpsw_priv.h
@@ -377,48 +377,7 @@ struct cpsw_priv {
 #define ndev_to_cpsw(ndev) (((struct cpsw_priv *)netdev_priv(ndev))->cpsw)
 #define napi_to_cpsw(napi)	container_of(napi, struct cpsw_common, napi)
 
-#ifdef CONFIG_TI_CPSW_SWITCHDEV
-#define for_each_slave(priv, func, arg...)				\
-	do {								\
-		struct cpsw_common *cpsw = (priv)->cpsw;		\
-		(func)((cpsw)->slaves + (priv)->emac_port - 1, ##arg);	\
-	} while (0)
-
-/* struct cpsw_common is not needed, kept here for compatibility
- * reasons witrh the old driver
- */
-static inline int cpsw_slave_index(struct cpsw_common *cpsw,
-				   struct cpsw_priv *priv)
-{
-	if (priv->emac_port == HOST_PORT_NUM)
-		return -1;
-
-	return priv->emac_port - 1;
-}
-#else
-#define for_each_slave(priv, func, arg...)				\
-	do {								\
-		struct cpsw_slave *slave;				\
-		struct cpsw_common *cpsw = (priv)->cpsw;		\
-		int n;							\
-		if (cpsw->data.dual_emac)				\
-			(func)((cpsw)->slaves + priv->emac_port, ##arg);\
-		else							\
-			for (n = cpsw->data.slaves,			\
-					slave = cpsw->slaves;		\
-					n; n--)				\
-				(func)(slave++, ##arg);			\
-	} while (0)
-
-#define cpsw_slave_index(cpsw, priv)				\
-		((cpsw->data.dual_emac) ? priv->emac_port :	\
-		cpsw->data.active_slave)
-#endif
-
-static inline int cpsw_get_slave_port(u32 slave_num)
-{
-	return slave_num + 1;
-}
+extern int (*cpsw_slave_index)(struct cpsw_common *cpsw, struct cpsw_priv *priv);
 
 struct addr_sync_ctx {
 	struct net_device *ndev;
-- 
2.17.1

