Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD85C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EF402190F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="T0XHmH7f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbfGXQYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 12:24:16 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39215 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728749AbfGXQYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 12:24:13 -0400
Received: by mail-wm1-f66.google.com with SMTP id u25so31815946wmc.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 09:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ocUEQSXynTuFhR8u/rePjf3f/sB3eXLVGjV4BtMdyVs=;
        b=T0XHmH7fMTKgxRE+sBpYoKeEOwc7aBtGRsTgi4fQxLrOEfcW0U1YUrrDIw3Rn8GfcX
         lhkdzqNgssqMuQEo4DlEKUn+PqiRDTIY4NzwiQSGNCWQYJT4nWBscmNenvtx/y77qByz
         O8J4L/61kEPly3Vt5mbDYBXjERECUfgji3eBFFbA6oDgkOQBZ8258HWGNKxps1E1ytBc
         yhcCI72ckTJOjSU/9LYbSvhgbXuhl++XmTvK3k18dhhjOxg4/KAzDMeMlj+t7BdxUBl4
         j/DDcIcHQnT2kaq7UbX8BV78x4zpvLXHqdaoHZc5oUhkEUtplY4+LLtmUNuYSRCw2Q2N
         fe6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ocUEQSXynTuFhR8u/rePjf3f/sB3eXLVGjV4BtMdyVs=;
        b=MvlD32upCuzfc3n6Vci8W8jQzOjsYeOBsZOA5DX8DyYUkx24h/LrXnJWrxiFcqvt9p
         CMK34vqFQs7wxvZ/nG6etQpK/eWCtuZyf3AFX2PNtUhqWKDyXEY0NuHPHZSPgEvArTP3
         EuuURSmub22TM7JYLmn4kvUjjdecnlC6BMTvK48oG/mNTRd0ZcLt9jNfEcyxQZMJW63f
         /eutasOWAaiOb/wu3LgcTvAE5a8AAbRyIMY6c+3+saG8MU1Pt6yz9btWGlMr+TyIK+60
         hMAlsgpmu/aB5tGO3bvaVQhJRk3nl90usmvRPM7jPQpZJ11r/RbSOJk3nV5PqfDf/Yke
         ECCA==
X-Gm-Message-State: APjAAAUs18wUklQBH6zUZyLIItsu4cbsty5RPI8ohVLU5nU4U6fy0sBF
        ynUgEYFKsfdkmqkUmGMa59/Idg==
X-Google-Smtp-Source: APXvYqz5KeYU3i1H08gJ6KW2smQMst4ZM+01sZk1tJDy733pmW2ILw3I6IwRuTSHXx60lHlH/0OyTA==
X-Received: by 2002:a1c:f409:: with SMTP id z9mr4986239wma.176.1563985450593;
        Wed, 24 Jul 2019 09:24:10 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id f70sm55688960wme.22.2019.07.24.09.24.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 09:24:09 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 1/6] ASoC: codec2codec: run callbacks in order
Date:   Wed, 24 Jul 2019 18:24:00 +0200
Message-Id: <20190724162405.6574-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190724162405.6574-1-jbrunet@baylibre.com>
References: <20190724162405.6574-1-jbrunet@baylibre.com>
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
 sound/soc/soc-dapm.c | 38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 1d04612601ad..5348abda7ce2 100644
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
@@ -3853,7 +3848,24 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 				goto out;
 			}
 			sink->active++;
-			ret = snd_soc_dai_hw_params(sink, &substream, params);
+		}
+
+		substream.stream = SNDRV_PCM_STREAM_CAPTURE;
+		snd_soc_dapm_widget_for_each_source_path(w, path) {
+			source = path->source->priv;
+
+			ret = soc_dai_hw_params(&substream, params, source);
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
+			ret = soc_dai_hw_params(&substream, params, sink);
 			if (ret < 0)
 				goto out;
 
@@ -3889,9 +3901,18 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 		substream.stream = SNDRV_PCM_STREAM_CAPTURE;
 		snd_soc_dapm_widget_for_each_source_path(w, path) {
 			source = path->source->priv;
-
 			snd_soc_dai_hw_free(source, &substream);
+		}
 
+		substream.stream = SNDRV_PCM_STREAM_PLAYBACK;
+		snd_soc_dapm_widget_for_each_sink_path(w, path) {
+			sink = path->sink->priv;
+			snd_soc_dai_hw_free(sink, &substream);
+		}
+
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

