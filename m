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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6679CC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 20:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D9B21019
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 20:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SE3r3geE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbfCPULJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 16:11:09 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38146 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfCPULH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 16:11:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id g12so12948027wrm.5
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 13:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Eh1SUabWgl71c5qGL/tJnP6qT1vCB267CU/qf5b9RSM=;
        b=SE3r3geEHz3eXwDd937jokH+yI/qC7SyIV1Yq34dQAtX4zPQtRF5gcGiLRpUkot16l
         TzM0Pi4S1ogITU+AUE+xTvKz0oN3CUsejyiF1oNdRbofMnH7hk6xIis5/EeZJtswVRkJ
         uh8YNDBabkZ0Xa4DIVSb8lTeGwtzpkBMyx0l5ptTCBOwoKAJLIFTCKTnCb255dO860cq
         6RSTGyAf0TALXC2vHPZx0AGgx3AqRepkXHCCqRBBhJqR7Uy06gwY7gm9cvD55ki64QAL
         NI3a1/hDzE0qGI1/nA5qkIQgtb2atFuv4pCtNXb9pve9zAtUGqNan/6HiKgJNrHDYeIu
         icRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Eh1SUabWgl71c5qGL/tJnP6qT1vCB267CU/qf5b9RSM=;
        b=BFsYBM7XM6qSjfx7j5MBQc3a8MFHEJDnNkVpD0df4uHRhZd1j+Jyo2bArP1s0nle8V
         ZQgAmf65ST/FsrRGqsiGa5gA9v7rATQBLJCq8SV/n3JtFAJVa9r6oqDIosXQHWIF9x+U
         z3k9ZPeJGPkV1XaDkkw1RPec+EJfKrrUBPe2xnknKcFQrdoxyWuGWijBywJUZe8gFC3D
         8iJHhpHqn5ByKMN8V5d2Xe9rvoXVjkH/xpTgtJvGw4ZyAKXNo4r+i2dCCxiyuL0CrDfx
         LSzpOWkkwvSWRO0Qr/gd3mw1gaZcpKj9FFZIlVddLAGEf6NOyT6hhlPpu0Ew8xJ8b5nB
         OjAQ==
X-Gm-Message-State: APjAAAXStDfdAI9UqLFbHJcCsTRN7JLgjEgQ4Kl1NqpxeGvAH5JMLUf2
        oc4Nv0HftEGikXKmn0ATMHrrTNNP
X-Google-Smtp-Source: APXvYqwAZ+ny99SbTbr+toul3G2yw8QTcCWVT5epnbPrtVp/qf/2RMu/8ZQb6ToSdCrRQ8M4P5SixQ==
X-Received: by 2002:a5d:4f82:: with SMTP id d2mr7012419wru.262.1552767065263;
        Sat, 16 Mar 2019 13:11:05 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id h10sm8722221wmf.2.2019.03.16.13.11.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 13:11:04 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Omer Shpigelman <oshpigelman@habana.ai>
Subject: [PATCH 2/4] habanalabs: fix bug when mapping very large memory area
Date:   Sat, 16 Mar 2019 22:10:45 +0200
Message-Id: <20190316201047.22516-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190316201047.22516-1-oded.gabbay@gmail.com>
References: <20190316201047.22516-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omer Shpigelman <oshpigelman@habana.ai>

This patch fixes a bug of allocating a too big memory size with kmalloc,
which causes a failure.
In case of mapping a large memory block, an array of the relevant physical
page addresses is allocated. If there are many pages the array might be
too big to allocate with kmalloc, hence changing to kvmalloc.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/memory.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/habanalabs/memory.c b/drivers/misc/habanalabs/memory.c
index 4f8c968e441a..ce1fda40a8b8 100644
--- a/drivers/misc/habanalabs/memory.c
+++ b/drivers/misc/habanalabs/memory.c
@@ -93,7 +93,7 @@ static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
 	phys_pg_pack->flags = args->flags;
 	phys_pg_pack->contiguous = contiguous;
 
-	phys_pg_pack->pages = kcalloc(num_pgs, sizeof(u64), GFP_KERNEL);
+	phys_pg_pack->pages = kvmalloc_array(num_pgs, sizeof(u64), GFP_KERNEL);
 	if (!phys_pg_pack->pages) {
 		rc = -ENOMEM;
 		goto pages_arr_err;
@@ -148,7 +148,7 @@ static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
 			gen_pool_free(vm->dram_pg_pool, phys_pg_pack->pages[i],
 					page_size);
 
-	kfree(phys_pg_pack->pages);
+	kvfree(phys_pg_pack->pages);
 pages_arr_err:
 	kfree(phys_pg_pack);
 pages_pack_err:
@@ -288,7 +288,7 @@ static void free_phys_pg_pack(struct hl_device *hdev,
 		}
 	}
 
-	kfree(phys_pg_pack->pages);
+	kvfree(phys_pg_pack->pages);
 	kfree(phys_pg_pack);
 }
 
@@ -692,7 +692,8 @@ static int init_phys_pg_pack_from_userptr(struct hl_ctx *ctx,
 
 	page_mask = ~(((u64) page_size) - 1);
 
-	phys_pg_pack->pages = kcalloc(total_npages, sizeof(u64), GFP_KERNEL);
+	phys_pg_pack->pages = kvmalloc_array(total_npages, sizeof(u64),
+						GFP_KERNEL);
 	if (!phys_pg_pack->pages) {
 		rc = -ENOMEM;
 		goto page_pack_arr_mem_err;
-- 
2.17.1

