Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AEA7C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 04:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 203122085B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 04:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XqXsTJWV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfJCEOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 00:14:46 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43296 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbfJCEOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 00:14:45 -0400
Received: by mail-pf1-f193.google.com with SMTP id a2so833467pfo.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 21:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FMBWBObY5TAg6ccjViv94lsR9vhyqh//qqXjnxybPn4=;
        b=XqXsTJWVRpZea6TA7FBFgnhTI63A2/g03nfSRRb33FkaY5eHoSUvNUKEOdIMbnpkbB
         Pecea+Q0A331rSFnGj2eJ25IBgyIygcpzhSbOdlVrje4TCo89GmFdQxR3an9e70yYyn9
         A+wMolfWeeZXTHrgo82zxfTc7I+G9zjh+5wFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FMBWBObY5TAg6ccjViv94lsR9vhyqh//qqXjnxybPn4=;
        b=AcR0x0eKRtcprUvrFN3HbSqTS3/z6RQmejfzyEGC5fxLVjQBuuIvkEvfsOeaRVfWFo
         okV8rDkbY/TQUS1gco2erQ/JGvNDhXDpOELYnQiZZ3kB9VNUNNrvTvi79ao3oY+x7R0U
         cVp9bnGTgORIE5+O6c7DckJvH6QsKtIi7KONDHG91gZpnwVcvlyPsQw+nTlM9dncn9x3
         tjygfWWEcy/rsdIrzIMoVus+0BVgBqBHSGV+c4XQLzs8JaZMzqRM8rYrA+es/UuYGA+w
         B1nqMvXEi8tgUhr+VzR0v5nyTVTz11Ii4EuYh0QLEXFCj3t1BVZU9JtZGPHkCR3Je1Qc
         8uPQ==
X-Gm-Message-State: APjAAAXVZrBsYIbWvqB5rQyoXdp2l23SNQbsLoBHXManPCFGYHOY/19g
        5m4/0vrmgeNO78VOJh9vzaqsxaHlrTo=
X-Google-Smtp-Source: APXvYqz6+m0BHndgOBBpcbuerLKGK0gYMwBss4tu7T/iC6fV04yrpAecbt/bgBysta04HsJtKsYn4A==
X-Received: by 2002:a63:1c09:: with SMTP id c9mr7498204pgc.347.1570076084849;
        Wed, 02 Oct 2019 21:14:44 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:79b4:bd83:e4a5:a720])
        by smtp.gmail.com with ESMTPSA id q42sm718700pja.16.2019.10.02.21.14.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2019 21:14:44 -0700 (PDT)
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
Subject: [PATCH v2 RESEND] drm/bridge: dw-hdmi: Restore audio when setting a mode
Date:   Thu,  3 Oct 2019 12:14:38 +0800
Message-Id: <20191003041438.194224-1-cychiang@chromium.org>
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
  - Fix the patch title.

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

