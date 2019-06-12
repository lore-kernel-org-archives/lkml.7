Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA356C31E48
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 06:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0B7D2082C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 06:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731105AbfFLG2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 02:28:30 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:44590 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726010AbfFLG2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 02:28:30 -0400
X-UUID: ee68a5836ab848e7bba4d9c3af397e7a-20190612
X-UUID: ee68a5836ab848e7bba4d9c3af397e7a-20190612
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 653344176; Wed, 12 Jun 2019 14:28:16 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 12 Jun 2019 14:28:14 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 12 Jun 2019 14:28:15 +0800
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <wsd_upstream@mediatek.com>
Subject: [PATCH] mtu3: fix setup packet response for HNP and SRP request
Date:   Wed, 12 Jun 2019 14:28:07 +0800
Message-ID: <1560320892-30551-1-git-send-email-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: CE1AD9F9C4AB7DD47709BB3955B3B7E2FF4BB35A299C25F5C5745B5492155FC12000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Add OTG_HNP_REQD and OTG_SRP_REQD definitions in ch9.h.
2. When OTG_HNP_REQD and OTG_SRP_REQD has been received,
usb hardware must not enter TEST mode but need to response setup packet.
3. Add otg_srp_reqd and otg_hnp_reqd in struct ssusb_mtk for futher
implementation.

Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
---
 drivers/usb/mtu3/mtu3.h            |  4 ++++
 drivers/usb/mtu3/mtu3_gadget_ep0.c | 13 +++++++++++++
 include/uapi/linux/usb/ch9.h       |  5 +++++
 3 files changed, 22 insertions(+)

diff --git a/drivers/usb/mtu3/mtu3.h b/drivers/usb/mtu3/mtu3.h
index 76ecf12fdf62..bb8a31bc6e4d 100644
--- a/drivers/usb/mtu3/mtu3.h
+++ b/drivers/usb/mtu3/mtu3.h
@@ -226,6 +226,8 @@ struct otg_switch_mtk {
  * @dma_clk: dma_bus_ck clock for AXI bus etc
  * @dr_mode: works in which mode:
  *		host only, device only or dual-role mode
+ * @otg_srp_reqd: used for SRP request handling.
+ * @otg_hnp_reqd: used for HNP request handling.
  * @u2_ports: number of usb2.0 host ports
  * @u3_ports: number of usb3.0 host ports
  * @u3p_dis_msk: mask of disabling usb3 ports, for example, bit0==1 to
@@ -252,6 +254,8 @@ struct ssusb_mtk {
 	/* otg */
 	struct otg_switch_mtk otg_switch;
 	enum usb_dr_mode dr_mode;
+	bool otg_srp_reqd;
+	bool otg_hnp_reqd;
 	bool is_host;
 	int u2_ports;
 	int u3_ports;
diff --git a/drivers/usb/mtu3/mtu3_gadget_ep0.c b/drivers/usb/mtu3/mtu3_gadget_ep0.c
index 4da216c99726..1247c43a63e6 100644
--- a/drivers/usb/mtu3/mtu3_gadget_ep0.c
+++ b/drivers/usb/mtu3/mtu3_gadget_ep0.c
@@ -285,11 +285,24 @@ static int handle_test_mode(struct mtu3 *mtu, struct usb_ctrlrequest *setup)
 		dev_dbg(mtu->dev, "TEST_PACKET\n");
 		mtu->test_mode_nr = TEST_PACKET_MODE;
 		break;
+	case OTG_SRP_REQD:
+		dev_dbg(mtu->dev, "OTG_SRP_REQD\n");
+		mtu->ssusb->otg_srp_reqd = 1;
+		break;
+	case OTG_HNP_REQD:
+		dev_dbg(mtu->dev, "OTG_HNP_REQD\n");
+		mtu->ssusb->otg_hnp_reqd = 1;
+		break;
 	default:
 		handled = -EINVAL;
 		goto out;
 	}
 
+	if (mtu->ssusb->otg_srp_reqd || mtu->ssusb->otg_hnp_reqd) {
+		mtu->ep0_state = MU3D_EP0_STATE_SETUP;
+		goto out;
+	}
+
 	mtu->test_mode = true;
 
 	/* no TX completion interrupt, and need restart platform after test */
diff --git a/include/uapi/linux/usb/ch9.h b/include/uapi/linux/usb/ch9.h
index d5a5caec8fbc..545918c83fd1 100644
--- a/include/uapi/linux/usb/ch9.h
+++ b/include/uapi/linux/usb/ch9.h
@@ -143,6 +143,11 @@
 #define	TEST_SE0_NAK	3
 #define	TEST_PACKET	4
 #define	TEST_FORCE_EN	5
+/*
+ * OTG HNP and SRP REQD
+ */
+#define	OTG_SRP_REQD	6
+#define	OTG_HNP_REQD	7
 
 /* Status Type */
 #define USB_STATUS_TYPE_STANDARD	0
-- 
2.18.0

