Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DEFC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDCC02081C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="wRxTnBMZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfE0Nlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 09:41:31 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45917 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfE0Nlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 09:41:31 -0400
Received: by mail-wr1-f67.google.com with SMTP id b18so16966176wrq.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 06:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PtDy3UqUv5LCOqIXsFJGqcQMLOz550V0nprsW2J4Uqs=;
        b=wRxTnBMZt4cyd6WSY+pJUHPjaTqxPDKslWD4fOAz8Cl2ktdI78Ttpi98/VNQZgMMhd
         aQZroMDNgYrSKNN5UN95MemKkMASMsxQPlnFHtESyOSQnBMvR+HaF9LfzxQO1c/R6x+5
         DGyUbTd4JEs885rGAnMICBiTHoU6mN9oX61c/ZpdNQZEn6+z7S+yrQ7mYPyF4AFE0pJG
         CB2QHL0pbFzN2w4+t7iQj+VufoK2s2CXmf7xai5IiJu57Os/SDq05AU1LFq0ruYrW/aD
         v/VEf+IplThk/8c87IVibob6n5cg4dHuQIgDwqlNxehqAI/Ci4ALdnMQ72C6SfthBx7w
         i9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PtDy3UqUv5LCOqIXsFJGqcQMLOz550V0nprsW2J4Uqs=;
        b=eMh0hcIqZN4d3EXU7r8DS02FhGr5Yb9o6nbov+NdkhHQqwz+b6eU76vu+tLRzD/7E6
         w+rPd9FJsnEh0ZltkWFOSjD2lJTXi2Fp2QrxxCaWhkBkZmdCKqtWqBOZWzLeCSCR785p
         v9+3nFlYrJMMWALuiIEdQVogPs0bHL1YUFAFxm6nXHMQ5RPA43F6271E+qTcpzbJhPdU
         m0MPM9F6BXFwks3LSB0u6KjaaQRBGyLI8BrLq8gcbh/LpIXy74uThR7Ba+FAxOgKYX/m
         x3j/DstuSNUlsQoNXel56+hoZWW9BVYOfbswfhwXVdsIZznTifidhfSkC63G7BLxHg41
         JC+Q==
X-Gm-Message-State: APjAAAWnOIZRGK3eDE/8uhlUm/zrsKePllwWSqBnNXr1Ihp4rVcTnT+S
        iGDzx8cMEj7eCDcf9HW8ehvgjw==
X-Google-Smtp-Source: APXvYqwDoS1XKkP03Qo+GoG8JiTCdQ46ynTcTBid/U8fuWfQmDWA+axN+IkEGbAUdXNQUif5PkUSqQ==
X-Received: by 2002:adf:fc8f:: with SMTP id g15mr21780561wrr.122.1558964489668;
        Mon, 27 May 2019 06:41:29 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z20sm19631838wmf.14.2019.05.27.06.41.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 May 2019 06:41:29 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2] spi: spi-meson-spifc: update with SPDX Licence identifier
Date:   Mon, 27 May 2019 15:41:24 +0200
Message-Id: <20190527134124.3034-1-narmstrong@baylibre.com>
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
- Moved to a single C++ comment block

 drivers/spi/spi-meson-spifc.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-meson-spifc.c b/drivers/spi/spi-meson-spifc.c
index 616566e793c6..f7fe9b13d122 100644
--- a/drivers/spi/spi-meson-spifc.c
+++ b/drivers/spi/spi-meson-spifc.c
@@ -1,15 +1,9 @@
-/*
- * Driver for Amlogic Meson SPI flash controller (SPIFC)
- *
- * Copyright (C) 2014 Beniamino Galvani <b.galvani@gmail.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Driver for Amlogic Meson SPI flash controller (SPIFC)
+//
+// Copyright (C) 2014 Beniamino Galvani <b.galvani@gmail.com>
+//
 
 #include <linux/clk.h>
 #include <linux/delay.h>
-- 
2.21.0

