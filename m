Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483BEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1676B2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDUkbUGq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfC0ILa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 04:11:30 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40137 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfC0ILa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 04:11:30 -0400
Received: by mail-pf1-f194.google.com with SMTP id c207so9356149pfc.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 01:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5xIaxSWXWv+BY7u3XIDDZCXSsuWmT0gj1RNn3WeT6jo=;
        b=QDUkbUGqhpo4mh26u6+6fJDLRi51HRBGNv0mnS7OcMbzOuIlaFRuKc9qh/JTpiP2oR
         +dNJjTzuZKSip2oL5sSVFNmwMMJEBlTGz7F9i5J94LUb9QzWEz5LEIvjOpImpRwCGkn0
         DaSRosFNuElqdewtOD2flq+aPQ5qbcdLl8OogFnsPedk0d8BWi4xQSZ3YtWpzgdAjZSM
         MGrUkmZmLEtGiVMAZ/YMWpCrennhk3E/+RzGb6MBHZFuRXX8Z7x82XPersQ4untPeX+J
         iHTS8c0emg0xZpD/V3D1ZzmwS4aiJ91GoqqRikCL/Hqf0ktPdGMyPurit+xm59PliXUy
         SqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5xIaxSWXWv+BY7u3XIDDZCXSsuWmT0gj1RNn3WeT6jo=;
        b=uAHz2Wx8G6q5myBJ01Deu8+gKLOsAAywiM5sesfcMiUrBWrTMQOD/sgpWbwsv+Pury
         T7I3EKNEFf1R3k2tJae+VAFEw9HPePWjxQHb1/8Nu60oGJaVgrBRC+9pCaDNTqbJCBle
         4GD1J7rDjabLcJi7NRGRcWwZj0l+FQrNqeh9F0LRiIlZHhzrN0g2ZHLOdur6wqbFV8Yw
         RDq4FyLKpH/devichJZp6ph75mxYfHpvbIeoTE5qIiFC/7BGmOad0mXQt1of4/B18PiC
         iK6MoaF3nJ+17hPRuBcTiNkVgjkY2Xgh6ORd7343ekWnV5VQX69tUVK7kqkMqjJve+KV
         K1fA==
X-Gm-Message-State: APjAAAWgJ89F5u899/4pi2mLTxwKAr2kgaK/Za1fJjXWcC5rkXZ1vctC
        rWGjBxuHf3Mg0mpMKl4VvnU=
X-Google-Smtp-Source: APXvYqyGwNgHJjAbPErgp7d92efsGb28B/mHjGqeW1D+0PbIqhHqZP46gOI3+zH2ceFzkqpuRTyLWQ==
X-Received: by 2002:a63:e10b:: with SMTP id z11mr29626167pgh.46.1553674289531;
        Wed, 27 Mar 2019 01:11:29 -0700 (PDT)
Received: from localhost.localdomain ([220.94.163.20])
        by smtp.gmail.com with ESMTPSA id f9sm25852488pfd.10.2019.03.27.01.11.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 01:11:28 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sidong Yang <realwakka@gmail.com>,
        Michael Straube <straube.linux@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: pi433: Fix rf69_set_tx_cfg() logic
Date:   Wed, 27 Mar 2019 08:11:20 +0000
Message-Id: <20190327081120.11152-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moved code to configure sync to where check enable_sync option before.
There is no need to check enable_sync twice. Configuring sync should be
executed immediately after enabling sync.

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 drivers/staging/pi433/pi433_if.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index 53928af696a6..0a48d6cb9547 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -318,10 +318,17 @@ rf69_set_tx_cfg(struct pi433_device *dev, struct pi433_tx_cfg *tx_cfg)
 			return ret;
 	}
 
+	/* configure sync, if enabled */
 	if (tx_cfg->enable_sync == OPTION_ON) {
 		ret = rf69_enable_sync(dev->spi);
 		if (ret < 0)
 			return ret;
+		ret = rf69_set_sync_size(dev->spi, tx_cfg->sync_length);
+		if (ret < 0)
+			return ret;
+		ret = rf69_set_sync_values(dev->spi, tx_cfg->sync_pattern);
+		if (ret < 0)
+			return ret;
 	} else {
 		ret = rf69_disable_sync(dev->spi);
 		if (ret < 0)
@@ -348,16 +355,6 @@ rf69_set_tx_cfg(struct pi433_device *dev, struct pi433_tx_cfg *tx_cfg)
 			return ret;
 	}
 
-	/* configure sync, if enabled */
-	if (tx_cfg->enable_sync == OPTION_ON) {
-		ret = rf69_set_sync_size(dev->spi, tx_cfg->sync_length);
-		if (ret < 0)
-			return ret;
-		ret = rf69_set_sync_values(dev->spi, tx_cfg->sync_pattern);
-		if (ret < 0)
-			return ret;
-	}
-
 	return 0;
 }
 
-- 
2.17.1

