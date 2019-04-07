Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB555C282DD
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 16:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9124321901
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 16:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="mE9MAjX6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfDGQFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 12:05:37 -0400
Received: from mail.z3ntu.xyz ([128.199.32.197]:33480 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbfDGQFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 12:05:36 -0400
Received: from localhost.localdomain (80-110-119-101.cgn.dynamic.surfer.at [80.110.119.101])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id DE363C1588;
        Sun,  7 Apr 2019 15:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1554652737; bh=IebeXy2FuMBusMkGiYMmOhOIgw3AZX/LiLxh3cqwBbM=;
        h=From:To:Cc:Subject:Date;
        b=mE9MAjX6Xx4c5SwRg6+Anzn0luAEYhKskccc+kaEAepw/HZONUUhqNSsDU5QWUPV1
         JmL5uL0Wv/vLPIev7A6Tcb31Gdn59KtDSNLZnBmPkwd1IpUF2gzZhFyJkbhNiyEfZK
         i9Ee32SvVWSCFlUL+8gmjpIWCClv+zNSELHKq67M=
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
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        linux-input@vger.kernel.org (open list:INPUT (KEYBOARD, MOUSE, JOYSTICK
        , TOUCHSCREEN)...),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list),
        Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH v2 1/3] dt-bindings: input: add GPIO controllable vibrator
Date:   Sun,  7 Apr 2019 17:58:40 +0200
Message-Id: <20190407155841.27354-1-luca@z3ntu.xyz>
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
Changes from v1:
- Mark vcc-supply as optional

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

