Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB78AC48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B46205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhEd+Upb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfF0RjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:39:14 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44594 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbfF0RjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:39:14 -0400
Received: by mail-pf1-f194.google.com with SMTP id t16so1571465pfe.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 10:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cO/EhwNLhEBZIOJaWYP275DFWQtB2l0qegc0KCTXlr4=;
        b=OhEd+Upb76lWIf0OlxsFw/JBvbBQsZ4lM6cn4tqa3owGLsDTVW+5Se/Uk6sZBSYUQ9
         hm5E9vPF1A4sydujUM8mxkGxGEyd5x1n54ziJY+zSHrN9I4mvrr5Zwv3mzKvheBGaHZ1
         OZkvw6VQpxk3SLRzAAs+LTHJ0bzmn8WXYzrpedhtgoC2TKe2ErLVAIPZCtiKhKtHeQRD
         EX79wZjXAEkURAG4UPeaHevFj5OxMI7B2C7GdYmg/YBSm4HxoQrkZCDIMxD5618z4o7W
         O53GJvcR+PKh/GcyO21HY5FnNdv3Jim3+uXYAQNlQTQleoqxelLOWPwKfLMMc089EboC
         vB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cO/EhwNLhEBZIOJaWYP275DFWQtB2l0qegc0KCTXlr4=;
        b=uIocYn/YQ7p747/I1Ycq6B0L/6Ws/z1gvWX0rbQO1BSuO2IxrDmHyag1HPwmoVio6I
         BMFk6KOi+x8HjS2FYFhH6pB0DLCK2/RByhvl3Sf+AU0aGSF+gDRysROOZ3Q7zo59VB+h
         CWsd45BajTB10uIHxGoZcniuFAdx1fhLfIXH0tfQI5ynImJBwaFgUmTYpo27V810DUVI
         trNdjfyZrf6UzTSbOwur2v09ZCcnMpK5tkHNthsM20atgD/B1xxmtTb6yM2ZcmnrLIAa
         zbBnZ8rxtmc+E1zlW1V9ud03K6YGxKqK4bDT2FoHCJumwo2r0eKqPOCvJOIIe5ErUVmD
         5eug==
X-Gm-Message-State: APjAAAUAgtqZ95ekEdkrVGjWv8HkHOWvTyCoFgBrbuXupwAZFTMmrZzD
        XWjMag5TJKGcWl8P87DKDL0=
X-Google-Smtp-Source: APXvYqx1+lqv+Rv9CYPJbjHJvv96N0Pg00kJiUjVmyPJ/ERoLmFfoLDu+geOyscEfSCTTegdydwoNg==
X-Received: by 2002:a17:90a:bb8a:: with SMTP id v10mr7556179pjr.78.1561657153468;
        Thu, 27 Jun 2019 10:39:13 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id 133sm3450478pfa.92.2019.06.27.10.39.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:39:13 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 35/87] mtd: nand: replace kmalloc and memset with kzalloc in nand_bch.c
Date:   Fri, 28 Jun 2019 01:39:05 +0800
Message-Id: <20190627173906.3675-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmalloc + memset(0) -> kzalloc

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/mtd/nand/raw/nand_bch.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_bch.c b/drivers/mtd/nand/raw/nand_bch.c
index 55aa4c1cd414..17527310c3a1 100644
--- a/drivers/mtd/nand/raw/nand_bch.c
+++ b/drivers/mtd/nand/raw/nand_bch.c
@@ -170,7 +170,7 @@ struct nand_bch_control *nand_bch_init(struct mtd_info *mtd)
 		goto fail;
 	}
 
-	nbc->eccmask = kmalloc(eccbytes, GFP_KERNEL);
+	nbc->eccmask = kzalloc(eccbytes, GFP_KERNEL);
 	nbc->errloc = kmalloc_array(t, sizeof(*nbc->errloc), GFP_KERNEL);
 	if (!nbc->eccmask || !nbc->errloc)
 		goto fail;
@@ -182,7 +182,6 @@ struct nand_bch_control *nand_bch_init(struct mtd_info *mtd)
 		goto fail;
 
 	memset(erased_page, 0xff, eccsize);
-	memset(nbc->eccmask, 0, eccbytes);
 	encode_bch(nbc->bch, erased_page, eccsize, nbc->eccmask);
 	kfree(erased_page);
 
-- 
2.11.0

