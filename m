Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787F7C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 17:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 553D12087E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 17:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbfHSRQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 13:16:11 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:43508 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbfHSRQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 13:16:11 -0400
Received: by mail-yb1-f194.google.com with SMTP id o82so677984ybg.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 10:16:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TMs535P7xxFLiQOk7wJAthNZTpkgqr1nBQtH4nH/Y58=;
        b=IsZolRq4D9ugD/n3Cx6odZ/1xIGiQ9XQL2IuWwAmIYWhbxIJx8dl6HcU7d5Ob44QHt
         ElaZvwnjhMgPhaOIAqszEwy+jKzICfAY06gudCjwe2YrdpPYFdvugT+CTrU53FYDAHd9
         pmnJM1tp8UggQw3Duk7e6f26skYNyukq2na0Cp+jNi23iqo/s9KVthkuQXEK8Sw4DfdO
         Mv/c1BMYcAqziNZ7zpdeWzit5D06938NgiRLKrKjEzRTsIgw9SuC1ZfY+q7v56DLOoc5
         9Hhx/pCc6nwUAnfQPjnRomSXoy7SFJevLZUNhR10KUIL7Rm6VgUFvB4maUvp92SLDcXM
         E5Bg==
X-Gm-Message-State: APjAAAXRf0DbVsYyFDT9OLxBcJH0p2WTtm0qtpnxdS79Gr9bJs/rCv7r
        5bD11CUDRu08CB7r/yjQMjI=
X-Google-Smtp-Source: APXvYqzS9X155iH1jfQ8BTy+g0T7ZE1WrdMJBLi8pYxlufq1uAsp5sPKPqwPuIsEDAgWqjqEQvRXSA==
X-Received: by 2002:a25:9747:: with SMTP id h7mr16350427ybo.432.1566234969941;
        Mon, 19 Aug 2019 10:16:09 -0700 (PDT)
Received: from localhost.localdomain (24-158-240-219.dhcp.smyr.ga.charter.com. [24.158.240.219])
        by smtp.gmail.com with ESMTPSA id d195sm3365808ywb.101.2019.08.19.10.16.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Aug 2019 10:16:08 -0700 (PDT)
From:   Wenwen Wang <wenwen@cs.uga.edu>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org (open list:SPI NOR SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] mtd: spi-nor: fix a memory leak bug
Date:   Mon, 19 Aug 2019 12:16:00 -0500
Message-Id: <1566234960-3226-1-git-send-email-wenwen@cs.uga.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In spi_nor_parse_4bait(), 'dwords' is allocated through kmalloc(). However,
it is not deallocated in the following execution if spi_nor_read_sfdp()
fails, leading to a memory leak. To fix this issue, free 'dwords' before
returning the error.

Fixes: 816873eaeec6 ("mtd: spi-nor: parse SFDP 4-byte Address Instruction
Table")

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 drivers/mtd/spi-nor/spi-nor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 03cc788..a41a466 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -3453,7 +3453,7 @@ static int spi_nor_parse_4bait(struct spi_nor *nor,
 	addr = SFDP_PARAM_HEADER_PTP(param_header);
 	ret = spi_nor_read_sfdp(nor, addr, len, dwords);
 	if (ret)
-		return ret;
+		goto out;
 
 	/* Fix endianness of the 4BAIT DWORDs. */
 	for (i = 0; i < SFDP_4BAIT_DWORD_MAX; i++)
-- 
2.7.4

