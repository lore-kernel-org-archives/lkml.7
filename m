Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8942C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 13:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD9B21783
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 13:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="rVwae6mm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfKMNQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 08:16:35 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55793 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfKMNQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 08:16:35 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so1954469wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 05:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8BHb3SywQ2Dt9H5f/ilLWEdUuC5kLAW3Nxdd9jO6uik=;
        b=rVwae6mmeRvxtocvmBFm3xrKSDvicxVWsAiLseyil2UouyqMagpRyP+0z9EmO1ZMZf
         qB1J5ctAFqZGxks1BDmWvuKBYyqrM3bZ+gP+UnRszg+B1tdNeGQ9cba1KHg7OIByf6wv
         oKiHLWMyfB+1PCKSaHAwXIjuwZLyZAKnG3PFew+OEI0cdvngh5Npc2/qL2y2W3b4Frkf
         kBnQK4fG8JK6dr9COxexGXZ4h5rPPeDtEL8+VD2liJ65ikPjJJJ5ptu4gsnRHhPpepxU
         XC9I91IsEROgy1zi0zpuuX0p0weNFpFCz5Z1BpdwTlulwR89oCug6apaKrbPt7gM4leC
         K+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8BHb3SywQ2Dt9H5f/ilLWEdUuC5kLAW3Nxdd9jO6uik=;
        b=mPDrfblqzuCm2YQPI6GZaHqia0bDbwsX+FzDqDSi/hs+WxvhZ8fsAd9EAZuYvzXhZd
         UjBsaJzRnQRLu7X/3eaGa9AgD514vYvM6N55jgOElHapxTBhMGabQUxVVBoz/4FVoWON
         TkNYn4paXxYM4apsmQC+nmTWSkfPlo3Sj0ZfhrYc/3FrqFhqCDv5pNUDEMhIADMJjOzV
         96SKqZ0G1w8eCdvXCsJtWHgmJ/0FlL5v+3F1IZGIT8U9yidOjoHohAE+QzLepMgJAI5K
         4SHJULbgaNnWWxdnIrt1f47+5joL0p9WfOVVngq76/qxrG+djEnsQxoxV1VXAd9PQyCF
         /taQ==
X-Gm-Message-State: APjAAAXBCMHbHv5KKVxeKfuVcgxVqXteKcol4ywbux93Q//U9Tu05f4g
        8jKjuahHxsbMckAIcEZf39jWaBP0UPs=
X-Google-Smtp-Source: APXvYqxvWPPhtFXQKCtnb6fJncbQD/MoKGKBUynI1Z/10IGu2rArcltHX0pAiED8NmiPdDQn1DAZyA==
X-Received: by 2002:a7b:c743:: with SMTP id w3mr2852317wmk.165.1573650992903;
        Wed, 13 Nov 2019 05:16:32 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id a11sm2376039wmh.40.2019.11.13.05.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 05:16:32 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jiri Kosina <trivial@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [TRIVIAL PATCH] gpiolib: fix coding style in gpiod_hog()
Date:   Wed, 13 Nov 2019 14:16:29 +0100
Message-Id: <20191113131629.3861-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

There should be spaces between logical operators and their operands.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpiolib.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 104ed299d5ea..5d4298415601 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4694,9 +4694,9 @@ int gpiod_hog(struct gpio_desc *desc, const char *name,
 
 	pr_info("GPIO line %d (%s) hogged as %s%s\n",
 		desc_to_gpio(desc), name,
-		(dflags&GPIOD_FLAGS_BIT_DIR_OUT) ? "output" : "input",
-		(dflags&GPIOD_FLAGS_BIT_DIR_OUT) ?
-		  (dflags&GPIOD_FLAGS_BIT_DIR_VAL) ? "/high" : "/low":"");
+		(dflags & GPIOD_FLAGS_BIT_DIR_OUT) ? "output" : "input",
+		(dflags & GPIOD_FLAGS_BIT_DIR_OUT) ?
+		  (dflags & GPIOD_FLAGS_BIT_DIR_VAL) ? "/high" : "/low" : "");
 
 	return 0;
 }
-- 
2.23.0

