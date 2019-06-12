Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B25C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 05:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D30D6208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 05:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730808AbfFLF4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 01:56:05 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:34952 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730695AbfFLF4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 01:56:01 -0400
X-UUID: 64847a9f3a504d1c88cde0d4f142c093-20190612
X-UUID: 64847a9f3a504d1c88cde0d4f142c093-20190612
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1279344623; Wed, 12 Jun 2019 13:55:51 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 12 Jun 2019 13:55:49 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 12 Jun 2019 13:55:48 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Jumin Li <jumin.li@mediatek.com>
Subject: [PATCH 5/5] usb: xhci-mtk: add an optional xhci_ck clock
Date:   Wed, 12 Jun 2019 13:55:21 +0800
Message-ID: <41bb0198ef2a4059685a8736b54c88487864a517.1560246390.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <5e06482a0be15476c7b5825f155accf98275afa8.1560246390.git.chunfeng.yun@mediatek.com>
References: <5e06482a0be15476c7b5825f155accf98275afa8.1560246390.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some SoCs may have an optional clock xhci_ck (125M or 200M), it
usually uses the same PLL as sys_ck, so support it.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/host/xhci-mtk.c | 13 +++++++++++++
 drivers/usb/host/xhci-mtk.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index 026fe18972d3..b18a6baef204 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -216,6 +216,10 @@ static int xhci_mtk_clks_get(struct xhci_hcd_mtk *mtk)
 		return PTR_ERR(mtk->sys_clk);
 	}
 
+	mtk->xhci_clk = devm_clk_get_optional(dev, "xhci_ck");
+	if (IS_ERR(mtk->xhci_clk))
+		return PTR_ERR(mtk->xhci_clk);
+
 	mtk->ref_clk = devm_clk_get_optional(dev, "ref_ck");
 	if (IS_ERR(mtk->ref_clk))
 		return PTR_ERR(mtk->ref_clk);
@@ -244,6 +248,12 @@ static int xhci_mtk_clks_enable(struct xhci_hcd_mtk *mtk)
 		goto sys_clk_err;
 	}
 
+	ret = clk_prepare_enable(mtk->xhci_clk);
+	if (ret) {
+		dev_err(mtk->dev, "failed to enable xhci_clk\n");
+		goto xhci_clk_err;
+	}
+
 	ret = clk_prepare_enable(mtk->mcu_clk);
 	if (ret) {
 		dev_err(mtk->dev, "failed to enable mcu_clk\n");
@@ -261,6 +271,8 @@ static int xhci_mtk_clks_enable(struct xhci_hcd_mtk *mtk)
 dma_clk_err:
 	clk_disable_unprepare(mtk->mcu_clk);
 mcu_clk_err:
+	clk_disable_unprepare(mtk->xhci_clk);
+xhci_clk_err:
 	clk_disable_unprepare(mtk->sys_clk);
 sys_clk_err:
 	clk_disable_unprepare(mtk->ref_clk);
@@ -272,6 +284,7 @@ static void xhci_mtk_clks_disable(struct xhci_hcd_mtk *mtk)
 {
 	clk_disable_unprepare(mtk->dma_clk);
 	clk_disable_unprepare(mtk->mcu_clk);
+	clk_disable_unprepare(mtk->xhci_clk);
 	clk_disable_unprepare(mtk->sys_clk);
 	clk_disable_unprepare(mtk->ref_clk);
 }
diff --git a/drivers/usb/host/xhci-mtk.h b/drivers/usb/host/xhci-mtk.h
index 8be8c5f7ff62..5ac458b7d2e0 100644
--- a/drivers/usb/host/xhci-mtk.h
+++ b/drivers/usb/host/xhci-mtk.h
@@ -139,6 +139,7 @@ struct xhci_hcd_mtk {
 	struct regulator *vusb33;
 	struct regulator *vbus;
 	struct clk *sys_clk;	/* sys and mac clock */
+	struct clk *xhci_clk;
 	struct clk *ref_clk;
 	struct clk *mcu_clk;
 	struct clk *dma_clk;
-- 
2.21.0

