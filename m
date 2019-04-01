Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C5EC4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10A7A20700
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Nh+AbC+0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732097AbfDAHsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 03:48:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35341 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731769AbfDAHsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 03:48:06 -0400
Received: by mail-wr1-f65.google.com with SMTP id w1so10611613wrp.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 00:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UV+n+dpIqqcipkajAaapuo73V0wxH6nDMwdCzNSuWU8=;
        b=Nh+AbC+0lMeu1HOMqzSHiJ5uwc4j3Ow+sXY68KlDAy8QL4XS/6Vs65sjz1V6WaKw52
         LRWPG9O2t4AVgyjDjZac0RgsWxOAWt2E6Qx0MUFEngPYS8qZwU4WcxOw5S3bUZIBZJDL
         BbccTbPc2S12JXGgjWwtcnZi4BwvU18AZ/SOUVwEtOyRNHuFaRuNzJv3m26bUozqTLUa
         yyTiGnZAd+AVtO1zXy9rhBPFj1KnipEfqPOAMyLSJmjeRJzCTyJVaJPrJZCiySTV7jOR
         xM5efuxric2GKDrXxOV+7L/PK1VqpR2g2dvKWx/BHJyVgpGUcSUBENR7u9BSEE/xbRsz
         hTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UV+n+dpIqqcipkajAaapuo73V0wxH6nDMwdCzNSuWU8=;
        b=rn7C7LpckH0dai3w+HjBOVnTd7ffiIke4KrPzs8krYpDLffrUYJbgIBaf6NP5tUfBm
         ZwjzahLoLo2oGJb5KVZ4SGGlpCXZQZYYeiNZjqNyVycoO7s9oeJGlr73M786rxo46bNF
         LSqInTRcNahyF5Z8aHUmnWhZEumboS427t9Xt/xqOK9XOZCACZLgehv5rR2ziEG9k5mO
         uF2/2f85p4WbTemdbQX7M4TEalmmpGX2tbYUglZD7WZdG8rNYjbhRirr5MElKvb4KLM9
         XMLIkFX5lTJ6OkptF6jZGXh6i/1Cd3qdibcc7CRx5ONXQm7sJMqmkgpUFq5N8YHPLw/t
         AfYA==
X-Gm-Message-State: APjAAAXYYOHJopLse7u28ibGCV+g1nXcKFrrkb6xhNmlc14vn/3LCg/W
        JZ4TSsXGAGgxtVt/ZLOgRA4g1w==
X-Google-Smtp-Source: APXvYqwVSZe24VlFPyfzvR+UEBF2sWx6RuqCeJwmVnzD9ckpRuC0AWI0KiigQPbIXX7bv+HtJ96kZA==
X-Received: by 2002:a5d:448b:: with SMTP id j11mr41494198wrq.218.1554104884439;
        Mon, 01 Apr 2019 00:48:04 -0700 (PDT)
Received: from localhost.localdomain (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id o17sm9448537wrw.73.2019.04.01.00.48.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Apr 2019 00:48:03 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: amlogic: meson-gx-pwrc-vpu: Fix power on/off register bitmask
Date:   Mon,  1 Apr 2019 09:48:01 +0200
Message-Id: <20190401074801.10414-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The register bitmask to power on/off the VPU memories was incorectly set
to 0x2 instead of 0x3. While still working, let's use the recommended
vendor value instead.

Fixes: 75fcb5ca4b46 ("soc: amlogic: add Meson GX VPU Domains driver")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/soc/amlogic/meson-gx-pwrc-vpu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/amlogic/meson-gx-pwrc-vpu.c b/drivers/soc/amlogic/meson-gx-pwrc-vpu.c
index 6289965c42e9..05421d029dff 100644
--- a/drivers/soc/amlogic/meson-gx-pwrc-vpu.c
+++ b/drivers/soc/amlogic/meson-gx-pwrc-vpu.c
@@ -54,12 +54,12 @@ static int meson_gx_pwrc_vpu_power_off(struct generic_pm_domain *genpd)
 	/* Power Down Memories */
 	for (i = 0; i < 32; i += 2) {
 		regmap_update_bits(pd->regmap_hhi, HHI_VPU_MEM_PD_REG0,
-				   0x2 << i, 0x3 << i);
+				   0x3 << i, 0x3 << i);
 		udelay(5);
 	}
 	for (i = 0; i < 32; i += 2) {
 		regmap_update_bits(pd->regmap_hhi, HHI_VPU_MEM_PD_REG1,
-				   0x2 << i, 0x3 << i);
+				   0x3 << i, 0x3 << i);
 		udelay(5);
 	}
 	for (i = 8; i < 16; i++) {
@@ -108,13 +108,13 @@ static int meson_gx_pwrc_vpu_power_on(struct generic_pm_domain *genpd)
 	/* Power Up Memories */
 	for (i = 0; i < 32; i += 2) {
 		regmap_update_bits(pd->regmap_hhi, HHI_VPU_MEM_PD_REG0,
-				   0x2 << i, 0);
+				   0x3 << i, 0);
 		udelay(5);
 	}
 
 	for (i = 0; i < 32; i += 2) {
 		regmap_update_bits(pd->regmap_hhi, HHI_VPU_MEM_PD_REG1,
-				   0x2 << i, 0);
+				   0x3 << i, 0);
 		udelay(5);
 	}
 
-- 
2.21.0

