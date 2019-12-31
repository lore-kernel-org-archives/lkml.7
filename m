Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29D1C2D0C2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 13:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92AC5205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 13:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="C1XNMIIr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfLaNFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 08:05:54 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33534 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbfLaNFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 08:05:53 -0500
Received: by mail-pg1-f195.google.com with SMTP id 6so19528723pgk.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Dec 2019 05:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EOyi5tzl/4nxk9xqAyclAM+URcfve5OZPh7MV8YnBrQ=;
        b=C1XNMIIrb2O3OzCmOxnI3KLkToL36K1e3oVnIkwDhOb7qAi+rVBZHeA8Ow4beqvyc3
         OmRIH1tZbE4YUFbem4RfF1tsmO1bJxhPU7MzEGXb5kR6yPVL68dQrzwJzF/N+TayzcL9
         gRZfFtDZn4otpmgJFfnrf8tUKpSIthlspA4+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EOyi5tzl/4nxk9xqAyclAM+URcfve5OZPh7MV8YnBrQ=;
        b=kOJ0t86QJ8DJG3tyiADCG8wieTBDh0XZpBgjvk5wIQPN6yKcY4jHA6452r6hCr3hii
         aTgAnbccZZdf58q2O/P7QVwx7kmqstyB5l/yZ1hE2FH3xr30lXBt35hlOdWC3RJ/rmU7
         bsCfOIgXiMYKJdygzY4650EThorg5McrlnNEPh850ZWz4/5tEiOjRirnFdp4JWxiq7C9
         YyjOMSQirvU+dmQ+lBiZx82wkmGpERZDkZWFKVBOqtpdWF6UXEkXOyoYNRj5gqNOd9cL
         /2lsC+SKhAt3JxQ9BHWxqPEGjKNsoT6JRhmtp6LPphBxl4FWFgk/jGyyJoCvNB2LdF5Y
         cf8w==
X-Gm-Message-State: APjAAAWoIUTaMAnQhuFhHJ5flUdNk80XfceEsHhtPFtsf9/AGRxbrBy1
        Q7+4RvicwMZlM3hvyXKSUAvFmA==
X-Google-Smtp-Source: APXvYqyYk9aV+EnROERG9fjC1KYiBt7tIzfsFrbzcVxWJhg/zyJNc52rgXItMppvEfsBzE5giSw/mg==
X-Received: by 2002:a62:ddd0:: with SMTP id w199mr75715315pff.1.1577797552360;
        Tue, 31 Dec 2019 05:05:52 -0800 (PST)
Received: from localhost.localdomain ([49.206.202.115])
        by smtp.gmail.com with ESMTPSA id i3sm55204089pfg.94.2019.12.31.05.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2019 05:05:51 -0800 (PST)
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
Subject: [PATCH v3 2/9] drm/sun4i: tcon: Add TCON LCD support for R40
Date:   Tue, 31 Dec 2019 18:35:21 +0530
Message-Id: <20191231130528.20669-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20191231130528.20669-1-jagan@amarulasolutions.com>
References: <20191231130528.20669-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TCON LCD0, LCD1 in allwinner R40, are used for managing
LCD interfaces like RGB, LVDS and DSI.

Like TCON TV0, TV1 these LCD0, LCD1 are also managed via
tcon top.

Add support for it, in tcon driver.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- none

 drivers/gpu/drm/sun4i/sun4i_tcon.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index fad72799b8df..69611d38c844 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -1470,6 +1470,13 @@ static const struct sun4i_tcon_quirks sun8i_a83t_tv_quirks = {
 	.has_channel_1		= true,
 };
 
+static const struct sun4i_tcon_quirks sun8i_r40_lcd_quirks = {
+	.supports_lvds		= true,
+	.has_channel_0		= true,
+	/* TODO Need to support TCON output muxing via GPIO pins */
+	.set_mux		= sun8i_r40_tcon_tv_set_mux,
+};
+
 static const struct sun4i_tcon_quirks sun8i_r40_tv_quirks = {
 	.has_channel_1		= true,
 	.set_mux		= sun8i_r40_tcon_tv_set_mux,
@@ -1500,6 +1507,7 @@ const struct of_device_id sun4i_tcon_of_table[] = {
 	{ .compatible = "allwinner,sun8i-a33-tcon", .data = &sun8i_a33_quirks },
 	{ .compatible = "allwinner,sun8i-a83t-tcon-lcd", .data = &sun8i_a83t_lcd_quirks },
 	{ .compatible = "allwinner,sun8i-a83t-tcon-tv", .data = &sun8i_a83t_tv_quirks },
+	{ .compatible = "allwinner,sun8i-r40-tcon-lcd", .data = &sun8i_r40_lcd_quirks },
 	{ .compatible = "allwinner,sun8i-r40-tcon-tv", .data = &sun8i_r40_tv_quirks },
 	{ .compatible = "allwinner,sun8i-v3s-tcon", .data = &sun8i_v3s_quirks },
 	{ .compatible = "allwinner,sun9i-a80-tcon-lcd", .data = &sun9i_a80_tcon_lcd_quirks },
-- 
2.18.0.321.gffc6fa0e3

