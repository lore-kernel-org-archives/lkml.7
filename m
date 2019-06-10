Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945B9C468C1
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 08:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A061207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 08:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="XzZad7db"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388533AbfFJIox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 04:44:53 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35079 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388015AbfFJIow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 04:44:52 -0400
Received: by mail-lj1-f194.google.com with SMTP id x25so2535570ljh.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 01:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=viMSGsc2sH0W4IamaJJExlMYXXNFTJxIq9rBwrE28ZY=;
        b=XzZad7db3BzZ+fs690M8G/7gjIdkmNFjn87kBq8NB4vwHApSl3dvbKDaEGMnLyEbJT
         S2jBdwEIQoat/s5EhPGVUoU7i2MtFO9extCYw1u1l6ZWplHwsd9G0M9CHwklY559gtgZ
         yQ/yibKNitRd116j5OwhJHvOAQEkPZiWo/VnIqi4bt7jj2o0jInEn6w0TK6hG/dTWiUZ
         5LW1ZZ/NMk6F1mGVCpjpr4gWvW//8p5Ri6LNX1Bq7faMHNG+wfDQtZIzre19vj/1cRO+
         Pe6t8kPTpMZRLgHsdfdxJE4MQSsUK74nm2dHz1Qyva/34Sifnp/aURX4N4OwD7AhrXZq
         DO2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=viMSGsc2sH0W4IamaJJExlMYXXNFTJxIq9rBwrE28ZY=;
        b=gk8v6BbBI+5ktCMbyViCixMQxqmbIDceJvySmDCJKr78ntIg3pJeycKQ4nc28zb58O
         WtxFM7JAGYUjv+hxUuan/sdjFqcbsRIUWP7Lg+DigBuyFXFNjxJNXtGfWlhz6NY/qK0D
         PXmOn0rXuNO4EEYhgi9OH+D03r/7bEua/QPNL8mkmzg8E1KaoJwDTxjTW2L31Q71Ri+g
         kESzCebLy0rXgLhIJnUFvl/966bvD5teGHSNQNrf4qDVT8qiMjW/+B1zj4c24V3oZ9PZ
         7ZaGXneu89lozz0hj2PCRPrOOF7w7sXyXfg5wE7gw65YfBd1LPEPNzNhv6jJmwzM7LCZ
         Ks+w==
X-Gm-Message-State: APjAAAWRZNQwMMmIQK+Cp6BwWPJHyYMSnaCg2ZU2ajGXn7L8FkJc9wlb
        EgFlw34eiNsT9GE25bflgJwL+A==
X-Google-Smtp-Source: APXvYqx39pIo8wgQDowe84y2NSSgUtjyhTm+QhSfv07LWWIofmxuaKXLJTf9/+XwfECUA1AzDovlCg==
X-Received: by 2002:a2e:824d:: with SMTP id j13mr34494963ljh.137.1560156289819;
        Mon, 10 Jun 2019 01:44:49 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id e26sm1826486ljl.33.2019.06.10.01.44.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 01:44:49 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     =simon@nikanor.nu, jeremy@azazel.net, dan.carpenter@oracle.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
Subject: [PATCH 1/5] staging: kpc2000: remove unnecessary debug prints in cell_probe.c
Date:   Mon, 10 Jun 2019 10:44:28 +0200
Message-Id: <20190610084432.12597-2-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190610084432.12597-1-simon@nikanor.nu>
References: <20190610084432.12597-1-simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Debug prints that are used only to inform about function entry or exit
can be removed as ftrace can be used to get this information.

Signed-off-by: Simon Sandström <simon@nikanor.nu>
---
 drivers/staging/kpc2000/kpc2000/cell_probe.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000/cell_probe.c b/drivers/staging/kpc2000/kpc2000/cell_probe.c
index f731a97c6cac..138d16bcf6e1 100644
--- a/drivers/staging/kpc2000/kpc2000/cell_probe.c
+++ b/drivers/staging/kpc2000/kpc2000/cell_probe.c
@@ -344,8 +344,6 @@ static int  create_dma_engine_core(struct kp2000_device *pcard, size_t engine_re
 	struct mfd_cell  cell = { .id = engine_num };
 	struct resource  resources[2];
 
-	dev_dbg(&pcard->pdev->dev, "create_dma_core(pcard = [%p], engine_regs_offset = %zx, engine_num = %d)\n", pcard, engine_regs_offset, engine_num);
-
 	cell.platform_data = NULL;
 	cell.pdata_size = 0;
 	cell.name = KP_DRIVER_NAME_DMA_CONTROLLER;
@@ -414,9 +412,6 @@ int  kp2000_probe_cores(struct kp2000_device *pcard)
 	unsigned int highest_core_id = 0;
 	struct core_table_entry cte;
 
-	dev_dbg(&pcard->pdev->dev, "%s(pcard = %p / %d)\n", __func__, pcard,
-		pcard->card_num);
-
 	err = kp2000_setup_dma_controller(pcard);
 	if (err)
 		return err;
-- 
2.20.1

