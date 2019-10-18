Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079C4CA9EB3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D458221D80
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LIaho/b0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503897AbfJRAUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 20:20:12 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34019 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503878AbfJRAUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 20:20:08 -0400
Received: by mail-wm1-f65.google.com with SMTP id y135so8125026wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 17:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QGtqqoloz6hjB0cfAJP9qri2qA1iaYEqSaS6htthArs=;
        b=LIaho/b0J0bCWjv6CBIj3ZqtNf200u7TNu0EqK9EI/D1EbS9cAYhiXleb9Uuiaqiu/
         fXTNI2o/N4Ml6abfGPssQl9a3BGnzm9yUVQrdqtGthafs5VwIdKWiFle8XjR6MBn5VZT
         bsHgs7DnzUSfOZcfj8Scuv913Cu8IdvSTdCkK2X/FqwpHtzfaKSYL1iNHBPtwKy+IXju
         dge0dRglAXmJRAT8ibNcpVEbZ5d9nm9VTdo4kRCCDgKVtgKZDN4MVeGa/tulRTotYkk6
         EbCi4a6rWfry6/yYGE5QMVEuWuLY/WZLHAkqUD4pYofrxv3I3xrhzFiQ9UXPi3lX0WKH
         nSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QGtqqoloz6hjB0cfAJP9qri2qA1iaYEqSaS6htthArs=;
        b=MOeL9Tp6IQsEeb8ItkCCrSVLEqpCfbBPV4mKbuoL6CPgU3SAUEygM1iKVGY+ZegEzK
         LIJEQceMIL9EQ/odgVUFdS5MZmLu46dHS+Sqf9sR4WJRrt/gVmvfLwlh6kz2CYDsXziw
         htMgYWP3+6NruEx9gcn/jmf3SE25J5BsdU6Y+OIEi/1+vse0kYfvoOUxKGeOKNdejqHk
         3ZN8Nj1qzxaYhsa7VtgsdeUY8mo7Y4xnzgdGj4W3Z8Tk7U3QkoFAVaelkf743+hgKDEU
         VuVJzgk1ouCbFM7r2xgw/NoQnbfGSjGByS5UQ+hm5DMMkB5zQZAcTJvSjlpmJ0b0SP7y
         4Dvg==
X-Gm-Message-State: APjAAAVQNGj8CGInuHVCDvbMRbzlUlEgvlZJaAEVrwiNrjuwWjz5wYdI
        xjC/9Ul/wRrG0DxMwJB103md9A==
X-Google-Smtp-Source: APXvYqx1D7V2pK2CNerimKn2kRSQmnmpBiXII2FunyzWAOtbGGBEB9dmQc42ffr4CshM5SaUVCtzuA==
X-Received: by 2002:a1c:7c13:: with SMTP id x19mr4991011wmc.80.1571358007133;
        Thu, 17 Oct 2019 17:20:07 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id z189sm4851248wmc.25.2019.10.17.17.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 17:20:06 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     robh@kernel.org, broonie@kernel.org, linus.walleij@linaro.org,
        lee.jones@linaro.org
Cc:     vinod.koul@linaro.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        spapothi@codeaurora.org, bgoswami@codeaurora.org,
        linux-gpio@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 08/11] dt-bindings: pinctrl: qcom-wcd934x: Add bindings for gpio
Date:   Fri, 18 Oct 2019 01:18:46 +0100
Message-Id: <20191018001849.27205-9-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191018001849.27205-1-srinivas.kandagatla@linaro.org>
References: <20191018001849.27205-1-srinivas.kandagatla@linaro.org>
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
 .../pinctrl/qcom,wcd934x-pinctrl.yaml         | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,wcd934x-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,wcd934x-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,wcd934x-pinctrl.yaml
new file mode 100644
index 000000000000..c8a36cbc4935
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,wcd934x-pinctrl.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/qcom,wcd934x-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: WCD9340/WCD9341 GPIO Pin controller
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
+      - qcom,wcd9340-pinctrl
+      - qcom,wcd9341-pinctrl
+
+  reg:
+    maxItems: 1
+
+  gpio-controller: true
+
+  gpio-ranges:
+    maxItems: 1
+
+  '#gpio-cells':
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - gpio-controller
+  - gpio-ranges
+  - "#gpio-cells"
+
+
+examples:
+  - |
+    wcdpinctrl: wcdpinctrl@42 {
+        compatible = "qcom,wcd9340-pinctrl";
+        reg = <0x042 0x2>;
+        gpio-controller;
+        gpio-ranges = <&wcdpinctrl 0 0 5>;
+        #gpio-cells = <2>;
+    };
+
+...
-- 
2.21.0

