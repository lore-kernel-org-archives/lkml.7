Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20E0C10F00
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 17:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCEAF2086A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 17:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="LflUIddU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfCCRgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 12:36:17 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35388 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfCCRgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 12:36:16 -0500
Received: by mail-pl1-f194.google.com with SMTP id p19so1371245plo.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2019 09:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YvQ56Xx1Bmp0kWQNDK2nAiI9K4YgbqYzq9u72/Tb/Wo=;
        b=LflUIddUoNDPr+yhSqv8YqZrx+sPJX8q6IeVAKXozXBQmd+7QqdF5FC/Nnfuh4HgEb
         P0P7322O1SSJswkLmEli+W4c4fUmqaQsvLpS23zbRTSmaNeBpt5i1mKVUS9aYaD6d08r
         50szGzTOFiwKeoS4HmqpCI/fn6Ka88k8gLleo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YvQ56Xx1Bmp0kWQNDK2nAiI9K4YgbqYzq9u72/Tb/Wo=;
        b=UxUqP7/R5iq/TRyvN9EAsdRWwc32Axm8uprSet6MMwOt5Pk44c+WjA8kUOFGWf20VT
         iZJdMGJTkfiJpGN3vE8CJPu84FTuKkyL7TRqlYxCXpEU+If4ZmylVX0lHezxwzzmihdh
         068rCW1qFFTBjJmraxP0jxxuo/W0xIDoYmACMVWkRDd3PGNlNteFOYcuQRb83KxCOQPw
         I7U/c3oemxH92eh+gsuD3IGxoNJzQoO6a35Kmw6/jYYr3NaTDwqbYH4F/H4pHfgCkngn
         /HY7DcU6ugqLeI3f+idyxYBziBGchcz1YDeACyTx1DxHx+lRk0n/fjuGUfzrUF8+mS5S
         6Frw==
X-Gm-Message-State: APjAAAUAcEt5PdadbQHRn2FenB73RxuXp2IhtXv3JDijBsRx7iOH4ozY
        jEn1jT/WM2yfAt0MmectfVQHJA==
X-Google-Smtp-Source: APXvYqwMfcEqRj8CRJW1LCxN3K8d+OryA2fDRcxHfLMc10INVG90SRQRlL8++UlhSKwM0Kz41FXC0Q==
X-Received: by 2002:a17:902:52c:: with SMTP id 41mr16382818plf.331.1551634575454;
        Sun, 03 Mar 2019 09:36:15 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
        by smtp.gmail.com with ESMTPSA id d129sm5614737pgc.59.2019.03.03.09.36.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 09:36:14 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v9 1/5] drm/sun4i: sun6i_mipi_dsi: Fix hsync_porch overflow
Date:   Sun,  3 Mar 2019 23:05:23 +0530
Message-Id: <20190303173527.31055-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190303173527.31055-1-jagan@amarulasolutions.com>
References: <20190303173527.31055-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Loop N1 instruction delay for burst mode devices are computed
based on horizontal sync and porch timing values.

The current driver is using u16 type for computing this hsync_porch
value, which would failed to fit within the u16 type for large sync
and porch timings devices. This would result in hsync_porch overflow
and eventually computed wrong instruction delay value.

Example, timings, where it produces the overflow
{
	.hdisplay       = 1080,
	.hsync_start    = 1080 + 408,
        .hsync_end      = 1080 + 408 + 4,
        .htotal         = 1080 + 408 + 4 + 38,
}

It reproduces the desired delay value 65487 but the correct working
value should be 7.

So, Fix it by computing hsync_porch value separately with u32 type.

Fixes: 1c1a7aa3663c ("drm/sun4i: dsi: Add burst support")
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Merlijn Wajer <merlijn@wizzup.org>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 6ff585055a07..465e7fc57899 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -457,8 +457,9 @@ static void sun6i_dsi_setup_inst_loop(struct sun6i_dsi *dsi,
 	u16 delay = 50 - 1;
 
 	if (device->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) {
-		delay = (mode->htotal - mode->hdisplay) * 150;
-		delay /= (mode->clock / 1000) * 8;
+		u32 hsync_porch = (mode->htotal - mode->hdisplay);
+
+		delay = ((hsync_porch * 150) / ((mode->clock / 1000) * 8));
 		delay -= 50;
 	}
 
-- 
2.18.0.321.gffc6fa0e3

