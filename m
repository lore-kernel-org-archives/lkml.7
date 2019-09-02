Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DA3C3A5A8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 03:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 440DE2168B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 03:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D9yjCxOs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbfIBDyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 23:54:50 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44875 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729425AbfIBDyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 23:54:49 -0400
Received: by mail-pg1-f195.google.com with SMTP id i18so6710647pgl.11
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2019 20:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OH1ekUs0bAkwdIcXuhIeBy1Fe7rzwyed9i4anOS+QSk=;
        b=D9yjCxOsKpxC2MY18oXKvPMh45HPOOO/2e6rqJimjQ57JSKfThLSfjFt2TWGoleJYA
         E0AElnWelyQ7JaAGl2mZzXl5pOrn4anpOQ00XxONWEggwisR/j5HvuSMs+qD8B5HkkrJ
         pDcjEHJYYMW/VQhxlYQREAnlnIwtdaxV6E5qw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OH1ekUs0bAkwdIcXuhIeBy1Fe7rzwyed9i4anOS+QSk=;
        b=Kr6rTF81OO3RdpwLVgmfT3CuRM5bK0KQjbxa0bYe1eHhmnQmkVIHjZVjAldiA/sdzs
         fZR4pW2GvrQvcH0tPuklaidnn6d/e43nGj958KU8Ubrwd4SJ7VbahNhHv5Pl1H5Ufdl/
         AW6FJoShYqUPa3liW+stHJkMpAZWEEy8bvqR86mPFDB9FrlAf/Mc7AcyBeyLUNkLvqo6
         gKwBSpl/2qskTVtu8pC0xd81ITFYRmilEjyXREkkQpoEDNgsVLJ4ENPIit/NYheAHSG0
         xK+vNyp2maJZqNAf3SrJbYac2teyfRL5DltUbHtR1M0ZOnragRC+hOglkw8Kz6+YIg47
         nFwA==
X-Gm-Message-State: APjAAAXeYBX7RsxJ8jgrUGwSkkjGUyuc5cc3NStIWkvk7Wp0dAIiiKKd
        sZXpo4Sp+qvKGIl1YPbd+HNED0t5tXc=
X-Google-Smtp-Source: APXvYqyLLTVcLzaki/zpgHyUnP83/ENMttMFuYtnXoMrj+6ZqRMI+e1TuQ0iyviYJx0zTEuLTNFtzg==
X-Received: by 2002:a63:f401:: with SMTP id g1mr24388291pgi.314.1567396489069;
        Sun, 01 Sep 2019 20:54:49 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:79b4:bd83:e4a5:a720])
        by smtp.gmail.com with ESMTPSA id y16sm14382217pfn.173.2019.09.01.20.54.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Sep 2019 20:54:48 -0700 (PDT)
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
        enric.balletbo@collabora.com, dri-devel@lists.freedesktop.org,
        Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2] drm: dw-hdmi-i2s: enable audio clock in audio_startup
Date:   Mon,  2 Sep 2019 11:54:35 +0800
Message-Id: <20190902035435.44463-1-cychiang@chromium.org>
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
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
Tested-by: Douglas Anderson <dianders@chromium.org>
---
 Changes from v1:
 1. Move audio_startup to the front of audio_shutdown.
 2. Fix the indentation of audio_startup equal sign using tab.
 3. Rebase the patch on linux-next/master.
 4. Add Reviewed-by and Tested-by fields from dianders@chromium.org.
 5. Add Reviewed-by field from jonas@kwiboo.se.

 drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
index 1d15cf9b6821..34d8e837555f 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
@@ -109,6 +109,14 @@ static int dw_hdmi_i2s_hw_params(struct device *dev, void *data,
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
@@ -153,6 +161,7 @@ static int dw_hdmi_i2s_get_dai_id(struct snd_soc_component *component,
 
 static struct hdmi_codec_ops dw_hdmi_i2s_ops = {
 	.hw_params	= dw_hdmi_i2s_hw_params,
+	.audio_startup  = dw_hdmi_i2s_audio_startup,
 	.audio_shutdown	= dw_hdmi_i2s_audio_shutdown,
 	.get_eld	= dw_hdmi_i2s_get_eld,
 	.get_dai_id	= dw_hdmi_i2s_get_dai_id,
-- 
2.23.0.187.g17f5b7556c-goog

