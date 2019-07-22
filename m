Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B0FC76195
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7FC72190D
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BMAJB7zC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732015AbfGVSZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 14:25:12 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33126 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731937AbfGVSZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:25:07 -0400
Received: by mail-pf1-f195.google.com with SMTP id g2so17781107pfq.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 11:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qfwsnuJ0Fo+yki7MwdfIhdjj83zSVUakcOxDUEqYWuw=;
        b=BMAJB7zCPWaxxlsIZhliKtF/Of3RCfBU19X2PdSfplILj6yScV53dJKd9GpZMW00sX
         21AvgBuU29a+7Tczy51BqeRf390trbirmAtQOeTwHaDaAgO71WXOqgW9qVG4I/0QwhsF
         fHbjC8EReFF044ivDo+ipVHhRsr2EV6EnYpNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qfwsnuJ0Fo+yki7MwdfIhdjj83zSVUakcOxDUEqYWuw=;
        b=TTVS4pNr+6CfuuidS376vGvOU5yAd50IV96/nGQtO3NDr/Rqab8HLDQ7VKhB94786p
         VEy1CW/sl38WRsE7ROFeilEvUFPOzgep4ORaWAr4Pctzlv1a4nGcW+SCGDFfz6BGs8Nr
         mrzgLgvVhRnE2Pyb5o9n1Yb48BwW1M6SM8bymo/zdBOskbMoeRhf3H89Hwjt1PW/GE/W
         gLva3/wb4yGGJ0o1s9uQyPZkwS53aNA4m+MuZXHfAQCQ+zKy5/1xTTFta4in6gSHj9EJ
         dFfpF6OuOYRWDvfvM9pUWnvV21cMrMx1CGnQ2CZqV4jf8X5FYKhhNW+HJvA/F6cnzehO
         HR0Q==
X-Gm-Message-State: APjAAAWJwMZe46zhy8U6P46h9E76VlFYYI6xq5TVQ5/mxafGNYVyw9Tv
        EXNBXV70F7Xm8s1/9oqUz2FvpQ==
X-Google-Smtp-Source: APXvYqyEp+PIjudMUc2kzpn+Zl2EC+eIJeevs//E8DRu5CFrWzPYRAgF8677H9fM7Q0RWCkvTACSQA==
X-Received: by 2002:a17:90a:23ce:: with SMTP id g72mr47354809pje.77.1563819906950;
        Mon, 22 Jul 2019 11:25:06 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id a3sm36117683pfl.145.2019.07.22.11.25.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 11:25:06 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     David Airlie <airlied@linux.ie>, linux-fbdev@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        dri-devel@lists.freedesktop.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Vetter <daniel@ffwll.ch>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] drm: panel-lvds: Spout an error if of_get_display_timing() gives an error
Date:   Mon, 22 Jul 2019 11:24:38 -0700
Message-Id: <20190722182439.44844-4-dianders@chromium.org>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
In-Reply-To: <20190722182439.44844-1-dianders@chromium.org>
References: <20190722182439.44844-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the patch ("video: of: display_timing: Don't yell if no timing node
is present") we'll stop spouting an error directly in
of_get_display_timing() if no node is present.  Presumably panel-lvds
should take charge of spouting its own error now.

NOTE: we'll print two errors if the node was present but there were
problems parsing the timing node (one in of_parse_display_timing() and
this new one).  Since this is a fatal error for the driver's probe
(and presumably someone will be debugging), this should be OK.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/gpu/drm/panel/panel-lvds.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-lvds.c b/drivers/gpu/drm/panel/panel-lvds.c
index 1ec57d0806a8..ad47cc95459e 100644
--- a/drivers/gpu/drm/panel/panel-lvds.c
+++ b/drivers/gpu/drm/panel/panel-lvds.c
@@ -147,8 +147,11 @@ static int panel_lvds_parse_dt(struct panel_lvds *lvds)
 	int ret;
 
 	ret = of_get_display_timing(np, "panel-timing", &timing);
-	if (ret < 0)
+	if (ret < 0) {
+		dev_err(lvds->dev, "%pOF: problems parsing panel-timing (%d)\n",
+			np, ret);
 		return ret;
+	}
 
 	videomode_from_timing(&timing, &lvds->video_mode);
 
-- 
2.22.0.657.g960e92d24f-goog

