Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54338C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 18:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3298A21721
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 18:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DtHMYn33"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbfGBSkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 14:40:19 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40963 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfGBSkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 14:40:18 -0400
Received: by mail-pg1-f194.google.com with SMTP id q4so6622939pgj.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 11:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0sF1tajbszgBkWrij+qh2Snun7Hdtkh6IqSmd5cLEoI=;
        b=DtHMYn33VMItS9Mqb2A54QLPgAHX3jNXlN2eS6J91/O6uY1z5UrJtJLI0XK57V19bz
         ndWySJwRfhNNtwkOkV5slrphsfMsZDy9Ei8txwVJgxuU60vPZIrno2FdLdyFXDLNcE6E
         5N6i/WXXz/+a37iqGWmZFlMhdyuWuV43td52R4cIU2sNVxvvg35pGctcBOI6Vpu4nZRb
         c9QBstZskl4Uu34b8ec+cRPQod7wIw9rN5xvDbD6o13VJ1ssJBLUUelzdmj9qc0wOOK3
         f7SpWpXVUGyQuWX/0bw/cpN/xiuYaC0qTsm/sPgKvO0jueJtIhCE9W/pr28seC2qlEId
         kfNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0sF1tajbszgBkWrij+qh2Snun7Hdtkh6IqSmd5cLEoI=;
        b=DQcv5cLoQ6uBJZmIw6bwQ6dPqwbuIZwDTioCe20CxidxIrBCVbuF2YCwLBVmIHR087
         7UIxtLZCjyjohkLWWRC0JXmEfTsnkvBisGK2tSOs5GqEVlU3FpY+pP54wXctFu9OXLTM
         PYj4FIIm8ngGJShPsJlSmdKY6oM8mysPy9MDfmBAkBiqkD9LD+HkZtfU+XmlclBuEeD7
         5gaSVjKfAQ71r+SWVxBYRLuDiT3z3+wQnQCz1oxdepe4NS7B+Nzoi0T5CyxhoRGAQfAz
         14THhAPoegcv/i81+Yp4tbJczKKg+CGqGiDkiI5To2LaKfp2S+0QXrVA8ACYPkXMHO8P
         otjg==
X-Gm-Message-State: APjAAAWxPOmVqdpoGycO4hm6/bKAy1uAYHiEcvNZAGfLoe8lKoCARoLR
        b548V9FnzzFNLXYxdg40m+NPg/ERu7Q=
X-Google-Smtp-Source: APXvYqzBLTVQUac6Xd9mE/tyVVz8vJIhTDTtyInPwU1KgqLrBTp0CAZs3Cu/UvLMDc9hMl7J+7xLzQ==
X-Received: by 2002:a63:610e:: with SMTP id v14mr32174956pgb.221.1562092818008;
        Tue, 02 Jul 2019 11:40:18 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id e10sm15065327pfi.173.2019.07.02.11.40.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Jul 2019 11:40:17 -0700 (PDT)
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     marek.vasut@gmail.com, tudor.ambarus@microchip.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     palmer@sifive.com, aou@eecs.berkeley.edu, paul.walmsley@sifive.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Subject: [PATCH v7 2/4] mtd: spi-nor: fix nor->addr_width for is25wp256
Date:   Wed,  3 Jul 2019 00:09:03 +0530
Message-Id: <1562092745-11541-3-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1562092745-11541-1-git-send-email-sagar.kadam@sifive.com>
References: <1562092745-11541-1-git-send-email-sagar.kadam@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the post bfpt fixup hook for the is25wp256 device as done for
is25lp256 device to overwrite the address width advertised by BFPT.

For instance the standard devices eg: IS25WP256D-JMLE where J stands
for "standard" does not support SFDP.

Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 971f0f3..315eeec 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1860,7 +1860,7 @@ static int sr2_bit7_quad_enable(struct spi_nor *nor)
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

