Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2810CC2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 19:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE48D21582
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 19:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZZTVTJg+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfLQTIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 14:08:49 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46280 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbfLQTIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 14:08:49 -0500
Received: by mail-pg1-f193.google.com with SMTP id z124so6161016pgb.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 11:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=M6ODtAK/kSPelKWo8qlr9AI1paG4/5fDCdQdMGc8cow=;
        b=ZZTVTJg+L/PA6VmNqIt/3FCmTOg4djZsQiSvscUk3zZc5nQjBWomowCzIXvBlzUXNd
         mxj6r/CCoBn8hRs9dEO4PnnnM2thQdnOs2ev8XTLU9OTaRdpbbxn56TudNEblGV0SMyf
         5oaI2e6PKqeBpqrvW8nbu6yM3lY36oKKVE+VAGu4W6eAaoqAa+NnNVEHDE+jMgrysBL1
         L384H7mgWGRUH4ry94uE7pU1QHSEFMwP/vPmNGoFWLr7VuKTIBXjoTMMDoWdksJ7QKzZ
         etwMVRDuZDwlHtviWS2hmKY5uTqNt0BwulsdGwsWvZh8toG3F/rqoOGhedu4VQrZjq2f
         OnAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=M6ODtAK/kSPelKWo8qlr9AI1paG4/5fDCdQdMGc8cow=;
        b=aQ6ij6Rm66T8ffw1ZjMdUgY4U2cL3sV1BXnB+MaSWkrIhEw4gHcobdqll0orc0fEgr
         6ZZ3duvmamx5DpXntJJAX1L+5lgi0FWATxVuhRwA16Yn8TKHq7BWpXyQw7Oog3JzIYHK
         5GIvdWRbJdwPSv8Q5GXN2NYzOerP6WgP9oUQeQUH/Hap1CbLKA3ENJwN3q4DV9hlDOsG
         +KUAbu0ASfn0xcmBgJpli4L6r2SFz4W5Fns66VeoC+vZUlos3q66fMrXMv7QlUIgfqdQ
         BGu6kf+WQbScziG9AHHo+B+/6KUxYMECLe0pnGirdBddsMxaUFtNvsKHhW2Qiwt9pGr9
         yJkQ==
X-Gm-Message-State: APjAAAUjUcAbkBB2vU0LFFJScr0vqiJ+E8SWCPc714Jzzk5LkSEseCju
        zFW+/L2OkZpQF3IdlEgvwUoblg==
X-Google-Smtp-Source: APXvYqwwYwEW8UujHenDnM3HGny/IvVE2Z/yHHlmaPBn+WxMZ+NHOf6z5+i7m2NFWdAv96HkaHfebA==
X-Received: by 2002:a63:f743:: with SMTP id f3mr26884769pgk.28.1576609728600;
        Tue, 17 Dec 2019 11:08:48 -0800 (PST)
Received: from nagraj.local ([49.206.21.239])
        by smtp.gmail.com with ESMTPSA id 12sm1697085pfn.177.2019.12.17.11.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 11:08:47 -0800 (PST)
From:   Sumit Semwal <sumit.semwal@linaro.org>
To:     sumit.semwal@linaro.org
Cc:     afd@ti.com, benjamin.gaignard@linaro.org, lmark@codeaurora.org,
        labbott@redhat.com, Brian.Starkey@arm.com, john.stultz@linaro.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        zhong jiang <zhongjiang@huawei.com>
Subject: [PATCH] dma-heap: Make the symbol 'dma_heap_ioctl_cmds' static
Date:   Wed, 18 Dec 2019 00:38:22 +0530
Message-Id: <20191217190822.1969-1-sumit.semwal@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhong jiang <zhongjiang@huawei.com>

Fix the following sparse warning.

drivers/dma-buf/dma-heap.c:109:14: warning: symbol 'dma_heap_ioctl_cmds'
was not declared. Should it be static?

Acked-by: Andrew F. Davis <afd@ti.com>
Acked-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: zhong jiang <zhongjiang@huawei.com>
Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
 [sumits: rebased over IOCTL rename patches]
---
 drivers/dma-buf/dma-heap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
index 1886aee46131..afd22c9dbdcf 100644
--- a/drivers/dma-buf/dma-heap.c
+++ b/drivers/dma-buf/dma-heap.c
@@ -106,7 +106,7 @@ static long dma_heap_ioctl_allocate(struct file *file, void *data)
 	return 0;
 }
 
-unsigned int dma_heap_ioctl_cmds[] = {
+static unsigned int dma_heap_ioctl_cmds[] = {
 	DMA_HEAP_IOCTL_ALLOC,
 };
 
-- 
2.18.0

