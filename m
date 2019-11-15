Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4E5C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 03:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E6F02068D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 03:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="fYgwOJG4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfKODKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 22:10:33 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43248 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbfKODKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 22:10:32 -0500
Received: by mail-pf1-f196.google.com with SMTP id 3so5648971pfb.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 19:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=TRkIoUi0GBj9I4dT2JvmosKGsiQbJSEbDRvIbo63/Gs=;
        b=fYgwOJG4p9E2bxbHOo4pCi89Hr08mSB/gRVLkMDo8YVyIIskkfZmcetI7SGL1kvyqy
         3eO1N/T57ru6/euwUaEJejoKH6VZACKTd5iN4k1772MFSuuka+MmixMTp3yVdTIpQGK2
         6XY3GqQeP5Yla8O5YPKiW+8loVXwnFV6MAaE8ptt3nqnwPYGr4CMtkGhjPr9UilcBvvh
         sBZ0Yqczu5m/VGWJ+dJ1fphpOECSRurVOpLgb5VHTqsXsuFmgZaI3IlO7FE9T93iRSFt
         UakLoWh57bVXCLTBaVk1wXwvKzlONOWYRoxwdIOs4uuBK5IwWRy4XqgQVfKVfu3Zjd7J
         mHLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TRkIoUi0GBj9I4dT2JvmosKGsiQbJSEbDRvIbo63/Gs=;
        b=OKgy2tkneCke6Jcq4av11p5lyw8Ex2T8PxqDyekuLn1W0K82gWFq8nnJVEDaKjbUgR
         R2jyj1c98/8zCGYtraLDHCYejPtOpEZPpjuuCmf9u5uHO+SWaoSuUvAkdm6TmghbGAEK
         SIHzV4jgJgLOjLTwEdWiZfqw4ot+ANMu38c4bwfXypMSs1ZbNHBO9uu5zEMADT68Gxf8
         3HzHov1dwvEFZed/uJqETKW+jME0kY6s8i7cmBSMUBYEZDu1keglF/H7ClCeyesP2For
         g5FC9mInoIx3r13wimRryB8Uw9GCZtIJyvt6g0dfElfh8Czo4S6W8LDvAqduArUJ2W/g
         h6oA==
X-Gm-Message-State: APjAAAWAAgUgJL/B4Ofrscvr7E8aI0XYUAvgPa9fp/IUFMX1aC6USho0
        UDR11BNrCsYDFwlRWj9iCIalfQ==
X-Google-Smtp-Source: APXvYqxUrktXvFs7jzxCHAmUbP3k8BfyrSbz4O+ZCgj98MyJK5NAdeX2EiyFlAwcnLMJqUyG3/Rkag==
X-Received: by 2002:a63:f743:: with SMTP id f3mr10817140pgk.410.1573787431911;
        Thu, 14 Nov 2019 19:10:31 -0800 (PST)
Received: from localhost.localdomain (111-241-173-86.dynamic-ip.hinet.net. [111.241.173.86])
        by smtp.gmail.com with ESMTPSA id z23sm7260287pgj.43.2019.11.14.19.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 19:10:31 -0800 (PST)
From:   Green Wan <green.wan@sifive.com>
Cc:     Green Wan <green.wan@sifive.com>, Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: sf-pdma: fix kernel-doc W=1 warning
Date:   Fri, 15 Nov 2019 11:10:09 +0800
Message-Id: <20191115031013.30448-1-green.wan@sifive.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix kernel-doc W=1 warning. There are several comments starting from "/**"
but not for function comment purpose. Remove them to fix the warning.
Another definition in front of function causes warning. Move definition
to header file.

kernel-doc warning:

drivers/dma/sf-pdma/sf-pdma.c:28: warning: Function parameter or member
	'addr' not described in 'readq'
drivers/dma/sf-pdma/sf-pdma.c:438: warning: Function parameter or member
	'ch' not described in 'SF_PDMA_REG_BASE'
drivers/dma/sf-pdma/sf-pdma.c:438: warning: Excess function parameter
	'pdma' description in 'SF_PDMA_REG_BASE'

Changes:
 - Replace string '/**' with '/*' not for comment purpose
 - Move definition, "SF_PDMA_REG_BASE", fomr sf-pdma.c to sf-pdma.h

Signed-off-by: Green Wan <green.wan@sifive.com>
---
 drivers/dma/sf-pdma/sf-pdma.c | 3 +--
 drivers/dma/sf-pdma/sf-pdma.h | 4 +++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
index 16fe00553496..465256fe8b1f 100644
--- a/drivers/dma/sf-pdma/sf-pdma.c
+++ b/drivers/dma/sf-pdma/sf-pdma.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * SiFive FU540 Platform DMA driver
  * Copyright (C) 2019 SiFive
  *
@@ -435,7 +435,6 @@ static int sf_pdma_irq_init(struct platform_device *pdev, struct sf_pdma *pdma)
  *
  * Return: none
  */
-#define SF_PDMA_REG_BASE(ch)	(pdma->membase + (PDMA_CHAN_OFFSET * (ch)))
 static void sf_pdma_setup_chans(struct sf_pdma *pdma)
 {
 	int i;
diff --git a/drivers/dma/sf-pdma/sf-pdma.h b/drivers/dma/sf-pdma/sf-pdma.h
index 55816c9e0249..0c20167b097d 100644
--- a/drivers/dma/sf-pdma/sf-pdma.h
+++ b/drivers/dma/sf-pdma/sf-pdma.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/**
+/*
  * SiFive FU540 Platform DMA driver
  * Copyright (C) 2019 SiFive
  *
@@ -57,6 +57,8 @@
 /* Error Recovery */
 #define MAX_RETRY					1
 
+#define SF_PDMA_REG_BASE(ch)	(pdma->membase + (PDMA_CHAN_OFFSET * (ch)))
+
 struct pdma_regs {
 	/* read-write regs */
 	void __iomem *ctrl;		/* 4 bytes */

base-commit: a7e335deed174a37fc6f84f69caaeff8a08f8ff8
-- 
2.17.1

