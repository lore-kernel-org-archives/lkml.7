Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98147C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A9C206B7
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="PG0J+FYJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731161AbfDDJru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:47:50 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:38502 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730481AbfDDJrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:47:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1554371265; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=pC7IhBU1DSC3dGwjIZTkxjmjv2SxALVB8x57y+wbglU=;
        b=PG0J+FYJ6gyXUbUJuQ8IPYFXUSQDC/mXCB6ZVmucUAayf22IFCvub/9l5IkcfPttxKnqF4
        Oq+2kZUD9hiqy1vZ2T3cH2d4FdsBJchU++0ZqF2hrzw1bFtr0pqHNm8dx0xJ3SouaxkXEo
        bg5o1Gx9B5oQoBJ/7FV9y4OH+YWr2Mo=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Bin Liu <b-liu@ti.com>
Cc:     od@zcrc.me, linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 1/3] dt-bindings: usb: Add usb-phy property to the jz4740-musb node
Date:   Thu,  4 Apr 2019 11:47:37 +0200
Message-Id: <20190404094739.23503-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a required 'usb-phy' property, to obtain a phandle to the USB PHY
from devicetree.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: Change "usb-phy" DT property to "phys"

 Documentation/devicetree/bindings/usb/ingenic,jz4740-musb.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/ingenic,jz4740-musb.txt b/Documentation/devicetree/bindings/usb/ingenic,jz4740-musb.txt
index 620355cee63f..16808721f3ff 100644
--- a/Documentation/devicetree/bindings/usb/ingenic,jz4740-musb.txt
+++ b/Documentation/devicetree/bindings/usb/ingenic,jz4740-musb.txt
@@ -8,9 +8,15 @@ Required properties:
 - interrupt-names: must be "mc"
 - clocks: phandle to the "udc" clock
 - clock-names: must be "udc"
+- phys: phandle to the USB PHY
 
 Example:
 
+usb_phy: usb-phy@0 {
+	compatible = "usb-nop-xceiv";
+	#phy-cells = <0>;
+};
+
 udc: usb@13040000 {
 	compatible = "ingenic,jz4740-musb";
 	reg = <0x13040000 0x10000>;
@@ -21,4 +27,6 @@ udc: usb@13040000 {
 
 	clocks = <&cgu JZ4740_CLK_UDC>;
 	clock-names = "udc";
+
+	phys = <&usb_phy>;
 };
-- 
2.11.0

