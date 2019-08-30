Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19930C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDD0922CE3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 07:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbfH3Hln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 03:41:43 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:12945 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728263AbfH3Hll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 03:41:41 -0400
X-UUID: 9833484203254332b3cccbd93e8fca5c-20190830
X-UUID: 9833484203254332b3cccbd93e8fca5c-20190830
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 406786229; Fri, 30 Aug 2019 15:41:09 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 30 Aug 2019 15:41:07 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 30 Aug 2019 15:41:06 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 4/7] usb: mtk-xhci: support ip-sleep wakeup for MT8183
Date:   Fri, 30 Aug 2019 15:40:51 +0800
Message-ID: <1567150854-30033-5-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1567150854-30033-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1567150854-30033-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 0CC1AD750E0584FBAD4C3A1BDC6182D22AD563DBB0112078F6AB14F6D427608F2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support USB wakeup by ip-sleep mode for MT8183, it's similar to
MT8173

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v3: change micros define

v2: no changes
---
 drivers/usb/host/xhci-mtk.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index 026fe18972d3..9b30a868a7ab 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -57,6 +57,12 @@
 #define CTRL_U2_FORCE_PLL_STB	BIT(28)
 
 /* usb remote wakeup registers in syscon */
+/* mt8183 etc */
+#define PERI_WK_CTRL0	0x20
+#define WC0_IS_C(x)	(((x) & 0xf) << 28)  /* cycle debounce */
+#define WC0_IS_P	BIT(12)	/* polarity */
+#define WC0_IS_EN	BIT(6)
+
 /* mt8173 etc */
 #define PERI_WK_CTRL1	0x4
 #define WC1_IS_C(x)	(((x) & 0xf) << 26)  /* cycle debounce */
@@ -69,7 +75,8 @@
 #define SSC_SPM_INT_EN		BIT(1)
 
 enum ssusb_uwk_vers {
-	SSUSB_UWK_V1 = 1,
+	SSUSB_UWK_V0 = 0,
+	SSUSB_UWK_V1,
 	SSUSB_UWK_V2,
 };
 
@@ -282,6 +289,11 @@ static void usb_wakeup_ip_sleep_set(struct xhci_hcd_mtk *mtk, bool enable)
 	u32 reg, msk, val;
 
 	switch (mtk->uwk_vers) {
+	case SSUSB_UWK_V0:
+		reg = mtk->uwk_reg_base + PERI_WK_CTRL0;
+		msk = WC0_IS_EN | WC0_IS_C(0xf) | WC0_IS_P;
+		val = enable ? (WC0_IS_EN | WC0_IS_C(0x8)) : 0;
+		break;
 	case SSUSB_UWK_V1:
 		reg = mtk->uwk_reg_base + PERI_WK_CTRL1;
 		msk = WC1_IS_EN | WC1_IS_C(0xf) | WC1_IS_P;
-- 
2.23.0

