Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800A6C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 17:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58C4B206CC
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 17:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H36Ym9ke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfKURGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 12:06:00 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:37930 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbfKURF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 12:05:58 -0500
Received: by mail-wm1-f54.google.com with SMTP id z19so4590334wmk.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 09:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XyoLjI/p85FmtU9sQ7uHTafXrtQ51MQgfkvDFnGjUfc=;
        b=H36Ym9keWbPzJ5lVYh8uv0JYNxaxXo75tGofwCllVhQwj7OG9xKnvGdqaHh0VZdnb9
         MMRSCIAKpgB4xNLSj3lV2b0YH8jgRE5PA8he+wPCxiAZovM9rYZ2amS3oxNE0L4y6/UJ
         O0iTxRYugHqAXlLerh05MTpyFowxjiCOHc/C7tOX6HaarHA8tPGZa6CsJTbbYXgL4Lmz
         aCPwfMJ0/nOt0D2bPTYxLaGB4eBmvCMezudjSSj0gr20jrYJco51sehio+UsMmy4Bi97
         jGutvRTVG8UB9DVL5yu7lI9m/bMEy7dAQaySfFlxCXJogWj+LgAlp88r1WGA2+/OMJat
         xQ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XyoLjI/p85FmtU9sQ7uHTafXrtQ51MQgfkvDFnGjUfc=;
        b=PElOIUfes3VVl5fJvChxVWdu/XyyK/Vvhhi2vLOryflg6eaaO6Rh+bF/bSbK8i5mQD
         jkSf4cgxUBBuODd2r9Ls2QL8NxJGqUNd7h7ZhoNNVzK+dWX4S7s313YXOZX3m9EipT5j
         JMTPLqniSB6rqw41jxyXDd7BQUKzNWr2Smg6LBDXVjQS3Md4ZI7Nj3b3kJwQYA9UcSmV
         tJRIidnLa3XEJCTdJw9V0pdWME+su2oIGP08EHN5vd4MMjEp68wOf2qit8SGpv4KUVG7
         FW40Qy8X2jkOy0y8v9Kpy7ClheZFO0D283rl/FGHKa/XawIpCbhjda5d2OlUhMwONxq6
         Lbvw==
X-Gm-Message-State: APjAAAUIhJRPGVljEP1U4O4ypShcoVS9j8mSqu2gDetWpdP+A1usM0a9
        2kPF4U3SvvYV3VAUiBiSX2QyvA==
X-Google-Smtp-Source: APXvYqxEwo8PX1yZ5dMNrtuP1K3nSh9t2jtx/KIyNWa7VtUCekIxRfaZK+K1UUKvfdsSacXI1QqpmA==
X-Received: by 2002:a1c:e915:: with SMTP id q21mr10405135wmc.148.1574355956834;
        Thu, 21 Nov 2019 09:05:56 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id i71sm4423731wri.68.2019.11.21.09.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 09:05:56 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     robh@kernel.org, broonie@kernel.org, lee.jones@linaro.org,
        linus.walleij@linaro.org
Cc:     vinod.koul@linaro.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        spapothi@codeaurora.org, bgoswami@codeaurora.org,
        linux-gpio@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 09/12] dt-bindings: gpio: wcd934x: Add bindings for gpio
Date:   Thu, 21 Nov 2019 17:05:06 +0000
Message-Id: <20191121170509.10579-10-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191121170509.10579-1-srinivas.kandagatla@linaro.org>
References: <20191121170509.10579-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm Technologies Inc WCD9340/WCD9341 Audio Codec has integrated
gpio controller to control 5 gpios on the chip. This patch adds
required device tree bindings for it.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/gpio/qcom,wcd934x-gpio.yaml      | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/qcom,wcd934x-gpio.yaml

diff --git a/Documentation/devicetree/bindings/gpio/qcom,wcd934x-gpio.yaml b/Documentation/devicetree/bindings/gpio/qcom,wcd934x-gpio.yaml
new file mode 100644
index 000000000000..32a566ec3558
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/qcom,wcd934x-gpio.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/qcom,wcd934x-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: WCD9340/WCD9341 GPIO controller
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+description: |
+  Qualcomm Technologies Inc WCD9340/WCD9341 Audio Codec has integrated
+  gpio controller to control 5 gpios on the chip.
+
+properties:
+  compatible:
+    enum:
+      - qcom,wcd9340-gpio
+      - qcom,wcd9341-gpio
+
+  reg:
+    maxItems: 1
+
+  gpio-controller: true
+
+  '#gpio-cells':
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - gpio-controller
+  - "#gpio-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    wcdgpio: gpio@42 {
+        compatible = "qcom,wcd9340-gpio";
+        reg = <0x042 0x2>;
+        gpio-controller;
+        #gpio-cells = <2>;
+    };
+
+...
-- 
2.21.0

