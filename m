Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C57C4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 07:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A4A21D71
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 07:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbfJCHsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 03:48:38 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:17091 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728504AbfJCHsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 03:48:36 -0400
X-UUID: 147ca20a810c4962b1ceac6e5b09e7bb-20191003
X-UUID: 147ca20a810c4962b1ceac6e5b09e7bb-20191003
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <argus.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1474518934; Thu, 03 Oct 2019 15:48:34 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 3 Oct 2019 15:48:34 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 3 Oct 2019 15:48:31 +0800
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
Subject: [PATCH 3/3] soc: mediatek: pwrap: add support for MT6359 PMIC
Date:   Thu, 3 Oct 2019 15:48:21 +0800
Message-ID: <1570088901-23211-4-git-send-email-argus.lin@mediatek.com>
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

MT6359 is a new power management IC and it is used for
MT6779 SoCs. To define mt6359_regs for pmic register mapping
and pmic_mt6359 for accessing register.

Signed-off-by: Argus Lin <argus.lin@mediatek.com>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 72 ++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index fa8daf2..dd04318 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -111,6 +111,29 @@ enum dew_regs {
 	PWRAP_RG_SPI_CON13,
 	PWRAP_SPISLV_KEY,

+	/* MT6359 only regs */
+	PWRAP_DEW_CRC_SWRST,
+	PWRAP_DEW_RG_EN_RECORD,
+	PWRAP_DEW_RECORD_CMD0,
+	PWRAP_DEW_RECORD_CMD1,
+	PWRAP_DEW_RECORD_CMD2,
+	PWRAP_DEW_RECORD_CMD3,
+	PWRAP_DEW_RECORD_CMD4,
+	PWRAP_DEW_RECORD_CMD5,
+	PWRAP_DEW_RECORD_WDATA0,
+	PWRAP_DEW_RECORD_WDATA1,
+	PWRAP_DEW_RECORD_WDATA2,
+	PWRAP_DEW_RECORD_WDATA3,
+	PWRAP_DEW_RECORD_WDATA4,
+	PWRAP_DEW_RECORD_WDATA5,
+	PWRAP_DEW_RG_ADDR_TARGET,
+	PWRAP_DEW_RG_ADDR_MASK,
+	PWRAP_DEW_RG_WDATA_TARGET,
+	PWRAP_DEW_RG_WDATA_MASK,
+	PWRAP_DEW_RG_SPI_RECORD_CLR,
+	PWRAP_DEW_RG_CMD_ALERT_CLR,
+	PWRAP_DEW_SPISLV_KEY,
+
 	/* MT6397 only regs */
 	PWRAP_DEW_EVENT_OUT_EN,
 	PWRAP_DEW_EVENT_SRC_EN,
@@ -197,6 +220,42 @@ enum dew_regs {
 	[PWRAP_SPISLV_KEY] =		0x044a,
 };

+static const u32 mt6359_regs[] = {
+	[PWRAP_DEW_RG_EN_RECORD] =	0x040a,
+	[PWRAP_DEW_DIO_EN] =		0x040c,
+	[PWRAP_DEW_READ_TEST] =		0x040e,
+	[PWRAP_DEW_WRITE_TEST] =	0x0410,
+	[PWRAP_DEW_CRC_SWRST] =		0x0412,
+	[PWRAP_DEW_CRC_EN] =		0x0414,
+	[PWRAP_DEW_CRC_VAL] =		0x0416,
+	[PWRAP_DEW_CIPHER_KEY_SEL] =	0x0418,
+	[PWRAP_DEW_CIPHER_IV_SEL] =	0x041a,
+	[PWRAP_DEW_CIPHER_EN] =		0x041c,
+	[PWRAP_DEW_CIPHER_RDY] =	0x041e,
+	[PWRAP_DEW_CIPHER_MODE] =	0x0420,
+	[PWRAP_DEW_CIPHER_SWRST] =	0x0422,
+	[PWRAP_DEW_RDDMY_NO] =		0x0424,
+	[PWRAP_DEW_RECORD_CMD0] =	0x0428,
+	[PWRAP_DEW_RECORD_CMD1] =	0x042a,
+	[PWRAP_DEW_RECORD_CMD2] =	0x042c,
+	[PWRAP_DEW_RECORD_CMD3] =	0x042e,
+	[PWRAP_DEW_RECORD_CMD4] =	0x0430,
+	[PWRAP_DEW_RECORD_CMD5] =	0x0432,
+	[PWRAP_DEW_RECORD_WDATA0] =	0x0434,
+	[PWRAP_DEW_RECORD_WDATA1] =	0x0436,
+	[PWRAP_DEW_RECORD_WDATA2] =	0x0438,
+	[PWRAP_DEW_RECORD_WDATA3] =	0x043a,
+	[PWRAP_DEW_RECORD_WDATA4] =	0x043c,
+	[PWRAP_DEW_RECORD_WDATA5] =	0x043e,
+	[PWRAP_DEW_RG_ADDR_TARGET] =	0x0440,
+	[PWRAP_DEW_RG_ADDR_MASK] =	0x0442,
+	[PWRAP_DEW_RG_WDATA_TARGET] =	0x0444,
+	[PWRAP_DEW_RG_WDATA_MASK] =	0x0446,
+	[PWRAP_DEW_RG_SPI_RECORD_CLR] =	0x0448,
+	[PWRAP_DEW_RG_CMD_ALERT_CLR] =	0x0448,
+	[PWRAP_DEW_SPISLV_KEY] =	0x044a,
+};
+
 static const u32 mt6397_regs[] = {
 	[PWRAP_DEW_BASE] =		0xbc00,
 	[PWRAP_DEW_EVENT_OUT_EN] =	0xbc00,
@@ -977,6 +1036,7 @@ enum pmic_type {
 	PMIC_MT6351,
 	PMIC_MT6357,
 	PMIC_MT6358,
+	PMIC_MT6359,
 	PMIC_MT6380,
 	PMIC_MT6397,
 };
@@ -1757,6 +1817,15 @@ static irqreturn_t pwrap_interrupt(int irqno, void *dev_id)
 	.pwrap_write = pwrap_write16,
 };

+static const struct pwrap_slv_type pmic_mt6359 = {
+	.dew_regs = mt6359_regs,
+	.type = PMIC_MT6359,
+	.regmap = &pwrap_regmap_config16,
+	.caps = PWRAP_SLV_CAP_DUALIO,
+	.pwrap_read = pwrap_read16,
+	.pwrap_write = pwrap_write16,
+};
+
 static const struct pwrap_slv_type pmic_mt6380 = {
 	.dew_regs = NULL,
 	.type = PMIC_MT6380,
@@ -1790,6 +1859,9 @@ static irqreturn_t pwrap_interrupt(int irqno, void *dev_id)
 		.compatible = "mediatek,mt6358",
 		.data = &pmic_mt6358,
 	}, {
+		.compatible = "mediatek,mt6359",
+		.data = &pmic_mt6359,
+	}, {
 		/* The MT6380 PMIC only implements a regulator, so we bind it
 		 * directly instead of using a MFD.
 		 */
--
1.8.1.1.dirty

