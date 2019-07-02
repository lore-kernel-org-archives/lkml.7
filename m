Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBC4C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 13:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A0D2064B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 13:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNncWwvr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfGBNPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 09:15:00 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33566 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbfGBNO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 09:14:59 -0400
Received: by mail-io1-f68.google.com with SMTP id u13so36905777iop.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 06:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=0ztf1PZrt5oedAcicUONlFjNaMMVTARFA+N8wrNUA0Q=;
        b=iNncWwvr3JS+GVKMI8sE6eC6JPeOW0+/n7i58LiHB012ztLksHRJlxh3Dx/feaC/c8
         WLDKUGg8QbTbvSU/T7QUCZ8szt5D05PzsX95kpiHiZVQUMqclatZAuKUzRcp0eaPFyII
         GUEEFK5XISpOKmQLQ1HShxxuEOWypcMZgih5/2c/WKpCMa6YuJ/8dyTC3Q2JEGhPFGdh
         fa2PtercOCt01XjTcsrJ+dte3/XLQvFruM3ctguP8K5igwqz458wdgeWwn+YbNLoLRig
         2/zL9MfdnX87SJ5xAJjT6E/Njspq4/rtAFOnwC+4l9xtdn90Jpexxthdt60OOGN/Rz2c
         8bUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=0ztf1PZrt5oedAcicUONlFjNaMMVTARFA+N8wrNUA0Q=;
        b=L6/5LrQikU7qy6f7eqfJFdnjvu+vgExA0gz+Qly/KQRWvcFDRiKC3gVk7Z6ap4VqFV
         8lGXPJOroXohNYJmTxxsWzos5Qp3HhsLTsEvHBfzKYgEaVa5Ni5olZfEBsS2CDq7xRUi
         dRTq3+GnP/gPDrvwSG+aBXavBataL4fxywIEFeQ9DfCoqjE0ZuIZ9hXyWgVLLtY5fPv0
         3AaM8L4DYEqtWIw9Aiqt9pAuyGACwayQVV4y4MgKS4CaqVkRc+m/RNMo33kxa4WZfika
         V0tY+UahGZCgUp9M3x1hmcnz3ShuaeAuawZyosv8mBBjwNSSKBK7pRkt2vXteofvkd0x
         ewbQ==
X-Gm-Message-State: APjAAAVyTvpm4XolUkR54YUdOfJ7HnZYMXc2lxXqc+vFC7w495S9cx8l
        Lw3rqet8jDzDdpohEuXrLg4i5oeFF/lRPc1Xmw==
X-Google-Smtp-Source: APXvYqxx7+xmweS9/gtiu7nUJE63to7JLzDZUwYe4YWkIkWVeq2Xdqecgw6rkU3/6F3u8u3XKiPu4y4tT5b/AxDTXrA=
X-Received: by 2002:a02:b914:: with SMTP id v20mr35251356jan.83.1562073299013;
 Tue, 02 Jul 2019 06:14:59 -0700 (PDT)
MIME-Version: 1.0
From:   Avi Fishman <avifishman70@gmail.com>
Date:   Tue, 2 Jul 2019 16:14:16 +0300
Message-ID: <CAKKbWA4jw9xiHkfF3bk4KTZPazPM5hb9ZANT6hjZyLuv8DM+mA@mail.gmail.com>
Subject: [PATCH] mtd: spi-nor: Add Winbond w25q256jvm
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tomer Maimon <tmaimon77@gmail.com>
Cc:     linux-mtd@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Avi Fishman <avifishman70@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to w25q256 (besides not supporting QPI mode) but with different ID.
The "JVM" suffix is in the datasheet.
The datasheet indicates DUAL and QUAD are supported.
https://www.winbond.com/resource-files/w25q256jv%20spi%20revi%2010232018%20plus.pdf

Signed-off-by: Avi Fishman <avifishman70@gmail.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c
b/drivers/mtd/spi-nor/spi-nor.c index 0c2ec1c21434..ccb217a24404
100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -2120,6 +2120,8 @@ static const struct flash_info spi_nor_ids[] = {
  { "w25q80bl", INFO(0xef4014, 0, 64 * 1024,  16, SECT_4K) },
  { "w25q128", INFO(0xef4018, 0, 64 * 1024, 256, SECT_4K) },
  { "w25q256", INFO(0xef4019, 0, 64 * 1024, 512, SECT_4K |
SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+ { "w25q256jvm", INFO(0xef7019, 0, 64 * 1024, 512,
+ SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
  { "w25m512jv", INFO(0xef7119, 0, 64 * 1024, 1024,
  SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_DUAL_READ) },

--
2.18.0


-- 
Regards,
Avi
