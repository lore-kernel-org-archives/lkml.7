Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFDFC10F00
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 02:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9D0A206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 02:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfDCCJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 22:09:59 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:41826 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726847AbfDCCJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 22:09:58 -0400
X-UUID: ea5dbd37b2964ab1b0b545f07876188a-20190403
X-UUID: ea5dbd37b2964ab1b0b545f07876188a-20190403
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 51371909; Wed, 03 Apr 2019 10:09:45 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 3 Apr 2019 10:09:43 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 3 Apr 2019 10:09:36 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Min Guo <min.guo@mediatek.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [v3 PATCH 3/6] dt-bindings: usb: mtu3: add properties about USB Role Switch
Date:   Wed, 3 Apr 2019 10:09:11 +0800
Message-ID: <1554257354-7440-4-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1554257354-7440-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1554257354-7440-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the USB Role Switch is supported, so add properties about it

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v3: no changes

v2 changes:
  1. fix typo
  2. refer new binding about connector property
---
 .../devicetree/bindings/usb/mediatek,mtu3.txt          | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt b/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt
index 3382b5cb471d..6e004c4a89af 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt
@@ -27,7 +27,9 @@ Optional properties:
  - ranges : allows valid 1:1 translation between child's address space and
 	parent's address space
  - extcon : external connector for vbus and idpin changes detection, needed
-	when supports dual-role mode.
+	when supports dual-role mode; it's consiedered valid for compatibility
+	reasons, and not allowed for new bindings, use the property
+	usb-role-switch instead.
  - vbus-supply : reference to the VBUS regulator, needed when supports
 	dual-role mode.
  - pinctrl-names : a pinctrl state named "default" is optional, and need be
@@ -36,7 +38,8 @@ Optional properties:
 	is not set.
  - pinctrl-0 : pin control group
 	See: Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
-
+ - usb-role-switch : use USB Role Switch to support dual-role switch, but
+	not extcon
  - maximum-speed : valid arguments are "super-speed", "high-speed" and
 	"full-speed"; refer to usb/generic.txt
  - enable-manual-drd : supports manual dual-role switch via debugfs; usually
@@ -61,6 +64,9 @@ The xhci should be added as subnode to mtu3 as shown in the following example
 if host mode is enabled. The DT binding details of xhci can be found in:
 Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt
 
+The port would be added as subnode if use usb-role-switch property
+	see graph.txt
+
 Example:
 ssusb: usb@11271000 {
 	compatible = "mediatek,mt8173-mtu3";
-- 
2.20.1

