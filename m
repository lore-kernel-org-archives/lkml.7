Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA62C76192
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 11:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1E672173B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 11:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aQA61TLC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732645AbfGPL6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 07:58:00 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46145 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbfGPL6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 07:58:00 -0400
Received: by mail-pg1-f195.google.com with SMTP id i8so9317607pgm.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 04:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Iwx8d0RGJRMbsUh5MH2Q2PhdCBXrR+QSvVmkF9EObNI=;
        b=aQA61TLCniToS5Likru1sIC54YWOnvRx7axSnnWpgtzks/Hl8axoW3VU5BVXp1Ee+E
         GrG+kW7RtexCd8nKHUgx9AI4Sz1vr1nuUrodOcC+pu6H1qsjl4d/kdreTjAb4Rq0MhwU
         dxDwdrfo4GjogYeVqxXtcPRPBukVIQHBpoTMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Iwx8d0RGJRMbsUh5MH2Q2PhdCBXrR+QSvVmkF9EObNI=;
        b=hCShAu6nRtgAPBdCcwcgye+dHrxolVvTjPf0Cfph/i0CKWLePnmJuWJqwSaIOVFm63
         egS99HNkYkwEg3VCd/QynU5drYcbb2ppGVtgwxMmrDLjiwcl8VIHvkepAWMR2NTyAj9d
         kzW1IkF+h1lT3na91ZXEkThNpe1NEQZTwOLTc9D0T5iX5i2QyQevX0Gfq1By64OyZQ2L
         26GvQTVPyIywfBp0SKc8+cJ1Ue80TGp4Ig+FDMmDL5Ou/+0zxSqWMVx0y54aMEWZnbHl
         IvMdgkySj7c7UJm7V7g4TSYcxBqCVxuSi5QMlV16NlOSS1hoGk4f6vfE4UbL8dZlMWlB
         C0cA==
X-Gm-Message-State: APjAAAU+L8QIKIHDCTabSUythssA/PU9tx/fLP4RbdX5qfuMlu9v0lO7
        79ad9usKnrOeDDHYcnQDBmpvxypPqY0=
X-Google-Smtp-Source: APXvYqy0weNkbZt4Hdxvqkz5Ox5mO/XYQPfxZE09Uq5wBCB1mS8+9Xf46+LJbAMKVfmKhHRqH1zqTw==
X-Received: by 2002:a17:90a:cb18:: with SMTP id z24mr34623260pjt.108.1563278279412;
        Tue, 16 Jul 2019 04:57:59 -0700 (PDT)
Received: from localhost ([2401:fa00:1:b:e688:dfd2:a1a7:2956])
        by smtp.gmail.com with ESMTPSA id x24sm19436499pgl.84.2019.07.16.04.57.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 04:57:58 -0700 (PDT)
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
Subject: [PATCH v4 3/5] drm: dw-hdmi-i2s: Use fixed id for codec device
Date:   Tue, 16 Jul 2019 19:57:23 +0800
Message-Id: <20190716115725.66558-4-cychiang@chromium.org>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
In-Reply-To: <20190716115725.66558-1-cychiang@chromium.org>
References: <20190716115725.66558-1-cychiang@chromium.org>
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

