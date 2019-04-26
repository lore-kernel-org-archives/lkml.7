Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E333AC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1E1320869
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="VugJoNAy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfDZTuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 15:50:14 -0400
Received: from mail.z3ntu.xyz ([128.199.32.197]:46824 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbfDZTuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 15:50:13 -0400
Received: from localhost.localdomain (80-110-119-101.cgn.dynamic.surfer.at [80.110.119.101])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 002EBC5309;
        Fri, 26 Apr 2019 19:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1556308210; bh=cWxIdwLO5sI8TQbQdV/dUPitSThiFu9+Fx7tFqperkY=;
        h=From:To:Cc:Subject:Date;
        b=VugJoNAyrzbXxb2eRQMOweFZqG2Adl8X7a4dmOxGyRh5cExaP0SPqzqPZ5xpVeQs6
         c94HmCDDIHkX2XZ2D2ogmMKbHmlJh5VmwPSIG9M+znvQMjiKudBz0RAaw463t74vn8
         SRGrfvV+zI7qMRVKP8eykfLwNbLbAoMvyEUsG8EU=
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
Subject: [PATCH v5 1/3] dt-bindings: input: add GPIO controllable vibrator
Date:   Fri, 26 Apr 2019 21:47:45 +0200
Message-Id: <20190426194747.22256-1-luca@z3ntu.xyz>
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
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes for v5:
- Simply compatible property definition
- Remove reference to regulator schema

 .../bindings/input/gpio-vibrator.yaml         | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/gpio-vibrator.yaml

diff --git a/Documentation/devicetree/bindings/input/gpio-vibrator.yaml b/Documentation/devicetree/bindings/input/gpio-vibrator.yaml
new file mode 100644
index 000000000000..903475f52dbd
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/gpio-vibrator.yaml
@@ -0,0 +1,37 @@
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
+    const: gpio-vibrator
+
+  enable-gpios:
+    maxItems: 1
+
+  vcc-supply:
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

