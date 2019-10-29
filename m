Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAC4CA9EC3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2729208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EA1r3HXJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387538AbfJ2L3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 07:29:37 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52098 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732569AbfJ2L3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:29:06 -0400
Received: by mail-wm1-f66.google.com with SMTP id q70so2167461wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 04:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6RliGfxjeZRZKsvz7+xFZDSC6zQkkXVAUlzYsp0mzbo=;
        b=EA1r3HXJQSw1Wc/1K8+BmJ1oGZOA1scoI+iD/EvM0ZkSCrsgix7EYZSzLH2+yOOnlf
         a4dr691lyhUVb2AJqJGeTnZIRr/uHkmK2/OEeg0t1ZmsdjTKL8Mrv2hB2J2v6jOdi8dz
         1Z+l31KZH+2xwp1PxWzyEzwE9k8YkdzjH3wSA5LS5yBJ5J2L1fa8U5FfzUX8Neb12QYW
         69YuJnS2iwDWfK4aGK4UreoTdwZIGz8C96LDNOcgBV7KLCQSU/d8oLlv78/vw8WLd9O4
         LNeibi8s4HtNlabgpVgSjlIPfUZrm9EGUQ4xGfMmFm0eFeC2KxSs/I05KusodbUCPh6P
         9RNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6RliGfxjeZRZKsvz7+xFZDSC6zQkkXVAUlzYsp0mzbo=;
        b=qtaFJL8gpCJYqyLItQHjJAFj7SVcTSveIKwAV/FAhgeew4wk5HF3bPWDOq/1QL1JFJ
         FPl/VP9J1JcVIincSbP+FAE5oVIfCqAgWMsuPUpFGYKf/qN1+bNvOmhhFc+Vh4rLrL0S
         T5cMo0PGNfustyQjN1XHzM38bZngFRtxLxv4/KAwfbUSZ4PPpPqeNFImeCL1E2IcMGII
         P2CudLw/P7YE65RSewZxcnD6QP0c9mlyrPSytERT35yILE2zvageUooPo15xl5l/AJ8k
         Gp3e5RO5zxn2Vl1YdqyF8AARxEZVCa3evxtc6LPApiA2OozMvOxw8VD4pps8zg4bXDfP
         yhIg==
X-Gm-Message-State: APjAAAWvR/kWyQwtM7jOAhCmkOKMyVuns8PMQGR00US1tAlq0VVSr4JT
        u77zo7lAXoNkrPnzUxFxszV8mQ==
X-Google-Smtp-Source: APXvYqyyXUH29YzkT8TrafrF9AotGHHKFEQ4zZ8CQ4t/MCXVculHlP/PhSsj+O6ynB5w7Sp8f+IgAg==
X-Received: by 2002:a05:600c:1009:: with SMTP id c9mr3586096wmc.6.1572348544385;
        Tue, 29 Oct 2019 04:29:04 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id f20sm2373247wmb.6.2019.10.29.04.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 04:29:03 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     robh@kernel.org, broonie@kernel.org, lee.jones@linaro.org,
        linus.walleij@linaro.org
Cc:     vinod.koul@linaro.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        spapothi@codeaurora.org, bgoswami@codeaurora.org,
        linux-gpio@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 08/11] dt-bindings: pinctrl: qcom-wcd934x: Add bindings for gpio
Date:   Tue, 29 Oct 2019 11:26:57 +0000
Message-Id: <20191029112700.14548-9-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191029112700.14548-1-srinivas.kandagatla@linaro.org>
References: <20191029112700.14548-1-srinivas.kandagatla@linaro.org>
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
 .../pinctrl/qcom,wcd934x-pinctrl.yaml         | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,wcd934x-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,wcd934x-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,wcd934x-pinctrl.yaml
new file mode 100644
index 000000000000..432486d753b3
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,wcd934x-pinctrl.yaml
@@ -0,0 +1,52 @@
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
+additionalProperties: false
+
+examples:
+  - |
+    wcdpinctrl: pinctrl@42 {
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

