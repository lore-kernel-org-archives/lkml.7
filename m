Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C96C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBDC6206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 10:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cdJSJvCO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730307AbfJHKVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 06:21:54 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38958 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728866AbfJHKVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 06:21:53 -0400
Received: by mail-pl1-f194.google.com with SMTP id s17so8263417plp.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 03:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GeMDvxk000kDXZOF/cVkZFJMD0gb/5P7FfXKteqfPL8=;
        b=cdJSJvCOf5lwlnvWxJxswCx6xNQ3AjanFRiUtsdswxZMfYmCMtj1PGMFewsVic258v
         Obg7GqwttJcCpt7nuw95onf8KC58807n8gbnHZJ/LRcDAza2N53eImEePNyxIg99BHpt
         Ebgr4PpV4SPUtutXxqVqDceBd9fiuEQOlx/sE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GeMDvxk000kDXZOF/cVkZFJMD0gb/5P7FfXKteqfPL8=;
        b=ghnxh/9O2jWqkf3NZN9mnFiJL0KsjpCmL/VjJpKU6z/wvC95CFvf0XUYJUkmkD1/He
         7X12eaaa5o/r6FrjXS3oAD0DE11pqzUPzdV/5kWcoCaTNlorz1z5Yf7j0fDkJhXK8LcP
         d7KZihgYrOFz/za8KNiD8JJS1JrWeD6SiU4i2And+AlxocI4KN8umptSijDHwK29z+SS
         yuodOZGl4z8Q126Nhov7pJ1Py4aMmjhMrS2wbQP4YkU33oA8FCau6rrfBiwu54Nhem38
         fnDdAbF0bnlIxMptN/n+urKLFvwF3UHRb3yaIkMwqYCsGC+vJBsLHfcLvg1z9gK4gCqM
         h5/g==
X-Gm-Message-State: APjAAAVMoeaVRfLuPfCrI8cnw1wkKTdeJL6I5zG/BH//LF3M6ppkfeji
        TnwAbVoGC1+6P4c1ZAO8sGSqQ8S4Y2I=
X-Google-Smtp-Source: APXvYqw2a0XI5XUbrLM3Qio4U723/Y5fi8MXrTnqZEIoVScPrqDX2SVFu2OcatshFfvpyWcA9OlBRA==
X-Received: by 2002:a17:902:7895:: with SMTP id q21mr33495295pll.94.1570530112854;
        Tue, 08 Oct 2019 03:21:52 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:79b4:bd83:e4a5:a720])
        by smtp.gmail.com with ESMTPSA id b9sm15111763pfo.105.2019.10.08.03.21.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2019 03:21:52 -0700 (PDT)
From:   Cheng-Yi Chiang <cychiang@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        dianders@chromium.org, dgreid@chromium.org, tzungbi@chromium.org,
        alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Daniel Kurtz <djkurtz@chromium.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Yakir Yang <ykk@rock-chips.com>
Subject: [PATCH v3] drm/bridge: dw-hdmi: Restore audio when setting a mode
Date:   Tue,  8 Oct 2019 18:21:45 +0800
Message-Id: <20191008102145.55134-1-cychiang@chromium.org>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Kurtz <djkurtz@chromium.org>

When setting a new display mode, dw_hdmi_setup() calls
dw_hdmi_enable_video_path(), which disables all hdmi clocks, including
the audio clock.

We should only (re-)enable the audio clock if audio was already enabled
when setting the new mode.

Without this patch, on RK3288, there will be HDMI audio on some monitors
if i2s was played to headphone when the monitor was plugged.
ACER H277HU and ASUS PB278 are two of the monitors showing this issue.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
 Change from v2 to v3:
 - Remove spinlock around setting clock.

 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index a15fbf71b9d7..af060162b0af 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2054,7 +2054,7 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
 
 		/* HDMI Initialization Step E - Configure audio */
 		hdmi_clk_regenerator_update_pixel_clock(hdmi);
-		hdmi_enable_audio_clk(hdmi, true);
+		hdmi_enable_audio_clk(hdmi, hdmi->audio_enable);
 	}
 
 	/* not for DVI mode */
-- 
2.23.0.581.g78d2f28ef7-goog

