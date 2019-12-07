Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8650CC43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 04:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A2D821835
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 04:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vKFZXiU8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfLGEyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 23:54:18 -0500
Received: from mail-ua1-f51.google.com ([209.85.222.51]:45128 "EHLO
        mail-ua1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfLGEyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 23:54:16 -0500
Received: by mail-ua1-f51.google.com with SMTP id 59so3709126uap.12;
        Fri, 06 Dec 2019 20:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PoAYAtQsECMKBQu3m3UL38cyfBNcCrjyU109EM5/2Kk=;
        b=vKFZXiU88cdk8U11fBerp2o/L9d60eSFcOf8iuyvdLhzAF+nThRMBGnaPY0Gm5EIO7
         fwco54CdXQfPHpYvhDp/m3EsVFrA8TciyqTvJ9DvDSTciLEHNm1xMdpNHsrdltMGQRSm
         xtv2y6APCIZ1MqVTlB6QAWiJGI/ezpQB/bIdhtivtjotOiONQAqwtXpVRfc2yqmWlbiD
         vRkWv2u45JfIoQsNVwLZhMnUfq7FIJbR7f8RoUo2lxqi+rH8L5qHNT7dlDPzaTYkoFSr
         R3h5DB6Kf8hIPGe9YU85vzyjY8YbKZvv9cUWekwvVS1fkbN0PqjgnSv1IXBi67u2+BUN
         7D3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PoAYAtQsECMKBQu3m3UL38cyfBNcCrjyU109EM5/2Kk=;
        b=BzMzn3X+XCr0WH/XL2SfOHvsEv12ipyXIV88eSPVBpC2vTLt4odaII3d+DokjER9Tl
         RF1lZc8msRFGW6L8Y5f296eNq+3vMaI6pOkVAEjCilJgKmUYtcEH1lTAniEZipa2W7gG
         wtxvv3QnDcxZASW5Yd8DtTYFtFEuMt7iVIGcqmVSQCbU80JBqAJVUacQXaHkxKlsf2gi
         +eKgCgyVQawkOQ8P+clGHf25D1CsrWIbWVLHDm7qIdKfb3xFRxWq0b6cOZoHyQFCmSrX
         jf8yCdXkaD2GbgiR83+cLQnLHoiFEOp4XSjxa2/SaooHRoOpFcULF9IixmYXIc+SPdy2
         IK7w==
X-Gm-Message-State: APjAAAV4N7wBrLM3WLVSuvruSGF7mum1yB1tp39mNHbu/7tkotvBbJmw
        kQb6uzu+iW3V7AxB1/YZjCE=
X-Google-Smtp-Source: APXvYqz5B4qddztDDlAGY2AqZoYhWgimCOX1uIFxzn4FIBcw/FxrrTMa9ztU/J7UcMFTFBUysGo9Jw==
X-Received: by 2002:ab0:30a4:: with SMTP id b4mr10697339uam.85.1575694455208;
        Fri, 06 Dec 2019 20:54:15 -0800 (PST)
Received: from localhost.localdomain ([177.45.184.74])
        by smtp.gmail.com with ESMTPSA id w132sm8156205vkw.46.2019.12.06.20.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 20:54:14 -0800 (PST)
From:   Rodrigo Carvalho <rodrigorsdc@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kernel-usp@googlegroups.com,
        Rodrigo Carvalho <rodrigorsdc@gmail.com>
Subject: [PATCH v6 2/2] dt-bindings: iio: accel: add binding documentation for ADIS16240
Date:   Sat,  7 Dec 2019 01:53:39 -0300
Message-Id: <20191207045339.9186-2-rodrigorsdc@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191207045339.9186-1-rodrigorsdc@gmail.com>
References: <20191207045339.9186-1-rodrigorsdc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add device tree binding documentation for ADIS16240.

Signed-off-by: Rodrigo Carvalho <rodrigorsdc@gmail.com>
---
V6:
  - Update SPDX license identifier

 .../bindings/iio/accel/adi,adis16240.yaml     | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml

diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
new file mode 100644
index 000000000000..4147f02b5e3c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/accel/adi,adis16240.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ADIS16240 Programmable Impact Sensor and Recorder driver
+
+maintainers:
+  - Alexandru Ardelean <alexandru.ardelean@analog.com>
+
+description: |
+  ADIS16240 Programmable Impact Sensor and Recorder driver that supports
+  SPI interface.
+    https://www.analog.com/en/products/adis16240.html
+
+properties:
+  compatible:
+    enum:
+      - adi,adis16240
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        /* Example for a SPI device node */
+        accelerometer@0 {
+            compatible = "adi,adis16240";
+            reg = <0>;
+            spi-max-frequency = <2500000>;
+            interrupt-parent = <&gpio0>;
+            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
-- 
2.24.0

