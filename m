Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3E1C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 22:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA8423404
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 22:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NHwJIpoO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405257AbfHVWg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 18:36:26 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44638 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394047AbfHVWgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 18:36:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id p17so6827580wrf.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 15:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ICylmLaXjvjxyRupyDXag7YX8QEWl2rJ5Qnlp9tRyNI=;
        b=NHwJIpoOygjAesmcaT9cgKgK5EmbkcoPBCgr/XVzQGV8/jwWWF9xDjRXqnPFirYByQ
         yCnYOdCUS3SZfZjfrXBGJKwRVnfm1/lrbnCsfiiN89KsgfjqPjM+DgZ+qaHDAi3S4ReQ
         517z9ZCq8+POKOrhJSVBX66zdPEVT45GrNTcSpfVdnTZDi+eAYXwuxX8E+zCg4ptrW4s
         kGnd+ATL2tbfubrA46gtMMH5LSYrayS3xTsSzUownEhr8lpne5QgzsyI5QckwJW2elvy
         VvQEtJyuxkhIEduKetGIaTLTvlGt1CGGIQ4UFlmkE98X2GVPi8iwZ0kCwjm1I3jCCKhL
         q6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ICylmLaXjvjxyRupyDXag7YX8QEWl2rJ5Qnlp9tRyNI=;
        b=LW90pCMGjOPSe/J5lviM2U0KORGk4RntJNX2OVd+UnJoQm4wSO6BNU8wpt+U3v575r
         Jlos9WmPE3JqfN0tv1pnEdAev4LY5MTOQT3l7LQdww9r8NMBk8zW+d8xq33tWR/IR6ac
         nD2tmKzqhBvymYyojvodfn00yoykdvVrNhHQ+uBeUzni4egU0qaxkN9JMx7z47Pu3Wp3
         H9o38A9MUr4GJhQRLAU4b/8t6FycwNyEcrTlDU7pAkf5pQ5bQoR3GTR0NqTfiFkD77Ic
         KCRK0dt3mTDQM3rJoUTlcJqDrhETIZL9MxdbFzFWz7drAD5/5POkYxGOD8lp3CJ2t5kb
         TjQA==
X-Gm-Message-State: APjAAAXC46IJ3teRO1fFQx+kLdoLrj2lGTiWsy2u/lMoGEfI5JhKdApY
        f4AnQ92qIjWhlCPg7b+fHEXOHg==
X-Google-Smtp-Source: APXvYqyWyQV/XNltW8o4rBAsXauwGsJAMNrtyIc5bFPN4+DmieytyPJI5Sa7f+OuakCvrBzDLa/fhQ==
X-Received: by 2002:adf:f1cc:: with SMTP id z12mr1114734wro.125.1566513382808;
        Thu, 22 Aug 2019 15:36:22 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id m188sm1886380wmm.32.2019.08.22.15.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 15:36:21 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, robh+dt@kernel.org, vkoul@kernel.org
Cc:     spapothi@codeaurora.org, bgoswami@codeaurora.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 1/4] dt-bindings: soundwire: add slave bindings
Date:   Thu, 22 Aug 2019 23:36:03 +0100
Message-Id: <20190822223606.6775-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822223606.6775-1-srinivas.kandagatla@linaro.org>
References: <20190822223606.6775-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds bindings for Soundwire Slave devices that includes how
SoundWire enumeration address and Link ID are used to represented in
SoundWire slave device tree nodes.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../soundwire/soudwire-controller.yaml        | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soundwire/soudwire-controller.yaml

diff --git a/Documentation/devicetree/bindings/soundwire/soudwire-controller.yaml b/Documentation/devicetree/bindings/soundwire/soudwire-controller.yaml
new file mode 100644
index 000000000000..91aa6c6d6266
--- /dev/null
+++ b/Documentation/devicetree/bindings/soundwire/soudwire-controller.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soundwire/soundwire-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SoundWire Controller Generic Binding
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+description: |
+  SoundWire busses can be described with a node for the SoundWire controller
+  device and a set of child nodes for each SoundWire slave on the bus.
+
+properties:
+  $nodename:
+    pattern: "^soundwire(@.*|-[0-9a-f])*$"
+
+  "#address-cells":
+    const: 2
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^.*@[0-9a-f]+$":
+    type: object
+
+    properties:
+      compatible:
+      pattern: "^sdw[0-9][0-9a-f]{4}[0-9a-f]{4}[0-9a-f]{2}$"
+      description:
+	  Is the textual representation of SoundWire Enumeration
+	  address. compatible string should contain SoundWire Version ID,
+	  Manufacturer ID, Part ID and Class ID in order and shall be in
+	  lower-case hexadecimal with leading zeroes.
+	  Valid sizes of these fields are
+	  Version ID is 1 nibble, number '0x1' represents SoundWire 1.0
+	  and '0x2' represents SoundWire 1.1 and so on.
+	  MFD is 4 nibbles
+	  PID is 4 nibbles
+	  CID is 2 nibbles
+	  More Information on detail of encoding of these fields can be
+	  found in MIPI Alliance DisCo & SoundWire 1.0 Specifications.
+
+      reg:
+        maxItems: 1
+        description:
+          Instance ID and Link ID of SoundWire Device Address.
+
+    required:
+      - compatible
+      - reg
+
+examples:
+  - |
+    soundwire@c2d0000 {
+        #address-cells = <2>;
+        #size-cells = <0>;
+        compatible = "qcom,soundwire-v1.5.0";
+        reg = <0x0c2d0000 0x2000>;
+
+        speaker@1 {
+            compatible = "sdw10217201000";
+            reg = <1 0>;
+        };
+
+        speaker@2 {
+            compatible = "sdw10217201000";
+            reg = <2 0>;
+        };
+    };
+
+...
-- 
2.21.0

