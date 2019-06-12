Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0E9C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 05:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF1C208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 05:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730781AbfFLFz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 01:55:57 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:24092 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730749AbfFLFzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 01:55:55 -0400
X-UUID: 48e9c147d8c44588a3ac909c68a8706f-20190612
X-UUID: 48e9c147d8c44588a3ac909c68a8706f-20190612
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 9459312; Wed, 12 Jun 2019 13:55:49 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 12 Jun 2019 13:55:47 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 12 Jun 2019 13:55:45 +0800
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
        <linux-kernel@vger.kernel.org>, Jumin Li <jumin.li@mediatek.com>
Subject: [PATCH 4/5] usb: mtu3: support force_vbus mode
Date:   Wed, 12 Jun 2019 13:55:20 +0800
Message-ID: <80b3e7ed4d7719b854816dfdd974772999a2e672.1560246390.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <5e06482a0be15476c7b5825f155accf98275afa8.1560246390.git.chunfeng.yun@mediatek.com>
References: <5e06482a0be15476c7b5825f155accf98275afa8.1560246390.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some SoCs don't support Vbus detection due to non-exist Vbus PIN,
so software need set force_vbus state when the controller works
as device mode.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/mtu3/mtu3.h      |  3 +++
 drivers/usb/mtu3/mtu3_core.c |  1 +
 drivers/usb/mtu3/mtu3_dr.c   |  2 ++
 drivers/usb/mtu3/mtu3_host.c |  1 +
 drivers/usb/mtu3/mtu3_plat.c | 23 +++++++++++++++++++++++
 5 files changed, 30 insertions(+)

