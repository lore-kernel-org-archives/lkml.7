Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1F3C10F00
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 09:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24A4D218A3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 09:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730601AbfC3J2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 05:28:44 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:9398 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730372AbfC3J2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 05:28:40 -0400
X-UUID: ecd17a923089409a8a0249dc810b0a73-20190330
X-UUID: ecd17a923089409a8a0249dc810b0a73-20190330
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1537852559; Sat, 30 Mar 2019 17:28:34 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 30 Mar 2019 17:28:32 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 30 Mar 2019 17:28:32 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Minas Harutyunyan <hminas@synopsys.com>
Subject: [PATCH 4/5] usb: dwc2: get optional clock by devm_clk_get_optional()
Date:   Sat, 30 Mar 2019 17:28:19 +0800
Message-ID: <e14524a4e6b38140f41e55bb74aedb6599e963e1.1553937592.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <2ec86ffd7de45dabaa7257019a79f1e80751934c.1553937592.git.chunfeng.yun@mediatek.com>
References: <2ec86ffd7de45dabaa7257019a79f1e80751934c.1553937592.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_clk_get_optional() to get optional clock

Cc: Minas Harutyunyan <hminas@synopsys.com>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/dwc2/platform.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index c0b64d483552..9aa9682a5cd2 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -284,10 +284,10 @@ static int dwc2_lowlevel_hw_init(struct dwc2_hsotg *hsotg)
 	}
 
 	/* Clock */
-	hsotg->clk = devm_clk_get(hsotg->dev, "otg");
+	hsotg->clk = devm_clk_get_optional(hsotg->dev, "otg");
 	if (IS_ERR(hsotg->clk)) {
-		hsotg->clk = NULL;
-		dev_dbg(hsotg->dev, "cannot get otg clock\n");
+		dev_err(hsotg->dev, "cannot get otg clock\n");
+		return PTR_ERR(hsotg->clk);
 	}
 
 	/* Regulators */
-- 
2.20.1

