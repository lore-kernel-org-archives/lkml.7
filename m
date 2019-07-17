Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D02C76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 08:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2231521743
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 08:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LWje8Czn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfGQIdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 04:33:44 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36385 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfGQIdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 04:33:44 -0400
Received: by mail-pg1-f195.google.com with SMTP id l21so10809265pgm.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 01:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nWIVAdKLsOhFpm09GAp/Kd9PshsoLswOzSbyeHOTCdU=;
        b=LWje8Czn4fMLg4cGgLHBvyg9dnZfrufxj8s9WFgnCPNKID+WleIhuFtbd3K2fZZGhV
         5nzXOUQna3cI73MjREOCP39GzGjDQdxnjU9Eyl5n2WCiFT9xEu17yezcCeFlsjNtSGq4
         fIIBTjJ3LCGHfl/Olx+UCJpq3POAqZHNq3rw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nWIVAdKLsOhFpm09GAp/Kd9PshsoLswOzSbyeHOTCdU=;
        b=pSyzPqunsu0i8M8M1hnodtzEm7JtYepW8ZusW9xMcuG50ujyZXH5daNzHZz7dnCnfe
         uhKi3H7IS89c0mZo9rwkpWC/5wttSOXX82oavM7opOOO2TJq8d3Vaije/QuIPTo5diD4
         2Dfv8fNdWhX0CVmC3eN300XHoDapujaccvM4ZNL8msU/lyhl6XeaOQdelnCnl6HUjuV+
         YCIyqFOMxRQOEJCZCLSLtYTMurETtcWez/9w5WqL+WC2uX/3oLR9eU/rHCNpOVUI80Ns
         jRwjRwv4gxl53xqFPPB4P5NlNQpak4Ywk0AxR+R9bAlFy6k85kczed30qMGZEcWkvhsc
         luSg==
X-Gm-Message-State: APjAAAUup7qYQkxf0QJ5Q+qu/8V4kMNgB/C3CH/OqG2Ejon3xlSXRlGM
        hxPmHQ2hUY8plalXzJqLaSXCG5Mon38=
X-Google-Smtp-Source: APXvYqxW922CsIcP7GhDMAEb73qrZMeDRGfdqCp/Vphtqp6605sAAq1T/HiWE7RXmKjk3ATv4tYVmg==
X-Received: by 2002:a63:c1c:: with SMTP id b28mr7542105pgl.354.1563352422941;
        Wed, 17 Jul 2019 01:33:42 -0700 (PDT)
Received: from localhost ([2401:fa00:1:b:e688:dfd2:a1a7:2956])
        by smtp.gmail.com with ESMTPSA id f20sm10577301pgg.56.2019.07.17.01.33.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 01:33:42 -0700 (PDT)
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
Subject: [PATCH v5 1/5] ASoC: hdmi-codec: Add an op to set callback function for plug event
Date:   Wed, 17 Jul 2019 16:33:23 +0800
Message-Id: <20190717083327.47646-2-cychiang@chromium.org>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
In-Reply-To: <20190717083327.47646-1-cychiang@chromium.org>
References: <20190717083327.47646-1-cychiang@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an op in hdmi_codec_ops so codec driver can register callback
function to handle plug event.

Driver in DRM can use this callback function to report connector status.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 include/sound/hdmi-codec.h    | 17 +++++++++++++
 sound/soc/codecs/hdmi-codec.c | 46 +++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/include/sound/hdmi-codec.h b/include/sound/hdmi-codec.h
index 7fea496f1f34..83b17682e01c 100644
--- a/include/sound/hdmi-codec.h
+++ b/include/sound/hdmi-codec.h
@@ -47,6 +47,9 @@ struct hdmi_codec_params {
 	int channels;
 };
 
+typedef void (*hdmi_codec_plugged_cb)(struct device *dev,
+				      bool plugged);
+
 struct hdmi_codec_pdata;
 struct hdmi_codec_ops {
 	/*
@@ -88,6 +91,14 @@ struct hdmi_codec_ops {
 	 */
 	int (*get_dai_id)(struct snd_soc_component *comment,
 			  struct device_node *endpoint);
+
+	/*
+	 * Hook callback function to handle connector plug event.
+	 * Optional
+	 */
+	int (*hook_plugged_cb)(struct device *dev, void *data,
+			       hdmi_codec_plugged_cb fn,
+			       struct device *codec_dev);
 };
 
 /* HDMI codec initalization data */
@@ -99,6 +110,12 @@ struct hdmi_codec_pdata {
 	void *data;
 };
 
+struct snd_soc_component;
+struct snd_soc_jack;
+
+int hdmi_codec_set_jack_detect(struct snd_soc_component *component,
+			       struct snd_soc_jack *jack);
+
 #define HDMI_CODEC_DRV_NAME "hdmi-audio-codec"
 
 #endif /* __HDMI_CODEC_H__ */
diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 0bf1c8cad108..b5fd8f08726e 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -7,6 +7,7 @@
 #include <linux/module.h>
 #include <linux/string.h>
 #include <sound/core.h>
+#include <sound/jack.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
@@ -274,6 +275,8 @@ struct hdmi_codec_priv {
 	struct snd_pcm_chmap *chmap_info;
 	unsigned int chmap_idx;
 	struct mutex lock;
+	struct snd_soc_jack *jack;
+	unsigned int jack_status;
 };
 
 static const struct snd_soc_dapm_widget hdmi_widgets[] = {
@@ -663,6 +666,49 @@ static int hdmi_dai_probe(struct snd_soc_dai *dai)
 	return 0;
 }
 
+static void hdmi_codec_jack_report(struct hdmi_codec_priv *hcp,
+				   unsigned int jack_status)
+{
+	if (hcp->jack && jack_status != hcp->jack_status) {
+		snd_soc_jack_report(hcp->jack, jack_status, SND_JACK_LINEOUT);
+		hcp->jack_status = jack_status;
+	}
+}
+
+static void plugged_cb(struct device *dev, bool plugged)
+{
+	struct hdmi_codec_priv *hcp = dev_get_drvdata(dev);
+
+	if (plugged)
+		hdmi_codec_jack_report(hcp, SND_JACK_LINEOUT);
+	else
+		hdmi_codec_jack_report(hcp, 0);
+}
+
+/**
+ * hdmi_codec_set_jack_detect - register HDMI plugged callback
+ * @component: the hdmi-codec instance
+ * @jack: ASoC jack to report (dis)connection events on
+ */
+int hdmi_codec_set_jack_detect(struct snd_soc_component *component,
+			       struct snd_soc_jack *jack)
+{
+	struct hdmi_codec_priv *hcp = snd_soc_component_get_drvdata(component);
+	int ret = -EOPNOTSUPP;
+
+	if (hcp->hcd.ops->hook_plugged_cb) {
+		hcp->jack = jack;
+		ret = hcp->hcd.ops->hook_plugged_cb(component->dev->parent,
+						    hcp->hcd.data,
+						    plugged_cb,
+						    component->dev);
+		if (ret)
+			hcp->jack = NULL;
+	}
+	return ret;
+}
+EXPORT_SYMBOL_GPL(hdmi_codec_set_jack_detect);
+
 static int hdmi_dai_spdif_probe(struct snd_soc_dai *dai)
 {
 	struct hdmi_codec_daifmt *cf = dai->playback_dma_data;
-- 
2.22.0.510.g264f2c817a-goog

