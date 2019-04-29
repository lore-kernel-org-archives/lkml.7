Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3050C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 13:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF7E3215EA
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 13:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="meqj0rsJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbfD2NaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 09:30:05 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51753 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbfD2N3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 09:29:55 -0400
Received: by mail-wm1-f66.google.com with SMTP id 4so14104900wmf.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 06:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c2Ly6nFnbTUuYqirG7Hg6dg1zRcYgFT1GAPuXl6J8C8=;
        b=meqj0rsJv5rfBIShZLQunnMvrc8ItTEICy2+kAclCNP4u/MykXbVjfGB2rZlt3+NG8
         0kXXs/AjAOB2zWPpqduLNYKK4WD+nT7H86fGbdVPXEA3IBi/rPUQSOWSWFGHXIpJw3gS
         VpwnuOvEyHRtvq17hw0O0lylYaxZV0eRkY2PknHzpbM8+q2P5biZpCQkFjQWcHzi4zhL
         CC1/4GTBYQwp/l4GSLsrOss2g/4OaEOEYetdNnJa3KWknO88apc6PrwVP0C816M4Gniz
         Qm+xY1TJ17Kqn7M9V0EIOYMQrG6u9ijK54KnoLq+iXPVWBf2904tvI2g/pqxJwkDa1eh
         KYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c2Ly6nFnbTUuYqirG7Hg6dg1zRcYgFT1GAPuXl6J8C8=;
        b=fjcSlA2GSEZLQKnr9KUR95NoRbSQEFF1Ab1C/x55PzCRH9n+0UmqG1KvsMkFpAnPAS
         35gTsqsDxd8quDZpBKXoo1PaG224SYYLByOrsFEPE14oCcNqqhZqls+Nq1ZcMBdqPixy
         /CRdASUlpT+pXn/8E9hNxUxukqr0pqUqtBbbj40fq1mYXkDpZyTv1oPl0yKbb4qUg7CG
         zOBUgbhSdMfpn0/NMhC11VBV+h59fP6N00B/QSHTDbhV5gia+DW9qhx96/NOZteA8w5m
         FOoECqyBUJYmjtJw586sosgR3RpjMS0APV63ihNhDmS9BHprDId5rWLRgm61RD825FtB
         Mqvw==
X-Gm-Message-State: APjAAAVTeOKJ5JdhpYWIh5UvREDXF7F2TJ9LvBLYtIcfzoNwVIXc2csx
        Ezyz2GviVV5S6fxH7H3Yrfum7w==
X-Google-Smtp-Source: APXvYqyFKnuadadxSREMNcWSC4Shu/wM2PVEDGkr9qobVHvnCB63myFUBW77jIIhHazK18HxgyS2nw==
X-Received: by 2002:a05:600c:204d:: with SMTP id p13mr2263305wmg.53.1556544593778;
        Mon, 29 Apr 2019 06:29:53 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id s17sm2857593wra.94.2019.04.29.06.29.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 06:29:53 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
Subject: [PATCH 5/6] ASoC: hdmi-codec: remove reference to the dai drivers in the private data
Date:   Mon, 29 Apr 2019 15:29:42 +0200
Message-Id: <20190429132943.16269-6-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190429132943.16269-1-jbrunet@baylibre.com>
References: <20190429132943.16269-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keeping the a pointer to the dai drivers is not necessary. It is not used
by the hdmi_codec after the probe.

Even if it was used, the 'struct snd_soc_dai_driver' can accessed through
the 'struct snd_soc_dai' so keeping the pointer in the private data
structure is not useful.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/codecs/hdmi-codec.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 717d0949f8b4..bcc2e5c3bf43 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -278,7 +278,6 @@ static const struct hdmi_codec_cea_spk_alloc hdmi_codec_channel_alloc[] = {
 
 struct hdmi_codec_priv {
 	struct hdmi_codec_pdata hcd;
-	struct snd_soc_dai_driver *daidrv;
 	struct hdmi_codec_daifmt daifmt[2];
 	uint8_t eld[MAX_ELD_BYTES];
 	struct snd_pcm_chmap *chmap_info;
@@ -720,6 +719,7 @@ static const struct snd_soc_component_driver hdmi_driver = {
 static int hdmi_codec_probe(struct platform_device *pdev)
 {
 	struct hdmi_codec_pdata *hcd = pdev->dev.platform_data;
+	struct snd_soc_dai_driver *daidrv;
 	struct device *dev = &pdev->dev;
 	struct hdmi_codec_priv *hcp;
 	int dai_count, i = 0;
@@ -742,25 +742,23 @@ static int hdmi_codec_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	hcp->hcd = *hcd;
-	hcp->daidrv = devm_kcalloc(dev, dai_count, sizeof(*hcp->daidrv),
-				   GFP_KERNEL);
-	if (!hcp->daidrv)
+	daidrv = devm_kcalloc(dev, dai_count, sizeof(*daidrv), GFP_KERNEL);
+	if (!daidrv)
 		return -ENOMEM;
 
 	if (hcd->i2s) {
-		hcp->daidrv[i] = hdmi_i2s_dai;
-		hcp->daidrv[i].playback.channels_max =
-			hcd->max_i2s_channels;
+		daidrv[i] = hdmi_i2s_dai;
+		daidrv[i].playback.channels_max = hcd->max_i2s_channels;
 		i++;
 	}
 
 	if (hcd->spdif)
-		hcp->daidrv[i] = hdmi_spdif_dai;
+		daidrv[i] = hdmi_spdif_dai;
 
 	dev_set_drvdata(dev, hcp);
 
-	ret = devm_snd_soc_register_component(dev, &hdmi_driver, hcp->daidrv,
-				     dai_count);
+	ret = devm_snd_soc_register_component(dev, &hdmi_driver, daidrv,
+					      dai_count);
 	if (ret) {
 		dev_err(dev, "%s: snd_soc_register_component() failed (%d)\n",
 			__func__, ret);
-- 
2.20.1

