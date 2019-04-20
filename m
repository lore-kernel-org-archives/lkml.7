Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A50C282E2
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 12:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C62E921871
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 12:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="W/vcSW1w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbfDTMYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 08:24:16 -0400
Received: from mail.z3ntu.xyz ([128.199.32.197]:46428 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbfDTMYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 08:24:16 -0400
Received: from localhost.localdomain (91-115-28-155.adsl.highway.telekom.at [91.115.28.155])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 1F776C17A5;
        Sat, 20 Apr 2019 12:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1555763053; bh=U/6xQAEPyP1EsnAjW4EqK13j+ZKhfQvV0IwSY8CpWEk=;
        h=From:To:Cc:Subject:Date;
        b=W/vcSW1w5ZNHo1cbiwivBW18eUdf1jQrpGnDl20De+Ki/yO4QJSV2fi9NyxwkfVnd
         tXou1MywKLQKzAbL2DvVJs8yq1SbCDcC42AI7+iMGlD2u4hCC3BHAeZRz3IUumeAZ/
         MF6U2Aaa09FsBxvXKpeoWusmV0kZaEGN9hCyLvP4=
From:   Luca Weiss <luca@z3ntu.xyz>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Pascal PAILLET-LME <p.paillet@st.com>,
        Coly Li <colyli@suse.de>, Lee Jones <lee.jones@linaro.org>,
        Xiaotong Lu <xiaotong.lu@spreadtrum.com>,
        Brian Masney <masneyb@onstation.org>,
        Rob Herring <robh@kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        linux-input@vger.kernel.org (open list:INPUT (KEYBOARD, MOUSE, JOYSTICK
        , TOUCHSCREEN)...),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list),
        Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH v4 1/3] dt-bindings: input: add GPIO controllable vibrator
Date:   Sat, 20 Apr 2019 14:23:31 +0200
Message-Id: <20190420122333.23662-1-luca@z3ntu.xyz>
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
Changes from v3:
- Convert .txt based doc to the new yaml based format

 .../bindings/input/gpio-vibrator.yaml         | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/gpio-vibrator.yaml

diff --git a/Documentation/devicetree/bindings/input/gpio-vibrator.yaml b/Documentation/devicetree/bindings/input/gpio-vibrator.yaml
new file mode 100644
index 000000000000..bca1b6ea07a4
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/gpio-vibrator.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/input/gpio-vibrator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GPIO vibrator
+
+maintainers:
+  - Luca Weiss <luca@z3ntu.xyz>
+
+description: |+
+  Registers a GPIO device as vibrator, where the on/off capability is controlled by a GPIO.
+
+properties:
+  compatible:
+    items:
+      - const: gpio-vibrator
+
+  enable-gpios:
+    maxItems: 1
+
+  vcc-supply:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Regulator that provides power
+
+required:
+  - compatible
+  - enable-gpios
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    vibrator {
+        compatible = "gpio-vibrator";
+        enable-gpios = <&msmgpio 86 GPIO_ACTIVE_HIGH>;
+        vcc-supply = <&pm8941_l18>;
+    };
-- 
2.21.0

