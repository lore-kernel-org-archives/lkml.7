Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AE1C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 07:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 969ED21D71
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 07:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbfJCHsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 03:48:41 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:5023 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725907AbfJCHsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 03:48:39 -0400
X-UUID: f6f349e05a354c4ca75482a73ab9a2c0-20191003
X-UUID: f6f349e05a354c4ca75482a73ab9a2c0-20191003
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <argus.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1542614071; Thu, 03 Oct 2019 15:48:33 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 3 Oct 2019 15:48:30 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 3 Oct 2019 15:48:30 +0800
From:   Argus Lin <argus.lin@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
CC:     Chenglin Xu <chenglin.xu@mediatek.com>, <argus.lin@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <wsd_upstream@mediatek.com>, <henryc.chen@mediatek.com>,
        <flora.fu@mediatek.com>, Chen Zhong <chen.zhong@mediatek.com>,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 2/3] soc: mediatek: pwrap: add pwrap driver for MT6779 SoCs
Date:   Thu, 3 Oct 2019 15:48:20 +0800
Message-ID: <1570088901-23211-3-git-send-email-argus.lin@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1570088901-23211-1-git-send-email-argus.lin@mediatek.com>
References: <1570088901-23211-1-git-send-email-argus.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT6779 is a highly integrated SoCs, it uses MT6359 for power
management. This patch adds pwrap driver to access MT6359.
Pwrap of MT6779 support dynamic priority meichanism, sequence
monitor and starvation mechanism to make transaction more
reliable. WDT setting only need to init when it is zero,
otherwise keep current value. When setting interrupt enable
flag at pwrap_probe, read current setting then do logical OR
operation with wrp->master->int_en_all.

Signed-off-by: Argus Lin <argus.lin@mediatek.com>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 85 ++++++++++++++++++++++++++++++++----
 1 file changed, 77 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index c725315..fa8daf2 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -497,6 +497,45 @@ enum pwrap_regs {
 	[PWRAP_DCM_DBC_PRD] =		0x1E0,
 };

