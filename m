Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65813C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F6BA2083E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbfDJGsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 02:48:39 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:63291 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726056AbfDJGsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 02:48:38 -0400
X-UUID: 6d255611d1f248b99fe4b70c13179371-20190410
X-UUID: 6d255611d1f248b99fe4b70c13179371-20190410
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 420435983; Wed, 10 Apr 2019 14:47:52 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 10 Apr 2019 14:47:50 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 10 Apr 2019 14:47:49 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [v2 PATCH 6/6] usb: mtu3: get optional clock by devm_clk_get_optional()
Date:   Wed, 10 Apr 2019 14:47:29 +0800
Message-ID: <147496a43bb93120bbd00a39668612c96e369691.1554877692.git.chunfeng.yun@mediatek.com>
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

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
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

