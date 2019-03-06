Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77C8C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0F352064A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729650AbfCFLq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 06:46:58 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:47953 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729562AbfCFLqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 06:46:55 -0500
X-UUID: d9f6dfc8a14748438eb99f9cb1a36618-20190306
X-UUID: d9f6dfc8a14748438eb99f9cb1a36618-20190306
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1847711942; Wed, 06 Mar 2019 19:46:51 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 6 Mar 2019 19:46:49 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 6 Mar 2019 19:46:48 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 04/11] usb: mtu3: rebuild the code of getting vbus regulator
Date:   Wed, 6 Mar 2019 19:46:16 +0800
Message-ID: <1551872783-13707-5-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1551872783-13707-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1551872783-13707-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove local variable @vbus and use @dev instead of @pdev->dev

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_plat.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_plat.c b/drivers/usb/mtu3/mtu3_plat.c
index 3a4a80f15957..a326b1d6006a 100644
--- a/drivers/usb/mtu3/mtu3_plat.c
+++ b/drivers/usb/mtu3/mtu3_plat.c
@@ -228,7 +228,6 @@ static int get_ssusb_rscs(struct platform_device *pdev, struct ssusb_mtk *ssusb)
 	struct device_node *node = pdev->dev.of_node;
 	struct otg_switch_mtk *otg_sx = &ssusb->otg_switch;
 	struct device *dev = &pdev->dev;
-	struct regulator *vbus;
 	struct resource *res;
 	int i;
 	int ret;
@@ -299,12 +298,11 @@ static int get_ssusb_rscs(struct platform_device *pdev, struct ssusb_mtk *ssusb)
 	of_property_read_u32(node, "mediatek,u3p-dis-msk",
 			     &ssusb->u3p_dis_msk);
 
-	vbus = devm_regulator_get(&pdev->dev, "vbus");
-	if (IS_ERR(vbus)) {
+	otg_sx->vbus = devm_regulator_get(dev, "vbus");
+	if (IS_ERR(otg_sx->vbus)) {
 		dev_err(dev, "failed to get vbus\n");
-		return PTR_ERR(vbus);
+		return PTR_ERR(otg_sx->vbus);
 	}
-	otg_sx->vbus = vbus;
 
 	if (ssusb->dr_mode == USB_DR_MODE_HOST)
 		goto out;
-- 
2.20.1