+static int mt6779_regs[] = {
+	[PWRAP_MUX_SEL] =		0x0,
+	[PWRAP_WRAP_EN] =		0x4,
+	[PWRAP_DIO_EN] =		0x8,
+	[PWRAP_RDDMY] =			0x20,
+	[PWRAP_CSHEXT_WRITE] =		0x24,
+	[PWRAP_CSHEXT_READ] =		0x28,
+	[PWRAP_CSLEXT_WRITE] =		0x2C,
+	[PWRAP_CSLEXT_READ] =		0x30,
+	[PWRAP_EXT_CK_WRITE] =		0x34,
+	[PWRAP_STAUPD_CTRL] =		0x3C,
+	[PWRAP_STAUPD_GRPEN] =		0x40,
+	[PWRAP_EINT_STA0_ADR] =		0x44,
+	[PWRAP_HARB_HPRIO] =		0x68,
+	[PWRAP_HIPRIO_ARB_EN] =		0x6C,
+	[PWRAP_MAN_EN] =		0x7C,
+	[PWRAP_MAN_CMD] =		0x80,
+	[PWRAP_WACS0_EN] =		0x8C,
+	[PWRAP_WACS1_EN] =		0x94,
+	[PWRAP_WACS2_EN] =		0x9C,
+	[PWRAP_INIT_DONE0] =		0x90,
+	[PWRAP_INIT_DONE1] =		0x98,
+	[PWRAP_INIT_DONE2] =		0xA0,
+	[PWRAP_INT_EN] =		0xBC,
+	[PWRAP_INT_FLG_RAW] =		0xC0,
+	[PWRAP_INT_FLG] =		0xC4,
+	[PWRAP_INT_CLR] =		0xC8,
+	[PWRAP_INT1_EN] =		0xCC,
+	[PWRAP_INT1_FLG] =		0xD4,
+	[PWRAP_INT1_CLR] =		0xD8,
+	[PWRAP_TIMER_EN] =		0xF0,
+	[PWRAP_WDT_UNIT] =		0xF8,
+	[PWRAP_WDT_SRC_EN] =		0xFC,
+	[PWRAP_WDT_SRC_EN_1] =		0x100,
+	[PWRAP_WACS2_CMD] =		0xC20,
+	[PWRAP_WACS2_RDATA] =		0xC24,
+	[PWRAP_WACS2_VLDCLR] =		0xC28,
+};
+
 static int mt6797_regs[] = {
 	[PWRAP_MUX_SEL] =		0x0,
 	[PWRAP_WRAP_EN] =		0x4,
@@ -945,6 +984,7 @@ enum pmic_type {
 enum pwrap_type {
 	PWRAP_MT2701,
 	PWRAP_MT6765,
+	PWRAP_MT6779,
 	PWRAP_MT6797,
 	PWRAP_MT7622,
 	PWRAP_MT8135,
@@ -1377,6 +1417,7 @@ static int pwrap_init_cipher(struct pmic_wrapper *wrp)
 		break;
 	case PWRAP_MT2701:
 	case PWRAP_MT6765:
+	case PWRAP_MT6779:
 	case PWRAP_MT6797:
 	case PWRAP_MT8173:
 	case PWRAP_MT8516:
@@ -1468,8 +1509,10 @@ static int pwrap_init_security(struct pmic_wrapper *wrp)
 	pwrap_writel(wrp, 0x0, PWRAP_SIG_MODE);
 	pwrap_writel(wrp, wrp->slave->dew_regs[PWRAP_DEW_CRC_VAL],
 		     PWRAP_SIG_ADR);
-	pwrap_writel(wrp,
-		     wrp->master->arb_en_all, PWRAP_HIPRIO_ARB_EN);
+	if (pwrap_readl(wrp, PWRAP_HIPRIO_ARB_EN) == 0) {
+		pwrap_writel(wrp,
+			     wrp->master->arb_en_all, PWRAP_HIPRIO_ARB_EN);
+	}

 	return 0;
 }
@@ -1581,7 +1624,10 @@ static int pwrap_init(struct pmic_wrapper *wrp)

 	pwrap_writel(wrp, 1, PWRAP_WRAP_EN);

-	pwrap_writel(wrp, wrp->master->arb_en_all, PWRAP_HIPRIO_ARB_EN);
+	if (pwrap_readl(wrp, PWRAP_HIPRIO_ARB_EN) == 0) {
+		pwrap_writel(wrp,
+			     wrp->master->arb_en_all, PWRAP_HIPRIO_ARB_EN);
+	}

 	pwrap_writel(wrp, 1, PWRAP_WACS2_EN);

@@ -1783,6 +1829,19 @@ static irqreturn_t pwrap_interrupt(int irqno, void *dev_id)
 	.init_soc_specific = NULL,
 };

+static const struct pmic_wrapper_type pwrap_mt6779 = {
+	.regs = mt6779_regs,
+	.type = PWRAP_MT6779,
+	.arb_en_all = 0,
+	.int_en_all = 0,
+	.int1_en_all = 0,
+	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
+	.wdt_src = 0,
+	.caps = 0,
+	.init_reg_clock = pwrap_common_init_reg_clock,
+	.init_soc_specific = NULL,
+};
+
 static const struct pmic_wrapper_type pwrap_mt6797 = {
 	.regs = mt6797_regs,
 	.type = PWRAP_MT6797,
@@ -1868,6 +1927,9 @@ static irqreturn_t pwrap_interrupt(int irqno, void *dev_id)
 		.compatible = "mediatek,mt6765-pwrap",
 		.data = &pwrap_mt6765,
 	}, {
+		.compatible = "mediatek,mt6779-pwrap",
+		.data = &pwrap_mt6779,
+	}, {
 		.compatible = "mediatek,mt6797-pwrap",
 		.data = &pwrap_mt6797,
 	}, {
@@ -1898,6 +1960,7 @@ static int pwrap_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	const struct of_device_id *of_slave_id = NULL;
 	struct resource *res;
+	u32 int_en;

 	if (np->child)
 		of_slave_id = of_match_node(of_slave_match_tbl, np->child);
@@ -1995,23 +2058,29 @@ static int pwrap_probe(struct platform_device *pdev)
 	}

 	/* Initialize watchdog, may not be done by the bootloader */
-	pwrap_writel(wrp, 0xf, PWRAP_WDT_UNIT);
+	if (pwrap_readl(wrp, PWRAP_WDT_UNIT) == 0)
+		pwrap_writel(wrp, 0xf, PWRAP_WDT_UNIT);
 	/*
 	 * Since STAUPD was not used on mt8173 platform,
 	 * so STAUPD of WDT_SRC which should be turned off
 	 */
-	pwrap_writel(wrp, wrp->master->wdt_src, PWRAP_WDT_SRC_EN);
+	if (pwrap_readl(wrp, PWRAP_WDT_SRC_EN) == 0)
+		pwrap_writel(wrp, wrp->master->wdt_src, PWRAP_WDT_SRC_EN);
 	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_WDT_SRC1))
 		pwrap_writel(wrp, wrp->master->wdt_src, PWRAP_WDT_SRC_EN_1);

 	pwrap_writel(wrp, 0x1, PWRAP_TIMER_EN);
-	pwrap_writel(wrp, wrp->master->int_en_all, PWRAP_INT_EN);
+	int_en = pwrap_readl(wrp, PWRAP_INT_EN);
+	pwrap_writel(wrp, (int_en) | (wrp->master->int_en_all), PWRAP_INT_EN);
 	/*
 	 * We add INT1 interrupt to handle starvation and request exception
 	 * If we support it, we should enable it here.
 	 */
-	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_INT1_EN))
-		pwrap_writel(wrp, wrp->master->int1_en_all, PWRAP_INT1_EN);
+	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_INT1_EN)) {
+		int_en = pwrap_readl(wrp, PWRAP_INT1_EN);
+		pwrap_writel(wrp, (int_en) | wrp->master->int1_en_all,
+			     PWRAP_INT1_EN);
+	}

 	irq = platform_get_irq(pdev, 0);
 	ret = devm_request_irq(wrp->dev, irq, pwrap_interrupt,
--
1.8.1.1.dirty

