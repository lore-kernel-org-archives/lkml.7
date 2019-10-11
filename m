Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B4AECE58E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 18:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E13622190F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 18:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wR7b4t8w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbfJKStK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 14:49:10 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33745 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbfJKStK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 14:49:10 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so6611376pfl.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 11:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UBpxkrL7tKtRXDCw9jTxzLjYHb3eYmsJbnS949ORXyY=;
        b=wR7b4t8wiKB1zRfIkb8Ljj8NDXM8pfWH1+h6ohkMaqOTccYaQbclt3YjdbDEixiooF
         IDrKFliJUFwWCgTS8nsd5hVivMEZZ2FXCWbfK6EZU0LW/dZdye3VbqMlsjvefV7AWN9M
         Yit4F6mdtbNSxanYWJMLq8DnMRSV7xLA4XFQ2McB0jIL+db/X1Qwb+UT7KdzJtvez9wp
         XJzHJnI8f7+F1n8s2VXVCP/mI3/GPj8xGTCriPly2jTdxtIyhpELEv31o71IIKYovCj2
         Xqn+zRTbs9/TeMzrMY61Fzq4yWXMJPKLPNB+SibztJMogoCwuz3B1DsXnJwgROY0nq/9
         3Rlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UBpxkrL7tKtRXDCw9jTxzLjYHb3eYmsJbnS949ORXyY=;
        b=tTwMWNdXoeHibCuT6nuO/YUqLIn/qokOGNFABVYnm/HXxRmkUcb6G5lV5Vx39MtKJe
         xvcGsbxtforakvCPj53F3q/g5FBdgr80VbF2pSwI66mC+wbeofkjyTEUo3PCmv3TXry0
         +0cz1gD4LkLd1/U6aeQobktreCrqLojUFWeKq/zuuh73Abt/GX7XLOTCCqo/X4bXcmZ/
         ffN69tjN7GswnTQuIn0e3y0ketBsD6qv3k1XbTSDjyODcUBhY3cP873vEjUhyInwikq8
         CTfgkijn0x0/2/mIri18dEpQAkdnG1H4oQNSX0PSpVV5hfUo1+qX0ag36f5l3C+uYFbz
         Vl8A==
X-Gm-Message-State: APjAAAUMgZk/9AjTuTLhDI+b+i2/Qg5wstl/dauYR11LUK5WGBO0kKOy
        cVAPsgHjf8guc6a5kIoxUCv6
X-Google-Smtp-Source: APXvYqxXIGdsoCVaSN/Uh4svgs7Yp0VbyU4voFE9v2eBu03uRl7ePFdrB717TH3GAR3dAYW/1TO97Q==
X-Received: by 2002:a65:4188:: with SMTP id a8mr17912797pgq.81.1570819749573;
        Fri, 11 Oct 2019 11:49:09 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6407:a090:18a3:ff6e:e66c:65b0])
        by smtp.gmail.com with ESMTPSA id 68sm10031497pgb.39.2019.10.11.11.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 11:49:09 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, robh+dt@kernel.org
Cc:     alexandru.Ardelean@analog.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 1/2] dt-bindings: iio: light: Add binding for ADUX1020
Date:   Sat, 12 Oct 2019 00:18:51 +0530
Message-Id: <20191011184852.12202-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011184852.12202-1-manivannan.sadhasivam@linaro.org>
References: <20191011184852.12202-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for Analog Devices ADUX1020 Photometric
sensor.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/iio/light/adux1020.yaml          | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/adux1020.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/adux1020.yaml b/Documentation/devicetree/bindings/iio/light/adux1020.yaml
new file mode 100644
index 000000000000..69bd5c06319d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/adux1020.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/adux1020.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices ADUX1020 Photometric sensor
+
+maintainers:
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+description: |
+  Photometric sensor over an i2c interface.
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ADUX1020.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,adux1020
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
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adux1020@64 {
+                compatible = "adi,adux1020";
+                reg = <0x64>;
+                interrupt-parent = <&msmgpio>;
+                interrupts = <24 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
+...
-- 
2.17.1

