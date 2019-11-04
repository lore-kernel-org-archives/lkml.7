Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA3CCA9EBB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 01:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F70222CF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 01:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbfKDBkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 20:40:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:55790 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728443AbfKDBk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 20:40:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 12DE7B22B;
        Mon,  4 Nov 2019 01:40:27 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Maxime Ripard <mripard@kernel.org>,
        Guillaume Gardet <guillaume.gardet@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: [PATCH 1/7] dt-bindings: gpu: mali-midgard: Tidy up conversion to YAML
Date:   Mon,  4 Nov 2019 02:39:26 +0100
Message-Id: <20191104013932.22505-2-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191104013932.22505-1-afaerber@suse.de>
References: <20191104013932.22505-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of grouping alphabetically by third-party vendor, leading to
one-element enums, sort by Mali model number, as done for Utgard.

This already allows us to de-duplicate two "arm,mali-t760" sections and
will make it easier to add new vendor compatibles.

Fixes: 553cedf60056 ("dt-bindings: Convert Arm Mali Midgard GPU to DT schema")
Fixes: 1be5b54d26ae ("dt-bindings: gpu: mali-midgard: Add samsung exynos5250 compatible")
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 .../devicetree/bindings/gpu/arm,mali-midgard.yaml  | 32 ++++++++++------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
index 8e00a21b36f5..ffdb24c4ab6a 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
@@ -16,36 +16,32 @@ properties:
     oneOf:
       - items:
           - enum:
-             - allwinner,sun50i-h6-mali
-          - const: arm,mali-t720
-      - items:
-          - enum:
-             - amlogic,meson-gxm-mali
-          - const: arm,mali-t820
+             - samsung,exynos5250-mali
+          - const: arm,mali-t604
       - items:
           - enum:
              - arm,juno-mali
           - const: arm,mali-t624
+      # "arm,mali-t628"
       - items:
           - enum:
-             - rockchip,rk3288-mali
-          - const: arm,mali-t760
+             - allwinner,sun50i-h6-mali
+          - const: arm,mali-t720
       - items:
           - enum:
-             - rockchip,rk3399-mali
-          - const: arm,mali-t860
+             - rockchip,rk3288-mali
+             - samsung,exynos5433-mali
+          - const: arm,mali-t760
       - items:
           - enum:
-             - samsung,exynos5250-mali
-          - const: arm,mali-t604
+             - amlogic,meson-gxm-mali
+          - const: arm,mali-t820
+      # "arm,mali-t830"
       - items:
           - enum:
-             - samsung,exynos5433-mali
-          - const: arm,mali-t760
-
-          # "arm,mali-t628"
-          # "arm,mali-t830"
-          # "arm,mali-t880"
+             - rockchip,rk3399-mali
+          - const: arm,mali-t860
+      # "arm,mali-t880"
 
   reg:
     maxItems: 1
-- 
2.16.4

