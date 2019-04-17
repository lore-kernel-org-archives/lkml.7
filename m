Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90723C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66DBC20835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731397AbfDQI2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 04:28:48 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:61757 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731363AbfDQI2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 04:28:45 -0400
X-UUID: b551e11c62bc4ef4adf0f522d45f8f81-20190417
X-UUID: b551e11c62bc4ef4adf0f522d45f8f81-20190417
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 589636522; Wed, 17 Apr 2019 16:28:39 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 17 Apr 2019 16:28:37 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 17 Apr 2019 16:28:37 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v3 6/6] usb: mtu3: get optional clock by devm_clk_get_optional()
Date:   Wed, 17 Apr 2019 16:28:21 +0800
Message-ID: <80f2a1a7ff74202ab2d2af74addcf1f8551fff19.1555488276.git.chunfeng.yun@mediatek.com>
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

Use devm_clk_get_optional() to get optional clock instead of
optional_clk_get() which uses devm_clk_get() to get clock and
checks for -EPROBE_DEFER but not -ENOENT as devm_clk_get_optional()
does, in fact, only ignoring -ENOENT will cover more errors, so
the replacement doesn't change original purpose.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
---
v3:
  1. modify changelog comment
  2. add Reviewed-by Matthias

v2: new patch, merged into this series from
    https://patchwork.kernel.org/patch/10878235/
---
 drivers/usb/mtu3/mtu3_plat.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_plat.c b/drivers/usb/mtu3/mtu3_plat.c
index e086630e41a9..745a1da5c9c0 100644
--- a/drivers/usb/mtu3/mtu3_plat.c
+++ b/drivers/usb/mtu3/mtu3_plat.c
@@ -210,19 +210,6 @@ static void ssusb_ip_sw_reset(struct ssusb_mtk *ssusb)
 	mtu3_setbits(ssusb->ippc_base, U3D_SSUSB_IP_PW_CTRL2, SSUSB_IP_DEV_PDN);
 }
 
-/* ignore the error if the clock does not exist */
-static struct clk *get_optional_clk(struct device *dev, const char *id)
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
 static int get_ssusb_rscs(struct platform_device *pdev, struct ssusb_mtk *ssusb)
 {
 	struct device_node *node = pdev->dev.of_node;
@@ -245,15 +232,15 @@ static int get_ssusb_rscs(struct platform_device *pdev, struct ssusb_mtk *ssusb)
 		return PTR_ERR(ssusb->sys_clk);
 	}
 
-	ssusb->ref_clk = get_optional_clk(dev, "ref_ck");
+	ssusb->ref_clk = devm_clk_get_optional(dev, "ref_ck");
 	if (IS_ERR(ssusb->ref_clk))
 		return PTR_ERR(ssusb->ref_clk);
 
-	ssusb->mcu_clk = get_optional_clk(dev, "mcu_ck");
+	ssusb->mcu_clk = devm_clk_get_optional(dev, "mcu_ck");
 	if (IS_ERR(ssusb->mcu_clk))
 		return PTR_ERR(ssusb->mcu_clk);
 
-	ssusb->dma_clk = get_optional_clk(dev, "dma_ck");
+	ssusb->dma_clk = devm_clk_get_optional(dev, "dma_ck");
 	if (IS_ERR(ssusb->dma_clk))
 		return PTR_ERR(ssusb->dma_clk);
 
-- 
2.21.0

