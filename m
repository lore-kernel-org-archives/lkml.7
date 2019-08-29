Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0750FC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 16:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C742F2166E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 16:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mApPXG0X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfH2Qgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 12:36:55 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38897 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbfH2Qgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 12:36:41 -0400
Received: by mail-wr1-f67.google.com with SMTP id e16so4118686wro.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 09:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uODZAlCkiSE/bKJhKAz8rlp7NCW9snJyiy8JBrR1VCw=;
        b=mApPXG0XWA1gfN05UGmqu2X89CUhhEFqhFFUCJsa9sadnG82mtfokDvxwlYTDWpieO
         F6SldFti2FnAMbHlNVojpVAr+OllpG7MgvdO/Z6LiSOUhWw6mdzFGLHOS8EnpoR81PxQ
         Xa/GRf5fSw1R+iZXUFxSc7FUNN2XLgOvHXGZInynrzyDkyQC5LbpLHMjcbmf7mJE7FO6
         HLh45DZxuXMzpiyQ89u9qsevOaSr/Iy651odrCGgVZeIJmtY3jOnPZu9pIQSU0wl97yX
         o9w37UW7CZNmeahBINh9vKz3iSMA6h1TErX5v8Fg2wNTl4uG1MrE6z5fQI5qf2vhD0vt
         /loQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uODZAlCkiSE/bKJhKAz8rlp7NCW9snJyiy8JBrR1VCw=;
        b=fsjEuf94vhewyWDsH5E6EVSYphfS2oUiXUx29v8YPlj4nhYw6ZYPJ6OeiaHzMt4SnU
         k0BccaiCNPKRCSHecwE6hAiNE9zB5yCCyqT+xPO3P+1dtDX5XNSFZc/AWD/CQciC033b
         N07UFWzEUfDERAnHXHtcATcsp1wQIj9zVYWtD2T6MF1X1eF4BnosZ1DT+Tk5khkwphb8
         PNb/He+pv13rzSXkt2wCzsIToUxX8R3eGGseVg6p3t9IUEs6CLqL5mbVbZOLLvxP+g5v
         gBBunmKyqMjrp7KILx3D9guj6oOkggXoweqduHFbbmQl+R4LD707RyzOy9XurFTiu66w
         jhTw==
X-Gm-Message-State: APjAAAW5jW9Itaj28KQsl6J+LZ0Lcnr9c5B1oyNeujEpJBYXsY+6QMWa
        cxsearO5IFjH5UC8aGHWNdDFng==
X-Google-Smtp-Source: APXvYqzGyFneHpcFhMPPomV4ePM5ce4JBgHf2enu6MOATiDfOAfr/WVqucexAtZ9BMn2awNiWQ3KiQ==
X-Received: by 2002:adf:e50b:: with SMTP id j11mr12682651wrm.65.1567096599459;
        Thu, 29 Aug 2019 09:36:39 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id k9sm4398243wrq.15.2019.08.29.09.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 09:36:38 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, robh+dt@kernel.org, vkoul@kernel.org
Cc:     spapothi@codeaurora.org, bgoswami@codeaurora.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v6 3/4] dt-bindings: ASoC: Add WSA881x bindings
Date:   Thu, 29 Aug 2019 17:35:13 +0100
Message-Id: <20190829163514.11221-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190829163514.11221-1-srinivas.kandagatla@linaro.org>
References: <20190829163514.11221-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds bindings for WSA8810/WSA8815 Class-D Smart Speaker
Amplifier. This Amplifier also has a simple thermal sensor for
over temperature and speaker protection.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/sound/qcom,wsa881x.yaml          | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml

diff --git a/Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml b/Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml
new file mode 100644
index 000000000000..faa90966a33a
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/qcom,wsa881x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bindings for Qualcomm WSA8810/WSA8815 Class-D Smart Speaker Amplifier
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+description: |
+  WSA8810 is a class-D smart speaker amplifier and WSA8815
+  is a high-output power class-D smart speaker amplifier.
+  Their primary operating mode uses a SoundWire digital audio
+  interface. This binding is for SoundWire interface.
+
+properties:
+  compatible:
+    const: sdw10217201000
+
+  reg:
+    maxItems: 1
+
+  powerdown-gpios:
+    description: GPIO spec for Powerdown/Shutdown line to use
+    maxItems: 1
+
+  '#thermal-sensor-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - powerdown-gpios
+  - "#thermal-sensor-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    soundwire@c2d0000 {
+        #address-cells = <2>;
+        #size-cells = <0>;
+        reg = <0x0c2d0000 0x2000>;
+
+        speaker@0,1 {
+            compatible = "sdw10217201000";
+            reg = <0 1>;
+            powerdown-gpios = <&wcdpinctrl 2 0>;
+            #thermal-sensor-cells = <0>;
+        };
+
+        speaker@0,2 {
+            compatible = "sdw10217201000";
+            reg = <0 2>;
+            powerdown-gpios = <&wcdpinctrl 2 0>;
+            #thermal-sensor-cells = <0>;
+        };
+    };
+
+...
-- 
2.21.0

