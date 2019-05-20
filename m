Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCA4C04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4E332085A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 09:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="izXs0xnF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731899AbfETJHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 05:07:51 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41384 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbfETJHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 05:07:50 -0400
Received: by mail-pg1-f194.google.com with SMTP id z3so6483132pgp.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 02:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l8/eiiMRzRHMeJJfg+NtIFfqaA+aEUt7A5oo1QrAYME=;
        b=izXs0xnF9WrDgcEPHUWlWp9gc4k0omlI5ON8oHnDXGfiCLU6GPTMi1TD53H72OhRJ9
         07OMMo1ZEK+83bw3/ptHwy7G9/QEAx4InSSgtV6dQkAuKRvQpPcDFEGDovibhbsGZ46q
         q87tXjbcR5kzwiL8RKIASnKXgb7PvMxBB0tQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l8/eiiMRzRHMeJJfg+NtIFfqaA+aEUt7A5oo1QrAYME=;
        b=UJEQZjk7x0SXHQC5HPdvKRGSubSkROQVI13vjxQM5Rau3o2zPA9gWEIsMv5gNdWdke
         v2L1GtGTenq7zxJ/Le27CI36NREdrPVnkg4tmBjdlTXj3qDAuvFziQ+4YYZyR4cothL2
         ukX18xNQeuo3FBCirpBhXhJgds6EoUHvGwZ/H6ZsTpygH0cBIStu+KEIbDcQIVVkrZbT
         HlMYcmINSyz0E5G5pZMJnW6ArcYDPCR4NQllP+KQr7+ZIPRtgSw7Ub6h2wJjuUJaqN6I
         GQ8ysDDfo4d7zNKQI6MYF4P4S3gV36aw2pZgfTowgbbMGCJEdIfnZua1B/B+XOET/p2L
         2Imw==
X-Gm-Message-State: APjAAAVgsI2h4uqh8hFQy1mnJdi0RpJO0wuFHiPPifKGUmQaCQLjp7OQ
        BwIW4yRufJEZH5frrVq6jqeEzg==
X-Google-Smtp-Source: APXvYqwLHvSwqQ0wDLSPdTFaZir99tjNhatCm3penvvdzh6SsenDaTxMVKo4xU4l8s1GExXu5p1q5Q==
X-Received: by 2002:a62:51c2:: with SMTP id f185mr18546991pfb.16.1558343269570;
        Mon, 20 May 2019 02:07:49 -0700 (PDT)
Received: from localhost.localdomain ([183.82.227.193])
        by smtp.gmail.com with ESMTPSA id d15sm51671614pfm.186.2019.05.20.02.07.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 02:07:49 -0700 (PDT)
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
Subject: [PATCH v10 07/11] drm/sun4i: dsi: Get tcon0_div at runtime
Date:   Mon, 20 May 2019 14:33:14 +0530
Message-Id: <20190520090318.27570-8-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190520090318.27570-1-jagan@amarulasolutions.com>
References: <20190520090318.27570-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tcon0 divider is used while computing drq edge0 for burst mode
devices, currently driver is using default macro value 4 via
SUN6I_DSI_TCON_DIV.

Unfortunately not all the panel devices are working with this
default divider value 4, so to make future changes on this divider
value get the divider from tcon dot clock at runtime instead of
static macro value.

Tested-by: Merlijn Wajer <merlijn@wizzup.org>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 8 +++++++-
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h | 2 --
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 1f9ed2642a47..5584e9c2f8bd 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -396,9 +396,15 @@ static u16 sun6i_dsi_get_drq_edge0(struct sun6i_dsi *dsi,
 				   struct drm_display_mode *mode,
 				   u16 line_num, u16 edge1)
 {
+	struct sun4i_tcon *tcon = dsi->tcon;
+	unsigned long dclk_rate, dclk_parent_rate, tcon0_div;
 	u16 edge0 = edge1;
 
-	edge0 += (mode->hdisplay + 40) * SUN6I_DSI_TCON_DIV / 8;
+	dclk_rate = clk_get_rate(tcon->dclk);
+	dclk_parent_rate = clk_get_rate(clk_get_parent(tcon->dclk));
+	tcon0_div = dclk_parent_rate / dclk_rate;
+
+	edge0 += (mode->hdisplay + 40) * tcon0_div / 8;
 
 	if (edge0 > line_num)
 		return edge0 - line_num;
diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
index f2826e3ea165..156523859d82 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.h
@@ -13,8 +13,6 @@
 #include <drm/drm_encoder.h>
 #include <drm/drm_mipi_dsi.h>
 
-#define SUN6I_DSI_TCON_DIV	4
-
 struct sun6i_dsi {
 	struct drm_connector	connector;
 	struct drm_encoder	encoder;
-- 
2.18.0.321.gffc6fa0e3

