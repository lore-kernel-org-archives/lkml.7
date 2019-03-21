Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68276C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 02:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E4D218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 02:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbfCUCym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 22:54:42 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:32830 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727859AbfCUCyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 22:54:39 -0400
X-UUID: 27fd29d830144a279d91a6a8c2bddeb9-20190321
X-UUID: 27fd29d830144a279d91a6a8c2bddeb9-20190321
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1682275090; Thu, 21 Mar 2019 10:54:30 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 21 Mar 2019 10:54:29 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 21 Mar 2019 10:54:28 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [RESEND PATCH 02/11] usb: mtu3: print useful information also for device and host modes
Date:   Thu, 21 Mar 2019 10:53:40 +0800
Message-ID: <1553136829-14712-3-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1553136829-14712-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1553136829-14712-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print useful information not only dual-role mode but also
device mode and host mode.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_plat.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_plat.c b/drivers/usb/mtu3/mtu3_plat.c
index dee31d5eefe1..3a4a80f15957 100644
--- a/drivers/usb/mtu3/mtu3_plat.c
+++ b/drivers/usb/mtu3/mtu3_plat.c
@@ -286,7 +286,7 @@ static int get_ssusb_rscs(struct platform_device *pdev, struct ssusb_mtk *ssusb)
 		ssusb->dr_mode = USB_DR_MODE_OTG;
 
 	if (ssusb->dr_mode == USB_DR_MODE_PERIPHERAL)
-		return 0;
+		goto out;
 
 	/* if host role is supported */
 	ret = ssusb_wakeup_of_property_parse(ssusb, node);
@@ -307,7 +307,7 @@ static int get_ssusb_rscs(struct platform_device *pdev, struct ssusb_mtk *ssusb)
 	otg_sx->vbus = vbus;
 
 	if (ssusb->dr_mode == USB_DR_MODE_HOST)
-		return 0;
+		goto out;
 
 	/* if dual-role mode is supported */
 	otg_sx->is_u3_drd = of_property_read_bool(node, "mediatek,usb3-drd");
@@ -322,6 +322,7 @@ static int get_ssusb_rscs(struct platform_device *pdev, struct ssusb_mtk *ssusb)
 		}
 	}
 
+out:
 	dev_info(dev, "dr_mode: %d, is_u3_dr: %d, u3p_dis_msk: %x, drd: %s\n",
 		ssusb->dr_mode, otg_sx->is_u3_drd, ssusb->u3p_dis_msk,
 		otg_sx->manual_drd_enabled ? "manual" : "auto");
-- 
2.20.1

