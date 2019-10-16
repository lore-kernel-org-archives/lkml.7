Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5368ECE58F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 01:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AED1E2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 01:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2cAhIp1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389441AbfJPBjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 21:39:48 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33655 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728260AbfJPBjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 21:39:48 -0400
Received: by mail-pg1-f196.google.com with SMTP id i76so13262347pgc.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 18:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BrtU0AEZKYDZWBVf1gNKSefnw5x4YOEIDWqA8O0kKHA=;
        b=V2cAhIp1eAQXSLsvZn1Z/vzHKU3uE2JriGrV7Is0yjbwy34Sblarunskfnq9WXrCh/
         eBleZMcFOTJoOSJD21r+v92UP3uCfaTmc9xM0iNOqE2WeSBMbSK2cMuL4qQ4Q4wyOYEJ
         eH8QzVu9/OJF1GVKXtya4KVJNbdCw8Vlm3+uTGDZrNkAQ54vrsTKeQaN+hGpe82w/S0p
         9Eaa4ensoPOAKcFfxerpyRHy3HrdLonOPMI5WyH422b55csWQiY0ZMSDJlZlkhdf4svk
         xvNJRIXEWkAA5Zl4mr8GbrMdZP1Ma0A4GPh2pQska5TzhFbwyGHQWkLEZse51bdCBgNe
         skaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BrtU0AEZKYDZWBVf1gNKSefnw5x4YOEIDWqA8O0kKHA=;
        b=V6L+MsmtPKaqmfDLANwTw2RnTKKwB57xv7t2tWLAhMN3tvRTTq0HOf8PMJlMhUE4KD
         4gUuNehKaiw8/+rCtw7xgTdrHvEmCYsJl0qHhKOsxMD7sHuAISnSFMd2Y1MklzUDKd2M
         zCv7JTzftyIOAEHrLDvuuzDHC+Hhz2+jrPhYDlZE7QQLWixKXCm/OAO6WFOh0immuLr/
         HIuHoLDlx+EolRIz4WzreLZa09CHJhB1eK3ta1eazE4IgZYbnbfK7vedcGqfAvLTpYm7
         i7beZ9fO3r6kwKrCf/RBj/y425gMNdnSpw1Ta0eXLjLyIViMgQgLvYbSOxTSS31ElcRC
         kNYQ==
X-Gm-Message-State: APjAAAVq4qYSr2hEcE6WofmAJXBgwpKYJQ1hljePk9WUCPrL+HLvNWRM
        y29eCAJFw8I0K+lMvJO4i4sJjv5jaf5OsQ==
X-Google-Smtp-Source: APXvYqwKDR4nRa/MAA2CIiB+2BRslacdm8lDn2OMwvYG7HxBI27huc24uwQYeD6zKQBU1JLWRkVb0A==
X-Received: by 2002:a63:e509:: with SMTP id r9mr25758636pgh.431.1571189987702;
        Tue, 15 Oct 2019 18:39:47 -0700 (PDT)
Received: from localhost.localdomain ([2001:19f0:7001:2668:5400:1ff:fe62:2bbd])
        by smtp.gmail.com with ESMTPSA id v8sm574725pje.6.2019.10.15.18.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 18:39:46 -0700 (PDT)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     Chuanhong Guo <gch981213@gmail.com>,
        Jeff Kletsky <git-commits@allycomm.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Stefan Roese <sr@denx.de>, linux-kernel@vger.kernel.org
Subject: [PATCH][RFC] mtd: spinand: fix detection of GD5FxGQ4xA flash
Date:   Wed, 16 Oct 2019 09:38:24 +0800
Message-Id: <20191016013845.23508-1-gch981213@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GD5FxGQ4xA didn't follow the SPI spec to keep MISO low while slave is
reading, and instead MISO is kept high. As a result, the first byte
of id becomes 0xFF.
Since the first byte isn't supposed to be checked at all, this patch
just removed that check.

While at it, redo the comment above to better explain what's happening.

Fixes: cfd93d7c908e ("mtd: spinand: Add support for GigaDevice GD5F1GQ4UFxxG")
Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
CC: Jeff Kletsky <git-commits@allycomm.com>
---
RFC:
I doubt whether this patch is a proper fix for the underlying problem:
The actual problem is that we have two different implementation of read id
command: One replies immediately after master sending 0x9f and the other
need to send 0x9f and an offset byte (found in winbond and early GD flashes.)
Current code only works if SPI master is properly implemented (i.e. keep MOSI
low while reading.)
I'm wondering if it worths to split the implementation of read_id into two
variants and assign corresponding ID tables to each variant, or we could
trust all SPI controllers and this fix is sufficient.

 drivers/mtd/nand/spi/gigadevice.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/spi/gigadevice.c b/drivers/mtd/nand/spi/gigadevice.c
index e99d425aa93f..ab0e53b09f0c 100644
--- a/drivers/mtd/nand/spi/gigadevice.c
+++ b/drivers/mtd/nand/spi/gigadevice.c
@@ -249,13 +249,14 @@ static int gigadevice_spinand_detect(struct spinand_device *spinand)
 	int ret;
 
 	/*
-	 * Earlier GDF5-series devices (A,E) return [0][MID][DID]
-	 * Later (F) devices return [MID][DID1][DID2]
+	 * Earlier GDF5-series devices (A,E) need sending an extra offset
+	 * byte before replying flash ID, so the first byte is undetermined.
+	 * Later (F) devices don't need that.
 	 */
 
 	if (id[0] == SPINAND_MFR_GIGADEVICE)
 		did = (id[1] << 8) + id[2];
-	else if (id[0] == 0 && id[1] == SPINAND_MFR_GIGADEVICE)
+	else if (id[1] == SPINAND_MFR_GIGADEVICE)
 		did = id[2];
 	else
 		return 0;
-- 
2.21.0

