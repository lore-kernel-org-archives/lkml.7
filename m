Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306A2C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 08:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D2AD2082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 08:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfCEIaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 03:30:14 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:25465 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726101AbfCEI36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 03:29:58 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x258BVoC008401;
        Tue, 5 Mar 2019 09:29:37 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2qyhgar6ky-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 05 Mar 2019 09:29:37 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 533DA3D;
        Tue,  5 Mar 2019 08:29:36 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 01A501675;
        Tue,  5 Mar 2019 08:29:35 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 5 Mar 2019
 09:29:35 +0100
Received: from localhost (10.201.23.166) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 5 Mar 2019 09:29:35
 +0100
From:   Christophe Roullier <christophe.roullier@st.com>
To:     <robh@kernel.org>, <davem@davemloft.net>, <joabreu@synopsys.com>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <peppe.cavallaro@st.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <christophe.roullier@st.com>, <andrew@lunn.ch>
Subject: [PATCH V3 1/6] net: ethernet: stmmac: manage Ethernet WoL for stm32mp157c.
Date:   Tue, 5 Mar 2019 09:29:23 +0100
Message-ID: <1551774568-11732-2-git-send-email-christophe.roullier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551774568-11732-1-git-send-email-christophe.roullier@st.com>
References: <1551774568-11732-1-git-send-email-christophe.roullier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.166]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-05_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add glue codes to support magic packet on stm32mp157c

Signed-off-by: Christophe Roullier <christophe.roullier@st.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c | 30 ++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
index 7e2e79d..d1cf145 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
@@ -42,6 +42,7 @@ struct stm32_dwmac {
 	struct clk *clk_ethstp;
 	struct clk *syscfg_clk;
 	bool int_phyclk;	/* Clock from RCC to drive PHY */
+	int irq_pwr_wakeup;
 	u32 mode_reg;		/* MAC glue-logic mode register */
 	struct regmap *regmap;
 	u32 speed;
@@ -232,7 +233,9 @@ static int stm32_dwmac_parse_data(struct stm32_dwmac *dwmac,
 static int stm32mp1_parse_data(struct stm32_dwmac *dwmac,
 			       struct device *dev)
 {
+	struct platform_device *pdev = to_platform_device(dev);
 	struct device_node *np = dev->of_node;
+	int err = 0;
 
 	dwmac->int_phyclk = of_property_read_bool(np, "st,int-phyclk");
 
@@ -260,7 +263,26 @@ static int stm32mp1_parse_data(struct stm32_dwmac *dwmac,
 		return PTR_ERR(dwmac->syscfg_clk);
 	}
 
-	return 0;
+	/* Get IRQ information early to have an ability to ask for deferred
+	 * probe if needed before we went too far with resource allocation.
+	 */
+	dwmac->irq_pwr_wakeup = platform_get_irq_byname(pdev,
+							"stm32_pwr_wakeup");
+	if (!dwmac->int_phyclk && dwmac->irq_pwr_wakeup >= 0) {
+		err = device_init_wakeup(&pdev->dev, true);
+		if (err) {
+			dev_err(&pdev->dev, "Failed to init wake up irq\n");
+			return err;
+		}
+		err = dev_pm_set_dedicated_wake_irq(&pdev->dev,
+						    dwmac->irq_pwr_wakeup);
+		if (err) {
+			dev_err(&pdev->dev, "Failed to set wake up irq\n");
+			device_init_wakeup(&pdev->dev, false);
+		}
+		device_set_wakeup_enable(&pdev->dev, false);
+	}
+	return err;
 }
 
 static int stm32_dwmac_probe(struct platform_device *pdev)
@@ -326,9 +348,15 @@ static int stm32_dwmac_remove(struct platform_device *pdev)
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct stmmac_priv *priv = netdev_priv(ndev);
 	int ret = stmmac_dvr_remove(&pdev->dev);
+	struct stm32_dwmac *dwmac = priv->plat->bsp_priv;
 
 	stm32_dwmac_clk_disable(priv->plat->bsp_priv);
 
+	if (dwmac->irq_pwr_wakeup >= 0) {
+		dev_pm_clear_wake_irq(&pdev->dev);
+		device_init_wakeup(&pdev->dev, false);
+	}
+
 	return ret;
 }
 
-- 
2.7.4

