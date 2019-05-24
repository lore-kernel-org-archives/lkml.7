Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C733C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 10:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE28217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 10:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="U3C+2Pkv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390631AbfEXKlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 06:41:50 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46584 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390410AbfEXKlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 06:41:49 -0400
Received: by mail-pg1-f196.google.com with SMTP id o11so234646pgm.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 03:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y5swjDHGKG+ezs/+w53g29T0/qBVH9yKlg23nn55c5E=;
        b=U3C+2Pkv2aIG9zWer39/ZGLeS4wd7ty00L8nRwq2xSL9FzpzYmJ8/WtIyJFRadmuQc
         DTP0KxyKCLyYHEAPVI55+6VrkoniAOF48Vl9Wj50Veq/wZPJat9/g22LGvoecBk8SR7s
         r9+EN1shbjhX2kn0bCjSZ2tUp8JHkSf1kS7r8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y5swjDHGKG+ezs/+w53g29T0/qBVH9yKlg23nn55c5E=;
        b=HHhBLt8MSjSTsBje1XbxX8871o5M4FBYz+21UJgHWEAht+xmzzKgVSOturr3i5hvBt
         PIMR2Dyy7iOs6YHaQWx6yyG/Lr1qxL6ZgZbYn05vtwFqFJdkNoTwxKcLPE5bV83LL/MC
         VmonmzZPpa0wO94SId9W9ktEJ6regtUnVgf7sUbyDV39gawYeLbFqd1pd3YBIgTsGlTx
         Suog3mT6+O6I1qN5u0Tiyvjgj6oiYMnT/huGuarxRaTyjuxCWVYDLpB9Wp/z3dH5ZdgR
         n7bXMjFiMFr6WEmz52r9YzfzS5Ora6ft7aWOu28c+ORM6w9sTvLRRuRY041UjWgkU06i
         oW9w==
X-Gm-Message-State: APjAAAV9yhQcOUEI9o6ESQrJW8CMAdGvzhm1H+8sKfXVNBRZwKMbQd9/
        8AaGBTADWyahRoU/dUHhBoQYBw==
X-Google-Smtp-Source: APXvYqyvPrCWj4wLzn1Yd+9CbYrQKIVeghMZMryVtTFYZMAHt18ZSgOULimYpUVkB3YXKeqkBNPeBw==
X-Received: by 2002:a63:9d8d:: with SMTP id i135mr104296236pgd.245.1558694509078;
        Fri, 24 May 2019 03:41:49 -0700 (PDT)
Received: from localhost.localdomain ([183.82.227.60])
        by smtp.gmail.com with ESMTPSA id m72sm6550113pjb.7.2019.05.24.03.41.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 03:41:48 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH v2 1/6] drm/sun4i: dsi: Use drm panel_or_bridge call
Date:   Fri, 24 May 2019 16:11:10 +0530
Message-Id: <20190524104115.20161-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190524104115.20161-1-jagan@amarulasolutions.com>
References: <20190524104115.20161-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now the driver is finding the panel using of_drm_find_panel,
replace the same with drm_of_find_panel_or_bridge which would help
to find the panel or bridge on the same call if bridge support added
in future.

Added NULL in bridge argument, same will replace with bridge parameter
once bridge supported.

Cc: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 65771e9a343a..ae2fe31b05b1 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -21,6 +21,7 @@
 #include <drm/drmP.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_mipi_dsi.h>
+#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_probe_helper.h>
 
@@ -964,11 +965,13 @@ static int sun6i_dsi_attach(struct mipi_dsi_host *host,
 			    struct mipi_dsi_device *device)
 {
 	struct sun6i_dsi *dsi = host_to_sun6i_dsi(host);
+	int ret;
 
 	dsi->device = device;
-	dsi->panel = of_drm_find_panel(device->dev.of_node);
-	if (IS_ERR(dsi->panel))
-		return PTR_ERR(dsi->panel);
+	ret = drm_of_find_panel_or_bridge(host->dev->of_node, 0, 0,
+					  &dsi->panel, NULL);
+	if (ret)
+		return ret;
 
 	dev_info(host->dev, "Attached device %s\n", device->name);
 
-- 
2.18.0.321.gffc6fa0e3

