Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F1DC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E841B2073B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="gO/BVoVs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfLCNsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 08:48:41 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45241 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfLCNsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 08:48:40 -0500
Received: by mail-pf1-f194.google.com with SMTP id 2so1873455pfg.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 05:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EGC/dOGDlJSYQ3xkj7DfBdq9vhE8rvcGutHHf40Jkqk=;
        b=gO/BVoVsJL4xEzBmaVscN3RJXJZgCV8rufB0cy0WTl2Mw3tqf841WEU8F8OfPl6iXJ
         tcmndNcqLNDxqpIXIWRVf1l9idid8xPBdg1kMTEoPwT2OKa1USdddMWtKRZ/S50TZmvm
         H75IKVE9Ypt9ZeR5PsTS55IlswuTM04Io4fBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EGC/dOGDlJSYQ3xkj7DfBdq9vhE8rvcGutHHf40Jkqk=;
        b=YfMG8PQz2CVK0YPwLcKjeZ+N8FnGwBAqCi5NJkcOmgR5yJSUoRF2w8qsJuUdvGFFJJ
         2/NgviXjEnUbFz7OqkUttldDrfui1VzXoq4mjyULvkw1IYFouUgeNwYa825z6PjLCEyb
         pH1j8k0FpxjXCjCiCPH8LvmVP9zTVDgtYMAPmLdH1iz3oc4kT3ln0xF+0f64s714e0mf
         iNFsuwUvT9hFrZ3CyEp4sqCXf9t5NxAlEoDJVx7gp95pAduJzuUn1Fj7F1LcfUEtlIfZ
         FJ9vtE6T32/YmLcaov4dlzX5UHxXQEny7ON/a1UkCJOgyDz9KtoFGK1Me78/XWM/30AM
         9d6A==
X-Gm-Message-State: APjAAAW+qwzaz9tEf356C1dTk0THMMuVEWkOZPoL0PicExxlLd6z+Vid
        3Vczv8uZql+qHdYT/DI3/xYPaA==
X-Google-Smtp-Source: APXvYqwR2WHs/BvcSDVgvw8QRHGGBx7PujazP2vgdr3BhHFqIFkSC6fyLCUzShQFbKUEz7BbybKzqw==
X-Received: by 2002:a62:2686:: with SMTP id m128mr4905220pfm.143.1575380919848;
        Tue, 03 Dec 2019 05:48:39 -0800 (PST)
Received: from localhost.localdomain ([115.97.190.29])
        by smtp.gmail.com with ESMTPSA id y144sm4397892pfb.188.2019.12.03.05.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 05:48:39 -0800 (PST)
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
Subject: [PATCH v12 2/7] dt-bindings: sun6i-dsi: Add A64 DPHY compatible (w/ A31 fallback)
Date:   Tue,  3 Dec 2019 19:18:11 +0530
Message-Id: <20191203134816.5319-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20191203134816.5319-1-jagan@amarulasolutions.com>
References: <20191203134816.5319-1-jagan@amarulasolutions.com>
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
Changes for v12:
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

