Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00B3C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 16:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB624205ED
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 16:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jCllPuGG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfEGQCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 12:02:24 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45396 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbfEGQCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 12:02:24 -0400
Received: by mail-pf1-f193.google.com with SMTP id e24so8872578pfi.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 09:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oVg9jhszQTOKPX1D60R98eWmwxuEwcGgeC32BmiCC7A=;
        b=jCllPuGG8CrK7CTMwCkPKJYL8zWr7vbjz1mIx6XznvK5UfqWJ+oGbQwQ7BrGMxrZdR
         EMskKWRZWvyoLeA0ZHjTBMw4Ezwyb1li4pFRfnJNzc3Rw9lHnZZMQvT1n72ndA34inD5
         rK36vY68JHuoh3mG4Sjo9j1fYBLFwhTB9bvgtVqA/n8zqeMcKFi/esIQxprmjjyg69k1
         FLWWsD5XNk2baGjknlh6l96sRSsJ6GTQ8vcfyT/vtJmprBC5zB7GeMn8woGr3+NCdJcf
         8rQnyVPK1SqZh42lawjJFYBpMOnwDMNmxamehqpzlhUInJWqRqO9lfzmUA+dTY0AeWKg
         M5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=oVg9jhszQTOKPX1D60R98eWmwxuEwcGgeC32BmiCC7A=;
        b=Ua8RTCASfG1+WzBnT5Phi10vRovzPwV4tgi0i9lZ00ADKsPIq7fq2Er9R49Gor4RvI
         XBvAAx/umr41tnXZvnqCG0j049OLAML0V5XlUjm3PEP2lz3Fm2ff8fQhyWDcJOCAG0Uw
         Yd6sjuFmDhMVQGmk6QDw4fsopNwx58moNETCO3LcEnc/9hhgkPPvjtZlcsnBVO2YH8qd
         714mXTxUZwdRyc+c+52ZlF5jyRkTZaeqBaS9i8nVqIcBtFod81+K+GqNeRWqtwCtKdRq
         ec6TF5LGjDztGa8WsNgUF9C0ja7dOblcueCNAixEBkTW9XvFf93CzWi6XWOqC4LGjtvj
         r5YQ==
MIME-Version: 1.0
X-Gm-Message-State: APjAAAVvFncqGGX3ey3VSbo2uPafN+Nvf6RNnP3sWtFFANuy8QpyICqA
        oN5lUVYkIN26iciXhxrHrKtvt1bFUZEUrrc7pDUrjDn1dS120L/A/Zut56lIVv5nbInW/VdBe5x
        COXMfdf6lRFINm1/5dg==
X-Google-Smtp-Source: APXvYqxvTAzllwIFd/OziGSwstlA9MxwXjvNPS8YISEepDqnYpycNRekLcN8eZHCxxqH0o+kb7b26Q==
X-Received: by 2002:a63:1cf:: with SMTP id 198mr32137329pgb.155.1557244943756;
        Tue, 07 May 2019 09:02:23 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id h187sm22543540pfc.52.2019.05.07.09.02.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 May 2019 09:02:22 -0700 (PDT)
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     marek.vasut@gmail.com, tudor.ambarus@microchip.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        bbrezillon@kernel.org, richard@nod.at, palmer@sifive.com,
        aou@eecs.berkeley.edu, paul.walmsley@sifive.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Subject: [PATCH v3 v3 3/3] mtd: spi-nor: add locking support for is25xxxxx device
Date:   Tue,  7 May 2019 21:29:35 +0530
Message-Id: <1557244775-14206-3-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1557244775-14206-1-git-send-email-sagar.kadam@sifive.com>
References: <1557244775-14206-1-git-send-email-sagar.kadam@sifive.com>
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement a basic locking scheme for ISSI devices similar to that of
stm_lock mechanism. The is25xxxxx  devices have 4 bits for selecting
the range of blocks to be locked/protected from erase/write.

The current implementation enables block protection as per the table
defined into datasheet for is25wp256d device.

Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 51 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 3942b26..5986260 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1459,6 +1459,56 @@ static int macronix_quad_enable(struct spi_nor *nor)
 
 	return 0;
 }
+/**
+ * issi_lock() - set BP[0123] write-protection.
+ * @nor: pointer to a 'struct spi_nor'.
+ * @ofs: offset from which to lock memory.
+ * @len: number of bytes to unlock.
+ *
+ * Lock a region of the flash.Implementation is based on stm_lock
+ * Supports the block protection bits BP{0,1,2,3} in the status register
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int issi_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
+{
+	int status_old, status_new, blk_prot;
+	u8 mask = SR_BP3 | SR_BP2 | SR_BP1 | SR_BP0;
+	u8 shift = ffs(mask) - 1;
+	u8 pow;
+	loff_t num_blks;
+
+	status_old = read_sr(nor);
+
+	/* if status reg is Write protected don't update bit protection */
+	if (status_old & SR_SRWD) {
+		dev_err(nor->dev,
+			"Status register is Write Protected, can't lock bit
+			protection bits...\n");
+		return -EINVAL;
+	}
+	num_blks = len / nor->info->sector_size;
+
+	pow = order_base_2(num_blks);
+
+	blk_prot = mask & (((pow+1) & 0xf)<<shift);
+
+	/*
+	 * Return if older protected blocks include the new requested block's
+	 */
+	if (((status_old >> shift) & 0x0f) > blk_prot) {
+		dev_info(nor->dev, "newly requested blocks are
+				already protected ");
+		return 0;
+	}
+
+	status_new = status_old | blk_prot;
+
+	if (status_old == status_new)
+		return 0;
+
+	return write_sr_and_check(nor, status_new, mask);
+}
 
 /**
  * issi_unlock() - clear BP[0123] write-protection.
@@ -4124,6 +4174,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
 	/* NOR protection support for ISSI chips */
 	if (JEDEC_MFR(info) == SNOR_MFR_ISSI ||
 	    info->flags & SPI_NOR_HAS_LOCK) {
+		nor->flash_lock = issi_lock;
 		nor->flash_unlock = issi_unlock;
 
 	}
-- 
1.9.1


-- 
The information transmitted is intended only for the person or entity to 
which it is addressed and may contain confidential and/or privileged 
material. If you are not the intended recipient of this message please do 
not read, copy, use or disclose this communication and notify the sender 
immediately. It should be noted that any review, retransmission, 
dissemination or other use of, or taking action or reliance upon, this 
information by persons or entities other than the intended recipient is 
prohibited.
