Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18149C2D0BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 19:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E29CD21D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 19:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="E+8ziUEv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbfLRTKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 14:10:38 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:51749 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbfLRTKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 14:10:37 -0500
Received: by mail-pj1-f65.google.com with SMTP id j11so1316184pjs.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 11:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=alXkMdM6X6QySpSco6rsE8zxLS76UNqtiB5B4hqdPT4=;
        b=E+8ziUEvMKi8sDEkiES60TVF+tNlUhhj8IHNiBcbbn371WCVzx44hbb9oQmdmCkXGQ
         hj8eBroZ2ihb46/3RVsdTD5NKgRbjqaf4ACgSi6PUIWdb5+180sHUakXUkH++To96gOn
         RIxHPJZtxlLOZtQ2kV8jtPPw49V5Lv4Rc3wWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=alXkMdM6X6QySpSco6rsE8zxLS76UNqtiB5B4hqdPT4=;
        b=T/jkZfc2neGC5ErYQaM/nD/pJ0us7S3DXJ65p5Red9+X4bvXqWKS437UX1qp1cdCUo
         L41frmoDaiJNOwllJzZSIil0DnWnnUVd9qkcnLB4GVIbUlNrj4a4TpL8SML2l0jdEgAy
         IXkRa99ShP4DzvpcZSn2oETlVD8kIIJbCl8uxHRbSBHBiRdJdckHDkxIybACt8YGe0lE
         UzbJhVb6wG03WnxZ5ffjehC+hFXvRQR0W1U61htweb87ZVTQxnmTPOLH6G8ltxN2U0nC
         v3k9mFIjbu51UFR1GvoPFQBgAlLZJaV/L4TPvMO+3CYDzQf3SunASCAjyNat58ZK97lk
         98hQ==
X-Gm-Message-State: APjAAAXBwpW9kcT0Ytp9LeTkoCP3f/2oPcKoIu2fqm2JwvkCRSDdlh8r
        ZNriqiwxcw+l60OQ4EV5azat/g==
X-Google-Smtp-Source: APXvYqwbe2b9Mvei8KPI9wO4JZV6Hz10WouMUmvDBFv2bWY2DwHIIMZxDNbDLq6tRccxycc9qNSXEw==
X-Received: by 2002:a17:90a:d344:: with SMTP id i4mr4801276pjx.42.1576696236642;
        Wed, 18 Dec 2019 11:10:36 -0800 (PST)
Received: from localhost.localdomain ([2405:201:c809:c7d5:78ea:e014:edb4:e862])
        by smtp.gmail.com with ESMTPSA id q7sm3745855pjd.3.2019.12.18.11.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 11:10:36 -0800 (PST)
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
Subject: [PATCH v13 2/7] dt-bindings: sun6i-dsi: Add A64 DPHY compatible (w/ A31 fallback)
Date:   Thu, 19 Dec 2019 00:40:12 +0530
Message-Id: <20191218191017.2895-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20191218191017.2895-1-jagan@amarulasolutions.com>
References: <20191218191017.2895-1-jagan@amarulasolutions.com>
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
Changes for v13:
- collect Rob review tag

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

