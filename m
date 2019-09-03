Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2E4C3A5A5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 05:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A25C12173E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 05:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K51UO9D1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfICFvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 01:51:13 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42977 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbfICFvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 01:51:13 -0400
Received: by mail-pf1-f195.google.com with SMTP id w22so1627814pfi.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 22:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TkPI7O1fVqnq6R/nJ+Pnt20RhQ4GXULllM+CXg8v034=;
        b=K51UO9D1aK3b/3+8I8RJfUnmD0e4/8iXNOPu94gB7YnCEMvStQ4ALdBjUCj5CQCsNK
         A1DXvkowreIHI/5gRRYxx9ZT8oZJq7skjn5YAvwNNDBhdy2b+89gjVkJPFxELRiAGCpH
         Er4/qOP3ASoq2/XBObfI2FaPdQjTHx5bnKmU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TkPI7O1fVqnq6R/nJ+Pnt20RhQ4GXULllM+CXg8v034=;
        b=SJ72jR3FCXBViBY0TIXbmHNU3flxACbRCkJv0YgVQTgEZKsGQVLNXMuhSkXg/Aw3MZ
         7+LEPZrveTgF8+ogO9EQlYPi6oD32xJbDUKT6eZAVgWfMq2XveyAmvymBPPV5i83AodG
         atZ+sRmRLNvBgifdrvLjLWSADLdQGZIcPPvUdiCsWT/Fm7GQ9olaWWbea71DvwMmtw9I
         6kAdgboLl47/W7vdE2PfJXntXp82XZKAAnBFAdjMA9nhbQZyxBLzqBXEzkd/bzBB6cH3
         9q6oyjJnAhN1JpAKaFzgZv9UiXjpw1H665yfyPsGIQ6iZmjQd7qWb4Jjn7wYCVlBnzUO
         hHMA==
X-Gm-Message-State: APjAAAXdjLvT3kZ8sDOL33nWnkwcMMyT+0AJoVsrO+M26B0U9moUTnXP
        ht5YI8K5x3bTqcoDu6Usmwi/PkE8zIY=
X-Google-Smtp-Source: APXvYqy+o0Y8D6HEyRM06kw7O9+KYZ0JH6HO+T0Xt4tKvQ5MDBFAx9QHtwodeC4EErYbNCsjkWMd+g==
X-Received: by 2002:a63:2a08:: with SMTP id q8mr28160269pgq.415.1567489872170;
        Mon, 02 Sep 2019 22:51:12 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:79b4:bd83:e4a5:a720])
        by smtp.gmail.com with ESMTPSA id g24sm6508687pfo.178.2019.09.02.22.51.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2019 22:51:11 -0700 (PDT)
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
        dri-devel@lists.freedesktop.org, Yakir Yang <ykk@rock-chips.com>
Subject: [PATCH] drm: bridge/dw_hdmi: add audio sample channel status setting
Date:   Tue,  3 Sep 2019 13:51:03 +0800
Message-Id: <20190903055103.134764-1-cychiang@chromium.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yakir Yang <ykk@rock-chips.com>

When transmitting IEC60985 linear PCM audio, we configure the
Audio Sample Channel Status information of all the channel
status bits in the IEC60958 frame.
Refer to 60958-3 page 10 for frequency, original frequency, and
wordlength setting.

This fix the issue that audio does not come out on some monitors
(e.g. LG 22CV241)

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 59 +++++++++++++++++++++++
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.h | 20 ++++++++
 2 files changed, 79 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index bd65d0479683..34d46e25d610 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -582,6 +582,63 @@ static unsigned int hdmi_compute_n(unsigned int freq, unsigned long pixel_clk)
 	return n;
 }
 
