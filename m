Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE100C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70CBC205F4
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="c+yGk6a3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731283AbfDEOTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:19:19 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:43454 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfDEOTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 10:19:18 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x35EJDIT105437;
        Fri, 5 Apr 2019 09:19:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554473953;
        bh=bvOPZwpjyrX7mnjif/WpG8h/cJ6hzQgKsUg+/89iHI0=;
        h=From:To:CC:Subject:Date;
        b=c+yGk6a3LHYJUvWsym8aBb6GXMYW85ECC+n6ADU4A5D3RgBDXhYt+dpg86ByVDTb0
         DO2ky1fhRZC3//VJDJvqmvzjldOhLxMrP28JKjw2uCEUQMBB1FKekdTz2MFZdtvrtQ
         nsBf2ZxsI/mUDklQny5Yh25iljYspixAVzneke7M=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x35EJDVR067481
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Apr 2019 09:19:13 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 5 Apr
 2019 09:19:13 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 5 Apr 2019 09:19:13 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x35EJDuZ019639;
        Fri, 5 Apr 2019 09:19:13 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <robh+dt@kernel.org>, <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>,
        <lee.jones@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH] dt-bindings: mfd: LMU: Fix lm3632 dt binding example
Date:   Fri, 5 Apr 2019 09:19:07 -0500
Message-ID: <20190405141907.3348-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the lm3632 dt binding examples as the LCM enable GPIOs
are defined as enable GPIOs per the regulator/lm363x-regulator.txt
bindings document.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 Documentation/devicetree/bindings/mfd/ti-lmu.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/ti-lmu.txt b/Documentation/devicetree/bindings/mfd/ti-lmu.txt
index 980394d701a7..86ca786d54fc 100644
--- a/Documentation/devicetree/bindings/mfd/ti-lmu.txt
+++ b/Documentation/devicetree/bindings/mfd/ti-lmu.txt
@@ -104,8 +104,8 @@ lm3632@11 {
 	regulators {
 		compatible = "ti,lm363x-regulator";
 
-		ti,lcm-en1-gpio = <&pioC 0 GPIO_ACTIVE_HIGH>; /* PC0 */
-		ti,lcm-en2-gpio = <&pioC 1 GPIO_ACTIVE_HIGH>; /* PC1 */
+		enable-gpios = <&pioC 0 GPIO_ACTIVE_HIGH>,
+			       <&pioC 1 GPIO_ACTIVE_HIGH>;
 
 		vboost {
 			regulator-name = "lcd_boost";
-- 
2.19.0

