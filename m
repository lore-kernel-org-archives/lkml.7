Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86444C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 15:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 544C720850
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 15:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5bfT551"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbfHYPGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 11:06:32 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37687 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfHYPGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 11:06:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id z11so12930143wrt.4;
        Sun, 25 Aug 2019 08:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EzGMcTh8cYrJ0fJe6kpJtuwR7ufzId3YdTEGcvV46I4=;
        b=T5bfT551DOss2tIjS7I2D9v9HeNSyM5WLjI8qnaGhZ9u4N1hbrB3ulttCaa2blX5jI
         1gV+3u+MmKX5SPS4cX4sW6NDrBGJje62dhV0GEpJiuillbYjPDOtGMS4x6eyXDsugnsw
         5f+MCJy8iM6OUqmY7kHZmJhkXtNFEnZrv/LeNDl+9LiAyo0ewRnx1WJf3eBTIp3t/T4l
         KmMc/mLNHp2+yiQJWPtktOd6PSSpkNzlmV7u+0jOMUoaibDXqc9IGylOCZq4nCpkVpA3
         E0NpW+MY2wH69YVMO2ELq0V9nVvvVIs1MZNkAFRbKXrauKk8S12s+if2/wjKu5dUeTta
         AUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EzGMcTh8cYrJ0fJe6kpJtuwR7ufzId3YdTEGcvV46I4=;
        b=dNGIS7aFuXx9z0yb4wxqkPSByqT7Q3i/ZxghtIsLGOr7Sm/a7ocE+Qx6RoZYPqlOmN
         J3jrVRgChm8AbF4at8MDN8VfNkou4AJsm6zYJgnWfu6D9Z7dZGbUIqr0ZDRvCVWBvjj4
         q+ApfM9VTmdwHHTtqBR2YmZZvLoxDA1QkpWqwqS1tCR7nZL8Oi3dOVh9OumsbKB2L+CP
         7GJXviH1IVAyasuJ35nPTASi9+seMqAHcynvrjSRMfheIWFC/nGyYb1OSR2cwBYbywdW
         eGofAoLECPaLuC/amsOJlFXBW+5nDNHxBMO/SIkuP4uIJJ3VJp0nIugNieF1V2ZyJLx1
         euWw==
X-Gm-Message-State: APjAAAUB1w8EYVte76DTgd2t7+AM+LRz8p1jhjnk1KKPBpjgSu2oM5Yg
        naqOrep9Yh9pG3++79MzgUw=
X-Google-Smtp-Source: APXvYqw/WXTJJuzkVX90/eatj/z3u7hsIamk6YChmEn5woj5sKeT2mTbgpIkmQXqmhDcW2TWZ1Cesw==
X-Received: by 2002:adf:f6d2:: with SMTP id y18mr16829269wrp.102.1566745589786;
        Sun, 25 Aug 2019 08:06:29 -0700 (PDT)
Received: from alejandro-pc.mundo-R.com (57.166.117.91.dynamic.reverse-mundo-r.com. [91.117.166.57])
        by smtp.gmail.com with ESMTPSA id 24sm8571017wmf.10.2019.08.25.08.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2019 08:06:29 -0700 (PDT)
From:   =?UTF-8?q?Alejandro=20Gonz=C3=A1lez?= 
        <alejandro.gonzalez.correo@gmail.com>
To:     ulf.hansson@linaro.org, maxime.ripard@bootlin.com, wens@csie.org,
        linus.walleij@linaro.org, gregkh@linuxfoundation.org,
        tglx@linutronix.de, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Alejandro=20Gonz=C3=A1lez?= 
        <alejandro.gonzalez.correo@gmail.com>, linux-sunxi@googlegroups.com
Subject: [PATCH] mmc: sunxi: fix unusuable eMMC on some H6 boards by disabling DDR
Date:   Sun, 25 Aug 2019 17:05:58 +0200
Message-Id: <20190825150558.15173-1-alejandro.gonzalez.correo@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Allwinner H6 boards have timing problems when dealing with
DDR-capable eMMC cards. These boards include the Pine H64 and Tanix TX6.

These timing problems result in out of sync communication between the
driver and the eMMC, which renders the memory unsuable for every
operation but some basic commmands, like reading the status register.

The cause of these timing problems is not yet well known, but they go
away by disabling DDR mode operation in the driver. Like on some H5
boards, it might be that the traces are not precise enough to support
these speeds. However, Jernej Skrabec compared the BSP driver with this
driver, and found that the BSP driver configures pinctrl to operate at
1.8 V when entering DDR mode (although 3.3 V operation is supported), while
the mainline kernel lacks any mechanism to switch voltages dynamically.
Finally, other possible cause might be some timing parameter that is
different on the H6 with respect to other SoCs.

Therefore, as this fix works reliably, the kernel lacks the required
dynamic pinctrl control for now and a slow eMMC is better than a not
working eMMC, just disable DDR operation for now on H6-compatible
devices.

Signed-off-by: Alejandro González <alejandro.gonzalez.correo@gmail.com>
---
 drivers/mmc/host/sunxi-mmc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index d577a6b0ceae..dac57d76d009 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1395,14 +1395,17 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 
 	/*
 	 * Some H5 devices do not have signal traces precise enough to
-	 * use HS DDR mode for their eMMC chips.
+	 * use HS DDR mode for their eMMC chips. Other H6 devices operate
+	 * unreliably on HS DDR mode, too.
 	 *
 	 * We still enable HS DDR modes for all the other controller
-	 * variants that support them.
+	 * variants that support them properly.
 	 */
 	if ((host->cfg->clk_delays || host->use_new_timings) &&
 	    !of_device_is_compatible(pdev->dev.of_node,
-				     "allwinner,sun50i-h5-emmc"))
+				     "allwinner,sun50i-h5-emmc") &&
+	    !of_device_is_compatible(pdev->dev.of_node,
+				     "allwinner,sun50i-h6-emmc"))
 		mmc->caps      |= MMC_CAP_1_8V_DDR | MMC_CAP_3_3V_DDR;
 
 	ret = mmc_of_parse(mmc);
-- 
2.20.1

