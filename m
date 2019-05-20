Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4D3C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13A33216B7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="G046+Nmo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732761AbfETOCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:02:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36202 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730274AbfETOCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:02:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id s17so14780570wru.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 07:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v8c/nNirEKJZwKIupGqiWC7ZFCXPvzpzRwKkeo1GtHI=;
        b=G046+NmoXL7OmlgnOxpy2A8NXGg3BrTDxquqdqUum4Ygxt4MvSRKsevFEyp+7us3XH
         fc4SPI5TljfQN8pVoQbCL0YXZIHTmu2XEgSxWGe6mB3B+pa/lf3M6nBFbRw1zey+uYD1
         X9t6E3SM/X5+Q11kw9fhVUxKAeA1srEnEUSQuANAn58IWxJPrGoc0suA68x5scwwTKTh
         I2vtdPfI0jNG6kq7z/53mlkT0hz5tX1kc8snw5EEqwftaqjiBOW5+JtIEVWkGaOI5+do
         yRsBpNKsIkdSS2CWP5NXKmz5ozy32+/VobT83THj3Db3a1T4FVNWxEq0h4d9RMZIKTyb
         sELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v8c/nNirEKJZwKIupGqiWC7ZFCXPvzpzRwKkeo1GtHI=;
        b=JEEkGISSa3KnoK9Jc6e9bcSa1RcdQ9iIQL9Mu5ZQeb2gjku2lTsvtXfSqkpSU/7fS2
         1oZsmFWnmcp5cT6PKWGy9bog9p5uQ9poW00JHJPHDbPdx0E0IujMw9aGt6WNnxCS2LYQ
         E2o4ImtfenqFNbZOdJkCh4PaU251miM5B8gP+rQBHRptrYtGk4kqOF8KsaAd6pvCmepI
         O0OoHJKW5gCUYV5qdWppibP+SG8LEw76I0+EifAqY6tpcuFBdCOETxqvBLk5j6RvXunF
         bbxRC0HwPAfGC+LsMQc9m/UlwnkvqEIrH4zSzrVkdTy+dxnjNqRKJ3uly9wRUJwhRsna
         wcbA==
X-Gm-Message-State: APjAAAVVfzq4mM89v0cPxo8iRtcFz5ZShLfp+zh4drjKLVbLCZe+Vn6w
        vjG6Q/0TSUcecsvN0V6Jy6hRJg==
X-Google-Smtp-Source: APXvYqwJ/Iyu7VnNKOAEfQFWmiIYCFgiEuV3TWfmUKry/H26rgf36s3aqukRIz7NFTNPiemoS3aFuQ==
X-Received: by 2002:adf:f44b:: with SMTP id f11mr16249685wrp.128.1558360951634;
        Mon, 20 May 2019 07:02:31 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 67sm6650580wmd.38.2019.05.20.07.02.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 07:02:31 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     martin.blumenstingl@googlemail.com, linux-iio@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH] iio: adc: meson_saradc: update with SPDX Licence identifier
Date:   Mon, 20 May 2019 16:02:28 +0200
Message-Id: <20190520140228.29325-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/iio/adc/meson_saradc.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 510d8b7ef3a0..e39d95734496 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -1,14 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Amlogic Meson Successive Approximation Register (SAR) A/D Converter
  *
  * Copyright (C) 2017 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <linux/bitfield.h>
-- 
2.21.0

