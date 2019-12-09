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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43D1C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 20:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E0F62068E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 20:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KewqzZ67"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfLIUuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 15:50:17 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44245 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfLIUuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 15:50:17 -0500
Received: by mail-ot1-f68.google.com with SMTP id x3so13440454oto.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 12:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a0z9b/fkZig/G7onSfzc2Xau8/wqkpIlIH1o9ziXfO0=;
        b=KewqzZ67eCJA9rsLegJPup+LEo0UaO8XtrPvGuu19iDVHzUu1NLEt49+HiTE2qqDAi
         Qgs1RhtYHm4QDykQec0Zr66/Q4Btt5fbLgPZMVuM4wJIT5BBI/drs/AV+vzFLi6/WJef
         x1D75rymK5cMsZ918vJFmzmjIv8XyTDXiO6eaEVNMQHf47qt1mlIngtj4UJ6CKywyefd
         MgwAQ/YNkUtC0sx5g+06Au7iKg6f5ZGYovmfUtqqXlV9yJrHrIWwoOztZzmn9ncSp+0/
         yjIVMx8iZTcdJRyxYzlxqt/iuW4eO3hPyy7h5R9pzkdBeQ4Z31tsMOEnCpB2eVWbkl29
         t7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a0z9b/fkZig/G7onSfzc2Xau8/wqkpIlIH1o9ziXfO0=;
        b=b9DkBJn2zOVogMRy4pFRlfWcGJVEIJIK4L64F/YT00VH0Cu5LyOvU9YuC9LDqOwKm1
         PaXHKpisQm3JKWDoMv8L1GKfOCZsOCxUD+7B4bxKU6lwbZyB6hia4XL6WXmb1dFrsDTC
         CPxmTNSbo3VmBc/yhnw/ZnjVMOmf8N44cFt6KwoqjlgzzoSr0ihFeuwIU9N7alUpgt9u
         LwLpaeGLg+uWm0KOP8dGMH+ia7YmNLkcrLDVwKsgnBNeeXD16SHqW0igpM8l23MCGvQE
         0SMhfNHsAyAWV5ditSb7UKvGHwGxgrFTLAMR3o8cr68zCQP/hGZHYWIhZSYfdo/jUvgK
         G6og==
X-Gm-Message-State: APjAAAUNm5iy1G0nn5rY6qqOF5fqDwAzkGRSvVquCvZ2h5CJR4OcsqKw
        Rva7FXbsrTtXGID4qJqRYh4=
X-Google-Smtp-Source: APXvYqwcs6FBEhf12NatET7C92kg8e/a6i0Gd/Cl4K8D9L5c4Ksvjlg5tApvV70N2s9qDrj9rwG8bQ==
X-Received: by 2002:a05:6830:20cf:: with SMTP id z15mr23195602otq.277.1575924615824;
        Mon, 09 Dec 2019 12:50:15 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id f3sm389396oto.57.2019.12.09.12.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 12:50:15 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Kyungmin Park <kyungmin.park@samsung.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] mtd: onenand_base: Adjust indentation in onenand_read_ops_nolock
Date:   Mon,  9 Dec 2019 13:50:10 -0700
Message-Id: <20191209205010.4115-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.24.0
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
 drivers/mtd/nand/onenand/onenand_base.c | 64 ++++++++++++-------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/mtd/nand/onenand/onenand_base.c b/drivers/mtd/nand/onenand/onenand_base.c
index 77bd32a683e1..c84ac749d70e 100644
--- a/drivers/mtd/nand/onenand/onenand_base.c
+++ b/drivers/mtd/nand/onenand/onenand_base.c
@@ -1266,26 +1266,26 @@ static int onenand_read_ops_nolock(struct mtd_info *mtd, loff_t from,
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
@@ -1302,23 +1302,23 @@ static int onenand_read_ops_nolock(struct mtd_info *mtd, loff_t from,
 		}
 
  		/* See if we are done */
- 		read += thislen;
- 		if (read == len)
- 			break;
- 		/* Set up for next read from bufferRAM */
- 		if (unlikely(boundary))
- 			this->write_word(ONENAND_DDP_CHIP1, this->base + ONENAND_REG_START_ADDRESS2);
- 		ONENAND_SET_NEXT_BUFFERRAM(this);
- 		buf += thislen;
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

