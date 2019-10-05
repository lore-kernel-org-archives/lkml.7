Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2918DC47404
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 14:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3B76222CB
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 14:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="pqNAHW+F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbfJEOTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 10:19:33 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39904 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727715AbfJEOTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 10:19:32 -0400
Received: by mail-pl1-f194.google.com with SMTP id s17so4529496plp.6
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2019 07:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lLu60EjnRBnW4wz32/fkJTOsgD5cNWvT5qBN+RYNBTg=;
        b=pqNAHW+FwCPLtmMCrEkOjKWwvUGOVLbSDKFc786vnhYyrwlP6swsENzUfsK51+kxu6
         cA0MvHQrlrJpu2rAbw5We0cRNiGT6OWwq+E4UdP0X+x8tJ33JVZQj3upf7PeS8f9W/2t
         FPdU2xvzZ/L6YVpMLVCBITsyrAOB7exwrsfv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lLu60EjnRBnW4wz32/fkJTOsgD5cNWvT5qBN+RYNBTg=;
        b=S7VRFXL/roNESIp9o9gAbgd0NWFQs8umwyqVfRZFNM6bP2TXNZzVzSw2oWaXSmNBQS
         6bx6kM7CKq+TjADsvw/+g2Do6zv6OcD8L1xCYWCjArQIZFQ2t/K0sX3s6HX+OHeHGpJM
         4dXKrH2Y0efH+NrGNeuWEiiL2usjrUIfFxZdvmFmd8e78xYvP/VN9YeQWqbws8h8ohCz
         RcTrnOc6Tr9HUt1PTY9N/cH0ip6boLyT8sKXcWONZ6YY4OXm/xSgbkEAhav927EVoRKX
         he0XfGosXAGKShxr16sDZMmr3BS/lEtA4Prz/Kl/8WpVSwojxHkqir9zuNAevh6A8qQW
         YooA==
X-Gm-Message-State: APjAAAUdT6Taj4jeAWv8kZOjnF0rxKbsiaffGKIRY7IQAqh3sgfBHeL9
        UWZj/k9+QzT3E4cOU8GYWzsFRg==
X-Google-Smtp-Source: APXvYqzyfbYoP0nigJLm601pen/N5iojsrxWH3PJfSr9afbuIRmYCd4P+TgvvrASJEz29Up2FoLOMw==
X-Received: by 2002:a17:902:9a41:: with SMTP id x1mr14550279plv.269.1570285172204;
        Sat, 05 Oct 2019 07:19:32 -0700 (PDT)
Received: from localhost.localdomain ([115.97.180.31])
        by smtp.gmail.com with ESMTPSA id y138sm8977604pfb.174.2019.10.05.07.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2019 07:19:31 -0700 (PDT)
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
        devicetree@vger.kernel.org, Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v10 2/6] dt-bindings: sun6i-dsi: Add A64 DPHY compatible (w/ A31 fallback)
Date:   Sat,  5 Oct 2019 19:49:09 +0530
Message-Id: <20191005141913.22020-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20191005141913.22020-1-jagan@amarulasolutions.com>
References: <20191005141913.22020-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MIPI DSI PHY controller on Allwinner A64 is similar
on the one on A31.

Add A64 compatible and append A31 compatible as fallback.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml         | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml b/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml
index fa46670de299..8841938050b2 100644
--- a/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml
+++ b/Documentation/devicetree/bindings/phy/allwinner,sun6i-a31-mipi-dphy.yaml
@@ -15,7 +15,11 @@ properties:
     const: 0
 
   compatible:
-    const: allwinner,sun6i-a31-mipi-dphy
+    oneOf:
+      - const: allwinner,sun6i-a31-mipi-dphy
+      - items:
+          - const: allwinner,sun50i-a64-mipi-dphy
+          - const: allwinner,sun6i-a31-mipi-dphy
 
   reg:
     maxItems: 1
-- 
2.18.0.321.gffc6fa0e3

