Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1450AC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 16:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB6D321835
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 16:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QoOAt2yU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfLFQr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 11:47:26 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37194 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfLFQr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 11:47:26 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB6GlLfs053956;
        Fri, 6 Dec 2019 10:47:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575650841;
        bh=eWOw3QJP4L3LAo1YWMiAnMJSvxy22UtNfCBkDyDbRAU=;
        h=From:To:CC:Subject:Date;
        b=QoOAt2yUVAML0QV72QVvIDE3vjRsNrx0mhOOBCsFDLNZujeg+TJFt+V0wSOiBmqsQ
         eYkB+hOk5dMwOE4/pJOLspTeRvM1ZL+AsJmp5MZxd+c4sRZmMvNF8reuKOs3idEIhh
         N/Lw2UrjC0QlzMmHnkWds7VVGEJ/ls7i7iFPWRIc=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xB6GlLj3117204
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 6 Dec 2019 10:47:21 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 6 Dec
 2019 10:47:21 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 6 Dec 2019 10:47:21 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB6GlLsQ106733;
        Fri, 6 Dec 2019 10:47:21 -0600
From:   Dan Murphy <dmurphy@ti.com>
To:     <andrew@lunn.ch>, <f.fainelli@gmail.com>, <hkallweit1@gmail.com>,
        <bunk@kernel.org>
CC:     <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <grygorii.strashko@ti.com>,
        Dan Murphy <dmurphy@ti.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH 1/2] dt-bindings: dp83867: Convert fifo-depth to common fifo-depth and make optional
Date:   Fri, 6 Dec 2019 10:45:15 -0600
Message-ID: <20191206164516.2702-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the ti,fifo-depth from a TI specific property to the common
tx-fifo-depth property.  Also add support for the rx-fifo-depth.

These are optional properties for this device and if these are not
available then the fifo depths are set to device default values.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
Reported-by: Adrian Bunk <bunk@kernel.org>
CC: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/net/ti,dp83867.txt | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/ti,dp83867.txt b/Documentation/devicetree/bindings/net/ti,dp83867.txt
index db6aa3f2215b..8c733ef0941f 100644
--- a/Documentation/devicetree/bindings/net/ti,dp83867.txt
+++ b/Documentation/devicetree/bindings/net/ti,dp83867.txt
@@ -8,8 +8,6 @@ Required properties:
 	- ti,tx-internal-delay - RGMII Transmit Clock Delay - see dt-bindings/net/ti-dp83867.h
 		for applicable values. Required only if interface type is
 		PHY_INTERFACE_MODE_RGMII_ID or PHY_INTERFACE_MODE_RGMII_TXID
-	- ti,fifo-depth - Transmitt FIFO depth- see dt-bindings/net/ti-dp83867.h
-		for applicable values
 
 Note: If the interface type is PHY_INTERFACE_MODE_RGMII the TX/RX clock delays
       will be left at their default values, as set by the PHY's pin strapping.
@@ -38,6 +36,14 @@ Optional property:
 			      be disabled by this property.  When omitted, the
 			      PHY's default will be left as is.
 
+	- ti,fifo-depth - Transmitt FIFO depth- see dt-bindings/net/ti-dp83867.h
+		for applicable values (deprecated)
+
+	-tx-fifo-depth - As defined in the ethernet-controller.yaml.  Values for
+			 the depth can be found in dt-bindings/net/ti-dp83867.h
+	-rx-fifo-depth - As defined in the ethernet-controller.yaml.  Values for
+			 the depth can be found in dt-bindings/net/ti-dp83867.h
+
 Note: ti,min-output-impedance and ti,max-output-impedance are mutually
       exclusive. When both properties are present ti,max-output-impedance
       takes precedence.
@@ -51,7 +57,7 @@ Example:
 		reg = <0>;
 		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_25_NS>;
 		ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_75_NS>;
-		ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
+		tx-fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
 	};
 
 Datasheet can be found:
-- 
2.23.0

