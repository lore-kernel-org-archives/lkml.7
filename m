Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39501C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C61122C7C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qxL/QDJI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391089AbfGYRAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 13:00:25 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39311 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389267AbfGYQ74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:59:56 -0400
Received: by mail-wr1-f67.google.com with SMTP id x4so51500133wrt.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 09:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g/jrkR4hgpIY3IEk8lJ9coIWHj6BT0CIAMNbTJmR/YI=;
        b=qxL/QDJIp2o63X7xJzs9kR9eme+RY19oKFA3sv/4jACT3uZA7tM5wT5OVmqIkqJew7
         WkqaQHmP0EA4kIgwJ8tyjckEtbj4eRa0Yo1eFaR9a98Vf9UbymNWtQyHOpHsaW0TTHJb
         ko5LcV6CzamQgg2zO1BYZqrsJ1eJySWMDHh+rTl3OKYYhujCq4X/GeadawMabL5g7lKj
         50TQrfD1m5zsXD4TuNxjO+hJrsnkS8RyeHTCyemcFY4KotA8JLsymTHntcp5UXe7zPka
         XHp6dYizSOtMgWuIMfLptctCbjrHIGXCGfEFznNSPNbwxNJxBxzW/h8e7Frm+1OCPiGN
         Uuug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g/jrkR4hgpIY3IEk8lJ9coIWHj6BT0CIAMNbTJmR/YI=;
        b=KOrTGAYs0xz1ug7p+Y5xHCOCvaMTlvceOgwl8cnx7e7rLwZ9HQjT5u0cO6+X+n5MIO
         F0qU/ZUN9A/6NhOTLCfv+KhVYdmvQn6gnGC9eWIDG0TmSYXPE9cSZGZzcnTvZoEBr/Hq
         ALe+vKPG0p2+mquJZZ6SNDPyQAXoqPjmmfc8pzisTlNgg92qsCZ+KT8+KyXzKwg8vAYB
         LzHnpqKwIYuQS+xlsiMeaAaK4vMJHj4lr4IsfJKqgJxBZKcZpubmM8TF+tEv2Dm/BX/J
         IiZAZ4mOs9TJfYnp9y+mOakBB6Ka2a1W1/Q3dxQd2kJud2HhI1pSJrEfXNyI/7hR7sNc
         PMmg==
X-Gm-Message-State: APjAAAUAncj3gUyrrscwdgIqDouM5hjeY4RzDkJPwgWQRw1rOl+1Fzn7
        NX3fg366Kl39JcHgTEAHFcWWojbU9x0=
X-Google-Smtp-Source: APXvYqzpTVvhh/KLIlDh7egDJKaGFgaz2cliKjsP5Ce7avkqYayCPiWNr+RETi3mzno+aLH8mp+cjQ==
X-Received: by 2002:adf:f84a:: with SMTP id d10mr89216078wrq.319.1564073994390;
        Thu, 25 Jul 2019 09:59:54 -0700 (PDT)
Received: from starbuck.baylibre.local (uluru.liltaz.com. [163.172.81.188])
        by smtp.googlemail.com with ESMTPSA id q10sm53627199wrf.32.2019.07.25.09.59.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 09:59:53 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v2 2/6] ASoC: codec2codec: name link using stream direction
Date:   Thu, 25 Jul 2019 18:59:45 +0200
Message-Id: <20190725165949.29699-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190725165949.29699-1-jbrunet@baylibre.com>
References: <20190725165949.29699-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment, codec to codec dai link widgets are named after the
cpu dai and the 1st codec valid on the link. This might be confusing
if there is multiple valid codecs on the link for one stream
direction.

Instead, use the dai link name and the stream direction to name the
the dai link widget

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/soc-dapm.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 034b31fd2ecb..7db4abd9a0a5 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -4056,8 +4056,7 @@ snd_soc_dapm_alloc_kcontrol(struct snd_soc_card *card,
 
 static struct snd_soc_dapm_widget *
 snd_soc_dapm_new_dai(struct snd_soc_card *card, struct snd_soc_pcm_runtime *rtd,
-		     struct snd_soc_dapm_widget *source,
-		     struct snd_soc_dapm_widget *sink)
+		     char *id)
 {
 	struct snd_soc_dapm_widget template;
 	struct snd_soc_dapm_widget *w;
@@ -4067,7 +4066,7 @@ snd_soc_dapm_new_dai(struct snd_soc_card *card, struct snd_soc_pcm_runtime *rtd,
 	int ret;
 
 	link_name = devm_kasprintf(card->dev, GFP_KERNEL, "%s-%s",
-				   source->name, sink->name);
+				   rtd->dai_link->name, id);
 	if (!link_name)
 		return ERR_PTR(-ENOMEM);
 
@@ -4247,15 +4246,13 @@ static void dapm_connect_dai_link_widgets(struct snd_soc_card *card,
 	}
 
 	for_each_rtd_codec_dai(rtd, i, codec_dai) {
-
 		/* connect BE DAI playback if widgets are valid */
 		codec = codec_dai->playback_widget;
 
 		if (playback_cpu && codec) {
 			if (!playback) {
 				playback = snd_soc_dapm_new_dai(card, rtd,
-								playback_cpu,
-								codec);
+								"playback");
 				if (IS_ERR(playback)) {
 					dev_err(rtd->dev,
 						"ASoC: Failed to create DAI %s: %ld\n",
@@ -4284,8 +4281,7 @@ static void dapm_connect_dai_link_widgets(struct snd_soc_card *card,
 		if (codec && capture_cpu) {
 			if (!capture) {
 				capture = snd_soc_dapm_new_dai(card, rtd,
-							       codec,
-							       capture_cpu);
+							       "capture");
 				if (IS_ERR(capture)) {
 					dev_err(rtd->dev,
 						"ASoC: Failed to create DAI %s: %ld\n",
-- 
2.21.0

