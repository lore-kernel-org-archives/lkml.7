Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E59C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B92C42075C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+E/rFtL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfECIxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 04:53:38 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45347 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfECIxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 04:53:38 -0400
Received: by mail-wr1-f67.google.com with SMTP id s15so6759394wra.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 01:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hxORxRJg8TxDLlfuGy/ZAzRDEoGhmOHyilLw0cwtIHE=;
        b=P+E/rFtLuKo6V7IcftbeFuvsBWZeqP7fBd+qzztLJW0ivZCuv4J1MTupMIdRatPHc+
         jCqDWa9HRy0FkT6ADVuV1mQoILMGi/0rM3X0RYGI5za2prQj+yNlQlNAogSkBHKvBnRP
         H1wDJ2677itFTXmNklMmXOKwU49L1xvclp2iN23D2bQJGKNKkYoudtk9jNO7mpHIDorv
         SmStRN62OLDBSrep9FjlSONJ5O8zHPKW+H6ZPoE87XidNFqjA8ZjZki/CX0RkZkpKBI7
         Hd3kKoR+gk5Dcey9oAEJDd4NbRlCOJLlKIBt77abr8jWRj58CMkRtvL83MBr2kOFpoLW
         R7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hxORxRJg8TxDLlfuGy/ZAzRDEoGhmOHyilLw0cwtIHE=;
        b=pnzPLunjgauq0Bb/2DXkYC0cX6VuZve2Slxui+tOIvd4dGz9e9qpsEtTT6D9P8tpG3
         UaqC7nOTppIf6FHznsKbfYMFoxoF3pbfqtDvE6qO6LEoDflK/6dl81nHtQBRB4qQzOc7
         Y9DMaiebXIRzBMiF+30YOnwFyRO8jANs4jKPpng9ki5fdBYeP3e5QD16ZwQlSxkQ1+p9
         B9J2bXO3XPwGyaCnMIhvMBV11gdQK4ha28sO9qGXbpx1vdIl5Tj8XpWYH/WfZZqF34IC
         btU2GyqvC0iVVCTG2XgMDkkcj6Rll89u4EnvC031D5hVVR3fFDLX5feaNr4M7q1tBefK
         kvww==
X-Gm-Message-State: APjAAAVYpYvQs6FOPLmls9DRHKyS1FgqW6rlxWFpaT2I8dh6aST41YLV
        JA+lc3m7S8ZOaraYJPXuXetQpbpX
X-Google-Smtp-Source: APXvYqwI/B+ifQHb8MGrb4+OoTqIzMr8/P6113ljMVFprinxPlpWqnPFz4flV5bbkp7rFn9RLl/ORw==
X-Received: by 2002:a5d:51cf:: with SMTP id n15mr5780238wrv.104.1556873616425;
        Fri, 03 May 2019 01:53:36 -0700 (PDT)
Received: from SiBook.guest.pepperl-fuchs.local ([80.150.243.190])
        by smtp.gmail.com with ESMTPSA id t27sm3592912wrb.27.2019.05.03.01.53.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 01:53:35 -0700 (PDT)
From:   Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
To:     Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org
Cc:     Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
        linux-kernel@vger.kernel.org,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH] mtd: spi-nor: enable 4B opcodes for n25q256a
Date:   Fri,  3 May 2019 10:53:26 +0200
Message-Id: <20190503085327.5180-1-simon.k.r.goldschmidt@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested on socfpga cyclone5 where this is required to ensure that the
boot rom can access this flash after warm reboot.

Signed-off-by: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
---

 drivers/mtd/spi-nor/spi-nor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index fae147452..4cdec2cc2 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1874,7 +1874,7 @@ static const struct flash_info spi_nor_ids[] = {
 	{ "n25q064a",    INFO(0x20bb17, 0, 64 * 1024,  128, SECT_4K | SPI_NOR_QUAD_READ) },
 	{ "n25q128a11",  INFO(0x20bb18, 0, 64 * 1024,  256, SECT_4K | SPI_NOR_QUAD_READ) },
 	{ "n25q128a13",  INFO(0x20ba18, 0, 64 * 1024,  256, SECT_4K | SPI_NOR_QUAD_READ) },
-	{ "n25q256a",    INFO(0x20ba19, 0, 64 * 1024,  512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ "n25q256a",    INFO(0x20ba19, 0, 64 * 1024,  512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ "n25q256ax1",  INFO(0x20bb19, 0, 64 * 1024,  512, SECT_4K | SPI_NOR_QUAD_READ) },
 	{ "n25q512a",    INFO(0x20bb20, 0, 64 * 1024, 1024, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ) },
 	{ "n25q512ax3",  INFO(0x20ba20, 0, 64 * 1024, 1024, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ) },
-- 
2.20.1

