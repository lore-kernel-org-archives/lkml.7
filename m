Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFB3C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33E602171F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 14:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="n4ucZluq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391690AbfETOhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 10:37:38 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35899 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730966AbfETOhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 10:37:37 -0400
Received: by mail-wr1-f65.google.com with SMTP id s17so14926979wru.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 07:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3QDibyFNEaQBAlcOcZglPf5uEDCypT1ErrGWYL3AuN8=;
        b=n4ucZluqd7Rn9USs5AaNQcjkyWV/7ZvhsEaiHXgqDmJDwmsOYW+Tc8gHioUBrggmSL
         4251XCulu6Dw79ci++0dkIlexw5Crd+G++jWvULCjL/uVcD8e9jNBpsOUcdUMMVds3sx
         vnx01w7hms6aoV0BX3+IL4XZK63zWrBq5zjMBjceXB5fS8ZAX0FDZ/SRvZ5j73c4Q2nJ
         z85NWcT8a6kDaM1hOu6ePfpyASuAKKkSRxl3ZdcqHNUywqo6cQobptZh6s8yPmCV2Ibj
         UBlo338Kt2yB4L5sRKE75tiJadZcXXRvvF3aaL2QwxetkGb8S90tDFJMAaGbBbMbyF69
         RsjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3QDibyFNEaQBAlcOcZglPf5uEDCypT1ErrGWYL3AuN8=;
        b=Bb6OOUn7pRsddEhoIXQLvnxeuFVP2tv77+cPx/Bv2VIHCHgNykZOxz8ogik7N+qRYn
         ulHnFbMporZHKpQBjZXDrV1HzTRMGT5KjMwnqFXV2qYBQAnHssR14x8ZRSGZqIBUeLjn
         IGRB6fm/BRekpOl+OSq3P8txsou/Jv4CnMgkZllm/h61ouXbgYyRGmAJUe7MBuetRCY9
         fV29pHteb/8lyeeWKY71rgBit9jLpbllmzBhVBJKilfihfCsd1CT9E/5G/QgiV7GIX2k
         Fs/dkdiflDnugV2cw922e9say1pMRINv+y2kSwnOPOTywbFrDzCl0xy0TK/bRClBT0nI
         4fnA==
X-Gm-Message-State: APjAAAXcch3B+NsVbHaogi3ZFkOoF2WleK+RsiB9teYpAkLGMX4C3tnP
        3Tyqc+xqw02NlB4AzXBhXG4ZKg==
X-Google-Smtp-Source: APXvYqxmDYEY1Ff/PypAXqIIxFM6K9hf2q4tW4sAGg5SIB2c/1YEMr3YhzaRmZW/7u5KKCEoKW757Q==
X-Received: by 2002:adf:8184:: with SMTP id 4mr48432770wra.27.1558363055370;
        Mon, 20 May 2019 07:37:35 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id b136sm19076204wmg.1.2019.05.20.07.37.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 07:37:34 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     srinivas.kandagatla@linaro.org
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 1/2] nvmem: meson-efuse: update with SPDX Licence identifier
Date:   Mon, 20 May 2019 16:37:31 +0200
Message-Id: <20190520143732.2701-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520143732.2701-1-narmstrong@baylibre.com>
References: <20190520143732.2701-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/nvmem/meson-efuse.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/nvmem/meson-efuse.c b/drivers/nvmem/meson-efuse.c
index 99372768446b..9f928fa9964f 100644
--- a/drivers/nvmem/meson-efuse.c
+++ b/drivers/nvmem/meson-efuse.c
@@ -1,17 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Amlogic Meson GX eFuse Driver
  *
  * Copyright (c) 2016 Endless Computers, Inc.
  * Author: Carlo Caione <carlo@endlessm.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
  */
 
 #include <linux/clk.h>
-- 
2.21.0

