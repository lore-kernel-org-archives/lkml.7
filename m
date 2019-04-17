Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE83C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 282712176F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731364AbfDQI2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 04:28:44 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:29693 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727177AbfDQI2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 04:28:42 -0400
X-UUID: 9f20facb5542416ea0c07cf66b6475c8-20190417
X-UUID: 9f20facb5542416ea0c07cf66b6475c8-20190417
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 848568013; Wed, 17 Apr 2019 16:28:30 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 17 Apr 2019 16:28:29 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 17 Apr 2019 16:28:28 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Minas Harutyunyan <hminas@synopsys.com>
Subject: [PATCH v3 4/6] usb: dwc2: get optional clock by devm_clk_get_optional()
Date:   Wed, 17 Apr 2019 16:28:19 +0800
Message-ID: <39be1493f7760c3c06858046f64d02e7cb86884e.1555488276.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <bacafa9a60c2f437e2be0ccdf504492343fc0a66.1555488276.git.chunfeng.yun@mediatek.com>
References: <bacafa9a60c2f437e2be0ccdf504492343fc0a66.1555488276.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the driver tries to get optional clock, it ignores all errors,
but if only ignores -ENOENT, it will cover some real errors, such as
-EPROBE_DEFER, so use devm_clk_get_optional() to get optional clock.

Cc: Minas Harutyunyan <hminas@synopsys.com>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Acked-by: Minas Harutyunyan <hminas@synopsys.com>
---
v3: modify changelog comment
v2: add Acked-by Minas Harutyunyan
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
2.21.0