+static void hdmi_set_schnl(struct dw_hdmi *hdmi)
+{
+	u8 aud_schnl_samplerate;
+	u8 aud_schnl_8;
+
+	/* These registers are on RK3288 using version 2.0a. */
+	if (hdmi->version != 0x200a)
+		return;
+
+	switch (hdmi->sample_rate) {
+	case 32000:
+		aud_schnl_samplerate = HDMI_FC_AUDSCHNLS7_SMPRATE_32K;
+		break;
+	case 44100:
+		aud_schnl_samplerate = HDMI_FC_AUDSCHNLS7_SMPRATE_44K1;
+		break;
+	case 48000:
+		aud_schnl_samplerate = HDMI_FC_AUDSCHNLS7_SMPRATE_48K;
+		break;
+	case 88200:
+		aud_schnl_samplerate = HDMI_FC_AUDSCHNLS7_SMPRATE_88K2;
+		break;
+	case 96000:
+		aud_schnl_samplerate = HDMI_FC_AUDSCHNLS7_SMPRATE_96K;
+		break;
+	case 176400:
+		aud_schnl_samplerate = HDMI_FC_AUDSCHNLS7_SMPRATE_176K4;
+		break;
+	case 192000:
+		aud_schnl_samplerate = HDMI_FC_AUDSCHNLS7_SMPRATE_192K;
+		break;
+	case 768000:
+		aud_schnl_samplerate = HDMI_FC_AUDSCHNLS7_SMPRATE_768K;
+		break;
+	default:
+		dev_warn(hdmi->dev, "Unsupported audio sample rate (%u)\n",
+			 hdmi->sample_rate);
+		return;
+	}
+
+	/* set channel status register */
+	hdmi_modb(hdmi, aud_schnl_samplerate, HDMI_FC_AUDSCHNLS7_SMPRATE_MASK,
+		  HDMI_FC_AUDSCHNLS7);
+
+	/*
+	 * Set original frequency to be the same as frequency.
+	 * Use one-complement value as stated in IEC60958-3 page 13.
+	 */
+	aud_schnl_8 = (~aud_schnl_samplerate) <<
+			HDMI_FC_AUDSCHNLS8_ORIGSAMPFREQ_OFFSET;
+
+	/* This means word length is 16 bit. Refer to IEC60958-3 page 12. */
+	aud_schnl_8 |= 2 << HDMI_FC_AUDSCHNLS8_WORDLEGNTH_OFFSET;
+
+	hdmi_writeb(hdmi, aud_schnl_8, HDMI_FC_AUDSCHNLS8);
+}
+
 static void hdmi_set_clk_regenerator(struct dw_hdmi *hdmi,
 	unsigned long pixel_clk, unsigned int sample_rate)
 {
@@ -620,6 +677,8 @@ static void hdmi_set_clk_regenerator(struct dw_hdmi *hdmi,
 	hdmi->audio_cts = cts;
 	hdmi_set_cts_n(hdmi, cts, hdmi->audio_enable ? n : 0);
 	spin_unlock_irq(&hdmi->audio_lock);
+
+	hdmi_set_schnl(hdmi);
 }
 
 static void hdmi_init_clk_regenerator(struct dw_hdmi *hdmi)
diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
index 6988f12d89d9..619ebc1c8354 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.h
@@ -158,6 +158,17 @@
 #define HDMI_FC_SPDDEVICEINF                    0x1062
 #define HDMI_FC_AUDSCONF                        0x1063
 #define HDMI_FC_AUDSSTAT                        0x1064
+#define HDMI_FC_AUDSV                           0x1065
+#define HDMI_FC_AUDSU                           0x1066
+#define HDMI_FC_AUDSCHNLS0                      0x1067
+#define HDMI_FC_AUDSCHNLS1                      0x1068
+#define HDMI_FC_AUDSCHNLS2                      0x1069
+#define HDMI_FC_AUDSCHNLS3                      0x106a
+#define HDMI_FC_AUDSCHNLS4                      0x106b
+#define HDMI_FC_AUDSCHNLS5                      0x106c
+#define HDMI_FC_AUDSCHNLS6                      0x106d
+#define HDMI_FC_AUDSCHNLS7                      0x106e
+#define HDMI_FC_AUDSCHNLS8                      0x106f
 #define HDMI_FC_DATACH0FILL                     0x1070
 #define HDMI_FC_DATACH1FILL                     0x1071
 #define HDMI_FC_DATACH2FILL                     0x1072
@@ -706,6 +717,15 @@ enum {
 /* HDMI_FC_AUDSCHNLS7 field values */
 	HDMI_FC_AUDSCHNLS7_ACCURACY_OFFSET = 4,
 	HDMI_FC_AUDSCHNLS7_ACCURACY_MASK = 0x30,
+	HDMI_FC_AUDSCHNLS7_SMPRATE_MASK = 0x0f,
+	HDMI_FC_AUDSCHNLS7_SMPRATE_192K = 0xe,
+	HDMI_FC_AUDSCHNLS7_SMPRATE_176K4 = 0xc,
+	HDMI_FC_AUDSCHNLS7_SMPRATE_96K = 0xa,
+	HDMI_FC_AUDSCHNLS7_SMPRATE_768K = 0x9,
+	HDMI_FC_AUDSCHNLS7_SMPRATE_88K2 = 0x8,
+	HDMI_FC_AUDSCHNLS7_SMPRATE_32K = 0x3,
+	HDMI_FC_AUDSCHNLS7_SMPRATE_48K = 0x2,
+	HDMI_FC_AUDSCHNLS7_SMPRATE_44K1 = 0x0,
 
 /* HDMI_FC_AUDSCHNLS8 field values */
 	HDMI_FC_AUDSCHNLS8_ORIGSAMPFREQ_MASK = 0xf0,
-- 
2.23.0.187.g17f5b7556c-goog

