Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D131FC10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C4952171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="hbaPVrQF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfDLPGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:06:50 -0400
Received: from mail.z3ntu.xyz ([128.199.32.197]:54058 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbfDLPGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 11:06:49 -0400
Received: from localhost.localdomain (91-115-28-155.adsl.highway.telekom.at [91.115.28.155])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id AFA3EC18E6;
        Fri, 12 Apr 2019 15:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1555081606; bh=xilMGDYcI7Yf/yFk9bgc3wG2Ba5kxUmIJ6hiMqHOhSw=;
        h=From:To:Cc:Subject:Date;
        b=hbaPVrQF3R5hUVjKO67GbDG8+iVdL50IWPNvH6mfzCmTUyAus8gNJqtgTr7F84KUl
         gpznWTkH5teNjW9pJsmzev8Qm3SuxhL9tc4CIIC+FmFEZkPiRFPBIXFDlkcKlgkWdQ
         9DBeBx6gmN0blypRia9G3YaRG4oGpNqinuUHYNx0=
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
Subject: [PATCH v3 1/3] dt-bindings: input: add GPIO controllable vibrator
Date:   Fri, 12 Apr 2019 17:06:23 +0200
Message-Id: <20190412150625.28384-1-luca@z3ntu.xyz>
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
 .../bindings/input/gpio-vibrator.txt          | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/gpio-vibrator.txt

diff --git a/Documentation/devicetree/bindings/input/gpio-vibrator.txt b/Documentation/devicetree/bindings/input/gpio-vibrator.txt
new file mode 100644
index 000000000000..93e5a8e7622d
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/gpio-vibrator.txt
@@ -0,0 +1,20 @@
+* GPIO vibrator device tree bindings
+
+Registers a GPIO device as vibrator, where the vibration motor just has the
+capability to turn on or off. If the device is connected to a pwm, you should
+use the pwm-vibrator driver instead.
+
+Required properties:
+- compatible: should contain "gpio-vibrator"
+- enable-gpios: Should contain a GPIO handle
+
+Optional properties:
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

