Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B9BC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 21:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 182E024655
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 21:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkPhOsRf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfLIVpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 16:45:08 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37910 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfLIVpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 16:45:08 -0500
Received: by mail-ot1-f66.google.com with SMTP id h20so13637020otn.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 13:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ER5XOmpfTbyA77VZ0mW/V+9R8ytRWk1qGHF5rdwU7So=;
        b=OkPhOsRfdqcG7yIBu/Vxs7LM4zdcAq2xGCHoNVMFrpG8RA/x57P9Nk91e6XPNtYeu0
         yDLoILlRLTckXgD3qIBvjEmg9h/L2cnI/7MS87MiMg+eKQumXK8XiQayMtfVsydRrxSf
         yQ8GfSJz6U1IVCsjGVj5In76A4ET/ZM7F23H/mHd+t4YDtKLMZXNmpA9dhfF82OUH31t
         j1156+QLTqu5x6kD/xkDX9GT4B4xXtM7PUm8qgmfNRFXrKupcA26mgfdA82s2yr1cOpy
         WRpSmo7QTP4EmuL9OdAnLEek3XxeUtID/DxtXojmKEWYfyffb9G9oeYdS6rqNmcDSiSx
         CKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ER5XOmpfTbyA77VZ0mW/V+9R8ytRWk1qGHF5rdwU7So=;
        b=SOgRZDkCDb6Z4qXrkMYkwrOIr0JP7SyX/dzTuanB0Izii53MlISSBqVFuLKT7L0uwX
         ZljMCBCsf9Vuzna6F+2dNKFai/K8DaEhhSnvL754c8u/RO5rWC6VJHaWLL8byngMZGuh
         NY3L4k+L24iDDk0rAicIxBYM7apUPOolxxW6y7cEKGFLFY63oKfVe34N7PUdS2yRyG0B
         88BBuppO4xnBjKRfXsVEBzhXzZo4/wISV62zOownfWTLu4Rnw6iKyJWRJd9fPJUqmp1t
         odNgXGOTmeDS29KRKxArfaBNgAhR9BXGeNbbPbeYr6lx7hpJuwhcG7RGvJuC6fWP+ine
         1QeA==
X-Gm-Message-State: APjAAAVhlTTWvDMPMXngVvXOI+KzHGRkIGiH92+qPXEFJZI4LYkgBdst
        0YcVJLahgaSrG23Lf2ezh70=
X-Google-Smtp-Source: APXvYqwY43CbS3Sb8mZuD3/Jw8lqjWbnbiMpng2baZgioTPwEu3ffo+xD2GO+SEDxlxfOGQeHXrzAg==
X-Received: by 2002:a9d:366:: with SMTP id 93mr1778892otv.183.1575927907211;
        Mon, 09 Dec 2019 13:45:07 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id t80sm533904oih.23.2019.12.09.13.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 13:45:06 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Kyungmin Park <kyungmin.park@samsung.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH v3] mtd: onenand_base: Adjust indentation in onenand_read_ops_nolock
Date:   Mon,  9 Dec 2019 14:44:23 -0700
Message-Id: <20191209214422.53661-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191209210328.18866-1-natechancellor@gmail.com>
References: <20191209210328.18866-1-natechancellor@gmail.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

