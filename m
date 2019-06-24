Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2E6C4646B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 22:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 520C02083D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 22:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561413609;
	bh=lw5GuMlwurRFIck+THkaL+0gGqOuBPz+HQ70nF0227w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mG0Hilt44mwvUWPTcnL5U0CDgscwQpN0K1Kon9e6yEhQQQEuSI23GK0/ukYhLUZaY
	 nbb+ZxUoNtqRFgSvaedcPjn5ESt46n+LIKQSFfXUdY6pHgC3VJ41IYsaEzf9iQE1wj
	 UaG2yCeTlTtkUNYzzMyHbs9fPol9X11kYXnqCqRI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730695AbfFXWAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 18:00:07 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44835 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732608AbfFXV65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 17:58:57 -0400
Received: by mail-io1-f65.google.com with SMTP id s7so373836iob.11;
        Mon, 24 Jun 2019 14:58:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EsofIvvvlgyPGjRrCqOhd2B5EfQ76NdrYwJSPILmUYU=;
        b=ZBDflobFKnKbmkU4va2vVnMcsZu6TPZuMSsqb38CVfNL9J+v3HJlmD/5WJKlUsb8Wn
         UsXc2iBxwtbyMsx6VjrvsPBosjFLT51AdRCDbEOnJLC8s7+FEE4TKyhMSIaUPe4xgz23
         nJPpoOLs7JfRZm8+6+sB+REkVCVtFTQy8wybH8ZFYRRMeCYd2MYKREHmhJG/VNds8lZO
         1g77K8NAaGFjrlvWpkEiClAgFSUx4A10Ecm2p2tXmbr/moY4mPf9HQMoBRGmvMvNzlgv
         U1hVwtW9EUS8TQBEZO4vnA/TggKitKej5c9/zc1VBWYDx03B6YNeq8IT0XhWi2yOeSUE
         NkpA==
X-Gm-Message-State: APjAAAUyEBjIpF1ZJyD2RfBMwWaoc0R1CtFTpzgZMjY8CbFpBGqSh7tx
        ez0q/pRS/+Iq/CNrxkOYrXKVVD4=
X-Google-Smtp-Source: APXvYqypkquLGIbeEuuKXDqGyJadIY3xZB0pV5upOm2xBGDsKARVJrcz5ROUd99C3CHulYEBkUg9wQ==
X-Received: by 2002:a6b:f00c:: with SMTP id w12mr4134606ioc.280.1561413536983;
        Mon, 24 Jun 2019 14:58:56 -0700 (PDT)
Received: from localhost.localdomain ([64.188.179.247])
        by smtp.googlemail.com with ESMTPSA id l5sm14717301ioq.83.2019.06.24.14.58.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 14:58:56 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        Thierry Reding <treding@nvidia.com>
Subject: [PATCH v2 03/15] dt-bindings: display: Convert ampire,am-480272h3tmqw-t01h panel to DT schema
Date:   Mon, 24 Jun 2019 15:56:37 -0600
Message-Id: <20190624215649.8939-4-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190624215649.8939-1-robh@kernel.org>
References: <20190624215649.8939-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the ampire,am-480272h3tmqw-t01h panel binding to DT schema.

Cc: Yannick Fertre <yannick.fertre@st.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org
Reviewed-by: Maxime Ripard <maxime.ripard@bootlin.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../panel/ampire,am-480272h3tmqw-t01h.txt     | 26 ------------
 .../panel/ampire,am-480272h3tmqw-t01h.yaml    | 42 +++++++++++++++++++
 2 files changed, 42 insertions(+), 26 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/ampire,am-480272h3tmqw-t01h.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/ampire,am-480272h3tmqw-t01h.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/ampire,am-480272h3tmqw-t01h.txt b/Documentation/devicetree/bindings/display/panel/ampire,am-480272h3tmqw-t01h.txt
deleted file mode 100644
index 6812280cb109..000000000000
--- a/Documentation/devicetree/bindings/display/panel/ampire,am-480272h3tmqw-t01h.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-Ampire AM-480272H3TMQW-T01H 4.3" WQVGA TFT LCD panel
-
-This binding is compatible with the simple-panel binding, which is specified
-in simple-panel.txt in this directory.
-
-Required properties:
-- compatible: should be "ampire,am-480272h3tmqw-t01h"
-
-Optional properties:
-- power-supply: regulator to provide the supply voltage
-- enable-gpios: GPIO pin to enable or disable the panel
-- backlight: phandle of the backlight device attached to the panel
-
-Optional nodes:
-- Video port for RGB input.
-
-Example:
-	panel_rgb: panel-rgb {
-		compatible = "ampire,am-480272h3tmqw-t01h";
-		enable-gpios = <&gpioa 8 1>;
-		port {
-			panel_in_rgb: endpoint {
-				remote-endpoint = <&controller_out_rgb>;
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/display/panel/ampire,am-480272h3tmqw-t01h.yaml b/Documentation/devicetree/bindings/display/panel/ampire,am-480272h3tmqw-t01h.yaml
new file mode 100644
index 000000000000..c6e33e7f36d0
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/ampire,am-480272h3tmqw-t01h.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/ampire,am-480272h3tmqw-t01h.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ampire AM-480272H3TMQW-T01H 4.3" WQVGA TFT LCD panel
+
+maintainers:
+  - Yannick Fertre <yannick.fertre@st.com>
+  - Thierry Reding <treding@nvidia.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: ampire,am-480272h3tmqw-t01h
+
+  power-supply: true
+  enable-gpios: true
+  backlight: true
+  port: true
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    panel_rgb: panel {
+      compatible = "ampire,am-480272h3tmqw-t01h";
+      enable-gpios = <&gpioa 8 1>;
+      port {
+        panel_in_rgb: endpoint {
+          remote-endpoint = <&controller_out_rgb>;
+        };
+      };
+    };
+
+...
-- 
2.20.1

