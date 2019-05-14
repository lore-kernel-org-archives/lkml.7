Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D833C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 22:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65F2420645
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 22:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pXS7Lnib"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfENW6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 18:58:51 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45260 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfENW6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 18:58:49 -0400
Received: by mail-lf1-f65.google.com with SMTP id n22so427982lfe.12;
        Tue, 14 May 2019 15:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T7dJtGSFbjWxWHWtg1H1pkzLh90BLS34Ro60mdQlGtQ=;
        b=pXS7LnibgSQvxgJQfrpes0/Ey1rz5rZMW0Y2fG1ZmwIvvBWrKz2ISfYOuHG7rTd242
         Fxs0ggRXV24zAbPNWSylBMFbRa7MeO/Y9yQpcpQvBryX6X89wQYiTZbbBLRtABtUrrSv
         v5HPeejMAlyQ1KtLgqtaHGMdEhf/fuhs0aJTJBFo255mRXHlIsdcPwk7Q5rp6fvnRxnS
         wPfhx9JBqk0s2a0XQkM7Q6I+48TzpjCI1XE68a+CKC0hqlS+ejy1AQ2hEUG2kjJlo/EE
         KqfHy4c36U2UUmoBaeoeVrQ3Vbks9OOEaZb3nG9bs8WCVpFAVcG9CtfvNSiuxLfzohmn
         EBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T7dJtGSFbjWxWHWtg1H1pkzLh90BLS34Ro60mdQlGtQ=;
        b=jC7HEfd0J4mFn/XozbIZp5fLpwytrE1RSOO8kHc/Q9Bv9NIds7UQmCwE/AlUn416d+
         8r6Mehbaexgn/00sY4wp1EjV9F9d7M8ieGldgB/Qrvj3BZcwZPnX1YCMJAE+9k1CPf7T
         JqMKa5rWcM8hB4390qTIsjbFIJWIBar4Mf3dq3gIWKsFYYTekKK6A5L9uYvNbIK9IcHq
         5wxlczcHjXKK8NgjEbjOOd3vn358c8GyD3DlYu9i0zGP2pQl+B06nndG6janl1D45dOE
         QfSg47dN7to1V2Hhj2ohteECC3cD1a5k/vJPLQtslr67GPpEs9MwKrQhH18mJaBf5VLN
         8SRA==
X-Gm-Message-State: APjAAAWtr122fShNeDtHblfLNaZjGdLyenfR3wx8S0OmMaQV0978pZst
        KvdEb2ErpeeO4u4g3AAreBE=
X-Google-Smtp-Source: APXvYqxQ+csEAJFD0eD/GsZ4ysqpBGlqOuOqHSWqW2KoxkpJiBAfARDTsXcOVlDYGGI5wSPvjVN6QQ==
X-Received: by 2002:ac2:424b:: with SMTP id m11mr3783326lfl.71.1557874726437;
        Tue, 14 May 2019 15:58:46 -0700 (PDT)
Received: from localhost.localdomain ([5.164.217.122])
        by smtp.gmail.com with ESMTPSA id n26sm30342lfi.90.2019.05.14.15.58.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 15:58:45 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Serge Semin <Sergey.Semin@t-platforms.ru>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: hwmon: Add DT bindings for TI ads1000/ads1100 ADCs
Date:   Wed, 15 May 2019 01:58:08 +0300
Message-Id: <20190514225810.12591-2-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190514225810.12591-1-fancer.lancer@gmail.com>
References: <20190514225810.12591-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-binding documentation for the Texas Instruments ads1000/ads1100 ADCs
driver.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 .../devicetree/bindings/hwmon/ads1000.txt     | 61 ++++++++++++++++
 Documentation/hwmon/ads1000.rst               | 72 +++++++++++++++++++
 2 files changed, 133 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ads1000.txt
 create mode 100644 Documentation/hwmon/ads1000.rst

