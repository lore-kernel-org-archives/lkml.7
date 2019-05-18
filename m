Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=AC_FROM_MANY_DOTS,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9672C46470
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 22:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ACDB20882
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 22:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="0WjwMwDT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbfERWkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 18:40:55 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46763 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbfERWkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 18:40:55 -0400
Received: by mail-qt1-f193.google.com with SMTP id z19so12106495qtz.13
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2019 15:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NASEVCcQeLERmb3lFWeHn5RecIxubexy9jBBwowK7lA=;
        b=0WjwMwDTtuOEdvLcrR7O/8y6q3Rf/jfoWaYAaqz9hczEVdCBlBz8K5nNxL3ukRDmiY
         IyWLRGZPFEsWBUMGAmLtJ5LyIQiEh9t3cPu+lLPnCulGzaL1xRygGE7uOXB/EpKDEido
         HDZxHzy8J1Z98lG9zvEiPRYGOtMoD3bxv84E20uuVU/SNUnCIUGvm4beapkNoiMcn5WC
         4ZGzv27ojqbVWdbycutUL//GamTmS7xJC5e+WkYbZqRsm6qdw/PfZFRlQa+9MhfgOMoA
         odmY6Nw8z7jxxTPNYtVfhg26omWkcHUr2rHOgX9u9dUc2QjEnk95vvBxKemrdmeMFe8K
         Ataw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NASEVCcQeLERmb3lFWeHn5RecIxubexy9jBBwowK7lA=;
        b=qGaY0dfxlIFrouPwzu5bhc+/vFaFvzH706HY3QWJ0EF+dJQUK0Q44AS3z72lCdhNj5
         /EQv0EcEXvB5FlfrIRSRLETKbwU0+ZJaCRoeVstTlFIDMF7D3+WE/4rRm81wjMz0ZWCH
         gsPEfZTwhuHy/VMSie49mEhisbMPa8vqUPc4DSASrn8aItXH0ZJMxCyDc54Xjia26rAw
         +KxnVgwRdVFUSyeK+dCcny5YxhDGQ8o3oYcNqC4LFN8b6cPfiRsFOYtsGtMfzTVfSFnF
         z5dTN2K2e62Q4mC0hkZfq6UGqlFrHbrZEBq/V78jPlRCyp6xPW08SmNwzx4WrRB5JCgH
         BwAg==
X-Gm-Message-State: APjAAAX+Oq3xxFly+0/uNEJlSXYh/AJIJixGl6/8cxtRuXrCYPBITqbC
        nLzxpXZFjphiFWa/Cdcs7CySGQ==
X-Google-Smtp-Source: APXvYqyPKneCyjGVMlT3EJFQrZD2wyAhm8de9f0HAHvFJ3KyB4wrL6VrwPg95rw2zSvLZemmW/Cmzg==
X-Received: by 2002:ac8:16b4:: with SMTP id r49mr47957644qtj.157.1558219253774;
        Sat, 18 May 2019 15:40:53 -0700 (PDT)
Received: from joao-pc.ime.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id g15sm6415068qkl.2.2019.05.18.15.40.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 18 May 2019 15:40:53 -0700 (PDT)
From:   =?UTF-8?q?Jo=C3=A3o=20Victor=20Marques=20de=20Oliveira?= 
        <joao.marques.oliveira@usp.br>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com,
        "Thiago L . A . Miller" <tmiller@mochsl.org.br>,
        "Osvaldo M . Yasuda" <omyasuda@yahoo.com.br>
Subject: [PATCH] dt-bindings: iio: ad7949: switch binding to yaml
Date:   Sat, 18 May 2019 19:40:36 -0300
Message-Id: <20190518224036.29596-1-joao.marques.oliveira@usp.br>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes switches from old text bindings, to YAML bindings, and also
include adi,reference-select property to specify the source for the
reference voltage signal.

Signed-off-by: João Victor Marques de Oliveira <joao.marques.oliveira@usp.br>
Signed-off-by: Thiago L. A. Miller <tmiller@mochsl.org.br>
Co-developed-by: Thiago L. A. Miller <tmiller@mochsl.org.br>
Signed-off-by: Osvaldo M. Yasuda <omyasuda@yahoo.com.br>
Co-developed-by: Osvaldo M. Yasuda <omyasuda@yahoo.com.br>
---
We're adding Charles-Antoine Couret as main dt maintainer since we have
just switched documentation to yaml format. 

 .../devicetree/bindings/iio/adc/ad7949.txt    | 16 -----
 .../devicetree/bindings/iio/adc/ad7949.yaml   | 71 +++++++++++++++++++
 2 files changed, 71 insertions(+), 16 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/ad7949.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ad7949.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/ad7949.txt b/Documentation/devicetree/bindings/iio/adc/ad7949.txt
deleted file mode 100644
index c7f5057356b1..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/ad7949.txt
+++ /dev/null
@@ -1,16 +0,0 @@
-* Analog Devices AD7949/AD7682/AD7689
-
-Required properties:
- - compatible: Should be one of
-	* "adi,ad7949"
-	* "adi,ad7682"
-	* "adi,ad7689"
- - reg: spi chip select number for the device
- - vref-supply: The regulator supply for ADC reference voltage
-
-Example:
-adc@0 {
-	compatible = "adi,ad7949";
-	reg = <0>;
-	vref-supply = <&vdd_supply>;
-};
diff --git a/Documentation/devicetree/bindings/iio/adc/ad7949.yaml b/Documentation/devicetree/bindings/iio/adc/ad7949.yaml
new file mode 100644
index 000000000000..111c9e26f8e7
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ad7949.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ad7949.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+
+title: Analog Devices AD7949/AD7682/AD7689
+
+maintainers:
+  - Charles-Antoine Couret <charles-antoine.couret@essensium.com>
+  - João Victor Marques de Oliveira <joao.marques.oliveira@usp.br>
+  - Thiago L. A. Miller <tmiller@mochsl.org.br>
+  - Osvaldo M. Yasuda <omyasuda@yahoo.com.br>
+
+properties:
+  compatible:
+    enum:
+      - adi,ad7949
+      - adi,ad7682
+      - adi,ad7689
+
+  reg:  
+    description:
+      spi chip select number for the device
+    maxItems: 1
+
+  vref-supply:
+    description:
+      The regulator supply for ADC reference voltage
+    maxItems: 1
+
+  adi,reference-select:
+    enum: [0, 1, 2, 3, 6, 7]
+    description:
+        Select the reference voltage source to use when converting the input voltages.
+            0 - Internal 2.5V reference; temperature sensor enabled
+            1 - Internal 4.096V reference; temperature sensor enabled
+            2 - External reference, temperature sensor enabled, no buffer
+            3 - External reference, temperature sensor enabled, buffer enabled
+            6 - External reference, temperature sensor disabled, no buffer
+            7 - External reference, temperature sensor disabled, buffer enabled
+    maxItems: 1
+
+required:
+  - compatible 
+  - reg
+  - vref-supply
+
+examples:
+  - |
+    spi0 {
+        #address-cells = <0x1>;
+        #size-cells = <0x0>;
+        adc@0 {
+            compatible = "adi,ad7949";
+            reg = <0>;
+            adi,reference-select = <0>;
+            vref-supply = <&vdd_supply>;
+        };
+    };
+  - |
+    spi0 {
+        #address-cells = <0x1>;
+        #size-cells = <0x0>;
+        adc@0 {
+            compatible = "adi,ad7949";
+            reg = <0>;
+            adi,reference-select = <0>;
+        };
+    };
-- 
2.21.0