diff --git a/drivers/usb/mtu3/mtu3.h b/drivers/usb/mtu3/mtu3.h
index 76ecf12fdf62..01b0dc9caa3e 100644
--- a/drivers/usb/mtu3/mtu3.h
+++ b/drivers/usb/mtu3/mtu3.h
@@ -231,6 +231,7 @@ struct otg_switch_mtk {
  * @u3p_dis_msk: mask of disabling usb3 ports, for example, bit0==1 to
  *		disable u3port0, bit1==1 to disable u3port1,... etc
  * @dbgfs_root: only used when supports manual dual-role switch via debugfs
+ * @force_vbus: without Vbus PIN, SW need set force_vbus state for device
  * @uwk_en: it's true when supports remote wakeup in host mode
  * @uwk: syscon including usb wakeup glue layer between SSUSB IP and SPM
  * @uwk_reg_base: the base address of the wakeup glue layer in @uwk
@@ -257,6 +258,7 @@ struct ssusb_mtk {
 	int u3_ports;
 	int u3p_dis_msk;
 	struct dentry *dbgfs_root;
+	bool force_vbus;
 	/* usb wakeup for host mode */
 	bool uwk_en;
 	struct regmap *uwk;
@@ -415,6 +417,7 @@ static inline void mtu3_clrbits(void __iomem *base, u32 offset, u32 bits)
 }
 
 int ssusb_check_clocks(struct ssusb_mtk *ssusb, u32 ex_clks);
+void ssusb_set_force_vbus(struct ssusb_mtk *ssusb, bool vbus_on);
 struct usb_request *mtu3_alloc_request(struct usb_ep *ep, gfp_t gfp_flags);
 void mtu3_free_request(struct usb_ep *ep, struct usb_request *req);
 void mtu3_req_complete(struct mtu3_ep *mep,
diff --git a/drivers/usb/mtu3/mtu3_core.c b/drivers/usb/mtu3/mtu3_core.c
index f8bd1d57e795..65aa382ffb85 100644
--- a/drivers/usb/mtu3/mtu3_core.c
+++ b/drivers/usb/mtu3/mtu3_core.c
@@ -604,6 +604,7 @@ static void mtu3_regs_init(struct mtu3 *mtu)
 	/* enable automatical HWRW from L1 */
 	mtu3_setbits(mbase, U3D_POWER_MANAGEMENT, LPM_HRWE);
 
+	ssusb_set_force_vbus(mtu->ssusb, true);
 	/* use new QMU format when HW version >= 0x1003 */
 	if (mtu->gen2cp)
 		mtu3_writel(mbase, U3D_QFCR, ~0x0);
diff --git a/drivers/usb/mtu3/mtu3_dr.c b/drivers/usb/mtu3/mtu3_dr.c
index 5fcb71af875a..006c5864ff45 100644
--- a/drivers/usb/mtu3/mtu3_dr.c
+++ b/drivers/usb/mtu3/mtu3_dr.c
@@ -173,8 +173,10 @@ static void ssusb_set_mailbox(struct otg_switch_mtk *otg_sx,
 	case MTU3_VBUS_OFF:
 		mtu3_stop(mtu);
 		pm_relax(ssusb->dev);
+		ssusb_set_force_vbus(ssusb, false);
 		break;
 	case MTU3_VBUS_VALID:
+		ssusb_set_force_vbus(ssusb, true);
 		/* avoid suspend when works as device */
 		pm_stay_awake(ssusb->dev);
 		mtu3_start(mtu);
diff --git a/drivers/usb/mtu3/mtu3_host.c b/drivers/usb/mtu3/mtu3_host.c
index c871b94f3e6f..7618a0c384f9 100644
--- a/drivers/usb/mtu3/mtu3_host.c
+++ b/drivers/usb/mtu3/mtu3_host.c
@@ -205,6 +205,7 @@ static void ssusb_host_setup(struct ssusb_mtk *ssusb)
 		ssusb_set_force_mode(ssusb, MTU3_DR_FORCE_HOST);
 
 	/* if port0 supports dual-role, works as host mode by default */
+	ssusb_set_force_vbus(ssusb, false);
 	ssusb_set_vbus(&ssusb->otg_switch, 1);
 }
 
diff --git a/drivers/usb/mtu3/mtu3_plat.c b/drivers/usb/mtu3/mtu3_plat.c
index fd0f6c5dfbc1..e9d313e92fc3 100644
--- a/drivers/usb/mtu3/mtu3_plat.c
+++ b/drivers/usb/mtu3/mtu3_plat.c
@@ -45,6 +45,27 @@ int ssusb_check_clocks(struct ssusb_mtk *ssusb, u32 ex_clks)
 	return 0;
 }
 
+void ssusb_set_force_vbus(struct ssusb_mtk *ssusb, bool vbus_on)
+{
+	u32 u2ctl;
+	u32 misc;
+
+	if (!ssusb->force_vbus)
+		return;
+
+	u2ctl = mtu3_readl(ssusb->ippc_base, SSUSB_U2_CTRL(0));
+	misc = mtu3_readl(ssusb->mac_base, U3D_MISC_CTRL);
+	if (vbus_on) {
+		u2ctl &= ~SSUSB_U2_PORT_OTG_SEL;
+		misc |= VBUS_FRC_EN | VBUS_ON;
+	} else {
+		u2ctl |= SSUSB_U2_PORT_OTG_SEL;
+		misc &= ~(VBUS_FRC_EN | VBUS_ON);
+	}
+	mtu3_writel(ssusb->ippc_base, SSUSB_U2_CTRL(0), u2ctl);
+	mtu3_writel(ssusb->mac_base, U3D_MISC_CTRL, misc);
+}
+
 static int ssusb_phy_init(struct ssusb_mtk *ssusb)
 {
 	int i;
@@ -268,6 +289,8 @@ static int get_ssusb_rscs(struct platform_device *pdev, struct ssusb_mtk *ssusb)
 	if (IS_ERR(ssusb->ippc_base))
 		return PTR_ERR(ssusb->ippc_base);
 
+	ssusb->force_vbus = of_property_read_bool(node, "mediatek,force-vbus");
+
 	ssusb->dr_mode = usb_get_dr_mode(dev);
 	if (ssusb->dr_mode == USB_DR_MODE_UNKNOWN)
 		ssusb->dr_mode = USB_DR_MODE_OTG;
-- 
2.21.0

