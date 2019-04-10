Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC89C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF6142083E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbfDJGsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 02:48:01 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:34226 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726838AbfDJGsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 02:48:01 -0400
X-UUID: e8285f07ad20495e9425662108bf1766-20190410
X-UUID: e8285f07ad20495e9425662108bf1766-20190410
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 864879019; Wed, 10 Apr 2019 14:47:50 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 10 Apr 2019 14:47:47 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 10 Apr 2019 14:47:45 +0800
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
Subject: [v2 PATCH 5/6] usb: chipidea: msm: get optional clock by devm_clk_get_optional()
Date:   Wed, 10 Apr 2019 14:47:28 +0800
Message-ID: <4fb0c15fc9e21307daceb9d26f20d87b4e0728d8.1554877692.git.chunfeng.yun@mediatek.com>
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

Cc: Peter Chen <Peter.Chen@nxp.com>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Acked-by: Peter Chen <Peter.Chen@nxp.com>
---
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

