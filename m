Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B11ECDE27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 08:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D9AC20863
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 08:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SkDdQyZv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfIKI06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 04:26:58 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37861 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfIKI06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 04:26:58 -0400
Received: by mail-pg1-f194.google.com with SMTP id c17so3394453pgg.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 01:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4r0nmZkQSsR2gJHf1JrXB09YJMiVgOB3zCW5D3saotk=;
        b=SkDdQyZvW4zi69+lyo92l0Kk3Thw/bwocTopP9fFph6zyBMtEB/3j1KLDMRUxqxdz8
         +GfX2YdSkpKSLb2PvhEGCOF4NwPA/U6Y1kiPxadIOSTS6TyJZFma9bzPGLj2n8QbL23D
         Hr+J8YoPtLhznecB9zPycHkXrnWu5k+PMPJ+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4r0nmZkQSsR2gJHf1JrXB09YJMiVgOB3zCW5D3saotk=;
        b=g+bk53u7k/WViYjxXmUYDxgowiNdssZyiPp2RHeWHOzTv2SpZIbnwt7nGtJYnPfoMy
         8uE2eBvgtxsos8V17uqTnhKZ1UCfzb8RgSkstUEMvSpWTOVlMs3S/Fdq2asfe1OQpfgy
         SBZEsMaJoy/OP/lN5BmQOKhI5ZIvMrEyD/ORn8YYJPkkk8X14GO3/0DOb5tlXzUgVTjT
         uNM+3pNeAh+TSIyThnl4GROdttsKBe2fzbtI3Smfn3trbbZKn7xwsMFo13IkxITVgMZX
         n2eT2yG5+mKXYFDw0IWmPxJwxIexQPR3ZlRQoYuPXJ6Bgp2/TnU02VE5s4oeznyijsdc
         8SNQ==
X-Gm-Message-State: APjAAAV4vfD54PwqKvBMhGHMatlJlvWQmMxcQNYF99xbuDYCJopNj53Q
        sudw/G8H9h9NbDKWmMay0pg4tiF0OG4=
X-Google-Smtp-Source: APXvYqyu86LR1qJn3qdq+8oCOL+6X9M/yekQdNO+TlGPFuebwd792sRf58JYMVY/Ym+ipZH+zK0xSA==
X-Received: by 2002:a63:487:: with SMTP id 129mr4981704pge.14.1568190416941;
        Wed, 11 Sep 2019 01:26:56 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:79b4:bd83:e4a5:a720])
        by smtp.gmail.com with ESMTPSA id t12sm22798655pfe.58.2019.09.11.01.26.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2019 01:26:55 -0700 (PDT)
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
        kuankuan.y@gmail.com, enric.balletbo@collabora.com,
        dri-devel@lists.freedesktop.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Yakir Yang <ykk@rock-chips.com>
Subject: [PATCH v3] drm: bridge/dw_hdmi: add audio sample channel status setting
Date:   Wed, 11 Sep 2019 16:26:46 +0800
Message-Id: <20190911082646.134347-1-cychiang@chromium.org>
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yakir Yang <ykk@rock-chips.com>

When transmitting IEC60985 linear PCM audio, we configure the
Aduio Sample Channel Status information in the IEC60958 frame.
The status bit is already available in iec.status of hdmi_codec_params.

This fix the issue that audio does not come out on some monitors
(e.g. LG 22CV241)

Note that these registers are only for interfaces:
I2S audio interface, General Purpose Audio (GPA), or AHB audio DMA
(AHBAUDDMA).
For S/PDIF interface this information comes from the stream.

Currently this function dw_hdmi_set_channel_status is only called
from dw-hdmi-i2s-audio in I2S setup.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---

Change from v2 to v3:
1. Reuse what is already set in iec.status in hw_param.
2. Remove all useless definition of registers and values.
3. Note that the original sampling frequency is not written to
   the channel status as we reuse create_iec958_consumer in pcm_iec958.c.
   Without that it can still play audio fine.

 .../drm/bridge/synopsys/dw-hdmi-i2s-audio.c   |  1 +
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c     | 20 +++++++++++++++++++
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.h     |  2 ++
 include/drm/bridge/dw_hdmi.h                  |  1 +
 4 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
index 34d8e837555f..20f4f92dd866 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
@@ -102,6 +102,7 @@ static int dw_hdmi_i2s_hw_params(struct device *dev, void *data,
 	}
 
 	dw_hdmi_set_sample_rate(hdmi, hparms->sample_rate);
+	dw_hdmi_set_channel_status(hdmi, hparms->iec.status);
 	dw_hdmi_set_channel_count(hdmi, hparms->channels);
 	dw_hdmi_set_channel_allocation(hdmi, hparms->cea.channel_allocation);
 
diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index bd65d0479683..aa7efd4da1c8 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -582,6 +582,26 @@ static unsigned int hdmi_compute_n(unsigned int freq, unsigned long pixel_clk)
 	return n;
 }
 
+/*
+ * When transmitting IEC60958 linear PCM audio, these registers allow to
+ * configure the channel status information of all the channel status
+ * bits in the IEC60958 frame. For the moment this configuration is only
+ * used when the I2S audio interface, General Purpose Audio (GPA),
+ * or AHB audio DMA (AHBAUDDMA) interface is active
+ * (for S/PDIF interface this information comes from the stream).
+ */
+void dw_hdmi_set_channel_status(struct dw_hdmi *hdmi,
+				u8 *channel_status)
+{
+	/*
+	 * Set channel status register for frequency and word length.
+	 * Use default values for other registers.
+	 */
+	hdmi_writeb(hdmi, channel_status[3], HDMI_FC_AUDSCHNLS7);
+	hdmi_writeb(hdmi, channel_status[4], HDMI_FC_AUDSCHNLS8);
+}
+EXPORT_SYMBOL_GPL(dw_hdmi_set_channel_status);
+
 static void hdmi_set_clk_regenerator(struct dw_hdmi *hdmi,
 	unsigned long pixel_clk, unsigned int sample_rate)
 {
diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
index 6988f12d89d9..fcff5059db24 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
@@ -158,6 +158,8 @@
 #define HDMI_FC_SPDDEVICEINF                    0x1062
 #define HDMI_FC_AUDSCONF                        0x1063
 #define HDMI_FC_AUDSSTAT                        0x1064
+#define HDMI_FC_AUDSCHNLS7                      0x106e
+#define HDMI_FC_AUDSCHNLS8                      0x106f
 #define HDMI_FC_DATACH0FILL                     0x1070
 #define HDMI_FC_DATACH1FILL                     0x1071
 #define HDMI_FC_DATACH2FILL                     0x1072
diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
index cf528c289857..4b3e863c4f8a 100644
--- a/include/drm/bridge/dw_hdmi.h
+++ b/include/drm/bridge/dw_hdmi.h
@@ -156,6 +156,7 @@ void dw_hdmi_setup_rx_sense(struct dw_hdmi *hdmi, bool hpd, bool rx_sense);
 
 void dw_hdmi_set_sample_rate(struct dw_hdmi *hdmi, unsigned int rate);
 void dw_hdmi_set_channel_count(struct dw_hdmi *hdmi, unsigned int cnt);
+void dw_hdmi_set_channel_status(struct dw_hdmi *hdmi, u8 *channel_status);
 void dw_hdmi_set_channel_allocation(struct dw_hdmi *hdmi, unsigned int ca);
 void dw_hdmi_audio_enable(struct dw_hdmi *hdmi);
 void dw_hdmi_audio_disable(struct dw_hdmi *hdmi);
-- 
2.23.0.162.g0b9fbb3734-goog

