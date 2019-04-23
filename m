Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA54C282E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7EBD20843
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1WC11RfA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbfDWJCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:02:55 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53056 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbfDWJCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 05:02:52 -0400
Received: by mail-wm1-f66.google.com with SMTP id j13so2036871wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 02:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lh/dg7Ph5gI3fwf6VslQBt0/ChaA/QQP0d5LUMjUu4Y=;
        b=1WC11RfAdc5GecWwsQU6yS8A+VNYwgWVMmL0MClvtzid3hmQvVtPUjHyJsiGJ2Xff9
         02WF36bW9tXM0GBMaZ+z0J3m116oKKreE8xdneCNqHBxr9CjABLDhUbc3J9AOhpoSIBs
         N02AwmWUiSmCeCU152QswI6kIDtqsvVThEbqrbHiPdaAOcrSy9gU44K9KxPIr8BObyfg
         z+xaQqIuGsvLC3hXnKKf7d30LDBEt4kE9TERhppVHZxupuq4eVq4G0FMDL0EewmI1gdF
         Z41N24f3zDhBcByx214ftOkS7jAOt0r2cviAzqbbcbbdOhZu6IrEaeFURU4+hiUxMNtA
         f7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lh/dg7Ph5gI3fwf6VslQBt0/ChaA/QQP0d5LUMjUu4Y=;
        b=CLd/fWSfN2xBRbc6BK/anHrJVnpqHcPI1BbKrKNy++rtPun6uBh99t+dhpOftYNOkn
         NuO/9tLpiEk/KYH0YD2K0pFfaYW9eqEA/Otd6o0IJjPGh2v+biPfbk6E5+Ag9jTqc/Y7
         alckT0YpdhbGISUP3tx7IzYJo9ivM9jXXnjhqivTDoYVeAF3jLx5VBUGaPakc+mgnQXa
         dtq16nopCXaqBDcjcpcntezzr8lx5QLXRKaHtJc1/g6pI2UeVNaDiEjQ28keTqC/Ogpc
         Sfc83kRzAL9766EH9TDX0keCuCTPiAsXV2HRhGr2VeFghwhxfz326lW021GEKSn06rBL
         b24w==
X-Gm-Message-State: APjAAAUod9y+t8416lh1oDnrwmpNH4wXp0QxPy6XeDM+2/Jc7VtQocGx
        uLDjAWzqgAHKAQaaNOLzCgSjxg==
X-Google-Smtp-Source: APXvYqze6CIxZJgB35Vu4qp8N/8FwJB3NGJfMNlkaHj8DAKAdlAxTXUPR5lTiWXqYtiT64X3cDX0hg==
X-Received: by 2002:a1c:4302:: with SMTP id q2mr1458598wma.28.1556010170616;
        Tue, 23 Apr 2019 02:02:50 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id z23sm12361894wma.0.2019.04.23.02.02.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 02:02:48 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] mmc: meson-gx: disable HS400
Date:   Tue, 23 Apr 2019 11:02:32 +0200
Message-Id: <20190423090235.17244-5-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190423090235.17244-1-jbrunet@baylibre.com>
References: <20190423090235.17244-1-jbrunet@baylibre.com>
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

