Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811F2C2D0DE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 13:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56A53205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 13:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="UH2yrbjY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfLaNGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 08:06:04 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39650 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbfLaNGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 08:06:03 -0500
Received: by mail-pj1-f66.google.com with SMTP id t101so1207204pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Dec 2019 05:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BeM5/vE72SAcfQsVVuZ380ILSoWPQPjSG9XVgKrQqeI=;
        b=UH2yrbjYmgnQDGO/LNq2e0XhLJ1Ka6A1yR30mvYQH3aXQKLXFPBUb5SIjhCESRnJ4N
         +jlgWk0XPtyzUxlN+K9gw760vP/KchdsXJFwvvKE+J4XyW6+ZBplorJO+lQDgTeuW2Xo
         GVR+9y/PLF6sKT6oBzAf2P7OzaIPDoz5Vv91g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BeM5/vE72SAcfQsVVuZ380ILSoWPQPjSG9XVgKrQqeI=;
        b=F5AR7aZ/6KvS/PxmWBbHfdME/AI51VDmRlbL12qNh3YA87QqkQC6/KuXqpcTh0aywy
         G1LYJNhBUPoBPdk9CZbzrU2AFlX0Ox/xGWQsBT/ZrB0FMfAiqKdqdOoNI6o6Jwe0o+6c
         dMdduPG0mtOHuo5AMRwWQFBxAVFpKhjag3ZJcuo0v94zKwdcEth1/DYrCDkHEM4dt9Ll
         4oqXTu1+HRytMW4lbZZ0me5bVb0hWxdITIesC5QFia840pUMyd2MYiss4Tyw9MfoQ8zk
         9N/pozvfrSgt/q2Y4qp8CiXKWF4A496pmiOYH8VVg6VCyWxyb8cvBgwl35YjSceZDfGN
         2tAg==
X-Gm-Message-State: APjAAAW/sGkEzqZzJ4TOJFUBWCEC6vgQ8PrQlFjlQE2a0Qbv5xztwECq
        7uJyr5p/rKc9cLNbZPdRW/idhA==
X-Google-Smtp-Source: APXvYqy5IX5WCJoCb/LEDCamEWRBDTmMw7gKLEU1Ln9QZTBxaTcQiP9kWA9CGOMXxEfx4WlBPy051g==
X-Received: by 2002:a17:902:b104:: with SMTP id q4mr64632455plr.132.1577797562596;
        Tue, 31 Dec 2019 05:06:02 -0800 (PST)
Received: from localhost.localdomain ([49.206.202.115])
        by smtp.gmail.com with ESMTPSA id i3sm55204089pfg.94.2019.12.31.05.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2019 05:06:02 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 4/9] drm/sun4i: tcon_top: Use clock name index macros
Date:   Tue, 31 Dec 2019 18:35:23 +0530
Message-Id: <20191231130528.20669-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20191231130528.20669-1-jagan@amarulasolutions.com>
References: <20191231130528.20669-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TCON TOP mux blocks in R40 are registering clock using
tcon top clock index numbers.

Right now the code is using, real numbers start with 0, but
we have proper macros that defined these name index numbers.

Use the existing macros, instead of real numbers for more
code readability.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- none

 drivers/gpu/drm/sun4i/sun8i_tcon_top.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
index 75d8e60c149d..e0b3c5330b9a 100644
--- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
+++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
@@ -194,19 +194,22 @@ static int sun8i_tcon_top_bind(struct device *dev, struct device *master,
 	clk_data->hws[CLK_TCON_TOP_TV0] =
 		sun8i_tcon_top_register_gate(dev, "tcon-tv0", regs,
 					     &tcon_top->reg_lock,
-					     TCON_TOP_TCON_TV0_GATE, 0);
+					     TCON_TOP_TCON_TV0_GATE,
+					     CLK_TCON_TOP_TV0);
 
 	if (quirks->has_tcon_tv1)
 		clk_data->hws[CLK_TCON_TOP_TV1] =
 			sun8i_tcon_top_register_gate(dev, "tcon-tv1", regs,
 						     &tcon_top->reg_lock,
-						     TCON_TOP_TCON_TV1_GATE, 1);
+						     TCON_TOP_TCON_TV1_GATE,
+						     CLK_TCON_TOP_TV1);
 
 	if (quirks->has_dsi)
 		clk_data->hws[CLK_TCON_TOP_DSI] =
 			sun8i_tcon_top_register_gate(dev, "dsi", regs,
 						     &tcon_top->reg_lock,
-						     TCON_TOP_TCON_DSI_GATE, 2);
+						     TCON_TOP_TCON_DSI_GATE,
+						     CLK_TCON_TOP_DSI);
 
 	for (i = 0; i < CLK_NUM; i++)
 		if (IS_ERR(clk_data->hws[i])) {
-- 
2.18.0.321.gffc6fa0e3

