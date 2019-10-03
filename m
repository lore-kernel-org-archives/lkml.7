Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EE1C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 04:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 799AC222C3
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 04:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GJ8dCYph"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfJCEFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 00:05:51 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41737 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfJCEFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 00:05:51 -0400
Received: by mail-pg1-f194.google.com with SMTP id s1so888959pgv.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 21:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ipcV5l1n/8It2aLom5M2l+YXf6MikdW6xOH7ijHIWC4=;
        b=GJ8dCYphiCUor6hJ8Gk2a0LVJjkKGKBK0qYgul5TeGjsdlVTkyabw4iWB5Tf+iw8Ua
         FiN7fu0PJaIxegA5BQ9wp6F5l6rFTNhY5aFK9pAnie4HM6QzrpFmxoq8pnTTVRFeYJAV
         OE4PSBL5YMHVsOurDvxBxxhEypEBCMV34tWV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ipcV5l1n/8It2aLom5M2l+YXf6MikdW6xOH7ijHIWC4=;
        b=ih+84fUkyJbVk7eY0cEPHdt0Iud2st/FuR1V1T/yX7n8NqxCubGYD1/1tYppr7vsgD
         Gaw4uGGXe0uNfTWg90S8YWIeZQjTdEwXX9zAAQYVgfb6woTefVNitD7TUmlv6mG7IUMp
         jNMxDNGhyH636y1grTgqMKXe/FGwGOikB9uGsyjPZPESA/f0AmsutVtyOeYY/5lwqJKN
         CUYpO/D1j0zmApCb+kv5Rw9E4Sby5NPguIbb6jAXtA7bRkdQUtNEBXkGU4aCusCsjx/m
         pfIa2/3xwSvn5KcLHYfw/cQmfyV+Gt4wuvrSUmKxKfens/tAZCPDVmVYrn+eTq1aK98J
         UMIA==
X-Gm-Message-State: APjAAAVG3YT4Wd6Cr9NRqdcW3y16f1+itqkGeAJMi71wvOJtZmeHP5EC
        VSmDqEt+L63pG0zHroWBl9ttyyQJXGI=
X-Google-Smtp-Source: APXvYqzWiB8hQkm2uo7S8xni0GVmAx2W9Y1kaKW4dhI8KN2xpmpX/enaUKzWwxDftTpN40iGJ57rhw==
X-Received: by 2002:a62:754a:: with SMTP id q71mr8685426pfc.70.1570075550111;
        Wed, 02 Oct 2019 21:05:50 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:79b4:bd83:e4a5:a720])
        by smtp.gmail.com with ESMTPSA id z5sm954845pgi.19.2019.10.02.21.05.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2019 21:05:49 -0700 (PDT)
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
Subject: [PATCH v2] FROMLIST: drm/bridge: dw-hdmi: Restore audio when setting a mode
Date:   Thu,  3 Oct 2019 12:05:40 +0800
Message-Id: <20191003040540.180310-1-cychiang@chromium.org>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
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
 Change from v1 to v2:
 - Use audio_lock to protect audio clock.

 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index aa7efd4da1c8..749d8e4c535b 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -1982,6 +1982,17 @@ static void hdmi_disable_overflow_interrupts(struct dw_hdmi *hdmi)
 		    HDMI_IH_MUTE_FC_STAT2);
 }
 
+static void dw_hdmi_audio_restore(struct dw_hdmi *hdmi)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&hdmi->audio_lock, flags);
+
+	hdmi_enable_audio_clk(hdmi, hdmi->audio_enable);
+
+	spin_unlock_irqrestore(&hdmi->audio_lock, flags);
+}
+
 static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
 {
 	int ret;
@@ -2045,7 +2056,7 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
 
 		/* HDMI Initialization Step E - Configure audio */
 		hdmi_clk_regenerator_update_pixel_clock(hdmi);
-		hdmi_enable_audio_clk(hdmi, true);
+		dw_hdmi_audio_restore(hdmi);
 	}
 
 	/* not for DVI mode */
-- 
2.23.0.444.g18eeb5a265-goog

