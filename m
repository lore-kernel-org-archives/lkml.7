Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F64C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D05217FA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1mPpeghD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387435AbfDQUog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:44:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41612 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733103AbfDQUoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:44:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id r4so75341wrq.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 13:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lh/dg7Ph5gI3fwf6VslQBt0/ChaA/QQP0d5LUMjUu4Y=;
        b=1mPpeghD3+pEqAmcuNDF7gqDFMo758uoBAud5UHWZIUDtRk8EjnSryUQy3VJHxY4MU
         FKz6W+RMZjKwMLDJgxlVOUSNX54BW4Ce1y6FcXZqfgiXH99tLHDoEfH5iK4lAAUXlao4
         2JDLy83rqkypIHa8CnAINKxYgU8w6FWfZIRRg8acw8dwGpYrRAtlFpDe9JwOUGm2OyJA
         qP0caZxUs0ivVIhNXdfXM50LKf9gan5hMB3RIYiowUH10Ubv94nQa7SQxG3AAAEvEVqw
         1x9jk61VkNsP+DKjek9Mds2fAVoyxjeOAIiObHA67mtw7wNfE2lLGJyJjS5YN1MwMegy
         PZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lh/dg7Ph5gI3fwf6VslQBt0/ChaA/QQP0d5LUMjUu4Y=;
        b=dJ9Lt2irwrITBk9m8XFeFlA2QP12iuHvtXn4exVmZPGjcymQj5dwJJjTVBPTcRGaXW
         vHFP6HHerXWLiRObOt3EXCBHinVNutSbQRXHYl9A8ztPQcMQ0C/ujC5vNk/Q0f6YRYFw
         2zxId+LQJGhtU6K//Zf2q7HN3Fx9MkTXlyuMI0D668rnvkp8I9plcKNKf1CfFGoYaRs8
         5CegviwzKDfcP4C5oGQ26WvvhzfOjb5ZDULOlE6j36abNIVQmyM8Gl7p7eLGrlz+Zz5m
         JZrlZLf3NzFX662lQiTuehpgtjbmwVcw3AL14m9D+R9fCJSnCJZseDVeLBFYWA/L224K
         jNGg==
X-Gm-Message-State: APjAAAUjgjPXc80+MjjmQDInKbEU9qnPeCfpb4luSKu5QkwQHLLlYBnS
        W/+8jEK819uhEVoF7/DWUylP9w==
X-Google-Smtp-Source: APXvYqxgXovl5BnoNoOEp4CmKK0ycCjwYYaDHc2FEDPp9FNNZMreUD7JhN81Sbr1WvTV9K7buaRB7Q==
X-Received: by 2002:a5d:6889:: with SMTP id h9mr34623582wru.12.1555533851257;
        Wed, 17 Apr 2019 13:44:11 -0700 (PDT)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id c20sm98716866wre.28.2019.04.17.13.44.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 13:44:10 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] mmc: meson-gx: disable HS400
Date:   Wed, 17 Apr 2019 22:43:52 +0200
Message-Id: <20190417204355.469-5-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190417204355.469-1-jbrunet@baylibre.com>
References: <20190417204355.469-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment, all our attempts to enable HS400 on Amlogic chipsets have
been unsuccessful or unreliable. Until we can figure out how to enable this
mode safely and reliably, let's force it off.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 3df50b53f834..118f09da8dfb 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -823,10 +823,6 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	if (meson_mmc_timing_is_ddr(ios))
 		val |= CFG_DDR;
 
-	val &= ~CFG_CHK_DS;
-	if (ios->timing == MMC_TIMING_MMC_HS400)
-		val |= CFG_CHK_DS;
-
 	err = meson_mmc_clk_set(host, ios);
 	if (err)
 		dev_err(host->dev, "Failed to set clock: %d\n,", err);
@@ -1339,6 +1335,13 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	mmc->max_segs = SD_EMMC_DESC_BUF_LEN / sizeof(struct sd_emmc_desc);
 	mmc->max_seg_size = mmc->max_req_size;
 
+	/*
+	 * At the moment, we don't know how to reliably enable HS400.
+	 * From the different datasheets, it is not even clear if this mode
+	 * is officially supported by any of the SoCs
+	 */
+	mmc->caps2 &= ~MMC_CAP2_HS400;
+
 	/* data bounce buffer */
 	host->bounce_buf_size = mmc->max_req_size;
 	host->bounce_buf =
-- 
2.20.1

