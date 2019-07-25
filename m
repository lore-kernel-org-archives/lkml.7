Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7848AC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51A3621851
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="m0yzJqTL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390574AbfGYQ77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:59:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43113 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389777AbfGYQ7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:59:55 -0400
Received: by mail-wr1-f68.google.com with SMTP id p13so51513235wru.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 09:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RjZlNK5foaQOSQzbPfrKvphWkFDjBwZWcqfyFOMILTw=;
        b=m0yzJqTLfQUVO9D+Kp04i0U6B7GihD54VtnGw83R3RZXjnk719z2IdBOI4yHFIO8pg
         BcdA7IFFjKE+VXE5k7AdT6/t48Cn8BgYW1es8YENonXXslAi0vXw0v/7RxiVUZWu40NY
         oxLDlEcPXF18or7K10CjlHkCS2P3s/IbPNxHzqFR//ddxQkc2D7HdacUD4CzQwNnFDmn
         5ceEzOgsjLEtp3yWBOEQKSZCkSGxgNweL34gsO9+3A0vzwlmku1j47Ahvuhn6oVWNEjd
         z7MYMCObi6thyoGQ89GVEUCXW1s2RSyuvrGM86imrJQ+cKvmVgt5WggZfZAcsq50cfon
         uJfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RjZlNK5foaQOSQzbPfrKvphWkFDjBwZWcqfyFOMILTw=;
        b=FQ2yCNYDh1EvRX1Ayz+9WpFiItZU8TjgcbBD2xgVrb8zkMw5r3MnCYQ5o2BUW2mqyB
         Rz1Q24N5AABL67nazFLdaqDeB511cIot0z0v0NONUn42sgBjhurpL5J31S04rn2hqQl0
         sQxGv+kfTHLbdXZKv/hqI4NsSWqY4qlWcP1x6q3m0+XjAOG5r2eQeJZd5TxmN2mUbgOW
         hvXquwjCxGDog+uuLfj7GnK/w6nRYpoSrJknOZuvTGK9MagP61MvlM1IHMPgz+Dk/LwI
         GhjW8D/LfTcV+1kUZ47bvbnTCwqCJcpOkhYTLGJxKXULBnkEPMIlvMbHHHUmWl38VXaB
         oNeg==
X-Gm-Message-State: APjAAAViPycuc/jMFWMU7wXo49gPyazTvm1y1p2P4QrDAgMXKojUAKz7
        D6dWECbZssArsAF1+sKejKVBIQ==
X-Google-Smtp-Source: APXvYqzkZIFz+KVxgJBu1r3Q+ftdDRhPRxm5CuaClhVaUFvnLzyoMd84/wr8z2QjCOwDlYK0tfyViw==
X-Received: by 2002:adf:eb51:: with SMTP id u17mr3481607wrn.257.1564073993318;
        Thu, 25 Jul 2019 09:59:53 -0700 (PDT)
Received: from starbuck.baylibre.local (uluru.liltaz.com. [163.172.81.188])
        by smtp.googlemail.com with ESMTPSA id q10sm53627199wrf.32.2019.07.25.09.59.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 09:59:52 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v2 1/6] ASoC: codec2codec: run callbacks in order
Date:   Thu, 25 Jul 2019 18:59:44 +0200
Message-Id: <20190725165949.29699-2-jbrunet@baylibre.com>
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

When handling dai_link events on codec to codec links, run all .startup()
callbacks on sinks and sources before running any .hw_params(). Same goes
for hw_free() and shutdown(). This is closer to the behavior of regular
dai links

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/soc-dapm.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 1d04612601ad..034b31fd2ecb 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3835,11 +3835,6 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 				goto out;
 			}
 			source->active++;
-			ret = snd_soc_dai_hw_params(source, &substream, params);
-			if (ret < 0)
-				goto out;
-
-			dapm_update_dai_unlocked(&substream, params, source);
 		}
 
 		substream.stream = SNDRV_PCM_STREAM_PLAYBACK;
@@ -3853,6 +3848,23 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 				goto out;
 			}
 			sink->active++;
+		}
+
+		substream.stream = SNDRV_PCM_STREAM_CAPTURE;
+		snd_soc_dapm_widget_for_each_source_path(w, path) {
+			source = path->source->priv;
+
+			ret = snd_soc_dai_hw_params(source, &substream, params);
+			if (ret < 0)
+				goto out;
+
+			dapm_update_dai_unlocked(&substream, params, source);
+		}
+
+		substream.stream = SNDRV_PCM_STREAM_PLAYBACK;
+		snd_soc_dapm_widget_for_each_sink_path(w, path) {
+			sink = path->sink->priv;
+
 			ret = snd_soc_dai_hw_params(sink, &substream, params);
 			if (ret < 0)
 				goto out;
@@ -3889,9 +3901,18 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 		substream.stream = SNDRV_PCM_STREAM_CAPTURE;
 		snd_soc_dapm_widget_for_each_source_path(w, path) {
 			source = path->source->priv;
-
 			snd_soc_dai_hw_free(source, &substream);
+		}
+
+		substream.stream = SNDRV_PCM_STREAM_PLAYBACK;
+		snd_soc_dapm_widget_for_each_sink_path(w, path) {
+			sink = path->sink->priv;
+			snd_soc_dai_hw_free(sink, &substream);
+		}
 
+		substream.stream = SNDRV_PCM_STREAM_CAPTURE;
+		snd_soc_dapm_widget_for_each_source_path(w, path) {
+			source = path->source->priv;
 			source->active--;
 			snd_soc_dai_shutdown(source, &substream);
 		}
@@ -3899,9 +3920,6 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 		substream.stream = SNDRV_PCM_STREAM_PLAYBACK;
 		snd_soc_dapm_widget_for_each_sink_path(w, path) {
 			sink = path->sink->priv;
-
-			snd_soc_dai_hw_free(sink, &substream);
-
 			sink->active--;
 			snd_soc_dai_shutdown(sink, &substream);
 		}
-- 
2.21.0

