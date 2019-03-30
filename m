Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F1FC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 09:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2EA7218A3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 09:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730491AbfC3J2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 05:28:37 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:9041 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730372AbfC3J2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 05:28:36 -0400
X-UUID: 712d86b331d64b4e9543c03c4b6dce91-20190330
X-UUID: 712d86b331d64b4e9543c03c4b6dce91-20190330
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1572047254; Sat, 30 Mar 2019 17:28:31 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 30 Mar 2019 17:28:29 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 30 Mar 2019 17:28:29 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 1/5] usb: xhci-mtk: get optional clock by devm_clk_get_optional()
Date:   Sat, 30 Mar 2019 17:28:16 +0800
Message-ID: <2ec86ffd7de45dabaa7257019a79f1e80751934c.1553937592.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_clk_get_optional() to get optional clock

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/host/xhci-mtk.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index 60987c787e44..026fe18972d3 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -206,19 +206,6 @@ static int xhci_mtk_ssusb_config(struct xhci_hcd_mtk *mtk)
 	return xhci_mtk_host_enable(mtk);
 }
 
-/* ignore the error if the clock does not exist */
-static struct clk *optional_clk_get(struct device *dev, const char *id)
-{
-	struct clk *opt_clk;
-
-	opt_clk = devm_clk_get(dev, id);
-	/* ignore error number except EPROBE_DEFER */
-	if (IS_ERR(opt_clk) && (PTR_ERR(opt_clk) != -EPROBE_DEFER))
-		opt_clk = NULL;
-
-	return opt_clk;
-}
-
 static int xhci_mtk_clks_get(struct xhci_hcd_mtk *mtk)
 {
 	struct device *dev = mtk->dev;
@@ -229,15 +216,15 @@ static int xhci_mtk_clks_get(struct xhci_hcd_mtk *mtk)
 		return PTR_ERR(mtk->sys_clk);
 	}
 
-	mtk->ref_clk = optional_clk_get(dev, "ref_ck");
+	mtk->ref_clk = devm_clk_get_optional(dev, "ref_ck");
 	if (IS_ERR(mtk->ref_clk))
 		return PTR_ERR(mtk->ref_clk);
 
-	mtk->mcu_clk = optional_clk_get(dev, "mcu_ck");
+	mtk->mcu_clk = devm_clk_get_optional(dev, "mcu_ck");
 	if (IS_ERR(mtk->mcu_clk))
 		return PTR_ERR(mtk->mcu_clk);
 
-	mtk->dma_clk = optional_clk_get(dev, "dma_ck");
+	mtk->dma_clk = devm_clk_get_optional(dev, "dma_ck");
 	return PTR_ERR_OR_ZERO(mtk->dma_clk);
 }
 
-- 
2.20.1

