Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E1CC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D99921D81
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uLdJG7tk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390330AbfJDQFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 12:05:46 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37378 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390313AbfJDQFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 12:05:43 -0400
Received: by mail-pf1-f195.google.com with SMTP id y5so4176169pfo.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 09:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GRyfXnoKWvtKyG57W37AUlln8akpvDYr2Xx/dz2ORHU=;
        b=uLdJG7tkav2IAy9bTjV+pwHZWiMRG+f1196ehm3mr8C+tpptuKOvJ8t5RtwkH8sm/K
         JLCyw34WX1e8crRwtm4vWkcCWccQtu4t/p3wJqjS0D3y9SeCG/jszGbU19Cuux/TBPff
         2pgUeb30c0Ma49RZTIGxdeCGWHVYNREf1t5yWrlJzKf5GCGJNQlKONs/oQiXHQMglGqx
         iwYI56jgL7YASZ6rACjQNf57dpH5dKWU43QE+WGSF3PTqiQapjHQho2JiDFbllWD8aBK
         d1G/JaPSeq3d4y+qaH+uwkl3U0KE0URG3TdxNy/KUYatcCng2vxA0zS2ZLRQ3tDCRQmM
         bbWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GRyfXnoKWvtKyG57W37AUlln8akpvDYr2Xx/dz2ORHU=;
        b=rWVjdNZbYhaBrHprPZ9DAEeiWxy615UVCGBDJUVP0wgszv4qQMGSWqfigoeTy740aO
         tYoZDO1epz3nT4rqYl3nzSatGupyqYmoiZiA6TIROirlMkBUgRVJLvSKtPU5GE442J8y
         NrdQ787KytjyoIpNpjAPCeH5swfmCD9L7k/tIhxeWprnYENPkqhB3ZdKaU3QBlTWclvE
         g32yZnXwChtfoeBau8ZwYb8pptoPK8iKpl+ruWo8oxUVULNKiA1Uezu5RNg50tEIY7ao
         jObIg4kMUk4AHpkiVZUMK6n3M3uDZY/FpfLgjCJZaH3UnZHLgRKwer85HXrfw5q0bQR7
         mE0w==
X-Gm-Message-State: APjAAAVjtQ2ecq/JholOvckrrxXCFci1PZyc9NbAm13dFcOniXPbzUaH
        jjTMgNcvb3jE2mykBRakgBhD
X-Google-Smtp-Source: APXvYqzeHVzT2teGBPgP2k+3EJkEPoCXJ5wbb81+QCX/AhHJ/bo6/WWAewIMF6WVKQKwIud7PVt8qw==
X-Received: by 2002:a17:90a:8d85:: with SMTP id d5mr17692406pjo.45.1570205142646;
        Fri, 04 Oct 2019 09:05:42 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:648a:e40a:3174:4ae1:69ba:aabb])
        by smtp.gmail.com with ESMTPSA id b5sm5402254pgb.68.2019.10.04.09.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 09:05:41 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mchehab@kernel.org, robh+dt@kernel.org, sakari.ailus@iki.fi
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        c.barrett@framos.com, a.brela@framos.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 1/2] dt-bindings: media: i2c: Add IMX290 CMOS sensor binding
Date:   Fri,  4 Oct 2019 21:35:24 +0530
Message-Id: <20191004160525.16716-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191004160525.16716-1-manivannan.sadhasivam@linaro.org>
References: <20191004160525.16716-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for IMX290 CMOS image sensor. Let's also
add MAINTAINERS entry for the binding and driver.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/media/i2c/imx290.txt  | 57 +++++++++++++++++++
 MAINTAINERS                                   |  8 +++
 2 files changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/imx290.txt

diff --git a/Documentation/devicetree/bindings/media/i2c/imx290.txt b/Documentation/devicetree/bindings/media/i2c/imx290.txt
new file mode 100644
index 000000000000..a3cc21410f7c
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/imx290.txt
@@ -0,0 +1,57 @@
+* Sony IMX290 1/2.8-Inch CMOS Image Sensor
+
+The Sony IMX290 is a 1/2.8-Inch CMOS Solid-state image sensor with
+Square Pixel for Color Cameras. It is programmable through I2C and 4-wire
+interfaces. The sensor output is available via CMOS logic parallel SDR output,
+Low voltage LVDS DDR output and CSI-2 serial data output. The CSI-2 bus is the
+default. No bindings have been defined for the other busses.
+
+Required Properties:
+- compatible: Should be "sony,imx290"
+- reg: I2C bus address of the device
+- clocks: Reference to the xclk clock.
+- clock-names: Should be "xclk".
+- clock-frequency: Frequency of the xclk clock in Hz.
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
+Required Properties on endpoint:
+- data-lanes: check ../video-interfaces.txt
+- link-frequencies: check ../video-interfaces.txt
+- remote-endpoint: check ../video-interfaces.txt
+
+Example:
+	&i2c1 {
+		...
+		imx290: camera-sensor@1a {
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
+					data-lanes = <1 2 3 4>;
+					link-frequencies = /bits/ 64 <445500000>;
+					remote-endpoint = <&csiphy0_ep>;
+				};
+			};
+		};
diff --git a/MAINTAINERS b/MAINTAINERS
index f7c84004187d..0ee261fca602 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14962,6 +14962,14 @@ S:	Maintained
 F:	drivers/media/i2c/imx274.c
 F:	Documentation/devicetree/bindings/media/i2c/imx274.txt
 
+SONY IMX290 SENSOR DRIVER
+M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+L:	linux-media@vger.kernel.org
+T:	git git://linuxtv.org/media_tree.git
+S:	Maintained
+F:	drivers/media/i2c/imx290.c
+F:	Documentation/devicetree/bindings/media/i2c/imx290.txt
+
 SONY IMX319 SENSOR DRIVER
 M:	Bingbu Cao <bingbu.cao@intel.com>
 L:	linux-media@vger.kernel.org
-- 
2.17.1

