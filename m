Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67612C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 408A821871
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="PPUpu2Uk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbfGXQYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 12:24:18 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33504 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728766AbfGXQYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 12:24:13 -0400
Received: by mail-wm1-f65.google.com with SMTP id h19so33829681wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 09:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Npvt6BnLoRE+ITNaKiuWjMdj+Jqxi0Z7NGG0xDY8eZY=;
        b=PPUpu2UkVrvoFD58jMMOxwF8SwBcLWeMm6AdGHu32jkbpMAD7Eg35djpLxCBi2fMDx
         0CxgU2P1kCEHKkMn4Elyn5ujwm+PeMd5CTF6eojwwGsHXP/nL1EgGvFdUZkSoRs+Bp96
         MJMh/rpOXNtt8dBM2uXRtqixTB9f3Tb6SH+Ece61kAKLtRkjJbWWEpr6s2ux2PaxDuD9
         Ea0i5p5nEreZOyRnnnuE4yReUMaDmvpktXnpAlZh38dcRK5DBm0tFgNZMijZkSebyinJ
         HkKCoSQfh9IXQEQn1eJ+qGqfov17Vww7kyvlbGqMUjXDEWdm4dIRP/IUI265UeYG4cEH
         79YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Npvt6BnLoRE+ITNaKiuWjMdj+Jqxi0Z7NGG0xDY8eZY=;
        b=ptoRi8kbDTZZwpTvOU6SMrDa5UJyXEKpoajS+Op9nEIMr0i5Td6f8VMjMJpA2AU0nr
         nQWNfSyWFFkuMmf+HBYEv/hRqfI7/4pHEUZVdilmwoqrdIlKHmLJ4u7DWjFbUa5G3CiP
         XTQgD8ubJDAuFo8SXQvBgms7tOB55Y/40rVZC5mUWSL8EVf+redD0xW0i2FtX+yned8p
         v9w+sqNsSP3Cz4sQk+askurkYyh90HV+PFBK5cqumAHHfjft4rG0pzBwbIPyhCCQLnHs
         IPBwo3a4vxGmY1edsmWg8z6JnOgtZl6E9dcRxul6wz6WBMGKQvNRth+qszsxOTjof6SF
         vVGg==
X-Gm-Message-State: APjAAAWgAsJlkLKRGxloWQJ5N2a50YZiSHz4rJvFOMhDbDqjnyvVtaVY
        iVEXwdxS+Wftd06E0baUrQMCMg==
X-Google-Smtp-Source: APXvYqxbB0+hlRjwpVSHseapZwEaI2p3LvGV7HWs+1hzOz2F2kLsTMcPSZVa4XmP+b9EpqBLQ2BEMw==
X-Received: by 2002:a1c:a101:: with SMTP id k1mr76948104wme.98.1563985451734;
        Wed, 24 Jul 2019 09:24:11 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id f70sm55688960wme.22.2019.07.24.09.24.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 09:24:11 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 2/6] ASoC: codec2codec: name link using stream direction
Date:   Wed, 24 Jul 2019 18:24:01 +0200
Message-Id: <20190724162405.6574-3-jbrunet@baylibre.com>
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
index 5348abda7ce2..d20cd89513a4 100644
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

