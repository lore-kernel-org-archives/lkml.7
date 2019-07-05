Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC34AC5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 04:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CBC220856
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 04:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nMtfntFD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfGEE0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 00:26:46 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32955 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfGEE0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 00:26:46 -0400
Received: by mail-pf1-f193.google.com with SMTP id x15so3742396pfq.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 21:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+3G7gaXEJuSaVZO7JAbYh3wKp+iQz6Nh9jSGcVM+k6U=;
        b=nMtfntFDTuoSfK9/VFf/q1vvFv3BHdF9zSOETr3vqyb6NzVWs4/fbfev94T09R+aUd
         3vNBcFB033ya7IZyhwEjfeccLxwKb4rNzeYxICCdJ6mDfnK8h5MLTINtR+qH1dqoaGr8
         WFkvrCy91KPXVRYCKm4om3V826Sg44F5rrCGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+3G7gaXEJuSaVZO7JAbYh3wKp+iQz6Nh9jSGcVM+k6U=;
        b=U9Be9Xf4xzJjQfVY9yMz8StnDyCvmqTOUtaAUXmmfBU+5yYnMmc1Dvx1rUCWgHLG1p
         oNXExfoFKlw5G5jhCgKC7qDj93LXAXGCPbZrMkXF4oqXyj1NUFO9gWJU2/UgJjR+YoVM
         bBzGU1yWq6UsxnpUq/Gj2faJdteBgaTJTka1rz2cf9HDy9P3BGrfP6sRViJtrTMoaqCn
         7wQuBkqVXXf0EHq+BWJ4hxuvlazEcUjQxGmMsXEVZrmPXo5cv/eJrRcvd7nj9nMMbxam
         r0N2tRRF4b+lHAb6mIQy14MAPLyEFE6gjkaMCzzsjD0/etMIlfi9i+alaP778V8HN0qA
         uhlg==
X-Gm-Message-State: APjAAAUO4KPWYv4xBXPKss7atEUAc2l/mE9Td+81MwCrAFg2LxoGJPrn
        DyTcE0TUGc1dcBhjICgF1S1YebyBJc0=
X-Google-Smtp-Source: APXvYqxo3SdDzWV2z9ih0ZiNNE3HnS7c3zDkLrVJE1fvL3y0/NYA0aJNny09tyDNEaQonEEmk3XdTw==
X-Received: by 2002:a65:430a:: with SMTP id j10mr2429110pgq.374.1562300804603;
        Thu, 04 Jul 2019 21:26:44 -0700 (PDT)
Received: from localhost ([2401:fa00:1:b:e688:dfd2:a1a7:2956])
        by smtp.gmail.com with ESMTPSA id b29sm17718645pfr.159.2019.07.04.21.26.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jul 2019 21:26:44 -0700 (PDT)
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
Subject: [PATCH 1/4] ASoC: hdmi-codec: Add an op to set callback function for plug event
Date:   Fri,  5 Jul 2019 12:26:20 +0800
Message-Id: <20190705042623.129541-2-cychiang@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190705042623.129541-1-cychiang@chromium.org>
References: <20190705042623.129541-1-cychiang@chromium.org>
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
 include/sound/hdmi-codec.h    | 16 +++++++++++
 sound/soc/codecs/hdmi-codec.c | 52 +++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/include/sound/hdmi-codec.h b/include/sound/hdmi-codec.h
index 7fea496f1f34..26c02abb8eba 100644
--- a/include/sound/hdmi-codec.h
+++ b/include/sound/hdmi-codec.h
@@ -47,6 +47,9 @@ struct hdmi_codec_params {
 	int channels;
 };
 
+typedef void (*hdmi_codec_plugged_cb)(struct platform_device *dev,
+				      bool plugged);
+
 struct hdmi_codec_pdata;
 struct hdmi_codec_ops {
 	/*
@@ -88,6 +91,13 @@ struct hdmi_codec_ops {
 	 */
 	int (*get_dai_id)(struct snd_soc_component *comment,
 			  struct device_node *endpoint);
+
+	/*
+	 * Hook callback function to handle connector plug event.
+	 * Optional
+	 */
+	int (*hook_plugged_cb)(struct device *dev, void *data,
+			       hdmi_codec_plugged_cb fn);
 };
 
 /* HDMI codec initalization data */
@@ -99,6 +109,12 @@ struct hdmi_codec_pdata {
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
index 0bf1c8cad108..5e7075f78c38 100644
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
@@ -663,6 +666,55 @@ static int hdmi_dai_probe(struct snd_soc_dai *dai)
 	return 0;
 }
 
+static void hdmi_codec_jack_report(struct hdmi_codec_priv *hcp,
+				   unsigned int jack_status)
+{
+	if (!hcp->jack)
+		return;
+
+	if (jack_status != hcp->jack_status) {
+		snd_soc_jack_report(hcp->jack, jack_status, SND_JACK_LINEOUT);
+		hcp->jack_status = jack_status;
+	}
+}
+
+static void plugged_cb(struct platform_device *pdev, bool plugged)
+{
+	struct platform_device *codec_pdev = platform_get_drvdata(pdev);
+	struct hdmi_codec_priv *hcp = platform_get_drvdata(codec_pdev);
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
+	int ret;
+
+	if (hcp->hcd.ops->hook_plugged_cb) {
+		hcp->jack = jack;
+		ret = hcp->hcd.ops->hook_plugged_cb(component->dev->parent,
+						    hcp->hcd.data,
+						    plugged_cb);
+		if (ret) {
+			hcp->jack = NULL;
+			return ret;
+		}
+		return 0;
+	}
+	return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL_GPL(hdmi_codec_set_jack_detect);
+
 static int hdmi_dai_spdif_probe(struct snd_soc_dai *dai)
 {
 	struct hdmi_codec_daifmt *cf = dai->playback_dma_data;
-- 
2.22.0.410.gd8fdbe21b5-goog

