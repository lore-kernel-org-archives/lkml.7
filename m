Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B313C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 16:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EC2F21670
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 16:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562344951;
	bh=lw5GuMlwurRFIck+THkaL+0gGqOuBPz+HQ70nF0227w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GhOrzyr+TPA0xdBjf9bwo7ZM6DGNiqTjQf4AzDdD6sM8o42ASdpWWWzeSfQ3wpQXK
	 EoB7lNUhtbab41Lb7ihW3gWzVCJA1+WfWYh/qBGkmFz1URzRwQNiEXpQecC8vvx5xf
	 i/lr4EY5URyJDF3sWTSGz1oZvc/5FAmxapdgpjUE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbfGEQma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 12:42:30 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:32880 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728606AbfGEQm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 12:42:27 -0400
Received: by mail-io1-f65.google.com with SMTP id z3so5402460iog.0;
        Fri, 05 Jul 2019 09:42:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EsofIvvvlgyPGjRrCqOhd2B5EfQ76NdrYwJSPILmUYU=;
        b=l68kmPE5f51uPNzoC7MuOOjl8L1Y4fLjN+zPtU54en2+iejrlN//P3yf1E0FKqXPmO
         LL3A7cHFGkw8I5290Kf35fF4rLzhYg67CbOuuJAkV3IQUWRQUhQXjjJjL/xiIVwpStb9
         zaRav6uflKrztshxiG2PTwV7M6x0x6YiMazZ3UjJPoVzhTFJl9oS/XvwirqI6rVYm9Mp
         /49hoRge4K9rx42hzeh+ZjGx3Trxxj+h/sDuoYwy/W49EklLrlEsd58KRw5vGzIOBikR
         gjZLLisKtsGGAkxlR2nV7iMFCtJG+wPt/pHVB5sO3nR6QxZ4KRrz/T79x3r2MJxem6LK
         kvFw==
X-Gm-Message-State: APjAAAV33psm96twaWPoVhuBq9KI6blfEpFypVhP44V/JCB++H+0v/rb
        3BU9BQt0zfB8OuS/ZmqRXA==
X-Google-Smtp-Source: APXvYqxj4IttrNLgYXfcBVNobwfb+KUKqyRv0sq9vrDvePX9xWww2ZDDrFdc58G7d3dvFLUuY0ZR9g==
X-Received: by 2002:a6b:dd18:: with SMTP id f24mr3652278ioc.97.1562344946800;
        Fri, 05 Jul 2019 09:42:26 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id b8sm6878104ioj.16.2019.07.05.09.42.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 09:42:25 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        Thierry Reding <treding@nvidia.com>
Subject: [PATCH v3 02/13] dt-bindings: display: Convert ampire,am-480272h3tmqw-t01h panel to DT schema
Date:   Fri,  5 Jul 2019 10:42:10 -0600
Message-Id: <20190705164221.4462-3-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190705164221.4462-1-robh@kernel.org>
References: <20190705164221.4462-1-robh@kernel.org>
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

