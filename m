Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DACBC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 20:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEFAC218D4
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 20:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qSrkH1wk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfCPULQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 16:11:16 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55386 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbfCPULM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 16:11:12 -0400
Received: by mail-wm1-f68.google.com with SMTP id 4so9446677wmf.5
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 13:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VjUlTJOkKvHwvn8BVoxONDpMnmkqdF92sTwEVz5Md5Y=;
        b=qSrkH1wk27OWmkXqDyNLWYKodWDR6HA8u8Wud/eEiwYh2DVP6Oj89zynPEoaCuJ4Kd
         CNrh4eMJDKoMmLi/G0sQUcZhWA12bWwRKr6yWj+VQPQY2toMjTZ56wuubsT1Bb7+fIYn
         QapWBKoru3SMMAwWFURh/5ncReZpLtePWXhZCNSzeebnU/qpabosXpeCtSgGiXnsn0Mw
         cpaSidMsk61/RCQJO90TvUoEAylXy8ITiucjgnweeVnKhhGlQXGH/sjv9cmgK2STh2Um
         c1/tai8Ua5+vpfhBCjzKCyBK5a6mcBkFxjcH1zgQY2E+xcCF7qboWW+pPQp2foaQsuni
         q5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VjUlTJOkKvHwvn8BVoxONDpMnmkqdF92sTwEVz5Md5Y=;
        b=LEcfnb/HcBmwoBwtHcPsMsqYhKxfXwrzhKE1RcsJYc20dDxbrONsPG2X7KquK+oMm1
         RqUiq0P0aJqCYTBev7ZzLzYMRgMFlCI2tM1IE9dytFauOr37zZZMmRIVrOBUfD12I2VU
         X1qrzT4UpAJSGe3P2IcXZ9t2oSA4nW1cH3sVUT/rMQ2aHnTobRRp194hY2BmTGY4rpii
         CyC2uB9ENeSHAaCWJCB0HaAngsuE15N5G68nGjz1Ub7dOenNndsAL/EPPFdtOcGM+Aq6
         NXWu9OSDEjA2h1jsnIkhlpkh6sr8raxgBXef/71b3TyO9EOy5MvAgWht+5peTV+3F0He
         YJuQ==
X-Gm-Message-State: APjAAAXoLUeXYCet+BgRgRBgUICmimoVtN76seS0pN0XVIaRITTQhQbx
        jlbvHfeV2h4YrEGH0142FPviUIPH
X-Google-Smtp-Source: APXvYqxYqTsSKcMh1CjkFK/HEwXy8hnMU3j4wuHTdoVk9MsR+E0i9WBOqgCKT9Kh0W/x9zkvqrhBjg==
X-Received: by 2002:a1c:38b:: with SMTP id 133mr6140609wmd.26.1552767070072;
        Sat, 16 Mar 2019 13:11:10 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id h10sm8722221wmf.2.2019.03.16.13.11.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 13:11:09 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Omer Shpigelman <oshpigelman@habana.ai>
Subject: [PATCH 4/4] habanalabs: fix mapping with page size bigger than 4KB
Date:   Sat, 16 Mar 2019 22:10:47 +0200
Message-Id: <20190316201047.22516-4-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190316201047.22516-1-oded.gabbay@gmail.com>
References: <20190316201047.22516-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omer Shpigelman <oshpigelman@habana.ai>

This patch fixes the mapping of virtual address to physical addresses on
architectures where PAGE_SIZE is bigger than 4KB.
The break down to the device page size was done only for the virtual
address while it should have been done for the physical address as well.
As a result virtual addresses were mapped to wrong physical address.
The fix is to apply the break down for the physical addresses as well in
order to get correct mappings.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/mmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/mmu.c b/drivers/misc/habanalabs/mmu.c
index 2f2e99cb2743..3a5a2cec8305 100644
--- a/drivers/misc/habanalabs/mmu.c
+++ b/drivers/misc/habanalabs/mmu.c
@@ -832,7 +832,7 @@ static int _hl_mmu_map(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr,
 int hl_mmu_map(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr, u32 page_size)
 {
 	struct hl_device *hdev = ctx->hdev;
-	u64 real_virt_addr;
+	u64 real_virt_addr, real_phys_addr;
 	u32 real_page_size, npages;
 	int i, rc, mapped_cnt = 0;
 
@@ -857,14 +857,16 @@ int hl_mmu_map(struct hl_ctx *ctx, u64 virt_addr, u64 phys_addr, u32 page_size)
 
 	npages = page_size / real_page_size;
 	real_virt_addr = virt_addr;
+	real_phys_addr = phys_addr;
 
 	for (i = 0 ; i < npages ; i++) {
-		rc = _hl_mmu_map(ctx, real_virt_addr, phys_addr,
+		rc = _hl_mmu_map(ctx, real_virt_addr, real_phys_addr,
 				real_page_size);
 		if (rc)
 			goto err;
 
 		real_virt_addr += real_page_size;
+		real_phys_addr += real_page_size;
 		mapped_cnt++;
 	}
 
-- 
2.17.1

