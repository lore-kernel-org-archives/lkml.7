Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB38CC3F68F
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 11:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DA0A20842
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 11:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="auDcUmhg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbgAALZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 06:25:33 -0500
Received: from mail-pl1-f178.google.com ([209.85.214.178]:37030 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbgAALZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 06:25:29 -0500
Received: by mail-pl1-f178.google.com with SMTP id c23so16720750plz.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 03:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uOT/TkO2nnC7kJ3ZhTvZjXZpoEskkRgkFAB8b45lofE=;
        b=auDcUmhg4vlldekHTaQDyr7XuUDsHbVYAoGMfWRlGGSsfEv5e2rcUajNy+n+E22vxO
         TvQ3K/Bpf0JWXK1PRJsNwIluXIcIjsWU2WqD5CL/pnHgGQzmmwY9KiaPGLZznCVDhdW3
         YPi4oE5/tU25aR8/zDNqLyUng7kdaivsSSKKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uOT/TkO2nnC7kJ3ZhTvZjXZpoEskkRgkFAB8b45lofE=;
        b=K7PM5DUTlO0Hu9mJl93tWw1D2PMKMEfVLbuFhfNqBOFZ0iAcyfrxN6DU4qVr+ESw/3
         +SZ0EQ+X2ArC6ipl55BJhH9YPdBrG7F/zpSEs/fBu+VUCdfgrZTIPg96HLcw3FEHX6jz
         cYWkfd/Z2RzGcBdE+sT39m58guU53WCbTNRIneB6KPSY0r7OppbrC7bJ8UK3KK4A4wAy
         GxLmsIH87Lant00+nRaBg/Tzz7PoKFRCDLE4HVKcbGSE5AK+lLG9cWbGXTKuwJPcPrmp
         rwKT9NOkXVxEHF7s7FluaSQ/zLdaFSzYKK4tbZfGan+wQUcLU3popYkyChAuyn9PIawo
         xC3Q==
X-Gm-Message-State: APjAAAUCAjDeKD9MSBlsJfbiaXi16x44dX+WIA8IqivjRAI4INezVDPO
        2lgyFTZOo+oYgn0unyFYn/7vzw==
X-Google-Smtp-Source: APXvYqw+QbH5vO3Ge5bKFurNuVGs9RF8kk81/+Grun+c37oR1I8wTfEAsM7OfMbCE0x8S1J/FwiNag==
X-Received: by 2002:a17:902:a5c2:: with SMTP id t2mr79230619plq.86.1577877928529;
        Wed, 01 Jan 2020 03:25:28 -0800 (PST)
Received: from localhost.localdomain ([2405:201:c809:c7d5:d0fe:8978:1b04:ff94])
        by smtp.gmail.com with ESMTPSA id y7sm51945439pfb.139.2020.01.01.03.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 03:25:28 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 5/6] dt-bindings: display: panel: Convert rocktech,rk070er9427 to DT schema
Date:   Wed,  1 Jan 2020 16:54:43 +0530
Message-Id: <20200101112444.16250-6-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20200101112444.16250-1-jagan@amarulasolutions.com>
References: <20200101112444.16250-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the rocktech,rk070er9427 panel bindings to DT schema.

Also, drop the description from legacy .txt since the yaml DT schema
of panel-common.yaml already have that information.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../display/panel/rocktech,rk070er9427.txt    | 25 -------------
 .../display/panel/rocktech,rk070er9427.yaml   | 37 +++++++++++++++++++
 2 files changed, 37 insertions(+), 25 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/rocktech,rk070er9427.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/rocktech,rk070er9427.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/rocktech,rk070er9427.txt b/Documentation/devicetree/bindings/display/panel/rocktech,rk070er9427.txt
deleted file mode 100644
index eb1fb9f8d1f4..000000000000
--- a/Documentation/devicetree/bindings/display/panel/rocktech,rk070er9427.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-Rocktech Display Ltd. RK070ER9427 800(RGB)x480 TFT LCD panel
-
-This binding is compatible with the simple-panel binding, which is specified
-in simple-panel.txt in this directory.
-
-Required properties:
-- compatible: should be "rocktech,rk070er9427"
-
-Optional properties:
-- backlight: phandle of the backlight device attached to the panel
-
-Optional nodes:
-- Video port for LCD panel input.
-
-Example:
-	panel {
-		compatible = "rocktech,rk070er9427";
-		backlight = <&backlight_lcd>;
-
-		port {
-			lcd_panel_in: endpoint {
-				remote-endpoint = <&lcd_display_out>;
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/display/panel/rocktech,rk070er9427.yaml b/Documentation/devicetree/bindings/display/panel/rocktech,rk070er9427.yaml
new file mode 100644
index 000000000000..ac5aebfa4adc
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/rocktech,rk070er9427.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0+ OR X11)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/rocktech,rk070er9427.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rocktech Display Ltd. RK070ER9427 800(RGB)x480 TFT LCD panel
+
+maintainers:
+  - Jagan Teki <jagan@amarulasolutions.com>
+  - Thierry Reding <thierry.reding@gmail.com>
+  - Sam Ravnborg <sam@ravnborg.org>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: rocktech,rk070er9427
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    panel {
+            compatible = "rocktech,rk070er9427";
+            backlight = <&backlight_lcd>;
+
+            port {
+                    lcd_panel_in: endpoint {
+                            remote-endpoint = <&lcd_display_out>;
+                    };
+            };
+    };
-- 
2.18.0.321.gffc6fa0e3

