Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CF1C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 421F620896
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ah9q799H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388032AbfDARog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:44:36 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53813 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731020AbfDARof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:44:35 -0400
Received: by mail-wm1-f67.google.com with SMTP id q16so305566wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 10:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=C5Z+ZbojR8u61jx7QLYGdsSJ+zSY1pyusZunuxUJras=;
        b=ah9q799HTT/VJZJ8zvV566ZT6PUgJYQMQwE8h68d4sTIAUnefzPba0JUl87JIiqIak
         oBX1jooenbUF1gcB9Qq2ahtNaahlRHjVvLqr8Zr3VZKPpdRBQ2aG7v+qfLrWoIEsKLcZ
         ZzH8LZlP2Ii4Dawmm+YlE/fG4vHN9yYtAxy9k0CzWaUsxbF7kyH6zXC7KvobdrYC4Oxz
         zYYz0F/0WCkNK5FuFstFdtdZXHvH0/lKXC6N25q6vcDguxl1H06RniqtQ4q3aQjZea2S
         9YGeIfBy7saDfYhuruGoO+ZejEdVOsiXU66g1VNEHhShbqWKSW6DaXukmcg9W+9uwJc0
         oqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=C5Z+ZbojR8u61jx7QLYGdsSJ+zSY1pyusZunuxUJras=;
        b=tqwDH56LLbfBQzeidRWwYu6Cs6HdaDiJYRv3GIFAcHTrBE0y7/yO/LItjFivUhbCDu
         oXSZTQaNC/7jFbWJtAMsB1oFJ8Sh23bhZTAAeX0cDOTdyvYfjMG9LYTHAHkm6O9s91h+
         wpAEVay7SWG36pPdNzazr1tLOeebq7m+hb9VKApnbXqD6j00GtMvO8HMZrqYNfip1qq4
         y0Srcr/JglFCpktLqkJG1Cnvtsa9jeqAqUvbSoXYs7+oBwc1utY7HPmlrhSk+VBNyQWL
         LlatyszUTE+cPpwTfcI5aYRIDqwFVBOIkCsos3zB6hyTM1RnNigO+hhR6eCoYThAnfLp
         wQ8g==
X-Gm-Message-State: APjAAAUqck/JAMkOV4w9GzNQFzJBfbKfweQ/0rHyb1RVRoBZJXryxQho
        AwPjljcRoE9swMMoUcRDfIS4oIgm
X-Google-Smtp-Source: APXvYqyl1xk+uTWD92DIZ/fp2+5o3L455tD6kTSkPIyfzSVFDrmFQAm2daMUL7Te6sV14vdtNHTVTA==
X-Received: by 2002:a1c:f312:: with SMTP id q18mr500833wmq.96.1554140672843;
        Mon, 01 Apr 2019 10:44:32 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id i18sm11892955wrm.7.2019.04.01.10.44.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 10:44:32 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH] habanalabs: prevent CPU soft lockup on Palladium
Date:   Mon,  1 Apr 2019 20:44:30 +0300
Message-Id: <20190401174430.15553-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unmapping ptes in the device MMU on Palladium can take a long time, which
can cause a kernel BUG of CPU soft lockup.

This patch minimize the chances for this bug by sleeping a little between
unmapping ptes.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/memory.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/memory.c b/drivers/misc/habanalabs/memory.c
index 39788b1cf8d0..e9e163545584 100644
--- a/drivers/misc/habanalabs/memory.c
+++ b/drivers/misc/habanalabs/memory.c
@@ -1046,10 +1046,17 @@ static int unmap_device_va(struct hl_ctx *ctx, u64 vaddr)
 
 	mutex_lock(&ctx->mmu_lock);
 
-	for (i = 0 ; i < phys_pg_pack->npages ; i++, next_vaddr += page_size)
+	for (i = 0 ; i < phys_pg_pack->npages ; i++, next_vaddr += page_size) {
 		if (hl_mmu_unmap(ctx, next_vaddr, page_size))
 			dev_warn_ratelimited(hdev->dev,
-				"unmap failed for vaddr: 0x%llx\n", next_vaddr);
+			"unmap failed for vaddr: 0x%llx\n", next_vaddr);
+
+		/* unmapping on Palladium can be really long, so avoid a CPU
+		 * soft lockup bug by sleeping a little between unmapping pages
+		 */
+		if (hdev->pldm)
+			usleep_range(500, 1000);
+	}
 
 	hdev->asic_funcs->mmu_invalidate_cache(hdev, true);
 
-- 
2.17.1

