Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9880CC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 704CD20640
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GlECiIs6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbfJGPjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 11:39:43 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34279 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729239AbfJGPjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 11:39:40 -0400
Received: by mail-pl1-f196.google.com with SMTP id k7so7063759pll.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 08:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NKz+jzuPRkeE8OyfVXN3xWzVOBpfNSKgJ1fmTtHwhbk=;
        b=GlECiIs6yqHMnmv6owgHQSiNAw8TmUs/ep7tSo5/YMXwUyBynPgentNR0AXiGM9wUS
         qPHCGRQfpXEOHvqYEe5BxlakCUYnxQvRbhK+UxZkKXuBtTBAEbR1vR/96ih4igNEHPef
         eXxCjUuiZEFUisDXIzZQVvpQQ5Vj4dO6ESiQLAWsQZRZjLWO9LvV44EeLSj8XF08GH6x
         moIkoc/krUGlmK3qoJhwpSK4Hyza4WCSIrvCLiYpPw5bQLzobYGLx/4RkiLHFpfWLue+
         uBEsWdZjUYA6rDBRmB2zgTq19Eq2J7VXguUZkjcysrcy0OJA6qdKW0b0tHJAtuZHXNfw
         mRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NKz+jzuPRkeE8OyfVXN3xWzVOBpfNSKgJ1fmTtHwhbk=;
        b=XJdjzYGzmfHKvQuJ+G9yxOA7OHM0ktuwrDtnBFIqVXpyetpCrZry4jMVAwxuOafqL/
         FB5pTBoVwK/n7VptKb0UWjfms5ru4KE40yEpxtw3Y/ckKhxHbHE12NV1AHjTWEDY/cIY
         NbVrCdlwgbw0F0MLGX9BrFab7nJR/Tj3I8P/KktdTLeAruVjKowgsej5FG2e46++IVQq
         6r7FPAwQz2Tzn6zhh6/ZzpUpn37sfLY58pcofKedL7P167DPDuDocSjEt1nUoWYKu/A/
         ylZs8w1hx76lbaRFUd7alAim3IbHeHr88XHjBTThv6XfsIRiVfz+qWJH7DFoIfmPDvX7
         48lA==
X-Gm-Message-State: APjAAAVJXxzX4c7FHLkMnTWQvYrVbk2Ng6T33LH38lT+n8KCsn+tqZx1
        QtXb9ZKqhpsvAcDEor7R5Ob0
X-Google-Smtp-Source: APXvYqwC2qTSZx1RcZnaOnSFwjtv4y1EeHa607q2ZdXiJy4DHtSGsRaMlhHdD9TuSR/e6KfaZw2U2w==
X-Received: by 2002:a17:902:9308:: with SMTP id bc8mr29510816plb.160.1570462778750;
        Mon, 07 Oct 2019 08:39:38 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7088:cb7f:1889:38a3:2d:5880])
        by smtp.gmail.com with ESMTPSA id d69sm15945077pfd.175.2019.10.07.08.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 08:39:38 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     ars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, robh+dt@kernel.org
Cc:     alexandru.Ardelean@analog.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 1/2] dt-bindings: iio: light: Add binding for ADUX1020
Date:   Mon,  7 Oct 2019 21:09:16 +0530
Message-Id: <20191007153917.13611-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191007153917.13611-1-manivannan.sadhasivam@linaro.org>
References: <20191007153917.13611-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for Analog Devices ADUX1020 Photometric
sensor.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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

