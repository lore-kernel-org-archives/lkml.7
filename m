Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84224C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 18:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD2B218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 18:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="udYEy6/z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbfC2SNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 14:13:35 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:37860 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730014AbfC2SNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 14:13:25 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2TIDEfP043751;
        Fri, 29 Mar 2019 13:13:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553883194;
        bh=nNQcJ45/9+Yr37Cf2cn2y97LT1XbdDa5lSs/O4uQxYI=;
        h=From:To:CC:Subject:Date;
        b=udYEy6/zQAi/2djhUVIAhJowSHGbQsWmUKTrinX5OVmA4pWW836f5Mvb2bWFhtf9X
         blT3LDnqro8C915o/qIGvQcmXHW6fBQ7b/eZ6yTwdf1sjAllIxTUV2oe9BP+oZuG5n
         NKUvLVD6f7UchEbS0d7Op1NujWEDL76xSChtrzak=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2TIDEX1071885
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 Mar 2019 13:13:14 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 29
 Mar 2019 13:13:14 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 29 Mar 2019 13:13:14 -0500
Received: from legion.dal.desgin.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x2TIDEoj040382;
        Fri, 29 Mar 2019 13:13:14 -0500
Received: from localhost ([10.250.67.168])
        by legion.dal.desgin.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x2TIDDU04847;
        Fri, 29 Mar 2019 13:13:13 -0500 (CDT)
From:   "Andrew F. Davis" <afd@ti.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>
CC:     <devicetree@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH 1/4] ARM: dts: imx6: RDU2: Use new CODEC reset pin name
Date:   Fri, 29 Mar 2019 13:13:10 -0500
Message-ID: <20190329181313.21009-1-afd@ti.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The correct DT property for specifying a GPIO used for reset
is "reset-gpios", the driver now accepts this name, use it here.

Note the GPIO polarity in the driver was ignored before and always
assumed to be active low, when all the DTs are fixed we will start
respecting the specified polarity. Switch polarity in DT to the
currently assumed one, this way when the driver changes the
behavior will not change.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
index 69942c7ff89d..cbf7c9cae565 100644
--- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
@@ -384,7 +384,7 @@
 		AVDD-supply = <&reg_3p3v>;
 		IOVDD-supply = <&reg_3p3v>;
 		DVDD-supply = <&vgen4_reg>;
-		gpio-reset = <&gpio1 2 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio1 2 GPIO_ACTIVE_LOW>;
 	};
 
 	accel@1c {
@@ -572,7 +572,7 @@
 		AVDD-supply = <&reg_3p3v>;
 		IOVDD-supply = <&reg_3p3v>;
 		DVDD-supply = <&vgen4_reg>;
-		gpio-reset = <&gpio1 0 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;
 	};
 
 	touchscreen@20 {
-- 
2.21.0

