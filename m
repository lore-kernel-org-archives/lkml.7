Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DEBC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 14:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0BFE20836
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 14:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="gmU34Yd0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfCBOL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 09:11:56 -0500
Received: from mail.z3ntu.xyz ([128.199.32.197]:35486 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbfCBOLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 09:11:55 -0500
Received: from localhost.localdomain (80-110-118-127.cgn.dynamic.surfer.at [80.110.118.127])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 6100FC5052;
        Sat,  2 Mar 2019 14:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1551535913; bh=URv8Iesj4qMowVM6J4UgsodrZDtb5bdRZ0k0tc+W0OY=;
        h=From:To:Cc:Subject:Date;
        b=gmU34Yd0Ufw+4zwoM6Ey/0Pi5TIIvhkTPNbk4L+NuoI9rhwwLk0PK5qSxwhBStUya
         DLyht4o7V+03x76AJ/jWSDsP2gOKtP+9EhE4uvtuLzJKKFzeayjGMT/wQDLP6m+a6/
         oSks5dTtSflCKN/ZKa4GzNxZAbRnVr8gn5uQlUAk=
From:   Luca Weiss <luca@z3ntu.xyz>
Cc:     Luca Weiss <luca@z3ntu.xyz>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-input@vger.kernel.org (open list:INPUT (KEYBOARD, MOUSE, JOYSTICK
        , TOUCHSCREEN)...),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] dt-bindings: input: add GPIO controllable vibrator
Date:   Sat,  2 Mar 2019 15:11:30 +0100
Message-Id: <20190302141132.21160-1-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a simple driver for GPIO controllable vibrators.
It will be used by the Fairphone 2.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 .../devicetree/bindings/input/gpio-vibrator.txt  | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/gpio-vibrator.txt

diff --git a/Documentation/devicetree/bindings/input/gpio-vibrator.txt b/Documentation/devicetree/bindings/input/gpio-vibrator.txt
new file mode 100644
index 000000000000..9e2e9acf497b
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/gpio-vibrator.txt
@@ -0,0 +1,16 @@
+* GPIO vibrator device tree bindings
+
+Registers a GPIO device as vibrator, where the vibration motor just has the capability to turn on or off. If the device is connected to a pwm, you should use the pwm-vibrator driver instead.
+
+Required properties:
+- compatible: should contain "gpio-vibrator"
+- enable-gpios: Should contain a GPIO handle
+- vcc-supply: Phandle for the regulator supplying power
+
+Example from Fairphone 2:
+
+vibrator {
+	compatible = "gpio-vibrator";
+	enable-gpios = <&msmgpio 86 GPIO_ACTIVE_HIGH>;
+	vcc-supply = <&pm8941_l18>;
+};
-- 
2.21.0

