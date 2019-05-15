Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C56C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 13:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A32212089E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 13:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="zDGPkuHo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbfEONTI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 09:19:08 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46924 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbfEONTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 09:19:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id r7so2622054wrr.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 06:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qs77ALhE/gKtnduPvCRtEn1+XaA68gtG693yCTv90Vk=;
        b=zDGPkuHoA+3szCHGN82vW7BAjTdBaU1OEwV8QGKRxUxlc/CvIbHhm/IJhbrHViITb8
         Msdp/fTbSM4btIYHBKCNaYVZ9n8AnJab4dM4x4ATaPA9r1roYVf93Xdo/bChCE+wWkEF
         cGZtKlUI9OejPiIb8VyEOg8mXy/XHD6YGtjlzYGbKpIsVSJv5wl2PlyVRCqOl5BZHpN/
         wTf4ruJlum1SBBQ948AXlntz0/Js3jMwR6yC+lrrFR/UGBPwf1KNKAnPJwoKaGlMcdUp
         2gKy5rNYaka0c8ojR19pSXOI0kOgsA8uDExnZ4ASqvPi2hzP4gUjXhCDeem7dIDTL5zT
         wvTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qs77ALhE/gKtnduPvCRtEn1+XaA68gtG693yCTv90Vk=;
        b=c99gX7GGYU3eTcoNWjW3U7e/NIzS5etR/c43/AdE9yfN7SxWVDbwxKaKD8if3f+GIt
         XAvpKWeeV5O+9tXOQQogi5Cm2hQX5mkhDbRJ5psOEmc/DC/bAZwOX9B7rMy9zdGfx2xU
         1F2Q5BXjmX6CcBNq1/a7aM2LRzyMpvxl39KxA+HlMFOvGtbgTzlpCgziqqXWqBkMmaLd
         CRzTvZzLhTKco13NvlHdv5CGs1ffQ/c2fC80r7wa3HfWRuOCkH+jFIE9CxQFXu0Q1Xby
         bkJsHuNLXlr4yKhD5mpeeTKh3OyJICwpwPsB/STEyvBNG88sA9HPTw+9LzR+Xc3KAxm3
         BCvw==
X-Gm-Message-State: APjAAAVPUv4fnFwPpCLWx3DXoPQ2Uc/lPxJwrxCTV5u15przv0tKbJeU
        MLOIHLyVN9nX5mZpT2aeU5br/A==
X-Google-Smtp-Source: APXvYqzm4ytAil3rojl8lYKukf8vaRhm+kH45f8n+v0RKH14Kw6A7pvAhM/MdQwtVNK4LuJ6xQgZOw==
X-Received: by 2002:adf:b641:: with SMTP id i1mr25792669wre.288.1557926344965;
        Wed, 15 May 2019 06:19:04 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id b206sm2789848wmd.28.2019.05.15.06.19.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 06:19:04 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 2/5] ASoC: dapm: allow muxes to force a disconnect
Date:   Wed, 15 May 2019 15:18:55 +0200
Message-Id: <20190515131858.32130-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190515131858.32130-1-jbrunet@baylibre.com>
References: <20190515131858.32130-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let soc_dapm_mux_update_power() accept NULL as 'e' enum.

It makes the code a bit more robust and, more importantly, let the calling
mux force a disconnect of the output path if necessary.

This is useful if the dapm elements following the mux must be off
while updating the mux, to avoid glitches or force a (re)configuration.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/soc-dapm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 81a7a12196ff..a4d6c068b545 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2245,7 +2245,7 @@ static int soc_dapm_mux_update_power(struct snd_soc_card *card,
 	dapm_kcontrol_for_each_path(path, kcontrol) {
 		found = 1;
 		/* we now need to match the string in the enum to the path */
-		if (!(strcmp(path->name, e->texts[mux])))
+		if (e && !(strcmp(path->name, e->texts[mux])))
 			connect = true;
 		else
 			connect = false;
-- 
2.20.1

