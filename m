Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B89C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84ED72064A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729622AbfCFLq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 06:46:56 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:37621 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729490AbfCFLqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 06:46:55 -0500
X-UUID: a2a2dbefbdf54025aef51791f4951fd6-20190306
X-UUID: a2a2dbefbdf54025aef51791f4951fd6-20190306
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 846422692; Wed, 06 Mar 2019 19:46:47 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 6 Mar 2019 19:46:45 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 6 Mar 2019 19:46:45 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 01/11] usb: mtu3: check return value of devm_extcon_register_notifier()
Date:   Wed, 6 Mar 2019 19:46:13 +0800
Message-ID: <1551872783-13707-2-git-send-email-chunfeng.yun@mediatek.com>
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

Check the return value of devm_extcon_register_notifier() and
add error handling.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3_dr.c   | 13 +++++++++----
 drivers/usb/mtu3/mtu3_plat.c |  8 +++++++-
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_dr.c b/drivers/usb/mtu3/mtu3_dr.c
index ac60e9c8564e..61694c40e101 100644
--- a/drivers/usb/mtu3/mtu3_dr.c
+++ b/drivers/usb/mtu3/mtu3_dr.c
@@ -238,14 +238,18 @@ static int ssusb_extcon_register(struct otg_switch_mtk *otg_sx)
 	otg_sx->vbus_nb.notifier_call = ssusb_vbus_notifier;
 	ret = devm_extcon_register_notifier(ssusb->dev, edev, EXTCON_USB,
 					&otg_sx->vbus_nb);
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(ssusb->dev, "failed to register notifier for USB\n");
+		return ret;
+	}
 
 	otg_sx->id_nb.notifier_call = ssusb_id_notifier;
 	ret = devm_extcon_register_notifier(ssusb->dev, edev, EXTCON_USB_HOST,
 					&otg_sx->id_nb);
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(ssusb->dev, "failed to register notifier for USB-HOST\n");
+		return ret;
+	}
 
 	dev_dbg(ssusb->dev, "EXTCON_USB: %d, EXTCON_USB_HOST: %d\n",
 		extcon_get_state(edev, EXTCON_USB),
@@ -415,6 +419,7 @@ void ssusb_set_force_mode(struct ssusb_mtk *ssusb,
 int ssusb_otg_switch_init(struct ssusb_mtk *ssusb)
 {
 	struct otg_switch_mtk *otg_sx = &ssusb->otg_switch;
+	int ret = 0;
 
 	INIT_WORK(&otg_sx->id_work, ssusb_id_work);
 	INIT_WORK(&otg_sx->vbus_work, ssusb_vbus_work);
@@ -422,9 +427,9 @@ int ssusb_otg_switch_init(struct ssusb_mtk *ssusb)
 	if (otg_sx->manual_drd_enabled)
 		ssusb_debugfs_init(ssusb);
 	else
-		ssusb_extcon_register(otg_sx);
+		ret = ssusb_extcon_register(otg_sx);
 
-	return 0;
+	return ret;
 }
 
 void ssusb_otg_switch_exit(struct ssusb_mtk *ssusb)
diff --git a/drivers/usb/mtu3/mtu3_plat.c b/drivers/usb/mtu3/mtu3_plat.c
index e086630e41a9..dee31d5eefe1 100644
--- a/drivers/usb/mtu3/mtu3_plat.c
+++ b/drivers/usb/mtu3/mtu3_plat.c
@@ -401,7 +401,11 @@ static int mtu3_probe(struct platform_device *pdev)
 			goto gadget_exit;
 		}
 
-		ssusb_otg_switch_init(ssusb);
+		ret = ssusb_otg_switch_init(ssusb);
+		if (ret) {
+			dev_err(dev, "failed to initialize switch\n");
+			goto host_exit;
+		}
 		break;
 	default:
 		dev_err(dev, "unsupported mode: %d\n", ssusb->dr_mode);
@@ -411,6 +415,8 @@ static int mtu3_probe(struct platform_device *pdev)
 
 	return 0;
 
+host_exit:
+	ssusb_host_exit(ssusb);
 gadget_exit:
 	ssusb_gadget_exit(ssusb);
 comm_exit:
-- 
2.20.1

