Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4F7C10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 04:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA7220879
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 04:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDzGIH//"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfDAEty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 00:49:54 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45641 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfDAEtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 00:49:53 -0400
Received: by mail-pl1-f195.google.com with SMTP id bf11so3830745plb.12
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 21:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=moNJlz8Hnp8YLvfjdfiXHR1qR6R97pFA3oXU5nhsmmU=;
        b=SDzGIH//bFj5ysGW9Bn4ADrZSYG7CaIdulWP2HGxnsk+BALBtIkYpbUa42iQKrpvfk
         gZDagi7qJeK3zODSAh6PWxsvRsyWjO7wqK1lONBVo8jGGamAtBf05XpCCjioEOwmXCX/
         l7Qho1wfAnhtAqqz3s+SSGfffkKKrrnhR2gZKu7J99PYHRQWCnAU6aYJgQQazoqhbM3i
         VIPGuQJ6mArLwnNxoq8LDZNjvWtdZhrMvxiZSCmLLvptPp4zC8Rd6J38EAXhIM84IAln
         Xd0MRNgwZY9P/HiwPmjBsFfxzYH3dLNvj/q8ANVOZpaMDhCVJyzcoA5R96AZ0PqGFLHD
         LPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=moNJlz8Hnp8YLvfjdfiXHR1qR6R97pFA3oXU5nhsmmU=;
        b=NkOAc1PwW53D7n+F5svy/GbVdOcTdzBC1+NaiJKbjFVsAGXNxD8vpHDTmYRKBedEwf
         pg14lFRVl4d9Mhe4g+HSnlbeGgzt9UW1OhXBKAo2fbZ4qh343daHvfpTSkR9MOvxwOwP
         K/KC6wzCLWTx0x3WhdDB1Nt4MMw8GmhL74EImSvcGMhxOnQExO7R+nBzBOYfx6txS6pj
         AJ/FvXZkyP6eiH6z1Ql9VTIOJoGEaTHikrJdlyat+iw5iij9eJenifg8JdBcJhOL33Jk
         zhPjnrcVE8NK8f0A9Xch0ssco7D72sU4D0/Wv9SSVLQpO8ReJt5zRpvZElsM4Hvgglrk
         +Dlw==
X-Gm-Message-State: APjAAAUFqsJYUZJLiF09ABP0+hEfYoUX5sB6KrMpmd1IxorjcAlp4Gqm
        UYBQLmGYtnV03quQVU+E7FY=
X-Google-Smtp-Source: APXvYqxPoH5bx85nZpF1l5tdVoirRcUd3/NBIvDFXloIEDGmac9KOCbNo8hjLENNpqF5oQ9voX9hQw==
X-Received: by 2002:a17:902:bb98:: with SMTP id m24mr40860174pls.17.1554094192397;
        Sun, 31 Mar 2019 21:49:52 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id i31sm16256097pgi.36.2019.03.31.21.49.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 21:49:51 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] mtd: devices: m25p80: Share code between m25p80_read() and m25p80_write()
Date:   Sun, 31 Mar 2019 21:49:38 -0700
Message-Id: <20190401044938.31237-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190401044938.31237-1-andrew.smirnov@gmail.com>
References: <20190401044938.31237-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move shared parts of m25p80_read() and m25p80_write() into a separate
subroutine and convert the rest of the code to use it. No functional
change intended.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Brian Norris <computersforpeace@gmail.com>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Marek Vasut <marek.vasut@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/mtd/devices/m25p80.c | 58 ++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 33 deletions(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index a54cad9bb6e3..199f7c210799 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -81,34 +81,41 @@ static int m25p80_write_reg(struct spi_nor *nor, u8 opcode, u8 *buf, int len)
 	return ret;
 }
 
