Return-Path: <SRS0=7h0X=2M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79980C2D0C0
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 13:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1A92063A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 13:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="dNOsofgd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfLVN3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 08:29:43 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33488 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfLVN3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 08:29:41 -0500
Received: by mail-pl1-f196.google.com with SMTP id c13so6125639pls.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Dec 2019 05:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NRAz4ZoqKI0Nd9TLnyy5Bof8VE4wzHjzOviJFUDWFYU=;
        b=dNOsofgdHJWSE8kXto64TSNFpxvXSvTZtOGMWYtrAbWMsEWHOWfyZJKTWKxhM/tWbM
         AzxWaWz0PjEHFhYXmk9MIjDaDM8CUit4sGy/NLqKXDZxAxfI5cQfx55rk7JCf61gEnsQ
         6XQLOI6jPwnXWXY7UFUUb9Fhteq4HIuQHSf8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NRAz4ZoqKI0Nd9TLnyy5Bof8VE4wzHjzOviJFUDWFYU=;
        b=t9w4KwRR8H4bAp8IpGk3ARVRyg+lEgXnIbvD0FsBBtMM1qFv4hdfPlae6OvimK9TRK
         rT55aaMmrG+VZNyEpIguv17dXtJN9k1IXy64L9ZNskwGfzPgopSRRQHTtJ04jCP3DZ/o
         dyRA/nWaEwDLgXmEa1VUkOAGlphMQlf4Ke6q1yWIu7yqThxm94ckeEsJfGX8W6ieTNCm
         qPR+FeCZ3S9n6yuOOzpP8YrsnzKPBDIH4uEDPy6O18f7lZDKd3LS0EumycjRuFYMnloZ
         NkXXtkLoysx3c2Pw/rQYcpsuL/wHLj5w/Xs4F6+SF6OGNHq+zJlBHJ2CuL5DWG8TBJ9e
         p4WA==
X-Gm-Message-State: APjAAAUf2fx0ifG7HL4ZUM5+SlOuuQLaSdeeJtipwvMha7v8M0bvk29R
        rpLhRYnAuAaGcSlBVsA0bOXyrw==
X-Google-Smtp-Source: APXvYqzi7D0b+20qvpHdXr2HAOx7HQsXtaHE5dZtjtMXAPfngax/iDdiCqnpwtaqArWonhyBKuzS1A==
X-Received: by 2002:a17:90a:a4c4:: with SMTP id l4mr27148361pjw.48.1577021380573;
        Sun, 22 Dec 2019 05:29:40 -0800 (PST)
Received: from localhost.localdomain ([49.206.202.16])
        by smtp.gmail.com with ESMTPSA id o2sm12073058pjo.26.2019.12.22.05.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2019 05:29:40 -0800 (PST)
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
Subject: [PATCH v14 3/7] drm/sun4i: dsi: Get the mod clock for A31
Date:   Sun, 22 Dec 2019 18:52:25 +0530
Message-Id: <20191222132229.30276-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20191222132229.30276-1-jagan@amarulasolutions.com>
References: <20191222132229.30276-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the user manual, look like mod clock is not mandatory
for all Allwinner MIPI DSI controllers, it is connected to
CLK_DSI_SCLK for A31 and not available in A64.

So, add compatible check for A31 and get mod clock accordingly.

Tested-by: Merlijn Wajer <merlijn@wizzup.org>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v14:
- none

 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index c958ca9bae63..68b88a3dc4c5 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -1120,10 +1120,13 @@ static int sun6i_dsi_probe(struct platform_device *pdev)
 		return PTR_ERR(dsi->reset);
 	}
 
-	dsi->mod_clk = devm_clk_get(dev, "mod");
-	if (IS_ERR(dsi->mod_clk)) {
-		dev_err(dev, "Couldn't get the DSI mod clock\n");
-		return PTR_ERR(dsi->mod_clk);
+	if (of_device_is_compatible(dev->of_node,
+				    "allwinner,sun6i-a31-mipi-dsi")) {
+		dsi->mod_clk = devm_clk_get(dev, "mod");
+		if (IS_ERR(dsi->mod_clk)) {
+			dev_err(dev, "Couldn't get the DSI mod clock\n");
+			return PTR_ERR(dsi->mod_clk);
+		}
 	}
 
 	/*
-- 
2.18.0.321.gffc6fa0e3

