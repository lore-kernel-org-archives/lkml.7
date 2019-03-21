Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30293C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F30DE21874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="xCU6CFsa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbfCUPKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:10:03 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:47246 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbfCUPKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 11:10:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1553181001; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=Rvw3eYzR213BH12vsryzVAbYH3MZt38Fuwhwieyydws=;
        b=xCU6CFsalyF4hn/chR8PjeqgP9jlNDhaHT630EcZ3hiO5zzUZoO/WYqARSnjGUHCu+z+uw
        hFgirGmcPTu+2kJGDJpLhtH8MXPgEWJnfCXPJfSiL0SQfxkYtZ7tzrNva1t5sbcEmQJd/g
        v/Tv9IGy9CkvSUryLPE0vnahsfuAJLA=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Bin Liu <b-liu@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, od@zcrc.me,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/3] dt-bindings: usb: Add usb-phy property to the jz4740-musb node
Date:   Thu, 21 Mar 2019 16:09:54 +0100
Message-Id: <20190321150956.6629-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a required 'usb-phy' property, to obtain a phandle to the USB PHY
from devicetree.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 Documentation/devicetree/bindings/usb/ingenic,jz4740-musb.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/ingenic,jz4740-musb.txt b/Documentation/devicetree/bindings/usb/ingenic,jz4740-musb.txt
index 620355cee63f..23213779f193 100644
--- a/Documentation/devicetree/bindings/usb/ingenic,jz4740-musb.txt
+++ b/Documentation/devicetree/bindings/usb/ingenic,jz4740-musb.txt
@@ -8,9 +8,15 @@ Required properties:
 - interrupt-names: must be "mc"
 - clocks: phandle to the "udc" clock
 - clock-names: must be "udc"
+- usb-phy: phandle to the USB PHY
 
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
+	usb-phy = <&usb_phy>;
 };
-- 
2.11.0

