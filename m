Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E703C43215
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3378220833
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="kxVcUwh6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfLCNsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 08:48:36 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39525 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfLCNsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 08:48:35 -0500
Received: by mail-pg1-f195.google.com with SMTP id b137so1714876pga.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 05:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UUlsRRK2pgCm9l96Sadau8/Jinv10/1VueVd+pNemqM=;
        b=kxVcUwh6Bbz7GVnMzIw7OTehgR8KgnjaD4BiGmDF/ZlEyM7XbXFeVNJkNUjcS0t6l1
         ug08pUmwQ8V3G1mAq5V/rr+pNYT5oBj1D04K4ejrpKH8Q0S2oo0oJ4yVDGTkroAclcl8
         ITvyf4yd9x2XCvuTbtm7VgEqscmkSFDA0Nuxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UUlsRRK2pgCm9l96Sadau8/Jinv10/1VueVd+pNemqM=;
        b=q95zkyt6dIVap9YNjd2a3JfbPK2t72Sd6DRBXzSgLYqsSmlsbAmgGtB1s2Hvzn+/ww
         T3RUwnXaUof901kQr9kBUUUHh428gP1dntRyoXMgP621dQZLOXG+t6zq7NahinEKErKx
         XJ9aENVhFn0QqttjVwR5z6Pd/W+tJcxDOw7feocamByqamlDHT4VknncIikKEodqzzCR
         aBuYIR7jc/sFXNEFy+R5/cl6hmd5F/q6eRgDHFWO8/sxegDQIHkqZ6WlOf/jsVRovc78
         aV/Fg6ZAY51N5/VFNKf3FaqCXzHYuiaG6ZZpdm1u3tjZyiM28iS/X+QFp24Czr2g6bhH
         qlCA==
X-Gm-Message-State: APjAAAV0m27UoDZB89rkdlpxKfAYihwKcJ0FY3mNivQqfQedUKuC/YNl
        f+PSKgnmqUY8sUzQiwo8u7Q1hw==
X-Google-Smtp-Source: APXvYqybsy7gWan3hjAOgJUaGmGoAqpOTEE3wpc7hSQ1++Wb69OSIzyrvfi/r0nKL4x2BRjmdiyFJw==
X-Received: by 2002:a63:e94d:: with SMTP id q13mr5361869pgj.209.1575380914518;
        Tue, 03 Dec 2019 05:48:34 -0800 (PST)
Received: from localhost.localdomain ([115.97.190.29])
        by smtp.gmail.com with ESMTPSA id y144sm4397892pfb.188.2019.12.03.05.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 05:48:34 -0800 (PST)
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
Subject: [PATCH v12 1/7] dt-bindings: sun6i-dsi: Document A64 MIPI-DSI controller
Date:   Tue,  3 Dec 2019 19:18:10 +0530
Message-Id: <20191203134816.5319-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20191203134816.5319-1-jagan@amarulasolutions.com>
References: <20191203134816.5319-1-jagan@amarulasolutions.com>
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
Changes for v12:
- Use 'enum' instead of oneOf+const

 .../display/allwinner,sun6i-a31-mipi-dsi.yaml | 20 +++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml b/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
index dafc0980c4fa..b91446475f35 100644
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

