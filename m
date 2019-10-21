Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F11CA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 17:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C41A2064B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 17:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="m52aS8bF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbfJURsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 13:48:41 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:45506 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfJURsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 13:48:40 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9LHmYfx106826;
        Mon, 21 Oct 2019 12:48:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571680114;
        bh=BIhYVTQWymD4mY31+ZJn/sbNnTMn160ESSh3gpWtn5Y=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=m52aS8bFak5L9jNVz3ugYup3CO4bzxZHoHurehVUKD+hHaunDHVCOtx23YOr/KEL5
         0dKWKV22SWB3RJjNJbmduJrZQwMxFCqXAsmwVQCA4hVXns0vMr1TbS/wIezsLty1Ww
         BYK2/A27riGk9EhwQnTLSA1jfV0WKWYZzmURaW+0=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9LHmIW1047774
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Oct 2019 12:48:19 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 21
 Oct 2019 12:48:08 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 21 Oct 2019 12:48:08 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9LHmGFk111774;
        Mon, 21 Oct 2019 12:48:17 -0500
From:   Jean-Jacques Hiblot <jjhiblot@ti.com>
To:     <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>
CC:     <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tomi.valkeinen@ti.com>, <jjhiblot@ti.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v7 1/2] dt-bindings: leds: document the "power-supply" property
Date:   Mon, 21 Oct 2019 19:47:50 +0200
Message-ID: <20191021174751.4421-2-jjhiblot@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191021174751.4421-1-jjhiblot@ti.com>
References: <20191021174751.4421-1-jjhiblot@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the LEDs are powered by a voltage/current regulator. Describing it
in the device-tree makes it possible for the LED core to enable/disable it
when needed.

Cc: devicetree@vger.kernel.org
To: robh+dt@kernel.org
To: mark.rutland@arm.com
Signed-off-by: Jean-Jacques Hiblot <jjhiblot@ti.com>
---
 Documentation/devicetree/bindings/leds/common.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/common.txt b/Documentation/devicetree/bindings/leds/common.txt
index 6d44f0c38487..dacaf863d687 100644
--- a/Documentation/devicetree/bindings/leds/common.txt
+++ b/Documentation/devicetree/bindings/leds/common.txt
@@ -96,6 +96,19 @@ Optional properties for child nodes:
 - panic-indicator : This property specifies that the LED should be used,
 		    if at all possible, as a panic indicator.
 
+- power-supply : A voltage/current regulator used to to power the LED. When a
+		 LED is turned off, the LED core disable its regulator. The
+		 same regulator can power many LED (or other) devices. It is
+		 turned off only when all of its users disabled it.
+
+- power-off-delays-ms: This property specifies the delay between the time a LED
+                       is turned off and the time the regulator is turned off.
+                       It can be used to limit the overhead of the regulator
+                       handling if the LED is toggling fast.
+                       ex: if power-off-delays-ms is set to 500 ms, the
+                       regulator will not be turned off until the LED is turned
+                       off for more than 500ms.
+
 - trigger-sources : List of devices which should be used as a source triggering
 		    this LED activity. Some LEDs can be related to a specific
 		    device and should somehow indicate its state. E.g. USB 2.0
@@ -143,6 +156,7 @@ led-controller@0 {
 		function = LED_FUNCTION_STATUS;
 		linux,default-trigger = "heartbeat";
 		gpios = <&gpio0 0 GPIO_ACTIVE_HIGH>;
+		power-supply = <&led_regulator>;
 	};
 
 	led1 {
-- 
2.17.1

