Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93906C3A589
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 02:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635D020651
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 02:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfHSCqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 22:46:13 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:42937 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfHSCqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 22:46:13 -0400
Received: by mail-yw1-f65.google.com with SMTP id z63so117404ywz.9
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 19:46:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wGyW4pmaDvW/xobvRCheZylYnIK2Mlk/QoBxdqMYERo=;
        b=O8wURTL7Pmq9H0Brh31yayN5tSkyan97DBe/UbyblOSm+JTV51Fb6CVHedeGIDlmc3
         RVweYJnqv6WROXoofXdHyMFxiCQ7Ko6rZnPbMwpXr8Zl22Yg+Zrj9kiA0QaD8LplDPNT
         f4eAeVxCyAmx49bONKY3zPuHTaTn1s9GZZWdo5wDOZzs2OS3fHy2iyAXAAGqmb6ERia6
         bEOvfh9LLOKzAIP+3jKzEhzJOJdrTLO/KsirtyU8FNbP1E6fbEb7LNHIqPZrnxH0HHW1
         eX/eH4Z6Y+MxWJWM5rtoH71RyCbJUaFlnSW25OSpnQJqTi87T/6ltkGGw8rQ0FdyBdVf
         p3Aw==
X-Gm-Message-State: APjAAAU4zBTxIzHi6oBNUgQlSLdcsrw17C+6NgRqv6YUEnRqk0gAoXmF
        2cqwTrtaRKhEVw5to4U4SpU=
X-Google-Smtp-Source: APXvYqxoqUvLyiINr9C0Xyto3ZIWpr93pZJ3NNHxY+/QOIirO6rnDaZKXJlvaGNVhJtf7wrPe/gFbQ==
X-Received: by 2002:a81:ae55:: with SMTP id g21mr14907282ywk.222.1566182772167;
        Sun, 18 Aug 2019 19:46:12 -0700 (PDT)
Received: from localhost.localdomain (24-158-240-219.dhcp.smyr.ga.charter.com. [24.158.240.219])
        by smtp.gmail.com with ESMTPSA id r9sm2991434ywl.108.2019.08.18.19.46.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Aug 2019 19:46:11 -0700 (PDT)
From:   Wenwen Wang <wenwen@cs.uga.edu>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-mtd@lists.infradead.org (open list:NAND FLASH SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] mtd: rawnand: Fix a memory leak bug
Date:   Sun, 18 Aug 2019 21:46:04 -0500
Message-Id: <1566182765-7150-1-git-send-email-wenwen@cs.uga.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In nand_scan_bbt(), a temporary buffer 'buf' is allocated through
vmalloc(). However, if check_create() fails, 'buf' is not deallocated,
leading to a memory leak bug. To fix this issue, free 'buf' before
returning the error.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 drivers/mtd/nand/raw/nand_bbt.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_bbt.c b/drivers/mtd/nand/raw/nand_bbt.c
index 2ef15ef..96045d6 100644
--- a/drivers/mtd/nand/raw/nand_bbt.c
+++ b/drivers/mtd/nand/raw/nand_bbt.c
@@ -1232,7 +1232,7 @@ static int nand_scan_bbt(struct nand_chip *this, struct nand_bbt_descr *bd)
 	if (!td) {
 		if ((res = nand_memory_bbt(this, bd))) {
 			pr_err("nand_bbt: can't scan flash and build the RAM-based BBT\n");
-			goto err;
+			goto err_free_bbt;
 		}
 		return 0;
 	}
@@ -1245,7 +1245,7 @@ static int nand_scan_bbt(struct nand_chip *this, struct nand_bbt_descr *bd)
 	buf = vmalloc(len);
 	if (!buf) {
 		res = -ENOMEM;
-		goto err;
+		goto err_free_bbt;
 	}
 
 	/* Is the bbt at a given page? */
@@ -1258,7 +1258,7 @@ static int nand_scan_bbt(struct nand_chip *this, struct nand_bbt_descr *bd)
 
 	res = check_create(this, buf, bd);
 	if (res)
-		goto err;
+		goto err_free_buf;
 
 	/* Prevent the bbt regions from erasing / writing */
 	mark_bbt_region(this, td);
@@ -1268,7 +1268,9 @@ static int nand_scan_bbt(struct nand_chip *this, struct nand_bbt_descr *bd)
 	vfree(buf);
 	return 0;
 
-err:
+err_free_buf:
+	vfree(buf);
+err_free_bbt:
 	kfree(this->bbt);
 	this->bbt = NULL;
 	return res;
-- 
2.7.4

