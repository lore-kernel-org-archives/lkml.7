Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A642EC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 12:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7756C20844
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 12:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ktbcE/AL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbfHMMkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 08:40:25 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36242 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbfHMMkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 08:40:24 -0400
Received: by mail-pl1-f196.google.com with SMTP id g4so2760457plo.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 05:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HuZqhFloNsXdkXS3ECm5uIQkv6TKXS63NVePQ94bhBM=;
        b=ktbcE/AL4sb1aIODwft8dRlSCxGZ43zSLC5NCthdXu4fWv5QoHCFZU2fpMaxZWeFFY
         Qyq129wZuAwpk46h68SWoNxmAVjuOoFu54bPyrjGgFvyl5uYNEM9o8godLU+YreMQbZk
         D+aGrUKbdJxHvTWmrPyILeXNH6/s6byaPeKQydLWHwMyg9k2v1D5LdnVcMBqendI1Ehh
         /L+VfdF2mLdy/hYw2Jmc5KAGMdNRZl6i1DNZTI2iYYb+u+BViLHTw/zSc79rm0CfYV3Q
         Yc3G7PPn1gJNXOElBy2rib87uEBdqv/3Mp/FHGJZzX1MEDJCi/9ESXu9+ptqDrtC6Om3
         xjkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HuZqhFloNsXdkXS3ECm5uIQkv6TKXS63NVePQ94bhBM=;
        b=Qm72wNYrogt4eP+SVo+oj5EaES2BXi/f9+TY9zO28aEuvg2d2PiKSncqUz/kv01FIi
         xMmM0GJYbg9WQdHx0cibfK42g3G3dBs55JlEBRj2/q5lB9bIerSwbHpI3xhqITuqoL8j
         pfSAZ+4aWsdyVEcVecK56R5tzA+tpgImy6WG2TsdZGwPABEdI+jVKVmMuA1coIXL6R9J
         ekuab8cW0OvaW3NBaOUU0ivaO6/hhoaC54SRp1IVZGb3TCTURGv0u4WNzZppOr7XqVJA
         w/0eBNWqSSZu+uXQRap9bnRdzavJr0xVT6eqEfJ3OB2PR16tdx7OlVpkTHIZI9bApvKv
         NcdQ==
X-Gm-Message-State: APjAAAX7Q6PFwe1ZgWZx+9WZNHP247Tukj/VXYaLOp9XZ3VUXRKMUXHq
        fXLiniaMzWUNNc8I94nd4yd6uw==
X-Google-Smtp-Source: APXvYqz7sJ7/aKi3Wqp7p4CdH0zx43soAGpeV6N+iBXq71zY2GoOnkwB5xc00uKcMcxN5GsX3ImK3Q==
X-Received: by 2002:a17:902:d890:: with SMTP id b16mr36912634plz.315.1565700024307;
        Tue, 13 Aug 2019 05:40:24 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id v145sm14758467pfc.31.2019.08.13.05.40.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Aug 2019 05:40:23 -0700 (PDT)
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     marek.vasut@gmail.com, tudor.ambarus@microchip.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     paul.walmsley@sifive.com, palmer@sifive.com, aou@eecs.berkeley.edu,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Subject: [PATCH v8 2/4] mtd: spi-nor: fix nor->addr_width for is25wp256
Date:   Tue, 13 Aug 2019 18:08:13 +0530
Message-Id: <1565699895-4770-3-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1565699895-4770-1-git-send-email-sagar.kadam@sifive.com>
References: <1565699895-4770-1-git-send-email-sagar.kadam@sifive.com>
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
index 6635127..cb40b1b 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1949,7 +1949,7 @@ static int spi_nor_spansion_clear_sr_bp(struct spi_nor *nor)
 	{ "is25wp256", INFO(0x9d7019, 0, 64 * 1024, 1024,
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
 			SPI_NOR_4B_OPCODES)
-	},
+			.fixups = &is25lp256_fixups },
 	/* Macronix */
 	{ "mx25l512e",   INFO(0xc22010, 0, 64 * 1024,   1, SECT_4K) },
 	{ "mx25l2005a",  INFO(0xc22012, 0, 64 * 1024,   4, SECT_4K) },
-- 
1.9.1

