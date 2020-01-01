Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2663CC2D0DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 11:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1D48207E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 11:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="HTjKXFD2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgAALZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 06:25:15 -0500
Received: from mail-pl1-f172.google.com ([209.85.214.172]:41232 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbgAALZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 06:25:15 -0500
Received: by mail-pl1-f172.google.com with SMTP id bd4so16718038plb.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 03:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oLDdytR8wc6Ae6UhyD4XL/UtDzruDft8+5Buo/1+G1g=;
        b=HTjKXFD2ObFDVX5Jlz2lDxOLFolVdTBrrmYKihRKTELokkjSSIDajoxN/LCdZ7wCE/
         oVTZryPwBx4mZvzDRSm/SRHjh+y2Zc+Lg6sL8cI4aqUmwesX8JsaWSvpjAraVLCol3a7
         AfEWc+et7+HMschH2BG605HEuByJ1Eh/f5oTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oLDdytR8wc6Ae6UhyD4XL/UtDzruDft8+5Buo/1+G1g=;
        b=GKfCkU481Lpqg7OHEsztuRC7IGsaBcoCk+Qpm1yIvRYzo2iTAAOo0UbbK+Kv1S0KLf
         y0rCCziy9Vognxa7eq0ePlLaa4fmMu2E1G5f4J+T/kA5NqsrOlemcEc5AMN/dfKQr4M3
         YgGyTxzneJ8FTKvi0a70HkMB0Go7RK/sAOWWMHNmd35vUFNCirLbrc2QUVH8R0esG0/R
         oBr19hWJaDtU9vTdUDtGk3hk8NB3vJjPH3rIf/4lnGmXIFRmE8/IBlXtcb5/84DGf1Nm
         lcoiNfUwO78K1FjavkymURSBoTZ7PNHsg9z52dNw3rIfoQ+Cd7KGEhxPYSMCbBTz+dLN
         Aynw==
X-Gm-Message-State: APjAAAWTpxnKxW3LmevBno+bqLIN9QuMA/ZuR7gsbGDXqQjPULoANymk
        q/+R5MDD55QGEOQe+dThVj2q0ZGal+g=
X-Google-Smtp-Source: APXvYqwRRNH87p7HLp499Z4ZpvkbBeuJtz0SbzIsx9Vle+soZ+CiON+l1FlEeOZhAveLC1BXRRh6wg==
X-Received: by 2002:a17:90a:a416:: with SMTP id y22mr13466959pjp.114.1577877914440;
        Wed, 01 Jan 2020 03:25:14 -0800 (PST)
Received: from localhost.localdomain ([2405:201:c809:c7d5:d0fe:8978:1b04:ff94])
        by smtp.gmail.com with ESMTPSA id y7sm51945439pfb.139.2020.01.01.03.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 03:25:14 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 1/6] dt-bindings: display: panel: Convert feiyang,fy07024di26a30d to DT schema
Date:   Wed,  1 Jan 2020 16:54:39 +0530
Message-Id: <20200101112444.16250-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20200101112444.16250-1-jagan@amarulasolutions.com>
References: <20200101112444.16250-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the feiyang,fy07024di26a30d panel bindings to DT schema.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../display/panel/feiyang,fy07024di26a30d.txt | 20 --------
 .../panel/feiyang,fy07024di26a30d.yaml        | 50 +++++++++++++++++++
 2 files changed, 50 insertions(+), 20 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.txt b/Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.txt
deleted file mode 100644
index 82caa7b65ae8..000000000000
--- a/Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.txt
+++ /dev/null
@@ -1,20 +0,0 @@
-Feiyang FY07024DI26A30-D 7" MIPI-DSI LCD Panel
-
-Required properties:
-- compatible: must be "feiyang,fy07024di26a30d"
-- reg: DSI virtual channel used by that screen
-- avdd-supply: analog regulator dc1 switch
-- dvdd-supply: 3v3 digital regulator
-- reset-gpios: a GPIO phandle for the reset pin
-
-Optional properties:
-- backlight: phandle for the backlight control.
-
-panel@0 {
-	compatible = "feiyang,fy07024di26a30d";
-	reg = <0>;
-	avdd-supply = <&reg_dc1sw>;
-	dvdd-supply = <&reg_dldo2>;
-	reset-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* LCD-RST: PD24 */
-	backlight = <&backlight>;
-};
diff --git a/Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.yaml b/Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.yaml
new file mode 100644
index 000000000000..16e2fedda49e
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0+ OR X11)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/feiyang,fy07024di26a30d.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Feiyang FY07024DI26A30-D 7" MIPI-DSI LCD Panel
+
+maintainers:
+  - Jagan Teki <jagan@amarulasolutions.com>
+
+properties:
+  compatible:
+    const: feiyang,fy07024di26a30d
+
+  reg:
+    description: DSI virtual channel used by that screen
+
+  avdd-supply:
+    description: analog regulator dc1 switch
+
+  dvdd-supply:
+    description: 3v3 digital regulator
+
+  reset-gpios:
+    description: a GPIO phandle for the reset pin
+
+  backlight:
+    description: Backlight used by the panel
+    $ref: "/schemas/types.yaml#/definitions/phandle"
+
+required:
+  - compatible
+  - reg
+  - avdd-supply
+  - dvdd-supply
+  - reset-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    panel@0 {
+            compatible = "feiyang,fy07024di26a30d";
+            reg = <0>;
+            avdd-supply = <&reg_dc1sw>;
+            dvdd-supply = <&reg_dldo2>;
+            reset-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* LCD-RST: PD24 */
+            backlight = <&backlight>;
+    };
-- 
2.18.0.321.gffc6fa0e3

