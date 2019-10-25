Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D1CCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 17:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 749AF205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 17:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="I4XfFKf3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbfJYR4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 13:56:52 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34477 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728670AbfJYR4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 13:56:49 -0400
Received: by mail-pg1-f195.google.com with SMTP id k20so2032289pgi.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 10:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SvO1A1WodzP09Lr/d61c8nwX2ky0IL4uKfdfDnxUPmw=;
        b=I4XfFKf3RnZY4BUBJ06ANjDE0z1GGx0Afz6XL/cNhEQmqi+MUhs+nXMKueeEqbcYv5
         ivOmHPAV2dOpG6pCDpgF2Vi8AXSwhVaudm6w1kFSZ4SP4AHmdQmdvPl+X9Tas0C6m3A3
         bFxqOPf/VbzeXjotxsF22smaJJ/2ZV1IjNkqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SvO1A1WodzP09Lr/d61c8nwX2ky0IL4uKfdfDnxUPmw=;
        b=l9S8KhOGlvTa/N/k9uYQsSUnspFgdARmmKeh1qJJwR00+8/1YPD0MOewhFUNjn4GZa
         vR07XdzIxwadtBfnEGRyQqIrAmuUdM+wMnhkQONcoBVwarckHTwRZQTabXPSsACu/zkY
         z5np8aeaGYMEcEJaj+zvLHsZpb4tU+BjugeeYkubiGv1wsm87qs+G3VdbTTBLJf1Fzir
         lAf2vIzlZF54Qv8MRTsg0vZZ5xb946SH9xu4pd0wI5St9gk/HFq8SihYXdvsz77S+I7T
         OoKqAVee1f0iBgC3zhuKNbqcZts52hCdLoSwPk+18apnjYONSLCuSWoG/p/syHWgUfMP
         PXtQ==
X-Gm-Message-State: APjAAAWisOFMsEsF52hQ9szIkwI/AJU0pU0TWEbboSmKbl22xTfJ5vX/
        QaRzpCYrmlkukFOwUf42Q0WIwQ==
X-Google-Smtp-Source: APXvYqwtMqZQKmJ6DIKbe31ZyiLHeuFErJqjqH6z2emRh6lR+XJ+rba3bVgZ3LyEV+aTG50TN3A3Rg==
X-Received: by 2002:a17:90a:fc93:: with SMTP id ci19mr5849047pjb.34.1572026208821;
        Fri, 25 Oct 2019 10:56:48 -0700 (PDT)
Received: from localhost.localdomain ([115.97.180.31])
        by smtp.gmail.com with ESMTPSA id n15sm2926580pfq.146.2019.10.25.10.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 10:56:48 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     michael@amarulasolutions.com, Icenowy Zheng <icenowy@aosc.io>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v11 1/7] dt-bindings: sun6i-dsi: Document A64 MIPI-DSI controller
Date:   Fri, 25 Oct 2019 23:26:19 +0530
Message-Id: <20191025175625.8011-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20191025175625.8011-1-jagan@amarulasolutions.com>
References: <20191025175625.8011-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MIPI DSI controller in Allwinner A64 is similar to A33.

But unlike A33, A64 doesn't have DSI_SCLK gating so it is valid
to have separate compatible for A64 on the same driver.

DSI_SCLK uses mod clock-names on dt-bindings, so the same
is not required for A64.

On that note
- A64 require minimum of 1 clock like the bus clock
- A33 require minimum of 2 clocks like both bus, mod clocks

So, update dt-bindings so-that it can document both A33,
A64 bindings requirements.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../display/allwinner,sun6i-a31-mipi-dsi.yaml | 20 +++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml b/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
index dafc0980c4fa..2b7016ca382c 100644
--- a/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
+++ b/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
@@ -15,7 +15,9 @@ properties:
   "#size-cells": true
 
   compatible:
-    const: allwinner,sun6i-a31-mipi-dsi
+    oneOf:
+      - const: allwinner,sun6i-a31-mipi-dsi
+      - const: allwinner,sun50i-a64-mipi-dsi
 
   reg:
     maxItems: 1
@@ -24,6 +26,8 @@ properties:
     maxItems: 1
 
   clocks:
+    minItems: 1
+    maxItems: 2
     items:
       - description: Bus Clock
       - description: Module Clock
@@ -63,13 +67,25 @@ required:
   - reg
   - interrupts
   - clocks
-  - clock-names
   - phys
   - phy-names
   - resets
   - vcc-dsi-supply
   - port
 
+allOf:
+  - if:
+      properties:
+         compatible:
+           contains:
+             const: allwinner,sun6i-a31-mipi-dsi
+      then:
+        properties:
+          clocks:
+            minItems: 2
+        required:
+          - clock-names
+
 additionalProperties: false
 
 examples:
-- 
2.18.0.321.gffc6fa0e3

