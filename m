Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D175C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB0E72081C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:43:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="OU+HYJGU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfE0NnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 09:43:23 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37426 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfE0NnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 09:43:23 -0400
Received: by mail-wm1-f66.google.com with SMTP id 7so15902869wmo.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 06:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kCiJ2Da6Bdx0f26fODvp2y3M2kismC8wC26JqfeJQ7M=;
        b=OU+HYJGUyJkf6WspzAE2MO/L7hPgR/TCD9A7gpk41fnqGWvDnS/2YYprGRmbtyXVlM
         WAK4BRaMdlleBVdPjeFZrLYt36k5CksvpLzZ5nYh8z/jnxf299e47VaP68Ipsex+X0qZ
         0KRhfIZKEwMPvSBZ6CqW0ZxgMpXilxkJdI8GUyrUmyqZoV2RtDblYlaPpf+BrUFUv2Dr
         3KA7YjSSTWmgnktkfBTtpz1FB6Dy7Ufr+qaGnOO5Uj5hNZJcn8dvXt4Om+7tSbPnxKZ2
         +y5VQAiOVWzpdty3fLHtZHHUGzqFGuZQ2P3yog3VojGIlkqZ8HTVXU5t1YWKhcO9yK4u
         4GFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kCiJ2Da6Bdx0f26fODvp2y3M2kismC8wC26JqfeJQ7M=;
        b=sLumG+cK5ckIRpKqVFpe0a7hov917SqQCm+7utLTpVeQvdDfRzek0SJDMJJZKlp9gv
         uGeuGePQ0ICeqZdP2smkpDVhme6OO4L9iBreRglxQdysdyDzw5RMnjj8FjBPvlnyudBs
         Se3E7O0sDTTD69s7twO5HihPeGjfrSLlO12V/2maVFhUe0MoX1gm6f7cBX3lRlPSKECx
         JVAcEZOcID2SNOkQ3CLZBefsZUYPiV5W36W5bbVAX5172HkYyHWyRpJGC1VO7vt6yoeU
         Oig0bdCeotmH5bu2IUnh4Yh108L/UO14w8HVcwm4ydCPsuCc68sDMr4WGgukf+WLj5I5
         dRvg==
X-Gm-Message-State: APjAAAXctGC6GqgvL+5Ob3hpbKz2WIQEo6r05NfPMno35Q4fZYJNk80p
        xsEYBJbuG349gh4zJPN1Iuwnrg==
X-Google-Smtp-Source: APXvYqyWGZ1o+3JoKtMfo50PU7d32A1d9yTM0bYrWBeHwltd357tf1/9T5MWMWeTFOdN3r9igxK68Q==
X-Received: by 2002:a05:600c:23ce:: with SMTP id p14mr24714908wmb.36.1558964600694;
        Mon, 27 May 2019 06:43:20 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id n4sm12965536wrp.61.2019.05.27.06.43.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 May 2019 06:43:19 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     linux-iio@vger.kernel.org
Cc:     martin.blumenstingl@googlemail.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2] iio: adc: meson_saradc: update with SPDX Licence identifier
Date:   Mon, 27 May 2019 15:43:14 +0200
Message-Id: <20190527134314.4340-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
Changes since v1:
- Used correct GPL-2.0 license

 drivers/iio/adc/meson_saradc.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 510d8b7ef3a0..7b28d045d271 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -1,14 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
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

