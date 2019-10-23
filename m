Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BAECA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8160A222CE
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="gMwNNbwH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407080AbfJWQMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 12:12:14 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54253 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404582AbfJWQMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 12:12:13 -0400
Received: by mail-wm1-f67.google.com with SMTP id i13so6647259wmd.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 09:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=94Fa0onmL8QGae72SEYXHjiLUCmbUKrPJtMdClFuS2o=;
        b=gMwNNbwHenujY7v/kJuQKntVQAWnsbgfL4M3WoHGC6pm2MKHeb8jdd5TIQPe7JlCEn
         uLskMNAA5vwIZaPVvT+qBK5AsvgbCLhqhL48s/ZapNXG9WwgIE+cc2XRKyithM4kw/jH
         Qruk2iiXGFqF20V1T4d/BOF0PgCnBhF3LJns6TBGWi1xj5grk+i1ooWWkhLoo5/Wz7pe
         3XjE2ouDUWRZA+ta1vLrkivCI2ABovlbJFO1Qv/iAYAmM6JVdwkSIr8EteFdFU85B8Rl
         tpbxiXX4+Z0HHikclQzwKJ6xrA7NEGwogl85KmN9OWjh9q4Yzt2Zrl/LMmNPt7pI1evZ
         NPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=94Fa0onmL8QGae72SEYXHjiLUCmbUKrPJtMdClFuS2o=;
        b=s5MDeRnEVy8N2tuwr68JzT0YJkHTHzsooOXMa0KtTMqRnXbK2kDpFc8DJfeE3hEb9f
         hZqIkovpUsO7e4mE+fBF011cnjzEaMjsd6jVe1GWlGBCj8QVsX5xTcYnSd0s3Ze+4Sy1
         oNQ+5yqqdaPBl8dtG28mpWjPqAc52rmQ+RdZ/D5aIxd8S9igLge9fELEIy3/uzWf6tMX
         j7rtzZPFgujEoA89UN7mDNmw6nWzLkUgJT3qsFTTgE8N+jhKoDseMcSikP3ZBaN+KiRC
         H4PxNOJ5uqNjAZXMWXTvb/YA36oJJabkR3ZaT/e0Bikzalu479BN3tBW+Qvagl5W7we6
         K72Q==
X-Gm-Message-State: APjAAAWphIUW7aaUSKn7hkHkdspy51ZVLyRCI8vxOVqPDZMZAjVryiqW
        wk7+18Kknnmb67UAVi3gDYXFaQ==
X-Google-Smtp-Source: APXvYqzMAmLwNI3p00bA5kimGrraRfnNgjr+Zbn8mCCG731Bi76QA7o5giekrbQp+R2MiBkIwKlWvg==
X-Received: by 2002:a1c:544e:: with SMTP id p14mr621282wmi.17.1571847132157;
        Wed, 23 Oct 2019 09:12:12 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id x7sm30240578wrg.63.2019.10.23.09.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 09:12:11 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 1/2] Revert "ASoC: hdmi-codec: re-introduce mutex locking"
Date:   Wed, 23 Oct 2019 18:12:02 +0200
Message-Id: <20191023161203.28955-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191023161203.28955-1-jbrunet@baylibre.com>
References: <20191023161203.28955-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit eb1ecadb7f67dde94ef0efd3ddaed5cb6c9a65ed.

This fixes the following warning reported by lockdep and a potential
issue with hibernation

====================================
WARNING: pulseaudio/1297 still has locks held!
5.3.0+ #1826 Not tainted
------------------------------------
1 lock held by pulseaudio/1297:
 #0: ee815308 (&hcp->lock){....}, at: hdmi_codec_startup+0x20/0x130

stack backtrace:
CPU: 0 PID: 1297 Comm: pulseaudio Not tainted 5.3.0+ #1826
Hardware name: Marvell Dove (Cubox)
[<c0017b4c>] (unwind_backtrace) from [<c0014d10>] (show_stack+0x10/0x14)
[<c0014d10>] (show_stack) from [<c00a2d18>] (futex_wait_queue_me+0x13c/0x19c)
[<c00a2d18>] (futex_wait_queue_me) from [<c00a3630>] (futex_wait+0x184/0x24c)
[<c00a3630>] (futex_wait) from [<c00a5e1c>] (do_futex+0x334/0x598)
[<c00a5e1c>] (do_futex) from [<c00a62e8>] (sys_futex_time32+0x118/0x180)
[<c00a62e8>] (sys_futex_time32) from [<c0009000>] (ret_fast_syscall+0x0/0x54)
Exception stack(0xebd31fa8 to 0xebd31ff0)
1fa0:                   00000000 ffffffff 000c8748 00000189 00000001 00000000
1fc0: 00000000 ffffffff 00000000 000000f0 00000000 00000000 00000000 00056200
1fe0: 000000f0 beac03a8 b6d6c835 b6d6f456

Fixes: eb1ecadb7f67 ("ASoC: hdmi-codec: re-introduce mutex locking")
Reported-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/codecs/hdmi-codec.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index b5fd8f08726e..f8b5b960e597 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -274,7 +274,7 @@ struct hdmi_codec_priv {
 	uint8_t eld[MAX_ELD_BYTES];
 	struct snd_pcm_chmap *chmap_info;
 	unsigned int chmap_idx;
-	struct mutex lock;
+	unsigned long busy;
 	struct snd_soc_jack *jack;
 	unsigned int jack_status;
 };
@@ -390,8 +390,8 @@ static int hdmi_codec_startup(struct snd_pcm_substream *substream,
 	struct hdmi_codec_priv *hcp = snd_soc_dai_get_drvdata(dai);
 	int ret = 0;
 
-	ret = mutex_trylock(&hcp->lock);
-	if (!ret) {
+	ret = test_and_set_bit(0, &hcp->busy);
+	if (ret) {
 		dev_err(dai->dev, "Only one simultaneous stream supported!\n");
 		return -EINVAL;
 	}
@@ -419,7 +419,7 @@ static int hdmi_codec_startup(struct snd_pcm_substream *substream,
 
 err:
 	/* Release the exclusive lock on error */
-	mutex_unlock(&hcp->lock);
+	clear_bit(0, &hcp->busy);
 	return ret;
 }
 
@@ -431,7 +431,7 @@ static void hdmi_codec_shutdown(struct snd_pcm_substream *substream,
 	hcp->chmap_idx = HDMI_CODEC_CHMAP_IDX_UNKNOWN;
 	hcp->hcd.ops->audio_shutdown(dai->dev->parent, hcp->hcd.data);
 
-	mutex_unlock(&hcp->lock);
+	clear_bit(0, &hcp->busy);
 }
 
 static int hdmi_codec_hw_params(struct snd_pcm_substream *substream,
@@ -811,8 +811,6 @@ static int hdmi_codec_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	hcp->hcd = *hcd;
-	mutex_init(&hcp->lock);
-
 	daidrv = devm_kcalloc(dev, dai_count, sizeof(*daidrv), GFP_KERNEL);
 	if (!daidrv)
 		return -ENOMEM;
-- 
2.21.0

