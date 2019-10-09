Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9B7ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 08:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5335E21721
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 08:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="m6J/yf6Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730419AbfJIIwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 04:52:14 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42724 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730339AbfJIIwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 04:52:11 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x998q3OP025343;
        Wed, 9 Oct 2019 03:52:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1570611123;
        bh=fC04mwblTajTVnvmoWMuLWLDn77q7UtTpBvMGssifP0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=m6J/yf6Yln5vRgh1xPXofEaMM4YH5h7VUj3yMlhagBLBREZEUPX5HV4ATAJ32LCVH
         a8VIyIC+KyV4srOS04PoevmYcsn5/HZPLHFnFvN44OXfNuVAsyB3ZYx+KSpJUR9HsO
         y7GpCbgP0jbFCGOvSTw/vzQcUVOek4V3cTXW4Zko=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x998q3OH073709
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Oct 2019 03:52:03 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 9 Oct
 2019 03:52:01 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 9 Oct 2019 03:52:01 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x998q1dY099284;
        Wed, 9 Oct 2019 03:52:01 -0500
From:   Jean-Jacques Hiblot <jjhiblot@ti.com>
To:     <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>, <sre@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <lee.jones@linaro.org>, <daniel.thompson@linaro.org>
CC:     <dmurphy@ti.com>, <linux-leds@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <tomi.valkeinen@ti.com>, Jean-Jacques Hiblot <jjhiblot@ti.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v10 4/6] dts-bindings: leds: Document the naming requirement for LED properties
Date:   Wed, 9 Oct 2019 10:51:25 +0200
Message-ID: <20191009085127.22843-5-jjhiblot@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191009085127.22843-1-jjhiblot@ti.com>
References: <20191009085127.22843-1-jjhiblot@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LED properties must be named "leds" in the same way that PWM, clocks or
PHY properties are names respectively "pwms", "clocks" and "phys".

Cc: devicetree@vger.kernel.org
Signed-off-by: Jean-Jacques Hiblot <jjhiblot@ti.com>
---
 .../devicetree/bindings/leds/common.txt       | 20 ++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/common.txt b/Documentation/devicetree/bindings/leds/common.txt
index 9fa6f9795d50..31b8c1f68d27 100644
--- a/Documentation/devicetree/bindings/leds/common.txt
+++ b/Documentation/devicetree/bindings/leds/common.txt
@@ -10,6 +10,9 @@ can influence the way of the LED device initialization, the LED components
 have to be tightly coupled with the LED device binding. They are represented
 by child nodes of the parent LED device binding.
 
+LED properties should be named "leds". The exact meaning of each leds
+property must be documented in the device tree binding for each device.
+
 
 Optional properties for child nodes:
 - led-sources : List of device current outputs the LED is connected to. The
@@ -165,9 +168,20 @@ led-controller@30 {
 		function-enumerator = <2>;
         };
 
-        led@3 {
+        bkl_led0: led@3 {
 		reg = <3>;
-		function = LED_FUNCTION_INDICATOR;
-		function-enumerator = <3>;
+		function = LED_FUNCTION_BACKLIGHT;
+		function-enumerator = <1>;
         };
+
+        bkl_led1: led@4 {
+		reg = <4>;
+		function = LED_FUNCTION_BACKLIGHT;
+		function-enumerator = <2>;
+        };
+};
+
+
+backlight@40 {
+	leds = <&bkl_led0> , <&bkl_led1>;
 };
-- 
2.17.1

