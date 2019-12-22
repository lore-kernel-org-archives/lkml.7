Return-Path: <SRS0=7h0X=2M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DB4C2D0D3
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 13:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D50D12063A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 13:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="CrIi6L/+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfLVN3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 08:29:33 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:55812 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfLVN3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 08:29:31 -0500
Received: by mail-pj1-f67.google.com with SMTP id d5so6248019pjz.5
        for <linux-kernel@vger.kernel.org>; Sun, 22 Dec 2019 05:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yZ8n1dFGNqx9MjMWepdptN60E7TYxz6HFWUIoiztPpA=;
        b=CrIi6L/++ZVUaxwSl7hMrcWzqn+AgARP/aDXgQhVDwayW9WwQjGIHVxOKVjmIs/LRU
         xRuzF+iEeSKXzPJ+uOS+jjwNozOdDnDRYA7/uQFxKE42sPXGKDftuDxi7JKTOTmROyrf
         laM6qMlWuFedzbEVUgqszL/8rFagkferTXcG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yZ8n1dFGNqx9MjMWepdptN60E7TYxz6HFWUIoiztPpA=;
        b=eZMrDUBGnJdv0hgIatzDoJBdFGRTh8QEeu0mbyRHKDybZxqb5x7q/yYGnDFLiLBG0W
         Kjyyvb6mXrMO5MN83tHfq2F0ANfJ9hIma8Msk3SeUGfAFj34Us+twwQmZoUNYcX0xdfP
         AFhOXkiuKQRVftP+nBMACMHkVjfIn+QIM0ujXveJ8PF4QZIG2StB2yOntawdbW1UTP5g
         OTcpm7Sb0xNlC9Olw9sdfM01C2bWiIGGDY3qHoI0PnHUolHmPjUy4W6a0mv/L57hPLSK
         qAdbiYlWwHX/q/ZcrqH299o3Zz6JajTkOeEQ4hMVkN5pmAJo1hPkwb2HolUwIe63wOlu
         BjRA==
X-Gm-Message-State: APjAAAXVByUJXphmCDqvnAdt/0PrjhSGjJBTrQLVKXkJr39fnpM/6vhc
        NMAVzGSb4xXX1V44iM6Av8r0Ue93Q1g=
X-Google-Smtp-Source: APXvYqx8VhsvVjyJ4/Sp6CH68k0bIUCH7wuk1lY1KWY5L9o3lzkZKagxgPGCiUmA9dsys23cSvHb8g==
X-Received: by 2002:a17:90a:9c1:: with SMTP id 59mr28516972pjo.65.1577021370933;
        Sun, 22 Dec 2019 05:29:30 -0800 (PST)
Received: from localhost.localdomain ([49.206.202.16])
        by smtp.gmail.com with ESMTPSA id o2sm12073058pjo.26.2019.12.22.05.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2019 05:29:30 -0800 (PST)
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
Subject: [PATCH v14 1/7] dt-bindings: sun6i-dsi: Document A64 MIPI-DSI controller
Date:   Sun, 22 Dec 2019 18:52:23 +0530
Message-Id: <20191222132229.30276-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20191222132229.30276-1-jagan@amarulasolutions.com>
References: <20191222132229.30276-1-jagan@amarulasolutions.com>
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

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v14:
- none

 .../display/allwinner,sun6i-a31-mipi-dsi.yaml | 33 +++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml b/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
index dafc0980c4fa..d41ecb5e7f7c 100644
--- a/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
+++ b/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
@@ -15,7 +15,9 @@ properties:
   "#size-cells": true
 
   compatible:
-    const: allwinner,sun6i-a31-mipi-dsi
+    enum:
+      - allwinner,sun6i-a31-mipi-dsi
+      - allwinner,sun50i-a64-mipi-dsi
 
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
@@ -63,13 +67,38 @@ required:
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
+
+    then:
+        properties:
+          clocks:
+            minItems: 2
+
+        required:
+          - clock-names
+
+  - if:
+      properties:
+         compatible:
+           contains:
+             const: allwinner,sun50i-a64-mipi-dsi
+
+    then:
+        properties:
+          clocks:
+            minItems: 1
+
 additionalProperties: false
 
 examples:
-- 
2.18.0.321.gffc6fa0e3

