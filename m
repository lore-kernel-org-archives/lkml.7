Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625A7C2D0C2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 13:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EA6E206E4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 13:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="MdCq41of"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfLaNGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 08:06:19 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42014 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbfLaNGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 08:06:18 -0500
Received: by mail-pf1-f193.google.com with SMTP id 4so19722830pfz.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Dec 2019 05:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=httxNtiAtTuNvzz6MxoyCtXDBVFL0u6yHkvzNjKde9c=;
        b=MdCq41ofpEY8c34RFkP1S5dM234FR2fXVDzxinANFdkXgf0FmIvFirPZtrEymmP3rZ
         LRs/Acpaff/uiK9bcF0jbGBfc4NqQsBHRXTV5RGNJtDUQMjnEHt3B4Fek+onqtGLlGXR
         6h2gMOSkO3d5uyOGF/tLmDijKezdJdS0sH1+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=httxNtiAtTuNvzz6MxoyCtXDBVFL0u6yHkvzNjKde9c=;
        b=Q4DjuWGMEvawLsXENeBqi06sOYRKYeUDDYpdMHZyfR69Nopyul2AiVzQ4xF5TifAmZ
         gnD/stiLGXMMkIvj3ZTHQedhHKL+Y0QLd4x+BIQl/MDFmk9OquFzGK1FlSwFgZ2gMGMB
         RN5M1Dskmizp0G6cST+2IzCiny3TbLOrdIbQLvNyxbxOKFDOnBIabFYbdVrPl9imvANE
         utDNrdI9HoFmG0Try+F1CnYFlpEv/vLQY5G7R/z6f6S2XWW7+xmrlWIpDNFx886AllUy
         rCNlMtZ1BECc/+dSi+hShO6liO7Su+DIkuNDYz4XNRM7QWLU/KT/jKPMe35ZXNzGI+z/
         Nqnw==
X-Gm-Message-State: APjAAAUUJBU/Pli4uuxbbdg+NqtyH/56PcFtbzbLkuDGlPiQ+ahDhA+H
        vnPryB+7Yezyiq73Ydq12KcTeA==
X-Google-Smtp-Source: APXvYqzP7Mrk8jxC0HNGSJpd7IzJbAguLU0Np2bAgt6OGvXHASkOvcgw72p733pq9UW4WQ3i9a9jJg==
X-Received: by 2002:a65:4501:: with SMTP id n1mr76072356pgq.336.1577797577740;
        Tue, 31 Dec 2019 05:06:17 -0800 (PST)
Received: from localhost.localdomain ([49.206.202.115])
        by smtp.gmail.com with ESMTPSA id i3sm55204089pfg.94.2019.12.31.05.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2019 05:06:17 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 7/9] dt-bindings: sun6i-dsi: Document R40 MIPI-DSI controller (w/ A64 fallback)
Date:   Tue, 31 Dec 2019 18:35:26 +0530
Message-Id: <20191231130528.20669-8-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20191231130528.20669-1-jagan@amarulasolutions.com>
References: <20191231130528.20669-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MIPI DSI controller on Allwinner R40 is similar on
the one on A64 like doesn't associate any DSI_SCLK gating.

So, add R40 compatible and append A64 compatible as fallback.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- update the binding in new yaml format

 .../bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml    | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml b/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
index d41ecb5e7f7c..138ffb6ae403 100644
--- a/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
+++ b/Documentation/devicetree/bindings/display/allwinner,sun6i-a31-mipi-dsi.yaml
@@ -15,9 +15,11 @@ properties:
   "#size-cells": true
 
   compatible:
-    enum:
-      - allwinner,sun6i-a31-mipi-dsi
-      - allwinner,sun50i-a64-mipi-dsi
+    oneOf:
+      - const: allwinner,sun6i-a31-mipi-dsi
+      - const: allwinner,sun50i-a64-mipi-dsi
+      - items:
+          - const: allwinner,sun8i-r40-mipi-dsi
 
   reg:
     maxItems: 1
-- 
2.18.0.321.gffc6fa0e3

