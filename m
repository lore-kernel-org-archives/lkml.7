Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2861AC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0667B21721
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="aiVm+Ij7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbfFMSx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 14:53:59 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41520 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729643AbfFMSx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 14:53:57 -0400
Received: by mail-pg1-f193.google.com with SMTP id 83so25853pgg.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 11:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z0BqE/PvwTCOuDfT7ziZnBtJoPRweQQwkvxwrMq6Xa0=;
        b=aiVm+Ij7KcL3D/0YWJ8nXlH+dgfcDlsdPwTvVK7cZVI0JKLrd/YYhm2+Cq76YkYLL5
         +phoUjSXOTIFC6r/5BNh/LSGecRqCp5OmsC+IYPu1fqgZLYit3+9HgiLNkwfgHCj0V7q
         RmkSuKtICHPNKPfeEpAIaKJAo9jVsCTYxn+ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z0BqE/PvwTCOuDfT7ziZnBtJoPRweQQwkvxwrMq6Xa0=;
        b=svbbZMuT/FTexLKpnyS16z3RYe+E5uOVStTo/83R8YG8JdJ2185tDTaRHJPDYr64qn
         VA5rI1/f26UkzoPuHbf16xyduBaq8RGM7IiG6fCGlxHUSv+8XRfLHtVPPS3OynSxEz9T
         hYQIpSSpPCt7ovE2wyeBoBtK580eWQfK3Ru8+v/ai11yU3Q1DrZe/0QOUktlQtHGs3e4
         bLK8VgilIcrm//pO3NCx7EY13bpEDX7x87a61+EEQvXJ+A3ZVqpvWXhpOQuQXUkS/Dq5
         ngFHGh1sHFhLVsFNDpM+MPK/DScCJyZykKxqzJVEz+AtN03pZJpGEwMMQX8HQy7VHnVj
         Rn3w==
X-Gm-Message-State: APjAAAWBW4CsWFSS3qQX4BgdfsWtJjIGkgUorfDuZncYht/LYY8q4EjZ
        /+7ZjeKCa9tcBmo+kA6mTHmASA==
X-Google-Smtp-Source: APXvYqwjcj/D4tJfxviPJ3DAP+ga6noWng4Pb876f1LgU512Tm5hDPwAQYW1f6WUhPSgbRzbYQRvtw==
X-Received: by 2002:a17:90a:a10f:: with SMTP id s15mr7164601pjp.30.1560452036899;
        Thu, 13 Jun 2019 11:53:56 -0700 (PDT)
Received: from localhost.localdomain ([115.97.180.18])
        by smtp.gmail.com with ESMTPSA id p43sm946314pjp.4.2019.06.13.11.53.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 11:53:56 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi@googlegroups.com, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 2/9] drm/sun4i: tcon: Add TCON LCD support for R40
Date:   Fri, 14 Jun 2019 00:22:34 +0530
Message-Id: <20190613185241.22800-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190613185241.22800-1-jagan@amarulasolutions.com>
References: <20190613185241.22800-1-jagan@amarulasolutions.com>
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
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 9e9d08ee8387..8553066e7bed 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -1471,6 +1471,12 @@ static const struct sun4i_tcon_quirks sun8i_a83t_tv_quirks = {
 	.has_channel_1		= true,
 };
 
+static const struct sun4i_tcon_quirks sun8i_r40_lcd_quirks = {
+	.supports_lvds		= true,
+	.has_channel_0		= true,
+	.set_mux		= sun8i_r40_tcon_tv_set_mux,
+};
+
 static const struct sun4i_tcon_quirks sun8i_r40_tv_quirks = {
 	.has_channel_1		= true,
 	.set_mux		= sun8i_r40_tcon_tv_set_mux,
@@ -1501,6 +1507,7 @@ const struct of_device_id sun4i_tcon_of_table[] = {
 	{ .compatible = "allwinner,sun8i-a33-tcon", .data = &sun8i_a33_quirks },
 	{ .compatible = "allwinner,sun8i-a83t-tcon-lcd", .data = &sun8i_a83t_lcd_quirks },
 	{ .compatible = "allwinner,sun8i-a83t-tcon-tv", .data = &sun8i_a83t_tv_quirks },
+	{ .compatible = "allwinner,sun8i-r40-tcon-lcd", .data = &sun8i_r40_lcd_quirks },
 	{ .compatible = "allwinner,sun8i-r40-tcon-tv", .data = &sun8i_r40_tv_quirks },
 	{ .compatible = "allwinner,sun8i-v3s-tcon", .data = &sun8i_v3s_quirks },
 	{ .compatible = "allwinner,sun9i-a80-tcon-lcd", .data = &sun9i_a80_tcon_lcd_quirks },
-- 
2.18.0.321.gffc6fa0e3

