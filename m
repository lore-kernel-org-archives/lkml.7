Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21C6C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 03:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D00320862
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 03:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRT3IpcP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfEMDdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 23:33:44 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35470 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbfEMDdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 23:33:43 -0400
Received: by mail-pg1-f193.google.com with SMTP id h1so6019085pgs.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 20:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ssvJqTtxKhAvLQPzQtpUqE8pWc5Fl+uFeyG3o3mGIG4=;
        b=hRT3IpcPm+r4T4Tp/gntF0uo4Co799yVXIYapcJ32vTkYN7nrUdCVlLGOJXKF4nwOy
         z9hUNBFPaCwgWjm2OfTCFA9Xh2KkdlAMmItYq0IJituQcXTbeJEBaqeKg6KGrWqgF8mg
         24tIG+UNvYOv6Ge9Pq4AsvvrhN4llYMZJbNBO23Amb+7Lw0MZoJuRAemsbHy+gM62KDK
         PJiZ3Iy/DlyAxOeMfxyWgjlbt7CM5sdJL/gXOhdIpBvOKRK6UCm8kBaCwEpWU6SMuTSn
         LOplrvoPtTcLuPVaDR7UlOy12GznY3tuYaQkA02iGHkf35ppQ6MQFElSX5NTA5nmIdFi
         Acpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ssvJqTtxKhAvLQPzQtpUqE8pWc5Fl+uFeyG3o3mGIG4=;
        b=QM7YYI2b8QN/TZPtbXEBc8xl3IMz6DCUdYVGZ0deso8UAliJ/VKUksnvgsMw7lQExe
         B7if4hJ+shTSyOEVOMyBC3hUFQEq7U0ymKwIr1wvgNOtc0Wg2Zx2srZwmqYxPmbC2rYO
         4z4vE0JsHHpdOZuIKaAIcSjIYOnE6S0A683EXAUYbbUZTU2PyLdsUm2DGtS640IyTDTa
         qKdbCaGXfJrxifa0Rsg8J09JC6esWgGJwEftf/YWlAWh873irNnfG+zqRswgrDe4oh+a
         c7eYsvEHNW1JwaEiY71EVx2hszhs/EQ6Sb04it/RdaRLk9mVQoynvABKWsuonHdrNV/A
         MtFA==
X-Gm-Message-State: APjAAAXRybtHFd5iRXGJeMtXMH0muoQpWpJIJL9Q5ZmXZNL3t6hZwE0O
        Wx974BRsXqvK+se3s9PofGE=
X-Google-Smtp-Source: APXvYqz0YNkp3r1oW/cR5CLyk4nKsq08dG0CjUW/rr7bPspvFvqYqKgC38adXFG3pYZvhMR60rFrgQ==
X-Received: by 2002:a63:8149:: with SMTP id t70mr28919889pgd.134.1557718422627;
        Sun, 12 May 2019 20:33:42 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id k6sm10883791pfi.86.2019.05.12.20.33.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 May 2019 20:33:41 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Cory Tusar <cory.tusar@pid1solutions.com>,
        Chris Healy <cphealy@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: spi-nor: Add Micron MT25QL02 support
Date:   Sun, 12 May 2019 20:33:26 -0700
Message-Id: <20190513033326.20352-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry for Micron MT25QL02 which is a 3V variant of already
supported MT25QU02.

Testing was done on a ZII VF610 Dev Board (rev. B).

Signed-off-by: Cory Tusar <cory.tusar@pid1solutions.com>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Marek Vasut <marek.vasut@gmail.com>
Cc: Tudor Ambarus <tudor.ambarus@microchip.com>
Cc: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---

Previous verion of the patch: https://lore.kernel.org/patchwork/patch/577372/

 drivers/mtd/spi-nor/spi-nor.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index fae147452aff..2a644f01254c 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1881,6 +1881,7 @@ static const struct flash_info spi_nor_ids[] = {
 	{ "n25q00",      INFO(0x20ba21, 0, 64 * 1024, 2048, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ | NO_CHIP_ERASE) },
 	{ "n25q00a",     INFO(0x20bb21, 0, 64 * 1024, 2048, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ | NO_CHIP_ERASE) },
 	{ "mt25qu02g",   INFO(0x20bb22, 0, 64 * 1024, 4096, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ | NO_CHIP_ERASE) },
+	{ "mt25ql02g",   INFO(0x20ba22, 0, 64 * 1024, 4096, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ | NO_CHIP_ERASE) },
 
 	/* Micron */
 	{
-- 
2.21.0

