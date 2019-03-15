Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A921EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 07:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE6821871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 07:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbfCOHk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 03:40:26 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:38523 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728060AbfCOHkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 03:40:24 -0400
X-UUID: 453f82dca0334daf8fe2bb78891f9e98-20190315
X-UUID: 453f82dca0334daf8fe2bb78891f9e98-20190315
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 147579338; Fri, 15 Mar 2019 15:40:17 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 15 Mar 2019 15:40:14 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 15 Mar 2019 15:40:14 +0800
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
        Min Guo <min.guo@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 3/6] dt-bindings: usb: mtu3: add properties about USB Role Switch
Date:   Fri, 15 Mar 2019 15:38:30 +0800
Message-ID: <1552635513-2378-4-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1552635513-2378-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1552635513-2378-1-git-send-email-chunfeng.yun@mediatek.com>
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
v2 changes:
  1. fix typo
  2. refer new binding about connector property
---
 .../devicetree/bindings/usb/mediatek,mtu3.txt          | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt b/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt
index 3382b5cb471d..359e8d565b54 100644
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
 
+The connector would be added as subnode if receptacle is Micro.
+	see usb/typeb-switch-gpio.txt
+
 Example:
 ssusb: usb@11271000 {
 	compatible = "mediatek,mt8173-mtu3";
-- 
2.20.1

