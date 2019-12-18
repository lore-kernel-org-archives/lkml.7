Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3642C2D0BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 19:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A18D24672
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 19:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ahpP2VUF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbfLRTKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 14:10:42 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42689 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbfLRTKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 14:10:41 -0500
Received: by mail-pl1-f193.google.com with SMTP id p9so1388082plk.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 11:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hp8TQeL3yIB1KqyuldLYK5Mau4+1RzHQTjjW58JR+LE=;
        b=ahpP2VUFj07C+YAeNRzrA76nsNFKGCa58LATV1abYF6W3evqhgS4VjoXIZF5Rxs/Zl
         KojhYjea5pEydc4TKZ3PzW8hmG8ZtdgiQqcbtzZreiFvxQIj/c5GnNzPA0rjzyel3sRZ
         rypwNDaFKZeKjEZwHrGEr6XO1coStIFAo1GzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hp8TQeL3yIB1KqyuldLYK5Mau4+1RzHQTjjW58JR+LE=;
        b=bD995NxwM/YNi+3y3P3e6JjmC/W69ymMyms08z2ux/589XyiUutG1t8r7LAzXKPHJN
         AQ9m8ugrRYptLHbDdxo4vbejKaumSEoUcguz4g+0FVdvnVZgNjM9imYY5caxDMZSP4sj
         YBQs6ix9P0spMNx6l9/yeLdfedERss0ee0O9JhT/lyc1eYEX2QhODLsqWUYf4L8T3u1z
         RWk6nYBBInF+496hkM1slkoAw1NI3LILGWTIN3gWIWLMaaY+yGTIlln/A5UBIXY4KT/g
         fLv+47Gzx98tfPSg1Sc3hkZNA9b5G6+np/qAwnw2x2cV7dapY58+yCqlAJdWcBPXFC2i
         r6Yg==
X-Gm-Message-State: APjAAAXS3vC7zZ4ef5s53yfU5EWsxp1JUs9fZYLBNgXYPUPM+JvcAJa1
        cIylxttRRM5BYBztVg6b+gAhaw==
X-Google-Smtp-Source: APXvYqzbv5fA1hAkQ1/0DqEdeyLCZYo/j3p0FDLo1mRnWUjMlN5AwYLYhnlRpg3B5Bk1ug5tM+pzvQ==
X-Received: by 2002:a17:90a:fb4f:: with SMTP id iq15mr4735561pjb.86.1576696240895;
        Wed, 18 Dec 2019 11:10:40 -0800 (PST)
Received: from localhost.localdomain ([2405:201:c809:c7d5:78ea:e014:edb4:e862])
        by smtp.gmail.com with ESMTPSA id q7sm3745855pjd.3.2019.12.18.11.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 11:10:40 -0800 (PST)
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
Subject: [PATCH v13 3/7] drm/sun4i: dsi: Get the mod clock for A31
Date:   Thu, 19 Dec 2019 00:40:13 +0530
Message-Id: <20191218191017.2895-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20191218191017.2895-1-jagan@amarulasolutions.com>
References: <20191218191017.2895-1-jagan@amarulasolutions.com>
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
Changes for v13:
- Drop has_mod_clk quirk as commented by Chen-Yu

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

