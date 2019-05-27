Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEF4C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1545620859
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ZWCIeJeJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbfE0Nj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 09:39:26 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33670 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbfE0NjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 09:39:11 -0400
Received: by mail-wr1-f68.google.com with SMTP id d9so16996161wrx.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 06:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6ultmkYjgWhJ/xZHGxkX6N7CA7j/pBGMWJYUycDlyOs=;
        b=ZWCIeJeJ5bbe3QYU5MHYCmvgdOx1CvzmjJ1SIJ+/EfRaQthknG2V3UFeEgwDV42KiD
         ff4floiGIvqL50CVQGqrsv3olYmlrE9/51PBX7UYPNLMjIM3NJ+qWUXUi5LsohTIg6Z+
         yGUKXHKhJw9prtsh8Ke1/bKpxWKdakHKTN+iwno6zEjcmCk/Lrd+Xvme8n/xqqlfNxfp
         ISAAWiimOCHcv1UCmcsfiLCfUMQUZu/vGC14lsyF6Jpgy72LnNb3XrNDIdUbXvkv89S8
         9YbS2dWln5pw869bY5Jeb0YsttYTTBw9ejIyQDiajuEiwQP4lj4nSXvXndViRYBY6PYx
         bXRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6ultmkYjgWhJ/xZHGxkX6N7CA7j/pBGMWJYUycDlyOs=;
        b=VFp2aSVNQWsGhZyR1NizjEmx3AUzTz+MKf3S/dVVAmKMb4AtvuRKci+tSNgo2CtQ20
         bMj87XM+Hqjv6hfs9EEiijT97E9lhby/Tm7ISm6PHwjF0lXwyWnyQHcieJo0SPTUJ37S
         V+woyPvup/bP3h3hMFxCw9cDDEJtpV5MDcC0hlBzdaJpSwUtqMlM6e+g1YLGfuDzixsJ
         4iRiVX7T6abtfA6/9JR9Tu4GnbJ+r3X7rIE5es38AjPAty8Zy8JW2pSZ+gEZxBs1r6vU
         9gjT0QWAhTZgl6sEKiASuu+TOi0Rs9d+3YmqQ+PqRxdFgdbGXeiBkAUT6F/kH61e4bji
         ZlIQ==
X-Gm-Message-State: APjAAAWOx5jMynv0MqpmGLito8eahYpHN2rRbqb8S93RlVchWvPxy2oL
        xodhOAy8oS1pbMRmIP++FT7W3w==
X-Google-Smtp-Source: APXvYqx24uqW1qXuZFPiiToIbx1locFeLMf7EvNsEfe3TjVzFZkOove/54wDfLTO4gRyDSMZlztdgA==
X-Received: by 2002:adf:e301:: with SMTP id b1mr10932162wrj.304.1558964350293;
        Mon, 27 May 2019 06:39:10 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a124sm7838335wmh.3.2019.05.27.06.39.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 May 2019 06:39:09 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 09/10] ARM: debug: meson.S: update with SPDX Licence identifier
Date:   Mon, 27 May 2019 15:38:56 +0200
Message-Id: <20190527133857.30108-10-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190527133857.30108-1-narmstrong@baylibre.com>
References: <20190527133857.30108-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/include/debug/meson.S | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/include/debug/meson.S b/arch/arm/include/debug/meson.S
index 1bae99bf6f11..df158693a327 100644
--- a/arch/arm/include/debug/meson.S
+++ b/arch/arm/include/debug/meson.S
@@ -1,10 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2014 Carlo Caione
  * Carlo Caione <carlo@caione.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #define MESON_AO_UART_WFIFO		0x0
-- 
2.21.0

