Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2B8C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 657F0246A8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576012149;
	bh=e97XmwMHx0vI+6xD3HXRhhHq8dw7yVxvDqvo9+ujASs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dpHUK/8XfBY843KolXU/olrHmyASqPgBfO9BT9Apgx2z5w+1nLtMQV05qggedF4Pf
	 d/2O9L11hjdpNAGtrt6wCyZW9VEL3Pe3oz0DVoTRP0a8kpY5JlLDuDKMR7Tb3SDB/R
	 Axvi9Hov74LcS5QISHhS1jEF4gnegP38gj4ah0XE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbfLJVJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:09:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:57090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728022AbfLJVJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:09:04 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4FF4246A0;
        Tue, 10 Dec 2019 21:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576012143;
        bh=e97XmwMHx0vI+6xD3HXRhhHq8dw7yVxvDqvo9+ujASs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QBB+9qroNE/pvujFKA2UVaKMFMmlwdTy4l5ZzsiJvub+qsp5jIr7OyXJAg5r4KrEl
         a6OEpz9tw1nEGo68A2talaqZ1S2GNTNp5Io0g2OJHlGIXuDuPmdKA2MXMebgr2a/Y7
         J50qHFu4av+IWsmx9A+NdJVvaqhoHZq0Jz5YyYeI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Daniel Kurtz <djkurtz@chromium.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Yakir Yang <ykk@rock-chips.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 108/350] drm/bridge: dw-hdmi: Restore audio when setting a mode
Date:   Tue, 10 Dec 2019 16:03:33 -0500
Message-Id: <20191210210735.9077-69-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Kurtz <djkurtz@chromium.org>

[ Upstream commit fadfee3f9d8f114435a8a3e9f83a227600d89de7 ]

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
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20191008102145.55134-1-cychiang@chromium.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 3e82d604201ee..1326f2c734bf8 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2033,7 +2033,7 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
 
 		/* HDMI Initialization Step E - Configure audio */
 		hdmi_clk_regenerator_update_pixel_clock(hdmi);
-		hdmi_enable_audio_clk(hdmi, true);
+		hdmi_enable_audio_clk(hdmi, hdmi->audio_enable);
 	}
 
 	/* not for DVI mode */
-- 
2.20.1