-static ssize_t m25p80_write(struct spi_nor *nor, loff_t to, size_t len,
-			    const u_char *buf)
+static ssize_t m25p80_read_write(struct spi_nor *nor, struct spi_mem_op *op,
+				 enum spi_nor_protocol proto)
 {
 	struct m25p *flash = nor->priv;
-	struct spi_mem_op op =
-			SPI_MEM_OP(SPI_MEM_OP_CMD(nor->program_opcode, 1),
-				   SPI_MEM_OP_ADDR(nor->addr_width, to, 1),
-				   SPI_MEM_OP_NO_DUMMY,
-				   SPI_MEM_OP_DATA_OUT(len, buf, 1));
 	int ret;
 
 	/* get transfer protocols. */
-	op.cmd.buswidth = spi_nor_get_protocol_inst_nbits(nor->write_proto);
-	op.addr.buswidth = spi_nor_get_protocol_addr_nbits(nor->write_proto);
-	op.data.buswidth = spi_nor_get_protocol_data_nbits(nor->write_proto);
-
-	if (nor->program_opcode == SPINOR_OP_AAI_WP && nor->sst_write_second)
-		op.addr.nbytes = 0;
+	op->cmd.buswidth = spi_nor_get_protocol_inst_nbits(proto);
+	op->addr.buswidth = spi_nor_get_protocol_addr_nbits(proto);
+	op->data.buswidth = spi_nor_get_protocol_data_nbits(proto);
 
-	ret = spi_mem_adjust_op_size(flash->spimem, &op);
+	ret = spi_mem_adjust_op_size(flash->spimem, op);
 	if (ret)
 		return ret;
 
-	ret = spi_mem_exec_op(flash->spimem, &op);
+	ret = spi_mem_exec_op(flash->spimem, op);
 	if (ret)
 		return ret;
 
-	return op.data.nbytes;
+	return op->data.nbytes;
+}
+
+static ssize_t m25p80_write(struct spi_nor *nor, loff_t to, size_t len,
+			    const u_char *buf)
+{
+	struct spi_mem_op op =
+			SPI_MEM_OP(SPI_MEM_OP_CMD(nor->program_opcode, 1),
+				   SPI_MEM_OP_ADDR(nor->addr_width, to, 1),
+				   SPI_MEM_OP_NO_DUMMY,
+				   SPI_MEM_OP_DATA_OUT(len, buf, 1));
+
+	if (nor->program_opcode == SPINOR_OP_AAI_WP && nor->sst_write_second)
+		op.addr.nbytes = 0;
+
+	return m25p80_read_write(nor, &op, nor->write_proto);
 }
 
 /*
@@ -118,32 +125,17 @@ static ssize_t m25p80_write(struct spi_nor *nor, loff_t to, size_t len,
 static ssize_t m25p80_read(struct spi_nor *nor, loff_t from, size_t len,
 			   u_char *buf)
 {
-	struct m25p *flash = nor->priv;
 	struct spi_mem_op op =
 			SPI_MEM_OP(SPI_MEM_OP_CMD(nor->read_opcode, 1),
 				   SPI_MEM_OP_ADDR(nor->addr_width, from, 1),
 				   SPI_MEM_OP_DUMMY(nor->read_dummy, 1),
 				   SPI_MEM_OP_DATA_IN(len, buf, 1));
-	int ret;
-
-	/* get transfer protocols. */
-	op.cmd.buswidth = spi_nor_get_protocol_inst_nbits(nor->read_proto);
-	op.addr.buswidth = spi_nor_get_protocol_addr_nbits(nor->read_proto);
-	op.dummy.buswidth = op.addr.buswidth;
-	op.data.buswidth = spi_nor_get_protocol_data_nbits(nor->read_proto);
 
+	op.dummy.buswidth = spi_nor_get_protocol_addr_nbits(nor->read_proto);
 	/* convert the dummy cycles to the number of bytes */
 	op.dummy.nbytes = (nor->read_dummy * op.dummy.buswidth) / 8;
 
-	ret = spi_mem_adjust_op_size(flash->spimem, &op);
-	if (ret)
-		return ret;
-
-	ret = spi_mem_exec_op(flash->spimem, &op);
-	if (ret)
-		return ret;
-
-	return op.data.nbytes;
+	return m25p80_read_write(nor, &op, nor->read_proto);
 }
 
 /*
-- 
2.20.1

