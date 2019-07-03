Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E47C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 19:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5872189E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 19:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ma8dAgiY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfGCTCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 15:02:52 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35156 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbfGCTCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 15:02:50 -0400
Received: by mail-pf1-f196.google.com with SMTP id u14so537080pfn.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 12:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BC0nre0H3tvgyc6oXK8ECt6TQUf5AweD/WSSfFgWqFY=;
        b=ma8dAgiYcin9n/ZPxPg0zlPmu1i7ueMiEvkJWEG5PthI85vwAFigHVuv86JwJCsZrH
         nZtW+R7WO0y3zuoTbd4VKmDii5btn5hS33s+M6SuWcg9fXpOcpOvryrMEgjaNIxYeDoe
         hI47qE0VOD1BGNlC+VJz+7DLBhf5H4yS2uH1MkHjybGHFd1wNoB6RLuROyBMMoYP2m+9
         RmOOLVMTn+5cE6/MGQdtqwHpET3PlcR77+o86jLz3FCgGxWw+w3GRvFmbT/2vqnmO98W
         Jslm2GWQnc6pdf9Qzvd/pb216f1HjtfH2T2/Kz5TqH7hjdjhALYeYNrQ7fkI8ZPy0KQS
         klZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BC0nre0H3tvgyc6oXK8ECt6TQUf5AweD/WSSfFgWqFY=;
        b=dYsJQVJf5r8lQ8KBIxyPWE2fG2Zx1o0sj1h/Kv+u2g0Ssn5CVL187jgvMe/SK+PNgb
         6g+V+5JerhdpKuo3elhVM23bcua0l57+q4rJ8/JZjBkzDPkdd4nW0VxpjWDmfZrdm6Tz
         sDlBhkj9Au7QgIpvG1KSQu6vKlw+aFO3Zv0+wdTkvBsHmX70sLIlMAy8tkcDzwAEKsJR
         0VA4clXYIu49EGh0LhSgLe8iqW6OdB3X3h3rTqlRwcP0z60PocvsWh4DRN0wBammQtz3
         xmzwgs4syvWGGF+SLhzAw3cMKNahQYZSa+ee92832izmrkEKLEoaDi/Vj/a0MKp1lMgW
         l8NQ==
X-Gm-Message-State: APjAAAWZm4z0qyyJ2cPgBsX+6+a4bakypsIx7YxvUimW6h3uGDQM8kfL
        PaBEWvGSvqdMqrwIP4fB9OzK
X-Google-Smtp-Source: APXvYqyufa3DkEExHyBid0gOffNH2ZRyxbIRfu+jKWfFJLJlxWgytv1PVRZo7b8pHu4aIkau6/cO7g==
X-Received: by 2002:a17:90a:d998:: with SMTP id d24mr11734240pjv.89.1562180569251;
        Wed, 03 Jul 2019 12:02:49 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:117:d72f:1d34:d0bb:bb4e:3065])
        by smtp.gmail.com with ESMTPSA id j14sm3631503pfn.120.2019.07.03.12.02.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 12:02:48 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mchehab@kernel.org, robh+dt@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        c.barrett@framos.com, a.brela@framos.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/3] dt-bindings: media: i2c: Add IMX290 CMOS sensor binding
Date:   Thu,  4 Jul 2019 00:32:28 +0530
Message-Id: <20190703190230.12392-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190703190230.12392-1-manivannan.sadhasivam@linaro.org>
References: <20190703190230.12392-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for IMX290 CMOS image sensor.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../devicetree/bindings/media/i2c/imx290.txt  | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/imx290.txt

diff --git a/Documentation/devicetree/bindings/media/i2c/imx290.txt b/Documentation/devicetree/bindings/media/i2c/imx290.txt
new file mode 100644
index 000000000000..7535b5b5b24b
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/imx290.txt
@@ -0,0 +1,51 @@
+* Sony IMX290 1/2.8-Inch CMOS Image Sensor
+
+The Sony IMX290 is a 1/2.8-Inch CMOS Solid-state image sensor with
+Square Pixel for Color Cameras. It is programmable through I2C and 4-wire
+interfaces. The sensor output is available via CMOS logic parallel SDR output,
+Low voltage LVDS DDR output and CSI-2 serial data output.
+
+Required Properties:
+- compatible: Should be "sony,imx290"
+- reg: I2C bus address of the device
+- clocks: Reference to the xclk clock.
+- clock-names: Should be "xclk".
+- clock-frequency: Frequency of the xclk clock.
+- vdddo-supply: Sensor digital IO regulator.
+- vdda-supply: Sensor analog regulator.
+- vddd-supply: Sensor digital core regulator.
+
+Optional Properties:
+- reset-gpios: Sensor reset GPIO
+
+The imx290 device node should contain one 'port' child node with
+an 'endpoint' subnode. For further reading on port node refer to
+Documentation/devicetree/bindings/media/video-interfaces.txt.
+
+Example:
+	&i2c1 {
+		...
+		imx290: imx290@1a {
+			compatible = "sony,imx290";
+			reg = <0x1a>;
+
+			reset-gpios = <&msmgpio 35 GPIO_ACTIVE_LOW>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&camera_rear_default>;
+
+			clocks = <&gcc GCC_CAMSS_MCLK0_CLK>;
+			clock-names = "xclk";
+			clock-frequency = <37125000>;
+
+			vdddo-supply = <&camera_vdddo_1v8>;
+			vdda-supply = <&camera_vdda_2v8>;
+			vddd-supply = <&camera_vddd_1v5>;
+
+			port {
+				imx290_ep: endpoint {
+					clock-lanes = <1>;
+					data-lanes = <0 2 3 4>;
+					remote-endpoint = <&csiphy0_ep>;
+				};
+			};
+		};
-- 
2.17.1

