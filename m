Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7949EC04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 18:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C8EA20C01
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 18:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="SVFjdqYS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfELSls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 14:41:48 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33296 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfELSlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 14:41:47 -0400
Received: by mail-pg1-f196.google.com with SMTP id h17so5578787pgv.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 11:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=McU3A/Y2+KH8KsiZ+LTp3qJ8zWb4gZuzV4pCEGTBglg=;
        b=SVFjdqYSyAPhETD5SmYAsNRKu3Wf4F+fbW/+KnD9toKXS3ehMbEWA4cauoMEyZxVM3
         W2/GPER2Zd9IkEVZf4W6g+lCw7bp/90c1izCMNumL1PsfyDh3Gl4sCCtp3yuJGmOxFrt
         ZpuHyTiZqAZYxxZSvyBL74T/y6FkIJ8C9XDws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=McU3A/Y2+KH8KsiZ+LTp3qJ8zWb4gZuzV4pCEGTBglg=;
        b=Cy2m05Lr08A9NwPxPD4ldlZhx49edm3kzzDIQfYGOkqRKHS/its6Nn9CGrBwNZJWEe
         MT6fnOKmw+sLl4LwMisdmBcYXM8LMEaXXRxR2lC3HpmmG6VC9WdTsEIcpoCeykh5dbDK
         hRpl9EONnJ1NxbFBtgiCjhSL5Y1E9EoBRrWHgc9WCteIRUnPI67wCvxwEJvw2qXWQhcG
         cF67NiN8a3e9xD4ipsC1Z5YCPNERXE4p4z0iju1rwSiyFI3mtkLxLPDHAnelvwMwFFSv
         X8gK7eK/aI1kFjemqNR0tyM3eRe7DiizJNxzH+2bfyWnDOpMXIfN+7hAwRVsXy5CEgRC
         tk4w==
X-Gm-Message-State: APjAAAUh5m3adCaCNdoWnH0kqMrF0y1PkHRI76JsHvuGDuUPq04wrstx
        v3o4wZw1o31FwLrI8PkquKgWlg==
X-Google-Smtp-Source: APXvYqymxOYGSIxI7rUWYYOmlL1YU/UTYVdKySGM7lGUdp7qmHIxhsd9GhZCn1HJuCfA9pBG34sdAQ==
X-Received: by 2002:a63:f754:: with SMTP id f20mr26935381pgk.162.1557686506891;
        Sun, 12 May 2019 11:41:46 -0700 (PDT)
Received: from localhost.localdomain ([115.97.185.144])
        by smtp.gmail.com with ESMTPSA id 37sm11041291pgn.21.2019.05.12.11.41.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 11:41:46 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>
Cc:     michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v10 1/2] drm/sun4i: sun6i_mipi_dsi: Fix hsync_porch overflow
Date:   Mon, 13 May 2019 00:11:26 +0530
Message-Id: <20190512184128.13720-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190512184128.13720-1-jagan@amarulasolutions.com>
References: <20190512184128.13720-1-jagan@amarulasolutions.com>
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
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 6ff585055a07..bfa7e2b146df 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -457,8 +457,9 @@ static void sun6i_dsi_setup_inst_loop(struct sun6i_dsi *dsi,
 	u16 delay = 50 - 1;
 
 	if (device->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) {
-		delay = (mode->htotal - mode->hdisplay) * 150;
-		delay /= (mode->clock / 1000) * 8;
+		u32 hsync_porch = (mode->htotal - mode->hdisplay) * 150;
+
+		delay = (hsync_porch / ((mode->clock / 1000) * 8));
 		delay -= 50;
 	}
 
-- 
2.18.0.321.gffc6fa0e3

