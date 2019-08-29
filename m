Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A43C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 04:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5412C23403
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 04:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MMK7O5IU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfH2EaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 00:30:15 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43555 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfH2EaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 00:30:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id k3so873412pgb.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 21:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WjPTSP9KK2QsqjmhzaDx1khiUa3+dCf9cZMoVMaAshk=;
        b=MMK7O5IUDss97+ZReyNXw062RBZnNuHPYc45XAcCIE0DL5/DB+mNF+5x81uwfZZ9fh
         LrEZ3DrQ4CCRN2P4AHfiQxbBoS/6fKM2ZqMmGV4BBMpM31+fR4kYqVAjtWFGBilNpbqJ
         XVYy0EPLnGvGvc2zVSJPSyF8gdUOu4Vu4gvIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WjPTSP9KK2QsqjmhzaDx1khiUa3+dCf9cZMoVMaAshk=;
        b=PjoEWn/q9sbw16EQDZQWtYmzpbRIVrwfcMn9E6908YQNJWU+yImgeE0C13BHSR+ns5
         4c7X98i+6vOCaO1rhL5yNxPKErlMF3xK1l3J7e5KvPkuUvuqSTQh/id+VojFBTNdeJr9
         ZlD+Jthp6LgUYvWzxBhwCCS000NB/yQQ2eD65Eu0xVN9bt/6gSNcM8WK5hGukcB8r1oe
         KxaRLEQzyhs9FVGP/FKciEtdHGibldtqhWWnhrDoBNVg28+h/m5rgiLUMbag4v1rdZHA
         JP5Sg8/mR80fyDmGmZPAmJz+oIuZiBZWcU8+I6PKtZj8fz6kdQVt1tCfpVAx0/xFjdNR
         nUAg==
X-Gm-Message-State: APjAAAX5ka2/7bQ7x5QiKas67y1/DarV6pE8NUi4uJvhT830UR3AiOTk
        uP8wKRd7ooxx1wl1JbxDyt0Wx4uMjkc=
X-Google-Smtp-Source: APXvYqyPaVF6cNmZOG33dRsz6I4yq7+2LHI4Ys4JgoXMTN5eZVkbgzvy71GI5pd6/ByGdtUhZbRStg==
X-Received: by 2002:a17:90a:2525:: with SMTP id j34mr8022406pje.11.1567053013589;
        Wed, 28 Aug 2019 21:30:13 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:79b4:bd83:e4a5:a720])
        by smtp.gmail.com with ESMTPSA id s72sm717756pgc.92.2019.08.28.21.30.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2019 21:30:12 -0700 (PDT)
From:   Cheng-Yi Chiang <cychiang@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, airlied@linux.ie,
        daniel@ffwll.ch, kuninori.morimoto.gx@renesas.com,
        sam@ravnborg.org, cychiang@chromium.org, dianders@chromium.org,
        dgreid@chromium.org, tzungbi@chromium.org,
        zhengxing@rock-chips.com, cain.cai@rock-chips.com,
        eddie.cai@rock-chips.com, jeffy.chen@rock-chips.com,
        enric.balletbo@collabora.com, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm: dw-hdmi-i2s: enable audio clock in audio_startup
Date:   Thu, 29 Aug 2019 12:29:57 +0800
Message-Id: <20190829042957.150929-1-cychiang@chromium.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the designware databook, the sequence of enabling audio clock and
setting format is not clearly specified.
Currently, audio clock is enabled in the end of hw_param ops after
setting format.

On some monitors, there is a possibility that audio does not come out.
Fix this by enabling audio clock in audio_startup ops
before hw_param ops setting format.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
index 5cbb71a866d5..08b4adbb1ddc 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
@@ -69,6 +69,14 @@ static int dw_hdmi_i2s_hw_params(struct device *dev, void *data,
 	hdmi_write(audio, conf0, HDMI_AUD_CONF0);
 	hdmi_write(audio, conf1, HDMI_AUD_CONF1);
 
+	return 0;
+}
+
+static int dw_hdmi_i2s_audio_startup(struct device *dev, void *data)
+{
+	struct dw_hdmi_i2s_audio_data *audio = data;
+	struct dw_hdmi *hdmi = audio->hdmi;
+
 	dw_hdmi_audio_enable(hdmi);
 
 	return 0;
@@ -105,6 +113,7 @@ static int dw_hdmi_i2s_get_dai_id(struct snd_soc_component *component,
 }
 
 static struct hdmi_codec_ops dw_hdmi_i2s_ops = {
+	.audio_startup = dw_hdmi_i2s_audio_startup,
 	.hw_params	= dw_hdmi_i2s_hw_params,
 	.audio_shutdown	= dw_hdmi_i2s_audio_shutdown,
 	.get_dai_id	= dw_hdmi_i2s_get_dai_id,
-- 
2.23.0.187.g17f5b7556c-goog

