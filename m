Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1448DC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F4D20859
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="BwmX6vUw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731889AbfETJHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 05:07:46 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32919 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbfETJHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 05:07:45 -0400
Received: by mail-pf1-f194.google.com with SMTP id z28so6929044pfk.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 02:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qhq8BOri8GqXtdsxg8qxzoiDzDhWP4zxzqC5ifM9GUM=;
        b=BwmX6vUwVXSoWUXZaDGxZnC4C2nA+2FLx9nM53JLcHkyAB5WcTW4XIBvaCMGkvN9l8
         h8ifkdY4+WuJmXFbgWagA5sRceen0HDsv0Ox5dmquIwP9fPC2bcFhBAVP4TCIRHCSf4Y
         7nZE/DDUbxoFttnsMo29hrKifDT5WRjCfoT3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qhq8BOri8GqXtdsxg8qxzoiDzDhWP4zxzqC5ifM9GUM=;
        b=oEhyn806T9NNA9ePFGSLn2OHGTgGyur42iumguSdhhFVrxDenXzkmAbPhsBxJnLPMD
         4Vo4EbMkj3WbSyAFc2w/Rj+KwzyLcYPskrBnTuoXR4n4QhCPrCIH0Chde1OyObvA3qRY
         LBEvWLKuSOEDHmN6cVD2oYkUkVRGBybErSZrXz183iyOmX+h22uNbpcyOd47lVDYfp0H
         N+DT0YCUNf0bTx+179wl9iln1+4vDzLTiFcJJMwqImw3VaoTxcXpdvkmliEPfQ8l9EQ2
         295exqmpwVjUgmPdvSZi01QV3mxCJm9QPcELHSl47LgLE0MuIUihYek/a6ehRW3ekn7O
         oCLw==
X-Gm-Message-State: APjAAAXYgHVeZSuCgYhJKeWt3zcsmQ0/bWazmrIUa9+qZDxmJtwc6MTI
        Aue6aP5X8N6nOt4lGrW7smzypA==
X-Google-Smtp-Source: APXvYqzQbGvwKqbUYTfkmz0DyTQcGldqq+MJrZmXW5rXq1utn0gBm9ge5J4w6ezaiZlHn0axjqJVLg==
X-Received: by 2002:a65:628b:: with SMTP id f11mr71262665pgv.95.1558343265015;
        Mon, 20 May 2019 02:07:45 -0700 (PDT)
Received: from localhost.localdomain ([183.82.227.193])
        by smtp.gmail.com with ESMTPSA id d15sm51671614pfm.186.2019.05.20.02.07.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 02:07:44 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     bshah@mykolab.com, Vasily Khoruzhick <anarsoul@gmail.com>,
        powerpan@qq.com, michael@amarulasolutions.com,
        linux-amarula@amarulasolutions.com, linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v10 06/11] drm/sun4i: dsi: Probe tcon0 during dsi_bind
Date:   Mon, 20 May 2019 14:33:13 +0530
Message-Id: <20190520090318.27570-7-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190520090318.27570-1-jagan@amarulasolutions.com>
References: <20190520090318.27570-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Probe tcon0 during dsi_bind, so-that the tcon attributes like
divider value, clock rates are available whenever it required.

Tested-by: Merlijn Wajer <merlijn@wizzup.org>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 6 ++++++
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 47d571d97600..1f9ed2642a47 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -1045,6 +1045,7 @@ static int sun6i_dsi_bind(struct device *dev, struct device *master,
 	struct drm_device *drm = data;
 	struct sun4i_drv *drv = drm->dev_private;
 	struct sun6i_dsi *dsi = dev_get_drvdata(dev);
+	struct sun4i_tcon *tcon0 = sun4i_get_tcon0(drm);
 	int ret;
 
 	if (!(dsi->panel || dsi->bridge)) {
@@ -1054,6 +1055,11 @@ static int sun6i_dsi_bind(struct device *dev, struct device *master,
 
 	dsi->drv = drv;
 
+	if (!tcon0)
+		return -EINVAL;
+
+	dsi->tcon = tcon0;
+
 	drm_encoder_helper_add(&dsi->encoder,
 			       &sun6i_dsi_enc_helper_funcs);
 	ret = drm_encoder_init(drm,
diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
index 9c140f55b822..f2826e3ea165 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
@@ -28,6 +28,7 @@ struct sun6i_dsi {
 
 	struct device		*dev;
 	struct sun4i_drv	*drv;
+	struct sun4i_tcon	*tcon;
 	struct mipi_dsi_device	*device;
 	struct drm_panel	*panel;
 	struct drm_bridge	*bridge;
-- 
2.18.0.321.gffc6fa0e3

