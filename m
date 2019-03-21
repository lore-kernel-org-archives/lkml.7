Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF91FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D16021917
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b="BbLV4RLD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfCUWQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 18:16:09 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44981 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbfCUWQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 18:16:04 -0400
Received: by mail-qt1-f194.google.com with SMTP id w5so397105qtb.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 15:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s0UWPcv45YDJ6fJXV9UJPLaAr8ooymlKhZRtGYGNJeo=;
        b=BbLV4RLDEgeW1nsgRPdI4SPa4CMGxHfMuiWXTrUBqLRmCiu6LqWifE2Vg1o1Ki+1dQ
         by4xgp1XPXOcnYrrdkmYHSVqr2TFknVsj+FBTHbActaJCF4yUj/gHyutOEH7ffkHdqBX
         x2aafF/qj06QVstJAyv2zFdiqYc8M3BHH4JzMUa5jV21XSoagrLgEnbvBxn8sOea/KxQ
         B/9csYbxa1eG0U40KRmCsBAKfBv9kv/NGMMO+nVuHD9RkCr2amWCL6DRNKD4MfSj1okd
         DCi69EylJSNjvedlIleSB4V4QKGHTgSq02quxGzfwhr56O0Dv85K59kyUA7VnR87+nOS
         pxmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s0UWPcv45YDJ6fJXV9UJPLaAr8ooymlKhZRtGYGNJeo=;
        b=GAk76fBQQqTf4RudqVbjtqrB0MTIUJJOp4B7QmqvwplP9+FqDs3lBTxQDNmD2A76Vp
         DfzhyrkTTiqCsPnI8W3IoqM9sXPgb3Z2bjYTL6modz81G8Zy2LR4Fu/5JD1arqNxiTPo
         3E3hgdF4zZBIWwe2Q3CkvYPssjEyZToQKf10x0buvbAKTc2dfxGC2U3mT6ydYMX2BjKg
         O6KSSmTiXJ6AjYzGbmaSsboaF4JiFh8dFFoPpMokBvfuAb5m++LJekkXJLNYhLSVtfZR
         z28VQOxSCE6l4s85iC7g9V2oWClqGsD1c7clN6NimmqidEB3VuxmSkdxyxYDOSWcVp8L
         uFEg==
X-Gm-Message-State: APjAAAVaIiS2yP5hC3P5240ly3rf25gB7d0l1EyuelGv4VhR5wi7Py7L
        8va3R/9+VEkSVQrvKCv0RGmlUQ==
X-Google-Smtp-Source: APXvYqwzwIZ2p8lX4ACrpomWcq8ueJyK1xSgw+G4qos9cfxnxt+dYC25L1EUvZtrKjyiSeYH5x6a+g==
X-Received: by 2002:ac8:7545:: with SMTP id b5mr5282235qtr.239.1553206563395;
        Thu, 21 Mar 2019 15:16:03 -0700 (PDT)
Received: from jcormier-MS-7A93.syr.criticallink.com (static-72-90-70-109.syrcny.fios.verizon.net. [72.90.70.109])
        by smtp.gmail.com with ESMTPSA id w37sm3895968qtw.27.2019.03.21.15.16.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 15:16:02 -0700 (PDT)
From:   "Cormier, Jonathan" <jcormier@criticallink.com>
To:     Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org
Cc:     Bob Duke <bduke@criticallink.com>,
        Mike Williamson <michael.williamson@criticallink.com>,
        Greg Gluszek <greg.gluszek@criticallink.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jyri Sarha <jsarha@ti.com>,
        Misael Lopez Cruz <misael.lopez@ti.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/7] ASoC: tlv320aic26: Fix regmap by setting reg_defaults and reg_stride
Date:   Thu, 21 Mar 2019 18:15:47 -0400
Message-Id: <20190321221549.13765-6-jcormier@criticallink.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190321221549.13765-1-jcormier@criticallink.com>
References: <20190321221549.13765-1-jcormier@criticallink.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tlv320aic26 codec wasn't being setup correctly on bootup due to
a misconfigured regmap cache.

Fixes: b7e9f3973279 "ASoC: tlv320aic26: Convert to direct regmap API usage"
Signed-off-by: Cormier, Jonathan <jcormier@criticallink.com>
---
 sound/soc/codecs/tlv320aic26.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic26.c b/sound/soc/codecs/tlv320aic26.c
index db1d1704ae5c..cd1bcb9cbfe1 100644
--- a/sound/soc/codecs/tlv320aic26.c
+++ b/sound/soc/codecs/tlv320aic26.c
@@ -41,6 +41,27 @@ struct aic26 {
 	int keyclick_len;
 };
 
+static const struct reg_default aic26_reg[] = {
+	/* Page 0 */
+	{ 0x00A0, 0x0000 }, { 0x00C0, 0x0000 }, { 0x00E0, 0x0000 },
+	{ 0x0120, 0x0000 }, { 0x0140, 0x0000 },
+	/* Page 1 */
+	{ 0x0800, 0x0000 }, { 0x0820, 0x8000 }, { 0x0860, 0x0002 },
+	{ 0x0880, 0xFFFF },
+	/* Page 2 */
+	{ 0x1000, 0x0000 }, { 0x1020, 0x8000 }, { 0x1040, 0xFFFF },
+	{ 0x1060, 0xC580 }, { 0x1080, 0x4410 }, { 0x10A0, 0xAFC0 },
+	{ 0x10C0, 0x0000 }, { 0x10E0,  27619 }, { 0x1100, -27034 },
+	{ 0x1120,  26461 }, { 0x1140,  27619 }, { 0x1160, -27034 },
+	{ 0x1180,  26461 }, { 0x11A0,  32131 }, { 0x11C0, -31506 },
+	{ 0x11E0,  32131 }, { 0x1200, -31506 }, { 0x1220,  27619 },
+	{ 0x1240, -27034 }, { 0x1260,  26461 }, { 0x1280,  27619 },
+	{ 0x12A0, -27034 }, { 0x12C0,  26461 }, { 0x12E0,  32131 },
+	{ 0x1300, -31506 }, { 0x1320,  32131 }, { 0x1340, -31506 },
+	{ 0x1360, 0x1004 }, { 0x1380, 0x0000 }, { 0x13A0, 0x0000 },
+	{ 0x13C0, 0xFE00 },
+};
+
 static const struct snd_soc_dapm_widget tlv320aic26_dapm_widgets[] = {
 SND_SOC_DAPM_INPUT("MICIN"),
 SND_SOC_DAPM_INPUT("AUX"),
@@ -336,6 +357,13 @@ static const struct snd_soc_component_driver aic26_soc_component_dev = {
 static const struct regmap_config aic26_regmap = {
 	.reg_bits = 16,
 	.val_bits = 16,
+	/* AIC26_PAGE_ADDR(0, 0x01) */
+	.reg_stride = 0x20,
+
+	.max_register = AIC26_REG_AUDIO_CTRL5,
+	.reg_defaults = aic26_reg,
+	.num_reg_defaults = ARRAY_SIZE(aic26_reg),
+	.cache_type = REGCACHE_RBTREE,
 };
 
 /* ---------------------------------------------------------------------
-- 
2.21.0

