Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA3FC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF622483D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfFK5rHz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbfE3INS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 04:13:18 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34434 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfE3INS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 04:13:18 -0400
Received: by mail-wr1-f65.google.com with SMTP id f8so3558857wrt.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 01:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mRYtIjjBT0gCdPjqX8QzT/b2ruybZVo2i8tgf4wGRV8=;
        b=GfFK5rHzsE1osVxjdjhR4PeXIj1ID4T6yvBWAAp16aTYwkVQSDD5A+MLTYoFmR22fd
         ct5mHRZ0XECSWo53oWawynKw5l4Lrfi0wCGSLspP/5Yba7A/SuCMdaD3/P5JcD8HjN2N
         G0j2Hh/aOWjC+223jAk6GjHBPme5iMsfo9I4V3MYKtA1iguEcSw4xb36fqsDcEz7g4v/
         K3N+qi4JkGCmPb8OUHmdbvwShyB81z/xgQIYreQhz8T16aoBsXpC1mzf8IXpXgGwSnHj
         6HyU1uuTCie6PzjPHy5glNQkJdeun9HfAn607LpsHBBjwNSjmFBLK8n/yygUiTULXoNr
         MgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mRYtIjjBT0gCdPjqX8QzT/b2ruybZVo2i8tgf4wGRV8=;
        b=SjxkK78r/Qe9sJNrC7VFhKD7yLMoDFH3UT/FBoB5jUsa0vsSfHFOz8WRL9pRgjjM2c
         wMcxyhj5SBlE3oPY17mDdzwKWFxDS1a12mhVGtcOALxrp/VS7R4XwA6tlvRPYTssgFrz
         194yMVUnEhxLM1QpR+T0GNj7XlRxp/2cHFj0y+klqfC3x47TO4tydCVwfKTsLZjydd3f
         Y0T+QVQymcykKigYl/ymfphXBQCeOfHjem+eRKIQ/7o62bcBnvp67C0c/Tl+FaZB6feQ
         yhhciUIPyoor7D5FfuSTT381QWU/LvebHVTVC+A3cWrXBwtbDX7ul4Flde4JRggPdfaL
         nFQA==
X-Gm-Message-State: APjAAAVuNBdc92PSmT2UMxquhw1nvHSLZKzmv2qSY8xdMmJDAySgLoBY
        SoKV0SLrPeWci1KCxZzvLfbfL6AY
X-Google-Smtp-Source: APXvYqzhxswiaqqeuv9e0qfSz5uRCPOay6zgOIboxlJ+o1LLAM2DzCoRDQbck2DVz8PaJD4q7oS8Gg==
X-Received: by 2002:adf:8b83:: with SMTP id o3mr1546275wra.278.1559203996684;
        Thu, 30 May 2019 01:13:16 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id 17sm1678651wmi.25.2019.05.30.01.13.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 01:13:15 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH] habanalabs: fix bug in checking huge page optimization
Date:   Thu, 30 May 2019 11:13:14 +0300
Message-Id: <20190530081314.19904-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix a bug in the mmu code that checks whether we can use huge
page mappings for host pages.

The code is supposed to enable huge page mappings only if ALL DMA
addresses are aligned to 2MB AND the number of pages in each DMA chunk is
a modulo of the number of pages in 2MB. However, the code ignored the
first requirement for the first DMA chunk.

This patch fix that issue by making sure the requirement of address
alignment is validated against all DMA chunks.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/memory.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/misc/habanalabs/memory.c b/drivers/misc/habanalabs/memory.c
index d67d24c13efd..693877e37fd8 100644
--- a/drivers/misc/habanalabs/memory.c
+++ b/drivers/misc/habanalabs/memory.c
@@ -675,11 +675,6 @@ static int init_phys_pg_pack_from_userptr(struct hl_ctx *ctx,
 
 		total_npages += npages;
 
-		if (first) {
-			first = false;
-			dma_addr &= PAGE_MASK_2MB;
-		}
-
 		if ((npages % PGS_IN_2MB_PAGE) ||
 					(dma_addr & (PAGE_SIZE_2MB - 1)))
 			is_huge_page_opt = false;
@@ -704,7 +699,6 @@ static int init_phys_pg_pack_from_userptr(struct hl_ctx *ctx,
 	phys_pg_pack->total_size = total_npages * page_size;
 
 	j = 0;
-	first = true;
 	for_each_sg(userptr->sgt->sgl, sg, userptr->sgt->nents, i) {
 		npages = get_sg_info(sg, &dma_addr);
 
-- 
2.17.1

