Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D023FC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 12:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97F0021D56
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 12:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="MOlak7eH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390328AbfISM3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 08:29:48 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38125 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389275AbfISM3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 08:29:48 -0400
Received: by mail-wm1-f67.google.com with SMTP id 3so3750297wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 05:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ih/MDhEc/lR/EwwEWd3UKHZku0wmOCPvpYdqNd7Cz3I=;
        b=MOlak7eHLX23anoot934MZPNCqef49OxOac8Pza7p1zC+IDnTa6+D9nOHorfBejy36
         XEdV05aEj0wP1+o9uwLdfQdWQyzTOJ0ZAmvaFnkmKmyxhMXjuJYAm33Yz2x0TkmnsdHW
         zU5ZqlaIfSDtNTWqGnoU4EftY6U2Kh++BvXSAvGG6pSeilS8SDvl2vvHTW/O4GRH2H30
         uTecNMafO95TjhTMtK4XYXYhSekGxXNpnuTluTNVP+pzARHkbznR4yZkAKcWvct0CV6F
         rdz8UljICE9v2iWgDSbWMFua5epnyEpndor195DpDgx4rkq+DivxLiNb7lumlEcWcpay
         lbKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ih/MDhEc/lR/EwwEWd3UKHZku0wmOCPvpYdqNd7Cz3I=;
        b=gFKAh3+G3bVdbdrGO9dKKnOX0y3I5tLyiWT98ZlJii1vmLrIZK9iaXM4sgBWzfI4cx
         D29zkb9JB5BGXaZztLYPja+n5h1v2VopG4KnxiZ6LFhz22WZsa92fS/mRLATwoQ0w9pU
         R57Hlbmsp7W9MVwwEj/HwDGYO2NmspCqQ7WVPZUvdji1Wk+8vtWbgcfY3VqOv+CggjBh
         Jo/lwRjaqOZ/5AYqPK0Tw8wCifx0LCfOBsd0qiONOFIQW59AUFeLE+G7fW7jsULg7QEr
         S6uIOki8VZ3yQPbc1qkhCQK235MWOc3qI1/94hLcQXO12GcArmjTOw3ZcSRHfb9MXBcY
         xxcQ==
X-Gm-Message-State: APjAAAXntMqyqZwkPG3/9SqIuej89ztKIWNBTx0U76Jvlpr+576XVSWs
        Gnfn50tygbVyf1jRV1dveDwliA==
X-Google-Smtp-Source: APXvYqx4hKCNiv9gZpKM7ZBFgWrBwYBYMkwk3rpvdDiIL6bb7B9oUvwnBLk2HXj2VFiNljt+us5Ktw==
X-Received: by 2002:a05:600c:118a:: with SMTP id i10mr2640350wmf.80.1568896186212;
        Thu, 19 Sep 2019 05:29:46 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id s10sm9203194wmf.48.2019.09.19.05.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 05:29:45 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] mtd: st_spi_fsm: remove unused variable
Date:   Thu, 19 Sep 2019 14:29:37 +0200
Message-Id: <20190919122937.29850-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The region resource in struct stfsm is unused and can be removed.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/mtd/devices/st_spi_fsm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/devices/st_spi_fsm.c b/drivers/mtd/devices/st_spi_fsm.c
index f4d1667daaf9..1888523d9745 100644
--- a/drivers/mtd/devices/st_spi_fsm.c
+++ b/drivers/mtd/devices/st_spi_fsm.c
@@ -255,7 +255,6 @@ struct stfsm_seq {
 struct stfsm {
 	struct device		*dev;
 	void __iomem		*base;
-	struct resource		*region;
 	struct mtd_info		mtd;
 	struct mutex		lock;
 	struct flash_info       *info;
-- 
2.23.0

