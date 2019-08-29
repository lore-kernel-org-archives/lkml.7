Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B751C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EDF22341B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AucqA/aP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfH2OpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:45:04 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51655 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfH2OpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:45:02 -0400
Received: by mail-wm1-f66.google.com with SMTP id k1so4023507wmi.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 07:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=suAbTDwiMceHqqJKAwUWw4QMtCa0U1oIrQMTW83oM3o=;
        b=AucqA/aPIGOQ+lWPkLe5EFM+3cZHoMFXxYg0z309/YTknvsCoTldO3TIfbIgldb07d
         js5zs6wpyJC6G2idGzXGF4Q1b2aRdWyZQysVy1L0vG6D8K6vrZUkDBM8cvg4mducf1Yz
         32EN93cjJGFg/NNT+gt+PQRpG1+ZyqEAq30soLx10k1aaIKUXNicV++ddlHAm1/X/e/w
         JvTAP+nI3JVLrVqxo9qYHEY/50HBaKPj+VWzGP4DHxgctwPy06QJlQDOk2P3oxrYNIKK
         szboHGHoRAM+nUzxFABrO7HRHVO1zLqf8tTUAYKvq3dbuTQnG0i80Xy43RUvoIiJqmBU
         +9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=suAbTDwiMceHqqJKAwUWw4QMtCa0U1oIrQMTW83oM3o=;
        b=C6Afv5V9pSFdRvKoRp8k1EUyF4cfNjNBz6y3AagqO8D+kQlv3ge3MgTuCmq/Gi7kvJ
         0EW1/SOVZ0Qvo85KCmBjVP5femQSljPoR5NmuDw58X+MJQ8Xk6JUd+PIE0btxnX3FihQ
         LpQvkA0EXWJUWzCAn2zTzWDEYZji4FvX9cmAgE2KItqeeMH2ZqH7vgkmhEWFY4t0JCBq
         uC9oqonI1w+WsQRX8Xmsu5MsF423hyDvS06n+Yqkh6IMVbZKBT7FNUyRdbdDi2zHyEw6
         mVBVHaH8lKTZKpLFg/fKL7BNBSpuvw3soxAWtj7STMCF+zionj3Isq8dK3WaIcJSJ1Mh
         hWRA==
X-Gm-Message-State: APjAAAXVo3NmWkEvGXYQgx24V+y1fJRJmvd++llS/sgGve/3eET3llnm
        yjkX7HSkpiMSD6gjnu5x8V1Naw==
X-Google-Smtp-Source: APXvYqzKx1ctg6+akphkGML905XR2L019Y5kxwFh2IX9IE5qLeWpKRFtIBLfvAcJNReE8hyVEQ+4eQ==
X-Received: by 2002:a1c:a6cd:: with SMTP id p196mr11902849wme.111.1567089900559;
        Thu, 29 Aug 2019 07:45:00 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id p7sm3923492wmh.38.2019.08.29.07.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 07:45:00 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, robh+dt@kernel.org, vkoul@kernel.org
Cc:     spapothi@codeaurora.org, bgoswami@codeaurora.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, devicetree@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v5 1/4] dt-bindings: soundwire: add slave bindings
Date:   Thu, 29 Aug 2019 15:44:39 +0100
Message-Id: <20190829144442.6210-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190829144442.6210-1-srinivas.kandagatla@linaro.org>
References: <20190829144442.6210-1-srinivas.kandagatla@linaro.org>
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
 .../soundwire/soundwire-controller.yaml       | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml

diff --git a/Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml b/Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml
new file mode 100644
index 000000000000..449b6130ce63
--- /dev/null
+++ b/Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml
@@ -0,0 +1,72 @@
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
+  - Vinod Koul <vkoul@kernel.org>
+
+description: |
+  SoundWire busses can be described with a node for the SoundWire controller
+  device and a set of child nodes for each SoundWire slave on the bus.
+
+properties:
+  $nodename:
+    pattern: "^soundwire(@.*)?$"
+
+  "#address-cells":
+    const: 2
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^.*@[0-9a-f],[0-9a-f]$":
+    type: object
+
+    properties:
+      compatible:
+        pattern: "^sdw[0-9a-f]{1}[0-9a-f]{4}[0-9a-f]{4}[0-9a-f]{2}$"
+        description: Is the textual representation of SoundWire Enumeration
+          address. compatible string should contain SoundWire Version ID,
+          Manufacturer ID, Part ID and Class ID in order and shall be in
+          lower-case hexadecimal with leading zeroes.
+          Valid sizes of these fields are
+          Version ID is 1 nibble, number '0x1' represents SoundWire 1.0
+          and '0x2' represents SoundWire 1.1 and so on.
+          MFD is 4 nibbles
+          PID is 4 nibbles
+          CID is 2 nibbles
+          More Information on detail of encoding of these fields can be
+          found in MIPI Alliance DisCo & SoundWire 1.0 Specifications.
+
+      reg:
+        maxItems: 1
+        description:
+          Link ID followed by Instance ID of SoundWire Device Address.
+
+    additionalProperties: false
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
+        };
+
+        speaker@0,2 {
+            compatible = "sdw10217201000";
+            reg = <0 2>;
+        };
+    };
+
+...
-- 
2.21.0

