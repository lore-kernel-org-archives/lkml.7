Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BE8C32792
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 01:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE07820815
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 01:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="epI3ugdy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbfJABAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 21:00:34 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44083 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfJABAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 21:00:34 -0400
Received: by mail-pg1-f193.google.com with SMTP id i14so8381908pgt.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 18:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E6c31Z8bqLagiMFjesWQuytu80YEed1XWODDuNsW24s=;
        b=epI3ugdyCvOb4zVNWfia360x2V+v1fm0AgFUCheJyZoUPJVy8ggRSIGIk4NaAVbcs8
         glkEUdVmFN63+q25+HfwPVyF7/WpBLgRjU2E3olV+ADe28YhCAQg+TX6TAKvCx31/fjd
         mDk4bYpvHaWJVnZyiYSSnbKK3bGoR5ynIr//c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E6c31Z8bqLagiMFjesWQuytu80YEed1XWODDuNsW24s=;
        b=KK2syX0QxL3m2kGbcfbvKOaSp7FiVczS4iEzXXL6DCYGx7xLS65YzN5dSnh0UV56OP
         0cDvGUo4+8RLOTN6KY7PsqzIOkOeuVSVNvWKcD2M9JlexNXBqNZJVCX0xNVI7oQpfh4P
         e7w7dp4Y0HXWS91r2MKqSO0850LkPnPZNHg0D1W32Xf7fDLAcv1RPKwRnPllPj8zdGet
         1gWWLquHVjkeW/knbPdCIqtC138skrE/WtO0UjUrbv2xFZjNffZYnXT3Ccwb4+Ju46dR
         cJ/QcwCo4khFxp5UKIIm0GJ8JzeHSpBNUTGD5ZlyXOCFLAcLwUukm2OJyigidBALx7lN
         lAUA==
X-Gm-Message-State: APjAAAU1r2zLr3tPAweIHFAvyUZeQ0MnoulXOK4Sif0OIn8c9ybgfTHI
        iQw52F9kju1UskutwCsSlhLK9MO1wYQ=
X-Google-Smtp-Source: APXvYqxIwQ/Z/NG15bD/vJSTi2QXMxa4a8imVSlOMCNDTKdY/6Mm2LE1FlsEyH4TWT/43exPRAlWBQ==
X-Received: by 2002:a63:1950:: with SMTP id 16mr28046453pgz.213.1569891631964;
        Mon, 30 Sep 2019 18:00:31 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:79b4:bd83:e4a5:a720])
        by smtp.gmail.com with ESMTPSA id 62sm13146047pfg.164.2019.09.30.18.00.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2019 18:00:31 -0700 (PDT)
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
Subject: [PATCH] drm/bridge: dw-hdmi: Restore audio when setting a mode
Date:   Tue,  1 Oct 2019 09:00:20 +0800
Message-Id: <20191001010020.122134-1-cychiang@chromium.org>
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
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index aa7efd4da1c8..c60e951122c9 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -1982,6 +1982,15 @@ static void hdmi_disable_overflow_interrupts(struct dw_hdmi *hdmi)
 		    HDMI_IH_MUTE_FC_STAT2);
 }
 
+static void dw_hdmi_audio_restore(struct dw_hdmi *hdmi)
+{
+	mutex_lock(&hdmi->audio_mutex);
+
+	hdmi_enable_audio_clk(hdmi, hdmi->audio_enable);
+
+	mutex_unlock(&hdmi->audio_mutex);
+}
+
 static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
 {
 	int ret;
@@ -2045,7 +2054,7 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
 
 		/* HDMI Initialization Step E - Configure audio */
 		hdmi_clk_regenerator_update_pixel_clock(hdmi);
-		hdmi_enable_audio_clk(hdmi, true);
+		dw_hdmi_audio_restore(hdmi);
 	}
 
 	/* not for DVI mode */
-- 
2.23.0.444.g18eeb5a265-goog

