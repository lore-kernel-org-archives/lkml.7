Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F69C3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 17:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ABC82086C
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 17:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfHRRj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 13:39:59 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:43019 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfHRRj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 13:39:59 -0400
Received: by mail-yb1-f193.google.com with SMTP id o82so3586053ybg.10
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 10:39:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xRA6A3IpkVXBsZQsDundHQBjGso3fPaNrTm4wSuFb2I=;
        b=uU0J1dSdSR7wvFsgN5du50NOA4Kv2eLMyfQlPiwjTiLDsbSNMF19nVD/lgvsYSf6uM
         BcUf0wMSytjl1VQChOOHjxbSuZYtALfBWKObQbedeb24oCoodGERIx2Zsg1S0CBYqJUz
         ngiSG+eUkLSESsH0G+Uktchz56ORLNWg0TWNvULzdBtcvkG75XRlWEkj9bH+S6TATQLg
         CXIVL1iaUeV+G5bdjaEY6G1fjNTeL6+TKGMYu7eePwuv2ITVYzrZXJtsfUFyeJXmwD+J
         4FNP81tTTQAW+DuD6NfssmmDo5PTqMHC0EgPV1wa0wcalMhf/nUfm6M2f0Ncor9tlkCH
         Ko/g==
X-Gm-Message-State: APjAAAWYKSQq7wo2jFtbMiuYb80yJfualV5iC/i7Ah0Z1DZu4voIY4Bp
        iRQc0o/HJWjBFjVXqwlGb8c=
X-Google-Smtp-Source: APXvYqz6cIYNKgmPI9/ElWLDLvo/dZWKDKfDQtT9fbhsMqawO74UYd5k8zODyNwRk3ic6wYVKMqM5Q==
X-Received: by 2002:a25:782:: with SMTP id 124mr14756624ybh.106.1566149998215;
        Sun, 18 Aug 2019 10:39:58 -0700 (PDT)
Received: from localhost.localdomain (24-158-240-219.dhcp.smyr.ga.charter.com. [24.158.240.219])
        by smtp.gmail.com with ESMTPSA id d81sm254314ywe.59.2019.08.18.10.39.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Aug 2019 10:39:57 -0700 (PDT)
From:   Wenwen Wang <wenwen@cs.uga.edu>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org (open list:SPI NOR SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] mtd: spi-nor: fix a memory leak bug
Date:   Sun, 18 Aug 2019 12:39:53 -0500
Message-Id: <1566149993-2748-1-git-send-email-wenwen@cs.uga.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In spi_nor_parse_4bait(), 'dwords' is allocated through kmalloc(). However,
it is not deallocated in the following execution if spi_nor_read_sfdp()
fails, leading to a memory leak. To fix this issue, free 'dwords' before
returning the error.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 drivers/mtd/spi-nor/spi-nor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 03cc788..a41a466 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -3453,7 +3453,7 @@ static int spi_nor_parse_4bait(struct spi_nor *nor,
 	addr = SFDP_PARAM_HEADER_PTP(param_header);
 	ret = spi_nor_read_sfdp(nor, addr, len, dwords);
 	if (ret)
-		return ret;
+		goto out;
 
 	/* Fix endianness of the 4BAIT DWORDs. */
 	for (i = 0; i < SFDP_4BAIT_DWORD_MAX; i++)
-- 
2.7.4