../drivers/mtd/nand/onenand/onenand_base.c:1269:3: warning: misleading
indentation; statement is not part of the previous 'if'
[-Wmisleading-indentation]
        while (!ret) {
        ^
../drivers/mtd/nand/onenand/onenand_base.c:1266:2: note: previous
statement is here
        if (column + thislen > writesize)
        ^
1 warning generated.

This warning occurs because there is a space before the tab of the while
loop. There are spaces at the beginning of a lot of the lines in this
block, remove them so that the indentation is consistent with the Linux
kernel coding style and clang no longer warns.

Fixes: a8de85d55700 ("[MTD] OneNAND: Implement read-while-load")
Link: https://github.com/ClangBuiltLinux/linux/issues/794
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

* Clean up the block before the one that warns, which was added as part
  of the fixes commit (Nick).

v2 -> v3:

* Fix one missed conversion (Nick).

 drivers/mtd/nand/onenand/onenand_base.c | 82 ++++++++++++-------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/mtd/nand/onenand/onenand_base.c b/drivers/mtd/nand/onenand/onenand_base.c
index 77bd32a683e1..9e81cd982dd3 100644
--- a/drivers/mtd/nand/onenand/onenand_base.c
+++ b/drivers/mtd/nand/onenand/onenand_base.c
@@ -1248,44 +1248,44 @@ static int onenand_read_ops_nolock(struct mtd_info *mtd, loff_t from,
 
 	stats = mtd->ecc_stats;
 
- 	/* Read-while-load method */
+	/* Read-while-load method */
 
- 	/* Do first load to bufferRAM */
- 	if (read < len) {
- 		if (!onenand_check_bufferram(mtd, from)) {
+	/* Do first load to bufferRAM */
+	if (read < len) {
+		if (!onenand_check_bufferram(mtd, from)) {
 			this->command(mtd, ONENAND_CMD_READ, from, writesize);
- 			ret = this->wait(mtd, FL_READING);
- 			onenand_update_bufferram(mtd, from, !ret);
+			ret = this->wait(mtd, FL_READING);
+			onenand_update_bufferram(mtd, from, !ret);
 			if (mtd_is_eccerr(ret))
 				ret = 0;
- 		}
- 	}
+		}
+	}
 
 	thislen = min_t(int, writesize, len - read);
 	column = from & (writesize - 1);
 	if (column + thislen > writesize)
 		thislen = writesize - column;
 
- 	while (!ret) {
- 		/* If there is more to load then start next load */
- 		from += thislen;
- 		if (read + thislen < len) {
+	while (!ret) {
+		/* If there is more to load then start next load */
+		from += thislen;
+		if (read + thislen < len) {
 			this->command(mtd, ONENAND_CMD_READ, from, writesize);
- 			/*
- 			 * Chip boundary handling in DDP
- 			 * Now we issued chip 1 read and pointed chip 1
+			/*
+			 * Chip boundary handling in DDP
+			 * Now we issued chip 1 read and pointed chip 1
 			 * bufferram so we have to point chip 0 bufferram.
- 			 */
- 			if (ONENAND_IS_DDP(this) &&
- 			    unlikely(from == (this->chipsize >> 1))) {
- 				this->write_word(ONENAND_DDP_CHIP0, this->base + ONENAND_REG_START_ADDRESS2);
- 				boundary = 1;
- 			} else
- 				boundary = 0;
- 			ONENAND_SET_PREV_BUFFERRAM(this);
- 		}
- 		/* While load is going, read from last bufferRAM */
- 		this->read_bufferram(mtd, ONENAND_DATARAM, buf, column, thislen);
+			 */
+			if (ONENAND_IS_DDP(this) &&
+			    unlikely(from == (this->chipsize >> 1))) {
+				this->write_word(ONENAND_DDP_CHIP0, this->base + ONENAND_REG_START_ADDRESS2);
+				boundary = 1;
+			} else
+				boundary = 0;
+			ONENAND_SET_PREV_BUFFERRAM(this);
+		}
+		/* While load is going, read from last bufferRAM */
+		this->read_bufferram(mtd, ONENAND_DATARAM, buf, column, thislen);
 
 		/* Read oob area if needed */
 		if (oobbuf) {
@@ -1301,24 +1301,24 @@ static int onenand_read_ops_nolock(struct mtd_info *mtd, loff_t from,
 			oobcolumn = 0;
 		}
 
- 		/* See if we are done */
- 		read += thislen;
- 		if (read == len)
- 			break;
- 		/* Set up for next read from bufferRAM */
- 		if (unlikely(boundary))
- 			this->write_word(ONENAND_DDP_CHIP1, this->base + ONENAND_REG_START_ADDRESS2);
- 		ONENAND_SET_NEXT_BUFFERRAM(this);
- 		buf += thislen;
+		/* See if we are done */
+		read += thislen;
+		if (read == len)
+			break;
+		/* Set up for next read from bufferRAM */
+		if (unlikely(boundary))
+			this->write_word(ONENAND_DDP_CHIP1, this->base + ONENAND_REG_START_ADDRESS2);
+		ONENAND_SET_NEXT_BUFFERRAM(this);
+		buf += thislen;
 		thislen = min_t(int, writesize, len - read);
- 		column = 0;
- 		cond_resched();
- 		/* Now wait for load */
- 		ret = this->wait(mtd, FL_READING);
- 		onenand_update_bufferram(mtd, from, !ret);
+		column = 0;
+		cond_resched();
+		/* Now wait for load */
+		ret = this->wait(mtd, FL_READING);
+		onenand_update_bufferram(mtd, from, !ret);
 		if (mtd_is_eccerr(ret))
 			ret = 0;
- 	}
+	}
 
 	/*
 	 * Return success, if no ECC failures, else -EBADMSG
-- 
2.24.0

