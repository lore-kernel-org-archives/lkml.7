Return-Path: <SRS0=7h0X=2M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758F9C2D0D3
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 13:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DC972070A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 13:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="lB4V4tgg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfLVN3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 08:29:37 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36858 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfLVN3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 08:29:36 -0500
Received: by mail-pj1-f66.google.com with SMTP id n59so6275909pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Dec 2019 05:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KhD44eBjciixBbXS0jbewwrbs2b2OiqLmvbXkaKHo00=;
        b=lB4V4tgg9XJchkZsFP26liTLrD5wSsSFIAEJ32qjq+iAwPpa8KAOLT+EVxcmw1pwYK
         WMckdTBx4XBA2jV1zAMUZl7P6mpT+gvrq67YYby5w8wExWSzt8Nz7CRKG/z/R4vuRF6+
         shHJH9AM/F2G+LyXB5Hw4yotlUHH1pZsM8UDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KhD44eBjciixBbXS0jbewwrbs2b2OiqLmvbXkaKHo00=;
        b=mW6os7hWW+Gd28Nm8EqIn4BTAptvdJUckLmOJ8ZRXuBqMkyR4wX24WlNoJBj/J+I4v
         ct5LIdfVlEHCdtAjzxWBgfCqc99wlmdq9apXsyR+SOvJzsjokdwlNHEh04/6Xv9ZYSjt
         1WzkLJ1ARQWBSlBSSJWTfzvi5rYBwB5LrmdV8bFdz74okLaE3Ln+m6J5bahRu7MOv9Lv
         F3N/YUpXTLD/BLKuU4rUeqo8awQWH5g8u/haP5i8jcMAXaX8772zEPWnhfyqSWFgLmqs
         dv0tLZKMM5IbxrvtJzyrM/dQedcmnOmas0h/6kMvILmIvubZHnv49JJTHQvTL4bEX1+N
         6WAA==
X-Gm-Message-State: APjAAAUDHlBScVh1MlXAg8pzCNaur2Nh86k+PmaW+DcjgaKfLg9S4DwS
        yJpeLB7j0SSvuy3U9xOE4YYmPQ==
X-Google-Smtp-Source: APXvYqzVvyqaDb1iAdI2rOGho/ufZoqSGILukc81YMHL6NVkze8m/8RkPnz08yfklmZh9CKXZYH2lw==
X-Received: by 2002:a17:902:74cb:: with SMTP id f11mr24895957plt.139.1577021375724;
        Sun, 22 Dec 2019 05:29:35 -0800 (PST)
Received: from localhost.localdomain ([49.206.202.16])
        by smtp.gmail.com with ESMTPSA id o2sm12073058pjo.26.2019.12.22.05.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2019 05:29:35 -0800 (PST)
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
Subject: [PATCH v14 2/7] dt-bindings: sun6i-dsi: Add A64 DPHY compatible (w/ A31 fallback)
Date:   Sun, 22 Dec 2019 18:52:24 +0530
Message-Id: <20191222132229.30276-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20191222132229.30276-1-jagan@amarulasolutions.com>
References: <20191222132229.30276-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MIPI DSI PHY controller on Allwinner A64 is similar
on the one on A31.

Add A64 compatible and append A31 compatible as fallback.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v14:
- none

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