diff --git a/Documentation/devicetree/bindings/hwmon/ads1000.txt b/Documentation/devicetree/bindings/hwmon/ads1000.txt
new file mode 100644
index 000000000000..3907b7da9b33
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/ads1000.txt
@@ -0,0 +1,61 @@
+ADS1000/ADS1100 (I2C)
+
+This device is a 12-16 bit A-D converter with 1 input.
+
+The inputs can be used either as a differential pair of Vin+ Vin- or as a single
+ended sensor for Vin+ GND. The inputs mode is platform-dependent and isn't
+configured by software in any case.
+
+Device A-D converter sensitivity can be configured using two parameters:
+ - pga is the programmable gain amplifier
+    0: x1 (default) 
+    1: x2
+    2: x4
+    3: x8
+ - data_rate in samples per second also affecting the output code accuracy
+    0: 128SPS - +/- Vdd*0.488mV (default, ads1000 accepts this rate only)
+    1: 32SPS  - +/- Vdd*0.122mV
+    2: 16SPS  - +/- Vdd*0.061mV
+    3: 8SPS   - +/- Vdd*0.030mV
+   Since this parameter also affects the output accuracy, be aware the greater
+   SPS the worse accuracy.
+
+As a result the output value is calculated by the next formulae:
+dVin = Cod * Vdd / (PGA * max(|Cod|)), where
+max(|Cod|) - maximum possible value of the output code, which depends on the SPS
+setting from the table above.
+
+The ADS1000/ADS1100 dts-node:
+
+  Required properties:
+   - compatible : must be "ti,ads1000" or "ti,ads1100"
+   - reg : I2C bus address of the device
+   - #address-cells : must be <1>
+   - #size-cells : must be <0>
+   - vdd-supply : regulator for reference supply voltage (usually fixed)
+
+  Optional properties:
+   - ti,gain : the programmable gain amplifier setting
+   - ti,datarate : the converter data rate
+   - ti,voltage-divider : <R1 R2> Ohms inbound voltage dividers,
+     so dVin = (R1 + R2)/R2 * dVin
+
+Example:
+
+vdd_5v0: fixedregulator@0 {
+	compatible = "regulator-fixed";
+	regulator-name = "vdd-ref";
+	regulator-min-microvolt = <5000000>;
+	regulator-max-microvolt = <5000000>;
+	regulator-always-on;
+};
+
+tiadc: ads1000@48 {
+	compatible = "ti,ads1000";
+	reg = <0x48>;
+
+	vdd-supply = <&vdd_5v0>;
+	ti,gain = <0>;
+	ti,voltage-divider = <31600 3600>;
+};
+
diff --git a/Documentation/hwmon/ads1000.rst b/Documentation/hwmon/ads1000.rst
new file mode 100644
index 000000000000..fcfe52d5d64d
--- /dev/null
+++ b/Documentation/hwmon/ads1000.rst
@@ -0,0 +1,72 @@
+Kernel driver ads1000
+=====================
+
+Supported chips:
+
+  * Texas Instruments ADS1000
+
+    Prefix: 'ads1000'
+
+    Datasheet: Publicly available at the Texas Instruments website:
+
+               http://www.ti.com/lit/ds/symlink/ads1000.pdf
+
+  * Texas Instruments ADS1100
+
+    Prefix: 'ads1100'
+
+    Datasheet: Publicly available at the Texas Instruments website:
+
+               http://www.ti.com/lit/ds/symlink/ads1100.pdf
+
+Authors:
+	Serge Semin <fancer.lancer@gmail.com>
+
+Description
+-----------
+
+This driver implements support for the Texas Instruments ADS1000/ADS1100 ADCs.
+
+This device is a 12-16 bit A-D converter with 1 input.
+
+The inputs can be used either as a differential pair of Vin+ Vin- or as a single
+ended sensor for Vin+ GND. The inputs mode is platform-dependent and isn't
+configured by software in any case.
+
+Platform Data
+-------------
+
+In linux/platform_data/ads1000.h platform data is defined to be of
+the following fields:
+
+ - pga is the programmable gain amplifier.
+
+    - 0: x1
+    - 1: x2
+    - 2: x4
+    - 3: x8
+
+ - data_rate in samples per second also affecting the output code accuracy.
+
+    - 0: 128SPS - +/- Vdd*0.488mV (ads1000 accepts this rate only)
+    - 1: 32SPS  - +/- Vdd*0.122mV
+    - 2: 16SPS  - +/- Vdd*0.061mV
+    - 3: 8SPS   - +/- Vdd*0.030mV
+   Since this parameter also affects the output accuracy, be aware the greater
+   SPS the worse accuracy.
+
+ - vdd is a pointer to the voltage regulator with reference voltage source.
+
+ - divider is an array of inbound voltage dividers in <R1 R2> Ohms, if each of
+   them is non-zero then the output voltage will be modified as follows:
+   dVin = (R1 + R2)/R2 * dVin.
+
+As a result the output value is calculated by the next formulae:
+dVin = Cod * Vdd / (PGA * max(|Cod|)), where max(|Cod|) - maximum possible
+value of the output code, which depends on the SPS setting from data_rate.
+
+Devicetree
+----------
+
+Configuration is also possible via devicetree:
+Documentation/devicetree/bindings/hwmon/ads1000.txt
-- 
2.21.0

