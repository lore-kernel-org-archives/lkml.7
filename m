Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063A7C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 08:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCC9221743
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 08:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F73HcBqr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbfGQId5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 04:33:57 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33360 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfGQIdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 04:33:55 -0400
Received: by mail-pl1-f194.google.com with SMTP id c14so11563299plo.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 01:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Iwx8d0RGJRMbsUh5MH2Q2PhdCBXrR+QSvVmkF9EObNI=;
        b=F73HcBqrBdoliIS0TswjZsyoSTqV3pr2Ql2l/+xRVG6vho0qliFDVTHs//UMlQounu
         kEc4t3ESghyIZxz4hI2DjAdn2PYy6Oil5zMAepaL1RrirWnjneNK4E+B4sYNLYJgquCv
         S4jUygxjiyQWrQTWl4lWN1R5b/Et1sgk6xOm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Iwx8d0RGJRMbsUh5MH2Q2PhdCBXrR+QSvVmkF9EObNI=;
        b=K1tXNZQM6L7gZTnRUNoFMRo5yvlQdV7RzhFOb/PFmjHn5PaQWNdYVLzJf8DJIlqxkh
         rltuWU5uHmq3soRbKLsGbTRpOk8yEi+irBGx2+31PB9TD7UsQRYOmKl/zhJz6anY1ZZk
         198AebzdUaeelj2SMbq7i+9mKSTE5f5I/DWGZwrQdflU5Sc30HQlNPkYkCZG78WntxGl
         t1y1kC9ow7SVdg3+FBNoPdRgGbmH+Svt8PylW4b6L3rii0BKfOR1hiuBs8+bpsFr/QQi
         tz/pRokoIEppaI800yLHuaXCwJCZBfTKtibjmaMuqfANUs169xX8k5b3Ny//ePLLQzK4
         oRuQ==
X-Gm-Message-State: APjAAAWlfrV09DUe1tMuC15JELgL5Pw/9OCjjuxruVvlEy949MgBsBdc
        PvuoWHScdn/w4g3MBNa9xyJ3pWwqQVs=
X-Google-Smtp-Source: APXvYqwca1yGfzgDVKjSr7q4qrti7DaSd7VKgHhWePyggYEHnIDdCbOEu9LujfkOwBuEBZ2NWDHJFA==
X-Received: by 2002:a17:902:3181:: with SMTP id x1mr40824727plb.135.1563352434649;
        Wed, 17 Jul 2019 01:33:54 -0700 (PDT)
Received: from localhost ([2401:fa00:1:b:e688:dfd2:a1a7:2956])
        by smtp.gmail.com with ESMTPSA id b1sm22020443pfi.91.2019.07.17.01.33.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 01:33:54 -0700 (PDT)
From:   Cheng-Yi Chiang <cychiang@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Hans Verkuil <hverkuil@xs4all.nl>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org,
        dgreid@chromium.org, tzungbi@chromium.org,
        alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH v5 3/5] drm: dw-hdmi-i2s: Use fixed id for codec device
Date:   Wed, 17 Jul 2019 16:33:25 +0800
Message-Id: <20190717083327.47646-4-cychiang@chromium.org>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
In-Reply-To: <20190717083327.47646-1-cychiang@chromium.org>
References: <20190717083327.47646-1-cychiang@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The problem of using auto ID is that the device name will be like
hdmi-audio-codec.<id number>.auto.

The number might be changed when there are other platform devices being
created before hdmi-audio-codec device.
Use a fixed name so machine driver can set codec name on the DAI link.

Using the fixed name should be fine because there will only be one
hdmi-audio-codec device.

Fix the codec name in rockchip rk3288_hdmi_analog machine driver.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c | 2 +-
 sound/soc/rockchip/rk3288_hdmi_analog.c             | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
index ca56783fae47..bc608f9258be 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
@@ -135,7 +135,7 @@ static int snd_dw_hdmi_probe(struct platform_device *pdev)
 
 	memset(&pdevinfo, 0, sizeof(pdevinfo));
 	pdevinfo.parent		= pdev->dev.parent;
-	pdevinfo.id		= PLATFORM_DEVID_AUTO;
+	pdevinfo.id		= PLATFORM_DEVID_NONE;
 	pdevinfo.name		= HDMI_CODEC_DRV_NAME;
 	pdevinfo.data		= &pdata;
 	pdevinfo.size_data	= sizeof(pdata);
diff --git a/sound/soc/rockchip/rk3288_hdmi_analog.c b/sound/soc/rockchip/rk3288_hdmi_analog.c
index 767700c34ee2..8286025a8747 100644
--- a/sound/soc/rockchip/rk3288_hdmi_analog.c
+++ b/sound/soc/rockchip/rk3288_hdmi_analog.c
@@ -15,6 +15,7 @@
 #include <linux/gpio.h>
 #include <linux/of_gpio.h>
 #include <sound/core.h>
+#include <sound/hdmi-codec.h>
 #include <sound/jack.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -142,7 +143,7 @@ static const struct snd_soc_ops rk_ops = {
 SND_SOC_DAILINK_DEFS(audio,
 	DAILINK_COMP_ARRAY(COMP_EMPTY()),
 	DAILINK_COMP_ARRAY(COMP_CODEC(NULL, NULL),
-			   COMP_CODEC("hdmi-audio-codec.2.auto", "i2s-hifi")),
+			   COMP_CODEC(HDMI_CODEC_DRV_NAME, "i2s-hifi")),
 	DAILINK_COMP_ARRAY(COMP_EMPTY()));
 
 static struct snd_soc_dai_link rk_dailink = {
-- 
2.22.0.510.g264f2c817a-goog

