Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C126C28CC3
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 01:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59F76277CB
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 01:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfFBBE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 21:04:27 -0400
Received: from mailgw01.mediatek.com ([216.200.240.184]:58334 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfFBBE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 21:04:27 -0400
X-UUID: 66ed6f722bb24d64bf3ae33a0e242ed2-20190601
X-UUID: 66ed6f722bb24d64bf3ae33a0e242ed2-20190601
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1308218860; Sat, 01 Jun 2019 17:04:23 -0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 1 Jun 2019 18:04:21 -0700
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 2 Jun 2019 09:04:20 +0800
From:   <sean.wang@mediatek.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v1 1/4] dt-bindings: net: bluetooth: add boot-gpios property to UART-based device
Date:   Sun, 2 Jun 2019 09:04:14 +0800
Message-ID: <1559437457-26766-2-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1559437457-26766-1-git-send-email-sean.wang@mediatek.com>
References: <1559437457-26766-1-git-send-email-sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Not every platform has the pinctrl device integrates the GPIO the function
such as MT7621 whose pinctrl and GPIO are separate hardware so adding an
additional boot-gpios property for such platform allows them to bring up
the device.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../devicetree/bindings/net/mediatek-bluetooth.txt  | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/mediatek-bluetooth.txt b/Documentation/devicetree/bindings/net/mediatek-bluetooth.txt
index 41a7dcc80f5b..14f23b354a6d 100644
--- a/Documentation/devicetree/bindings/net/mediatek-bluetooth.txt
+++ b/Documentation/devicetree/bindings/net/mediatek-bluetooth.txt
@@ -50,11 +50,24 @@ Required properties:
 		  "mediatek,mt7663u-bluetooth": for MT7663U device
 		  "mediatek,mt7668u-bluetooth": for MT7668U device
 - vcc-supply:	Main voltage regulator
+
+If the pin controller on the platform can support both pinmux and GPIO
+control such as the most of MediaTek platform. Please use below properties.
+
 - pinctrl-names: Should be "default", "runtime"
 - pinctrl-0: Should contain UART RXD low when the device is powered up to
 	     enter proper bootstrap mode.
 - pinctrl-1: Should contain UART mode pin ctrl
 
+Else, the pin controller on the platform only can support pinmux control and
+the GPIO control still has to rely on the dedicated GPIO controller such as
+a legacy MediaTek SoC, MT7621. Please use the below properties.
+
+- boot-gpios:	GPIO same to the pin as UART RXD and used to keep LOW when
+		the device is powered up to enter proper bootstrap mode when
+- pinctrl-names: Should be "default"
+- pinctrl-0: Should contain UART mode pin ctrl
+
 Optional properties:
 
 - reset-gpios:	GPIO used to reset the device whose initial state keeps low,
-- 
2.17.1

