Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C00C3A59D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 09:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4811E22CF7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 09:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Sc66PKmn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbfHTJqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 05:46:35 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41100 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729599AbfHTJqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 05:46:33 -0400
Received: by mail-wr1-f67.google.com with SMTP id j16so11669438wrr.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 02:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OCqVb1b3ky6iQzAtUB0i7OFFbduthR84Csc9ahGaOQU=;
        b=Sc66PKmnhvSczvFG4A+2IsY4y788+71RHz17he6fqbGBB7lV2eetN+bT1iC6s+Nt+I
         oJASVWmdfkn7D49IDGS3xpbFWAe29TgnxL50murfoXlijNtsx86Ii1AdRSK/WoGfEIOb
         5DSIIYeFO6ud7bPIe6OaDxaPP6l8lGhXajospvzpWeUst3j1/MMgVdsO2QO0NrRIh7dl
         ACu8TT71vzZ4AIRTucs2hPUGGUzWHSyV68rlhNpZHwXoRRZFm+1G3VoPkwmFsvQj8XcO
         MKxIW4NC7LyvMlfcU3kHRADKDeuleLnsmwJ+AEf38aMAW9o8qZhQdbm1N9KPMY40XrAS
         uT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OCqVb1b3ky6iQzAtUB0i7OFFbduthR84Csc9ahGaOQU=;
        b=Eo4IoZa06f/eZ43DSKle7theaqs56IJpAK1k8TCoDV2Yh/54ZLkJYxTIqw3u1gk1u6
         SI4UHYHtdEd2cZ5Nt4seev/aY+EsF/JmAh3hBUvQ5dDIY/47VRvAQzXGnQslq0oG2Tlw
         0RFCktPL3w1fuU2kwY1LmzPIStyzvV51/NUoYBWEavmbVr6WgomsxUuPKI6Cw5GgsBGn
         yx3G/khp1S7uFBDVQEtCA4G1ou/3phxm4YW94muxjZf6cAWZP/W8lHC3Lyny1t78c9UH
         cFdDaukVOlJEgMJ6gwj4z1VNyi2jrw1eSyBQRJ1ZqTCPoAUFoIb2yQawoBFRHBuyP3C6
         LrmQ==
X-Gm-Message-State: APjAAAXO5SHWcFeEAhXQMgN9wfJIwhDJytNtt0n87oXkDnqunG7ulUgV
        I//NM0Fc1Z8ujBHeGH65sF5iOg==
X-Google-Smtp-Source: APXvYqw3tlq5yvBtrHDp0eeORLI4XXpzdTgTQ9X/0q31O3NVubVX/vqO+if/abH98mEREbLMHw7SNQ==
X-Received: by 2002:a5d:6ad0:: with SMTP id u16mr33820477wrw.84.1566294391450;
        Tue, 20 Aug 2019 02:46:31 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id o17sm15958305wrx.60.2019.08.20.02.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 02:46:31 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] reset: meson-audio-arb: add sm1 support
Date:   Tue, 20 Aug 2019 11:46:25 +0200
Message-Id: <20190820094625.13455-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190820094625.13455-1-jbrunet@baylibre.com>
References: <20190820094625.13455-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the new arb reset lines of the SM1 SoC family

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/reset/reset-meson-audio-arb.c | 28 ++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/reset/reset-meson-audio-arb.c b/drivers/reset/reset-meson-audio-arb.c
index c53a2185a039..72d29dbca45a 100644
--- a/drivers/reset/reset-meson-audio-arb.c
+++ b/drivers/reset/reset-meson-audio-arb.c
@@ -30,6 +30,17 @@ static const unsigned int axg_audio_arb_reset_bits[] = {
 	[AXG_ARB_FRDDR_C]	= 6,
 };
 
+static const unsigned int sm1_audio_arb_reset_bits[] = {
+	[AXG_ARB_TODDR_A]	= 0,
+	[AXG_ARB_TODDR_B]	= 1,
+	[AXG_ARB_TODDR_C]	= 2,
+	[AXG_ARB_FRDDR_A]	= 4,
+	[AXG_ARB_FRDDR_B]	= 5,
+	[AXG_ARB_FRDDR_C]	= 6,
+	[AXG_ARB_TODDR_D]	= 3,
+	[AXG_ARB_FRDDR_D]	= 7,
+};
+
 static int meson_audio_arb_update(struct reset_controller_dev *rcdev,
 				  unsigned long id, bool assert)
 {
@@ -82,8 +93,14 @@ static const struct reset_control_ops meson_audio_arb_rstc_ops = {
 };
 
 static const struct of_device_id meson_audio_arb_of_match[] = {
-	{ .compatible = "amlogic,meson-axg-audio-arb", },
-	{}
+	{
+		.compatible = "amlogic,meson-axg-audio-arb",
+		.data = axg_audio_arb_reset_bits,
+	},
+	{
+		.compatible = "amlogic,meson-sm1-audio-arb",
+		.data = sm1_audio_arb_reset_bits
+	}, {}
 };
 MODULE_DEVICE_TABLE(of, meson_audio_arb_of_match);
 
@@ -104,10 +121,15 @@ static int meson_audio_arb_remove(struct platform_device *pdev)
 static int meson_audio_arb_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	const unsigned int *data;
 	struct meson_audio_arb_data *arb;
 	struct resource *res;
 	int ret;
 
+	data = of_device_get_match_data(dev);
+	if (!data)
+		return -EINVAL;
+
 	arb = devm_kzalloc(dev, sizeof(*arb), GFP_KERNEL);
 	if (!arb)
 		return -ENOMEM;
@@ -126,7 +148,7 @@ static int meson_audio_arb_probe(struct platform_device *pdev)
 		return PTR_ERR(arb->regs);
 
 	spin_lock_init(&arb->lock);
-	arb->reset_bits = axg_audio_arb_reset_bits;
+	arb->reset_bits = data;
 	arb->rstc.nr_resets = ARRAY_SIZE(axg_audio_arb_reset_bits);
 	arb->rstc.ops = &meson_audio_arb_rstc_ops;
 	arb->rstc.of_node = dev->of_node;
-- 
2.21.0

