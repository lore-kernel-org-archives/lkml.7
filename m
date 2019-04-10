Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EEBC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 006C92133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbfDJGsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 02:48:15 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:21845 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728058AbfDJGsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 02:48:13 -0400
X-UUID: 4dd1abe3a9df435fa044080a6e9d6256-20190410
X-UUID: 4dd1abe3a9df435fa044080a6e9d6256-20190410
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 6647350; Wed, 10 Apr 2019 14:47:44 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 10 Apr 2019 14:47:42 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 10 Apr 2019 14:47:35 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [v2 PATCH 2/6] usb: host: xhci-plat: get optional clock by devm_clk_get_optional()
Date:   Wed, 10 Apr 2019 14:47:25 +0800
Message-ID: <95a415bf48b1aceaba3d0f6c85e2880ef84bcf47.1554877692.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <bc6cdc2dce698dddbd692ba100fbf08c15c7b023.1554877692.git.chunfeng.yun@mediatek.com>
References: <bc6cdc2dce698dddbd692ba100fbf08c15c7b023.1554877692.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_clk_get_optional() to get optional clock

Cc: Mathias Nyman <mathias.nyman@intel.com>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2: no changes
---
 drivers/usb/host/xhci-plat.c | 39 +++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 0ac4ec975547..998241f5fce3 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -165,8 +165,6 @@ static int xhci_plat_probe(struct platform_device *pdev)
 	struct xhci_hcd		*xhci;
 	struct resource         *res;
 	struct usb_hcd		*hcd;
-	struct clk              *clk;
-	struct clk              *reg_clk;
 	int			ret;
 	int			irq;
 
@@ -235,31 +233,32 @@ static int xhci_plat_probe(struct platform_device *pdev)
 	hcd->rsrc_start = res->start;
 	hcd->rsrc_len = resource_size(res);
 
+	xhci = hcd_to_xhci(hcd);
+
 	/*
 	 * Not all platforms have clks so it is not an error if the
 	 * clock do not exist.
 	 */
-	reg_clk = devm_clk_get(&pdev->dev, "reg");
-	if (!IS_ERR(reg_clk)) {
-		ret = clk_prepare_enable(reg_clk);
-		if (ret)
-			goto put_hcd;
-	} else if (PTR_ERR(reg_clk) == -EPROBE_DEFER) {
-		ret = -EPROBE_DEFER;
+	xhci->reg_clk = devm_clk_get_optional(&pdev->dev, "reg");
+	if (IS_ERR(xhci->reg_clk)) {
+		ret = PTR_ERR(xhci->reg_clk);
 		goto put_hcd;
 	}
 
-	clk = devm_clk_get(&pdev->dev, NULL);
-	if (!IS_ERR(clk)) {
-		ret = clk_prepare_enable(clk);
-		if (ret)
-			goto disable_reg_clk;
-	} else if (PTR_ERR(clk) == -EPROBE_DEFER) {
-		ret = -EPROBE_DEFER;
+	ret = clk_prepare_enable(xhci->reg_clk);
+	if (ret)
+		goto put_hcd;
+
+	xhci->clk = devm_clk_get_optional(&pdev->dev, NULL);
+	if (IS_ERR(xhci->clk)) {
+		ret = PTR_ERR(xhci->clk);
 		goto disable_reg_clk;
 	}
 
-	xhci = hcd_to_xhci(hcd);
+	ret = clk_prepare_enable(xhci->clk);
+	if (ret)
+		goto disable_reg_clk;
+
 	priv_match = of_device_get_match_data(&pdev->dev);
 	if (priv_match) {
 		struct xhci_plat_priv *priv = hcd_to_xhci_priv(hcd);
@@ -271,8 +270,6 @@ static int xhci_plat_probe(struct platform_device *pdev)
 
 	device_wakeup_enable(hcd->self.controller);
 
-	xhci->clk = clk;
-	xhci->reg_clk = reg_clk;
 	xhci->main_hcd = hcd;
 	xhci->shared_hcd = __usb_create_hcd(driver, sysdev, &pdev->dev,
 			dev_name(&pdev->dev), hcd);
@@ -348,10 +345,10 @@ static int xhci_plat_probe(struct platform_device *pdev)
 	usb_put_hcd(xhci->shared_hcd);
 
 disable_clk:
-	clk_disable_unprepare(clk);
+	clk_disable_unprepare(xhci->clk);
 
 disable_reg_clk:
-	clk_disable_unprepare(reg_clk);
+	clk_disable_unprepare(xhci->reg_clk);
 
 put_hcd:
 	usb_put_hcd(hcd);
-- 
2.21.0

