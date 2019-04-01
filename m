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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2214EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 04:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D30482086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 04:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kl3XAJBY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfDAEtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 00:49:50 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38178 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfDAEtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 00:49:50 -0400
Received: by mail-pf1-f195.google.com with SMTP id 10so3908180pfo.5
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 21:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rk3Ae2iwNpo3lJh94VQoOUfBl1sapgxDeR3iigr8IFI=;
        b=kl3XAJBYCjf0iJDQydJiH/wnpxYJYmf/4h+qPjqt+Vf1xBRsvLKwRqRbHQYtU7uBoi
         YBRuR8VkBo7/HDqGrY9lBqR4+iPGFdm9ul1t2Y3r8u0hNaLSfrpNxXG7+cz3++q8n7z+
         jmFB5hC7H58SFPm8WkkBiv8yb+NyfJUP1R5zx/0dvpPgXNxziIXng+QX38MrN/+7XoIx
         6aHxd9JrYuOZpP3QW5On7FhFk7h40Payo6D65ZlIG92r70KagvAP6gMaWcJK28d9YS8j
         51WzBmtnc9IptlxbCj2DJYjQ6Qxop5E0+4o0/X3quFqFF1QG1roYosDaET9b7ka/eoe3
         rArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rk3Ae2iwNpo3lJh94VQoOUfBl1sapgxDeR3iigr8IFI=;
        b=EktWa7tQZyE19WheY2Rq3EBV6W1QgFSQWKIYpy50t0hQzgk/BszljxBBmVk1zDEPOu
         NTJc3/ebW+5epjo9AyT2J7ebup0sal8utYF8+YRUlZxpORzKhUqlVo/Tx/SUUnpR9TaH
         XOI6aHYfhv8ohpOnjdgjPYvy/IQIqGth4Nvysvd5P6+CRmuS9PRpGwCFsbU/ASdqfDc6
         n2UUlIXUNy6ohmOCN6G8c4uMzztjdGgr0K8Tr84oZTKmuqqxPsjkN+y2lUgXLAvOBrUP
         lruwB95Df0SLE/HKJK8BzpU+cq80Nhi/sQBH71VVXbtU31plvqucYQSPajxUViwXF9hj
         TOJA==
X-Gm-Message-State: APjAAAWSj29fvwRgKdmdQqliJqJnE9ngT8B+s0Xr6DyNVw/BId8UTWTH
        DZxFhtVqmFbLXPin3VaTPsc=
X-Google-Smtp-Source: APXvYqwCxcLKi1hn7lh62EKf97H9X5HzM++8mfnXaBl/H7zDkjPcSUaGSLhaO75HisOxb7/zG5H9PA==
X-Received: by 2002:a65:6148:: with SMTP id o8mr17857564pgv.153.1554094189465;
        Sun, 31 Mar 2019 21:49:49 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id i31sm16256097pgi.36.2019.03.31.21.49.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 21:49:48 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Chris Healy <cphealy@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] mtd: devices: m25p80: Simplify m25p80_read()
Date:   Sun, 31 Mar 2019 21:49:36 -0700
Message-Id: <20190401044938.31237-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Spi_nor_read() already has an appropriate loop around .read() callback
to handle the case when not all of the data requested was written in a
signle ->read() call. Drop extra code doing the same thing in
m25p80_read().

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Brian Norris <computersforpeace@gmail.com>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Marek Vasut <marek.vasut@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/mtd/devices/m25p80.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index 651bab6d4e31..114f8ccea85b 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -125,7 +125,6 @@ static ssize_t m25p80_read(struct spi_nor *nor, loff_t from, size_t len,
 				   SPI_MEM_OP_ADDR(nor->addr_width, from, 1),
 				   SPI_MEM_OP_DUMMY(nor->read_dummy, 1),
 				   SPI_MEM_OP_DATA_IN(len, buf, 1));
-	size_t remaining = len;
 	int ret;
 
 	/* get transfer protocols. */
@@ -137,22 +136,15 @@ static ssize_t m25p80_read(struct spi_nor *nor, loff_t from, size_t len,
 	/* convert the dummy cycles to the number of bytes */
 	op.dummy.nbytes = (nor->read_dummy * op.dummy.buswidth) / 8;
 
-	while (remaining) {
-		op.data.nbytes = remaining < UINT_MAX ? remaining : UINT_MAX;
-		ret = spi_mem_adjust_op_size(flash->spimem, &op);
-		if (ret)
-			return ret;
-
-		ret = spi_mem_exec_op(flash->spimem, &op);
-		if (ret)
-			return ret;
+	ret = spi_mem_adjust_op_size(flash->spimem, &op);
+	if (ret)
+		return ret;
 
-		op.addr.val += op.data.nbytes;
-		remaining -= op.data.nbytes;
-		op.data.buf.in += op.data.nbytes;
-	}
+	ret = spi_mem_exec_op(flash->spimem, &op);
+	if (ret)
+		return ret;
 
-	return len;
+	return op.data.nbytes;
 }
 
 /*
-- 
2.20.1

