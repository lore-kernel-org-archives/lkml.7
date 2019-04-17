Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7896C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9750620835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731417AbfDQI2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 04:28:50 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:3550 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731366AbfDQI2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 04:28:48 -0400
X-UUID: 2fb472d24ea9453aadadc8170d0525c6-20190417
X-UUID: 2fb472d24ea9453aadadc8170d0525c6-20190417
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1631658962; Wed, 17 Apr 2019 16:28:38 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 17 Apr 2019 16:28:33 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 17 Apr 2019 16:28:29 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Peter Chen <Peter.Chen@nxp.com>
Subject: [PATCH v3 5/6] usb: chipidea: msm: get optional clock by devm_clk_get_optional()
Date:   Wed, 17 Apr 2019 16:28:20 +0800
Message-ID: <f298553253f74808ef49d40e71c9cf0624a4403a.1555488276.git.chunfeng.yun@mediatek.com>
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

When the driver tries to get optional clock, it ignores all errors except
-EPROBE_DEFER, but if only ignores -ENOENT, it will cover some real errors,
such as -ENOMEM, so use devm_clk_get_optional() to get optional clock.

Cc: Peter Chen <Peter.Chen@nxp.com>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Acked-by: Peter Chen <Peter.Chen@nxp.com>
---
v3: modify changelog comment
v2: add Acked-by Peter Chen
---
 drivers/usb/chipidea/ci_hdrc_msm.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_msm.c b/drivers/usb/chipidea/ci_hdrc_msm.c
index 880009987460..b8b3caad889c 100644
--- a/drivers/usb/chipidea/ci_hdrc_msm.c
+++ b/drivers/usb/chipidea/ci_hdrc_msm.c
@@ -205,12 +205,9 @@ static int ci_hdrc_msm_probe(struct platform_device *pdev)
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
-	ci->fs_clk = clk = devm_clk_get(&pdev->dev, "fs");
-	if (IS_ERR(clk)) {
-		if (PTR_ERR(clk) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
-		ci->fs_clk = NULL;
-	}
+	ci->fs_clk = clk = devm_clk_get_optional(&pdev->dev, "fs");
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	ci->base = devm_ioremap_resource(&pdev->dev, res);
-- 
2.21.0

