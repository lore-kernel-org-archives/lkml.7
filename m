Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F170AC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C619920866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZNQQg+I9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbfFNOco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 10:32:44 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51318 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728686AbfFNOca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 10:32:30 -0400
Received: by mail-wm1-f67.google.com with SMTP id 207so2617122wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 07:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tXKT5ral/nl9+HtiFFVBF6lhcj4AzBHp0GEsDCkDxuc=;
        b=ZNQQg+I9sMBruYVnXh9+GCR9U6s0Za4MBghxSh2kQgDiOZPEhxMmkJdUcu2+Wby4n8
         sR5+aciqY9FQDF++Mk4BDDopp57/hpSi2W7hg9GRwMSZOT/T8zTEGS3W0oSwiJScDGcM
         GUsY7zl+swRo+n0MLMZcEVMR8UnJ44Efedz3chYPdgGaujTbEOE+RlFSNB502cIjQGLB
         Q8is1qkd7d4RIWQkatn+JDrxYFmltk2TAG4hcm9rsykKuYoQ1i/kKaq0nixHfNdP12wm
         K7SCpuB/ahzENq7ALAnuKxYEQzscouepQWFdkNb6O7+k/JpXN5T+XT+XZdnjg7IfwOxD
         Auew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tXKT5ral/nl9+HtiFFVBF6lhcj4AzBHp0GEsDCkDxuc=;
        b=umCTG705o6g7mP41QVzCptXT3iilBkgiND7tJrMFTPLoGoi5p+8//c7xsyTV3k+Xsc
         BTvcIddyojsHK1I+9eVbLgJ7TjxZg8hc6l+ooS8TaHvrg4phQMdXvIfn+9UQOhc0CV6j
         PEd8/r6yAA8xUD9FvzVKz0bAVB3yC3tv8xPvnkMPkQjcZesE9AfaRhMFc8nEYUHSDvF8
         J7Ul4mDQ+cwUVL2QShayqBMyj+3Y6UNqbT9gR67/VvttAQuQkss4BUcAe699ZKhTq3++
         FEnYsIrUHyeATepf9SaOv3IK624sxXdDRr1O8CyAIZXI0lTHXmpuPEELVI2rprcesTmN
         1VOw==
X-Gm-Message-State: APjAAAVA2iqptA60XJ5kwvtp/utMV0Z9aaqVFkxMunz21BqzRXiAVztJ
        Ofz919EIVEjZ4tZAwTxh57KF/F/Kslt7KA==
X-Google-Smtp-Source: APXvYqxLxJJyWdBBSjAswGMU//ZhPrN5wz9Zei5JLXI0/VjguFhIzHWuIQK6o2P/IVMGuTZeTDwjjQ==
X-Received: by 2002:a1c:a7ca:: with SMTP id q193mr8963049wme.150.1560522749256;
        Fri, 14 Jun 2019 07:32:29 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id t6sm4738007wmb.29.2019.06.14.07.32.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 07:32:28 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] dt-bindings: nvmem: Convert Allwinner SID to a schema
Date:   Fri, 14 Jun 2019 15:32:21 +0100
Message-Id: <20190614143221.32035-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190614143221.32035-1-srinivas.kandagatla@linaro.org>
References: <20190614143221.32035-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Ripard <maxime.ripard@bootlin.com>

The Allwinner SoCs have an efuse supported in Linux, with a matching Device
Tree binding.

Now that we have the DT validation in place, let's convert the device tree
bindings for that controller over to a YAML schemas.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../nvmem/allwinner,sun4i-a10-sid.yaml        | 51 +++++++++++++++++++
 .../bindings/nvmem/allwinner,sunxi-sid.txt    | 29 -----------
 2 files changed, 51 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
 delete mode 100644 Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt

diff --git a/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml b/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
new file mode 100644
index 000000000000..c9efd6e2c134
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/allwinner,sun4i-a10-sid.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner A10 Security ID Device Tree Bindings
+
+maintainers:
+  - Chen-Yu Tsai <wens@csie.org>
+  - Maxime Ripard <maxime.ripard@bootlin.com>
+
+allOf:
+  - $ref: "nvmem.yaml#"
+
+properties:
+  compatible:
+    enum:
+      - allwinner,sun4i-a10-sid
+      - allwinner,sun7i-a20-sid
+      - allwinner,sun8i-a83t-sid
+      - allwinner,sun8i-h3-sid
+      - allwinner,sun50i-a64-sid
+      - allwinner,sun50i-h5-sid
+      - allwinner,sun50i-h6-sid
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+# FIXME: We should set it, but it would report all the generic
+# properties as additional properties.
+# additionalProperties: false
+
+examples:
+  - |
+    sid@1c23800 {
+        compatible = "allwinner,sun4i-a10-sid";
+        reg = <0x01c23800 0x10>;
+    };
+
+  - |
+    sid@1c23800 {
+        compatible = "allwinner,sun7i-a20-sid";
+        reg = <0x01c23800 0x200>;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt b/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
deleted file mode 100644
index cfb18b4ef8f7..000000000000
--- a/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
+++ /dev/null
@@ -1,29 +0,0 @@
-Allwinner sunxi-sid
-
-Required properties:
-- compatible: Should be one of the following:
-  "allwinner,sun4i-a10-sid"
-  "allwinner,sun7i-a20-sid"
-  "allwinner,sun8i-a83t-sid"
-  "allwinner,sun8i-h3-sid"
-  "allwinner,sun50i-a64-sid"
-  "allwinner,sun50i-h5-sid"
-  "allwinner,sun50i-h6-sid"
-
-- reg: Should contain registers location and length
-
-= Data cells =
-Are child nodes of sunxi-sid, bindings of which as described in
-bindings/nvmem/nvmem.txt
-
-Example for sun4i:
-	sid@1c23800 {
-		compatible = "allwinner,sun4i-a10-sid";
-		reg = <0x01c23800 0x10>
-	};
-
-Example for sun7i:
-	sid@1c23800 {
-		compatible = "allwinner,sun7i-a20-sid";
-		reg = <0x01c23800 0x200>
-	};
-- 
2.21.0

