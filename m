Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A18C10F05
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 21:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3765B2133F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 21:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="OSSuiy0+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbfCWVTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 17:19:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42636 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728470AbfCWVRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 17:17:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id g3so2489781wrx.9
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 14:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AbhkTI13AmSY9XKV0JobMbHsJRDpOGhDj343gt4xJ3k=;
        b=OSSuiy0+nlnD/R893s9W0y/CWu7AdqerwHBWlHHl9ZlybkoGvfqGAN7L56WPPha1MB
         MKaPDel06r9R3cRa8C477bVrlUanMhMvzKZhIt/raf8P1sZ7RVuoJFLiKWfNr9ejThFz
         QdRTRvAS8+QJG6f/EoJZJxcaLaudyE1YxQbRb9Mh7svXXJTRiBSIgA/hZ/bzWJBgl7Lu
         TtxW1WtMbum6aIhlnlNdOJdFt6LdRSIom125fdRYi8MqfNHSSqNmK/53EpARGjrVks66
         Dw0oPwCtVWIPfYsiFJw2HH7Nnyn+25qJDCvSo7pPEgVaZzhGRV8rudg3ZcTAy7v/cYwZ
         OW6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AbhkTI13AmSY9XKV0JobMbHsJRDpOGhDj343gt4xJ3k=;
        b=LGq38HZdB0bGUhbtNWc3xmAJlBELoo09c/DsCd2JTQAinBUSF+LiUbGwsxZK0742F2
         x85XgoXVhbQ/KHFCliLVloCZYxFmDY88l1tJy9OY4M6Izj9Ha8xJgdbA35dBaaNlLCMR
         5ShYqhbOThbTfICWn6AXic65+/ATTO0tpiZ/NkKBZnG3MeMDFSrcOs6QscOmURuCwmpo
         FQW9PXMm/UjqLu4tIVQTbCkkyOFKL01cdiwbEq2znAkbujkVWRs7v+iY5oJHvgAi6eN9
         UqBWQOeliQ0C/9kEyK+kn6kGG4y12fs1rP+0uEGxLSiqhfZnVnb59dqfxfyXGOYcc8CH
         TRIA==
X-Gm-Message-State: APjAAAX7T5VOY7dVYtRNqy4SSuNTq9xQbNKsM0oqxmvBnz9DQTf3IH9J
        4lVN55VVJk1nrvMeZv6sL6hh1Q==
X-Google-Smtp-Source: APXvYqw2oFsC1FoDUfneZhEfe0V8cFIQUhwZ73vh1DeurRVzjVV3E+VWUa1ylEOtMk0hNTMeTo+0qQ==
X-Received: by 2002:a5d:4c88:: with SMTP id z8mr3724209wrs.291.1553375824363;
        Sat, 23 Mar 2019 14:17:04 -0700 (PDT)
Received: from localhost.localdomain (cag06-8-78-203-165-84.fbx.proxad.net. [78.203.165.84])
        by smtp.gmail.com with ESMTPSA id y66sm8050503wmd.37.2019.03.23.14.17.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2019 14:17:03 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     matthias.bgg@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     sean.wang@kernel.org, ryder.lee@mediatek.com,
        hsin-hsiung.wang@mediatek.com, wenzhen.yu@mediatek.com,
        chaotian.jing@mediatek.com, yong.mao@mediatek.com,
        jjian.zhou@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-clk@vger.kernel.org, stephane.leprovost@mediatek.com,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 10/24] mmc: mtk-sd: add support for MT8516
Date:   Sat, 23 Mar 2019 22:15:58 +0100
Message-Id: <20190323211612.860-11-fparent@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190323211612.860-1-fparent@baylibre.com>
References: <20190323211612.860-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the MSDC configuration for the MT8516 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/mmc/host/mtk-sd.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 573aa127d00b..51139275b1b2 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -507,6 +507,16 @@ static const struct mtk_mmc_compatible mt7622_compat = {
 	.support_64g = false,
 };
 
+static const struct mtk_mmc_compatible mt8516_compat = {
+	.clk_div_bits = 12,
+	.hs400_tune = false,
+	.pad_tune_reg = MSDC_PAD_TUNE0,
+	.async_fifo = true,
+	.data_tune = true,
+	.busy_check = true,
+	.stop_clk_fix = true,
+};
+
 static const struct of_device_id msdc_of_ids[] = {
 	{ .compatible = "mediatek,mt8135-mmc", .data = &mt8135_compat},
 	{ .compatible = "mediatek,mt8173-mmc", .data = &mt8173_compat},
@@ -514,6 +524,7 @@ static const struct of_device_id msdc_of_ids[] = {
 	{ .compatible = "mediatek,mt2701-mmc", .data = &mt2701_compat},
 	{ .compatible = "mediatek,mt2712-mmc", .data = &mt2712_compat},
 	{ .compatible = "mediatek,mt7622-mmc", .data = &mt7622_compat},
+	{ .compatible = "mediatek,mt8516-mmc", .data = &mt8516_compat},
 	{}
 };
 MODULE_DEVICE_TABLE(of, msdc_of_ids);
-- 
2.20.1

