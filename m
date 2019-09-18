Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE71C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 16:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F4EE21920
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 16:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lHwAihyQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731857AbfIRQCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 12:02:42 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40179 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfIRQCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 12:02:41 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10so92804pgj.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 09:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GmcLSQu6EQAPA4h2lTeOhp0gk5DIW9Hi/4PZD6ne2GI=;
        b=lHwAihyQ01mNJtRlkEW+zkPVzH7UN8YNJXaBctlQNpIunIvVg6WN0WEdXI8t5rk2Bi
         RUrfAstL9JVlFpP/c3KOvWqDNzrtR7+IYAS7TGcOoB46wOLsdiXhx1uuo0MWNqsHm9V7
         h3w2jHTh10BIcHn4CDyjqjbNZCdCCyQhafdFmzvxsC7i/5YRosUbwiwdaF8XZoZ/Ikmt
         4qI+8/4UTWN9tlpuJGLujevehagKhBMf7TgEJBy3gpC9MDHln5DN6jtkSOOxYLz8F7Jb
         g4S9sB51TTBrRobOH22E+ccjjnVfhGuoxzGV3N4Ze3FC5JzVyvwAnGspg3cF/W3bdQqf
         lyUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GmcLSQu6EQAPA4h2lTeOhp0gk5DIW9Hi/4PZD6ne2GI=;
        b=gBThDNAtDctLDhgO0Vv/GMl847jmNr9u4+bxm9AAPLDXF0ldqZfPAaijn9HsW4SOoQ
         OdXCIM1pn4fBOJ+4RTJ8Zl9Omu4BLy7QDiunn7ap39WZY2K3XBZP9CE9g+0BcgrilThR
         hu6ShExiVcU7z6NogY0ieKd1og+FGDeJ9kMRoBVc7UZs6mFJlvoR/3gjRoWUukeMAmzw
         +YR1Gr6I6K/0S9oKm6kLocP4Eg7KyNQhEw8/PRPz1FaXgZZUHcApXiLT5mA7undmPOQj
         WkdHK7X/sQlJ4JfnHoEs5OCkHLbyh3gUg2LixXhV+pZIRCVpGiCnfU8XljS9ww1AfoyV
         bL/g==
X-Gm-Message-State: APjAAAUlKE64F84XUeN7DbWbiXOtq7iFFzR61BdX/nTKb8iFtJ/nB062
        0GHv7ZPQzmPNBRb0a+KDqI6zbQ==
X-Google-Smtp-Source: APXvYqxqsqKgZ2IZgToJhuCvJIAOwPTlNQxrTbdYExiHkeaBfu8MCmPQqWqbRpaNvkXeYJ5WvqewIg==
X-Received: by 2002:aa7:8005:: with SMTP id j5mr5077266pfi.50.1568822560215;
        Wed, 18 Sep 2019 09:02:40 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id g12sm9872379pfb.97.2019.09.18.09.02.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Sep 2019 09:02:39 -0700 (PDT)
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     marek.vasut@gmail.com, tudor.ambarus@microchip.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     paul.walmsley@sifive.com, palmer@sifive.com, aou@eecs.berkeley.edu,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Subject: [PATCH v9 2/2] mtd: spi-nor: fix nor->addr_width for is25wp256
Date:   Wed, 18 Sep 2019 21:31:45 +0530
Message-Id: <1568822505-19297-3-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1568822505-19297-1-git-send-email-sagar.kadam@sifive.com>
References: <1568822505-19297-1-git-send-email-sagar.kadam@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the post bfpt fixup hook for the is25wp256 device as done for
is25lp256 device to overwrite the address width advertised by BFPT.

For instance the standard devices eg: IS25WP256D-JMLE where J stands
for "standard" does not support SFDP.

Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 003c1c7..75e8560 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1949,7 +1949,7 @@ static int spi_nor_spansion_clear_sr_bp(struct spi_nor *nor)
 	{ "is25wp256", INFO(0x9d7019, 0, 64 * 1024, 512,
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
 			SPI_NOR_4B_OPCODES)
-	},
+			.fixups = &is25lp256_fixups },
 	/* Macronix */
 	{ "mx25l512e",   INFO(0xc22010, 0, 64 * 1024,   1, SECT_4K) },
 	{ "mx25l2005a",  INFO(0xc22012, 0, 64 * 1024,   4, SECT_4K) },
-- 
1.9.1

