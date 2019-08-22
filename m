Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8496CC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 23:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56FEC21848
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 23:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QVFV+tCm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfHVXig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 19:38:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43707 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbfHVXiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 19:38:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id y8so6922789wrn.10
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 16:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jKItD6VTynhG44BbTNA1tEZDVFXwDRIxmLymjPcSI/g=;
        b=QVFV+tCmy73EcWKH38tXOwHM6SjX/FN3fkinZ7uN/cE2EylFPohB4Y1zd2SHcj7jlV
         2FEPd68dT+aA3c5GZ1Rn9TorNwaCs2Lbq8cdHyCbTe2Y0+4ohF3kEvIQ97cbOR8fVrd8
         P5oeaNwy35bkTttplbIAsm8Ek0dt4krXJs+Pxo7LtnziZnoklTADfgvQ64CL1Tkd3Hpt
         j0CNaeNBlnMKXAaR6v0fZvv1yX647dEYtqq3pVywqhF/9+Oo8ZNoMRgSFVWL15+ia7Kn
         kw3vwnq0dVB7Z6McBw6FakPSQ5Hj/AR3es/4NhqknOUsek+vamh/fGQvPkGQS9pvxUmb
         Bakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jKItD6VTynhG44BbTNA1tEZDVFXwDRIxmLymjPcSI/g=;
        b=lXHNK49RViVz1sEp4HMESpr6Ck+/bRJujtpy71b1y9iodEO1u1AEiTK4r77jMx8mpz
         7G2lN/iZ/3HMI+9qe1rzB9DvcHScUND5Im8H8wivTwTFY26+pzhrGOgRHOuxcE5gW16S
         TrYVHOJa4LeduiCAVfTmhHOQNkzU1t+SQLx6+YVT9tpqBK9I7Zr8/M8VSA0xsWrjAtD2
         Z4DoiqGpYufP1ScMwbBgq4h8uiUFbcHKmsZMZn3OtqTrqq7c+AtjcsKaiXuDVUrM3olB
         12BlSHLg/vK/mYelUSO9OwYglKrBYnGcF3oCf47XPkx1n2DTgDMzZvJYmTHv8+NMoABB
         NxgQ==
X-Gm-Message-State: APjAAAVWDnmnjS7aBl66jxq0ZaGm38zFOgfo2iSh+YUfai/Anzy2mKXp
        meUjtxM/LBq8/sg6/RmrMl5clA==
X-Google-Smtp-Source: APXvYqyVlH6GOM5XCUzQUNZg2t2gprlrtcS5VkO7+x5WYPnk12cSbxatchRYDwtle4pkss+6BBvh9g==
X-Received: by 2002:adf:db01:: with SMTP id s1mr1357911wri.164.1566517103228;
        Thu, 22 Aug 2019 16:38:23 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id f134sm1705157wmg.20.2019.08.22.16.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 16:38:22 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, robh+dt@kernel.org, vkoul@kernel.org
Cc:     spapothi@codeaurora.org, bgoswami@codeaurora.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RESEND PATCH v4 3/4] dt-bindings: ASoC: Add WSA881x bindings
Date:   Fri, 23 Aug 2019 00:37:58 +0100
Message-Id: <20190822233759.12663-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822233759.12663-1-srinivas.kandagatla@linaro.org>
References: <20190822233759.12663-1-srinivas.kandagatla@linaro.org>
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

