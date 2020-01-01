Return-Path: <SRS0=1Df5=2W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E447BC2D0DC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 11:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA6C92080A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jan 2020 11:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="MO1HGiBM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbgAALZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 06:25:34 -0500
Received: from mail-pg1-f171.google.com ([209.85.215.171]:33120 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbgAALZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 06:25:32 -0500
Received: by mail-pg1-f171.google.com with SMTP id 6so20535619pgk.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 03:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fdGoH1RBSE0s/FT++wCk+eXRQE/Dps6JokN9W13ec2A=;
        b=MO1HGiBMORzlmmGBTIkfOKcf78TkkSN/9tgtVrUAJc/hRF0XNQaz+yNfURcEgkZtLE
         6LhWWEtQ16lZn4VmnnutJU83l2YZ0Kwi1+mRZ3H9iqS3DSN2jKxEUAZD/v3IeeTSo+Ol
         ovt48RgOeck5uh1ThZ/ZKLFMdDeBwR/dUv+7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fdGoH1RBSE0s/FT++wCk+eXRQE/Dps6JokN9W13ec2A=;
        b=fSVk5iGBLJTunvtx+CRT0o0aQYaNpuFA9/L+AUmv0U2rZz0Nh7PcimU6F5SQx48uG2
         5CdhHnd9HGDfz3n/A7ZjrUiVIZicb8r0824qUkZdvqe75sZZlFRyoRavtoxokExEDqMz
         lGbuJv4iA/rdkNO+8k4J2G0wALSxN9DeRyUftaUt3W/FYcLa5AEaZoy169/cakeAfjSN
         iWq2lpan6MY2OqNqmPedLdpXvHVfAglwPxFETy/5Id9a1UpQKpO/qqLrNcBw8k0WfXc3
         CgjlmmbyA/2h0iS0tBAAeFy+H+E5F2HaGTbw5hlSQdd6kn71quFLIoeNRi/6N7H3zch1
         /Bng==
X-Gm-Message-State: APjAAAUDH5IF9Wcx8IXijKAwzNYKvMLqyz3ka/TXoWH+8phOz7mdnchB
        Ial07MLF/2Pv58vexpY4hmBHGQ==
X-Google-Smtp-Source: APXvYqyhFnef0p6xMGnWn9M8e38I99cM5qjK6fUCTcmrXYfohQ69YIgfsfWMkjrpcd1nvhR1r9Hkmg==
X-Received: by 2002:a65:4587:: with SMTP id o7mr82913622pgq.303.1577877931997;
        Wed, 01 Jan 2020 03:25:31 -0800 (PST)
Received: from localhost.localdomain ([2405:201:c809:c7d5:d0fe:8978:1b04:ff94])
        by smtp.gmail.com with ESMTPSA id y7sm51945439pfb.139.2020.01.01.03.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2020 03:25:31 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 6/6] dt-bindings: display: panel: Convert koe,tx31d200vm0baa to DT schema
Date:   Wed,  1 Jan 2020 16:54:44 +0530
Message-Id: <20200101112444.16250-7-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20200101112444.16250-1-jagan@amarulasolutions.com>
References: <20200101112444.16250-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the koe,tx31d200vm0baa panel bindings to DT schema.

Also, drop the description from legacy .txt since the yaml DT schema
of panel-common.yaml already have that information.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../display/panel/koe,tx31d200vm0baa.txt      | 25 -------------
 .../display/panel/koe,tx31d200vm0baa.yaml     | 37 +++++++++++++++++++
 2 files changed, 37 insertions(+), 25 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/panel/koe,tx31d200vm0baa.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/koe,tx31d200vm0baa.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/koe,tx31d200vm0baa.txt b/Documentation/devicetree/bindings/display/panel/koe,tx31d200vm0baa.txt
deleted file mode 100644
index 6a036ede3e28..000000000000
--- a/Documentation/devicetree/bindings/display/panel/koe,tx31d200vm0baa.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-Kaohsiung Opto-Electronics. TX31D200VM0BAA 12.3" HSXGA LVDS panel
-
-This binding is compatible with the simple-panel binding, which is specified
-in simple-panel.txt in this directory.
-
-Required properties:
-- compatible: should be "koe,tx31d200vm0baa"
-
-Optional properties:
-- backlight: phandle of the backlight device attached to the panel
-
-Optional nodes:
-- Video port for LVDS panel input.
-
-Example:
-	panel {
-		compatible = "koe,tx31d200vm0baa";
-		backlight = <&backlight_lvds>;
-
-		port {
-			panel_in: endpoint {
-				remote-endpoint = <&lvds0_out>;
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/display/panel/koe,tx31d200vm0baa.yaml b/Documentation/devicetree/bindings/display/panel/koe,tx31d200vm0baa.yaml
new file mode 100644
index 000000000000..4b64e8ad8ec5
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/koe,tx31d200vm0baa.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0+ OR X11)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/koe,tx31d200vm0baa.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Kaohsiung Opto-Electronics. TX31D200VM0BAA 12.3" HSXGA LVDS panel
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
+    const: koe,tx31d200vm0baa
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    panel {
+            compatible = "koe,tx31d200vm0baa";
+            backlight = <&backlight_lcd>;
+
+            port {
+                    panel_in: endpoint {
+                            remote-endpoint = <&lvds0_out>;
+                    };
+            };
+    };
-- 
2.18.0.321.gffc6fa0e3

