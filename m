Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54828C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 22:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0620A233FC
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 22:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UIbD8GdZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405294AbfHVWg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 18:36:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36581 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405066AbfHVWg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 18:36:27 -0400
Received: by mail-wr1-f68.google.com with SMTP id r3so6856262wrt.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 15:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jKItD6VTynhG44BbTNA1tEZDVFXwDRIxmLymjPcSI/g=;
        b=UIbD8GdZb05DvJGyoe8mUhcjQ+SEbR4I1go5jt3NvovhaS5NSHSJFJ1Zhn7URrhEbN
         VElQUAWabycOuciSESS4qCbHIFw6xUeb7HsjI5iThHVz0bBZeUMw3yVS+f9aSZ2OeZ/6
         m/FGQv9upzbh47uolgLBj6YE0VLyzp7WyBx8wGqM6q6+/CqAHn9Fs2Yt274hpZKDMOFB
         pJpB8ff93pEiB9c5L0H5gPFY8MCMuTBTFLK/0ZfaNTMtiqrg2wRdjE3XG698ck02HEI9
         zUSPGXphTpUiqi8T1UPZFArmPpY+XzuD1eQbvkXtprW64A7XzrFDS4RPgBkxbLBGfJFI
         /mzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jKItD6VTynhG44BbTNA1tEZDVFXwDRIxmLymjPcSI/g=;
        b=YAWAfFW+Dqy3wwJmGo3zyvRP5bpGPbdrUWlKX0/vl7hmKI/lhY0dXrwEAAp/xkn3J7
         eRdw9JzvHtWqn6CYXYC7K8vv++rUP3gJ7eoymli0sd7aQMs1JVeZYeYTBLUYluYn8tnv
         Z5okhyjajBYtWNhzxxNVmeVGlxemcdF1WFRIpqbs9zgNAGB9RgHlpcSrCCq5+ygLFQli
         JPD6rMb5pqUfneIZn6lmNDbZvw0+T1G4uswAm4fwVMrp2lrQOvQ2zDCDkEvNXwkcZaTG
         TXgkldEK9yV9Jg1+jhyL/OYX+VSF5Mpik9yQHT/2kK11r5U/wcIUTxT8P3WkI7/pK2Fc
         eRJQ==
X-Gm-Message-State: APjAAAVUVKja8pMeYjTgjc4f/GDPDK8iDDttUQrQu3lkZmXuHBdF0/jz
        Lbu1KdKo7qIKVl3U+lafbtZnyQ==
X-Google-Smtp-Source: APXvYqy0eUrEncO6dXNEUZrNk2ZhNndpnblHusApU+VE3u0zUnQEc3+LjQadGewlrSU67VKgbRwHtQ==
X-Received: by 2002:a5d:568e:: with SMTP id f14mr1102872wrv.167.1566513385232;
        Thu, 22 Aug 2019 15:36:25 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id m188sm1886380wmm.32.2019.08.22.15.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 15:36:24 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, robh+dt@kernel.org, vkoul@kernel.org
Cc:     spapothi@codeaurora.org, bgoswami@codeaurora.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 3/4] dt-bindings: ASoC: Add WSA881x bindings
Date:   Thu, 22 Aug 2019 23:36:05 +0100
Message-Id: <20190822223606.6775-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822223606.6775-1-srinivas.kandagatla@linaro.org>
References: <20190822223606.6775-1-srinivas.kandagatla@linaro.org>
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
 .../bindings/sound/qcom,wsa881x.yaml          | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml

diff --git a/Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml b/Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml
new file mode 100644
index 000000000000..ad718d75c660
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: GPL-2.0
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
+allOf:
+  - $ref: "soundwire-controller.yaml#"
+
+properties:
+  compatible:
+    const: sdw10217201000
+
+  reg:
+    maxItems: 1
+
+  pd-gpios:
+    description: GPIO spec for Powerdown/Shutdown line to use
+    maxItems: 1
+
+  "#thermal-sensor-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - pd-gpios
+  - #thermal-sensor-cells
+
+examples:
+  - |
+    efuse@1c23800 {
+        compatible = "allwinner,sun4i-a10-sid";
+        reg = <0x01c23800 0x10>;
+        pd-gpios = <&wcdpinctrl 2 0>;
+        #thermal-sensor-cells = <0>;
+    };
+
+...
-- 
2.21.0

