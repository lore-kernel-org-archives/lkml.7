Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D48C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 03:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B91DC21A4A
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 03:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aWuycG4L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfJKD4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 23:56:33 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35807 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfJKD4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 23:56:33 -0400
Received: by mail-pl1-f194.google.com with SMTP id c3so3828352plo.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 20:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1cUKYd2JGuOPb29vx0RY5RciC85cA8yW6+caoygW+J0=;
        b=aWuycG4LboxAq7KuhuLikokhD/yMdUvlgY6lN1NrGhIhuXttaZ/skjSMPHQ6DMHOcW
         f45MuDy63ux0Y0y0K4otxgKbPAS/acxq25kJzWDxNcEjUeQnqYUiKmGpXgUPhZqU46fd
         PI4rDcnM7AcOK2EOEuw82O2dmWvBIxDlPHu8l+Z2P3kKXmOo+KkIBhvWcs7lAwdRu73E
         nYR0AkaduIwE2d7Zg8X2Fy5SjQ4Yx4jTucCui11XylJseHg0lp6BN0ugdXalySWH6nij
         EFDcrwkc0AaatAdq6vXIgzxHYoYy325iFvP8nAG30i9R1pfJkdARxa76Nd/l1WZ5g0AJ
         oJbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1cUKYd2JGuOPb29vx0RY5RciC85cA8yW6+caoygW+J0=;
        b=b0DVy/yV12D8EYoV1ezmBS37OyOVkQRu8NyL9IvdHyMC48pxYq/Hk0WXz/QGcKS563
         U9NS9Dk1ADegYf9UD8p2DhJUtXlslI+1cPUxBTm8WXLrCkihgOwYt45nUQknxHooio5B
         7Os6wlwbJpkBF1UU3xSe3A1pIwvoi3QiIRfNE599NLvav/yNbNp8zS491xtawSTRt+8H
         6BlCN1HraikuFoYN0wIpkS+X9hAfSf40b5bv2XYdSISUFCsR8o9TlmdGiGTZnhXN82x5
         IFzgnwPzMz/3o94TKm7cpo4jUTMLbJVdtuHtZIZIrk675TllGYkMmRQ4YsBOLBxGRsbF
         W7Vg==
X-Gm-Message-State: APjAAAWH+RxZRxeONwda/kTerxLVJttq7zVMJh2itTnCF/IndMYq8iSw
        igjPNlWvJ/M99mFqlugCU7fE
X-Google-Smtp-Source: APXvYqybv4dUMKgehLfH8auvSwt7/o2lRH+/cZX47WXX599yek7j6tmTPlwDYhmglObLBsJJ9dUh5g==
X-Received: by 2002:a17:902:904b:: with SMTP id w11mr11183843plz.182.1570766192428;
        Thu, 10 Oct 2019 20:56:32 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:638c:660b:18a3:ff6e:e66c:65b0])
        by smtp.gmail.com with ESMTPSA id b185sm9534210pfg.14.2019.10.10.20.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 20:56:31 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mchehab@kernel.org, robh+dt@kernel.org, sakari.ailus@iki.fi
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        c.barrett@framos.com, a.brela@framos.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/2] dt-bindings: media: i2c: Add IMX296 CMOS sensor binding
Date:   Fri, 11 Oct 2019 09:26:12 +0530
Message-Id: <20191011035613.13598-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011035613.13598-1-manivannan.sadhasivam@linaro.org>
References: <20191011035613.13598-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for IMX296 CMOS image sensor.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../devicetree/bindings/media/i2c/imx296.txt  | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/imx296.txt

diff --git a/Documentation/devicetree/bindings/media/i2c/imx296.txt b/Documentation/devicetree/bindings/media/i2c/imx296.txt
new file mode 100644
index 000000000000..25d3b15162c1
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/i2c/imx296.txt
@@ -0,0 +1,55 @@
+* Sony IMX296 1/2.8-Inch CMOS Image Sensor
+
+The Sony IMX296 is a 1/2.9-Inch active pixel type CMOS Solid-state image
+sensor with square pixel array and 1.58 M effective pixels. This chip features
+a global shutter with variable charge-integration time. It is programmable
+through I2C and 4-wire interfaces. The sensor output is available via CSI-2
+serial data output (1 Lane).
+
+Required Properties:
+- compatible: Should be "sony,imx296"
+- reg: I2C bus address of the device
+- clocks: Reference to the mclk clock.
+- clock-names: Should be "mclk".
+- clock-frequency: Frequency of the mclk clock in Hz.
+- vddo-supply: Interface power supply.
+- vdda-supply: Analog power supply.
+- vddd-supply: Digital power supply.
+
+Optional Properties:
+- reset-gpios: Sensor reset GPIO
+
+The imx296 device node should contain one 'port' child node with
+an 'endpoint' subnode. For further reading on port node refer to
+Documentation/devicetree/bindings/media/video-interfaces.txt.
+
+Required Properties on endpoint:
+- data-lanes: check ../video-interfaces.txt
+- remote-endpoint: check ../video-interfaces.txt
+
+Example:
+	&i2c1 {
+		...
+		imx296: camera-sensor@1a {
+			compatible = "sony,imx296";
+			reg = <0x1a>;
+
+			reset-gpios = <&msmgpio 35 GPIO_ACTIVE_LOW>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&camera_rear_default>;
+
+			clocks = <&gcc GCC_CAMSS_MCLK0_CLK>;
+			clock-names = "mclk";
+			clock-frequency = <37125000>;
+
+			vddo-supply = <&camera_vddo_1v8>;
+			vdda-supply = <&camera_vdda_3v3>;
+			vddd-supply = <&camera_vddd_1v2>;
+
+			port {
+				imx296_ep: endpoint {
+					data-lanes = <1>;
+					remote-endpoint = <&csiphy0_ep>;
+				};
+			};
+		};
-- 
2.17.1

