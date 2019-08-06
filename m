Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13540C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8D54216F4
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="esx00ei9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731553AbfHFNJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 09:09:57 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44990 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfHFNJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 09:09:56 -0400
Received: by mail-pf1-f194.google.com with SMTP id t16so41462855pfe.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 06:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C4Azk3N1QldkmkijyZBaYZs0K+xeT/HqprwCHyNXS4g=;
        b=esx00ei9uxuWTFn3HN0Cfx7KK7QzWhNoYu3IVDf3Cd9cBS9onLD3xbhIAB5h+eoEXl
         KFHq1lVRB+oS5BGkF2ucwnScf1XKmbtFXJGZ8uYYYBS+pjAt9Iv8l9jyQDG1gXABXmM1
         HwAOhfVUBDGx2A7qQlOG0oigCdSnWsUxtmIn9WhUXke71aBLvQuJmAg9qplwpK+LWq27
         GfXmH1+AjWKH3tBU1XH22jOoJvCeJL/iibHxtdD+FlEx2qyfacdxDBlTtlFIFMhhirnZ
         NtxwY3O5HodQ6SKXPIhCX9z9j0/mVZdIVGo++hn9oFwBfclZqguc99dTOM+boDACcR1f
         xNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C4Azk3N1QldkmkijyZBaYZs0K+xeT/HqprwCHyNXS4g=;
        b=aF3QzLvwj/90kqBgPrUxtIOJsHt0dcKcJrZcGfOpBlpMBwpfHKebWuwglEh3QKzD0v
         YDxHu/KCOhm0gGJtEXduo9L6x//daye9evozgDbr4XSwCqMciC1ERurfEfT2P6PTnglD
         7bWDEHD9Nu2CcrRVTMyKJbnmdN0X+UqEPbIoqKdpO5zyEzCeEhKK7l3XfIesHomVqcVn
         l5Xd02lWjZkNtzZ7SYr2FSVOUa9csHJEL5lCaI4FJ5g0ZyXlrBwFbiQyjegt5dcgiupu
         FbwGgSrDAeRrDzLYM/2SkXH7pPIbl/oBvzPrSC5lqSsV1OPgJwkhpwZVktonA8HMn2Ao
         fdMw==
X-Gm-Message-State: APjAAAUJs+gqWBK/xpicdZPnyoW9JMIzZsgjxrZh26G+4lV+x68ti4t0
        yt0L4VwubBstJ2h/XAHaOwyc
X-Google-Smtp-Source: APXvYqyVw0eUyqoyVUidAiq1F670HWkNCzwAqJlQ+kXljU8Bn7Utb4NHlePOEGT0+QHolZwwFdAdGA==
X-Received: by 2002:aa7:9819:: with SMTP id e25mr3490211pfl.47.1565096995489;
        Tue, 06 Aug 2019 06:09:55 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7180:928a:153d:caa0:477e:f9fd])
        by smtp.gmail.com with ESMTPSA id v8sm73715371pgs.82.2019.08.06.06.09.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 06:09:54 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mchehab@kernel.org, robh+dt@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        c.barrett@framos.com, a.brela@framos.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 1/3] dt-bindings: media: i2c: Add IMX290 CMOS sensor binding
Date:   Tue,  6 Aug 2019 18:39:36 +0530
Message-Id: <20190806130938.19916-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190806130938.19916-1-manivannan.sadhasivam@linaro.org>
References: <20190806130938.19916-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for IMX290 CMOS image sensor.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
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

