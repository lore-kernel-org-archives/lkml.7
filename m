Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDF8C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 21:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A417920674
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 21:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfDJV71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 17:59:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53122 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbfDJV71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 17:59:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DA9212C971E;
        Wed, 10 Apr 2019 21:59:26 +0000 (UTC)
Received: from t460p.redhat.com (ovpn-118-18.phx2.redhat.com [10.3.118.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 28A375D704;
        Wed, 10 Apr 2019 21:59:26 +0000 (UTC)
From:   Scott Wood <swood@redhat.com>
To:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Scott Wood <swood@redhat.com>
Subject: [PATCH] dma-debug: Only skip one stackframe entry
Date:   Wed, 10 Apr 2019 16:59:25 -0500
Message-Id: <20190410215925.8458-1-swood@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 10 Apr 2019 21:59:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With skip set to 1, I get a traceback like this:

[  106.867637] DMA-API: Mapped at:
[  106.870784]  afu_dma_map_region+0x2cd/0x4f0 [dfl_afu]
[  106.875839]  afu_ioctl+0x258/0x380 [dfl_afu]
[  106.880108]  do_vfs_ioctl+0xa9/0x720
[  106.883688]  ksys_ioctl+0x60/0x90
[  106.887007]  __x64_sys_ioctl+0x16/0x20

With the previous value of 2, afu_dma_map_region was being omitted.  I
suspect that the code paths have simply changed since the value of 2 was
chosen a decade ago, but it's also possible that it varies based on which
mapping function was used, compiler inlining choices, etc.  In any case,
it's best to err on the side of skipping less.

Signed-off-by: Scott Wood <swood@redhat.com>
---
 kernel/dma/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 45d51e8e26f6..a218e43cc382 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -706,7 +706,7 @@ static struct dma_debug_entry *dma_entry_alloc(void)
 #ifdef CONFIG_STACKTRACE
 	entry->stacktrace.max_entries = DMA_DEBUG_STACKTRACE_ENTRIES;
 	entry->stacktrace.entries = entry->st_entries;
-	entry->stacktrace.skip = 2;
+	entry->stacktrace.skip = 1;
 	save_stack_trace(&entry->stacktrace);
 #endif
 
-- 
1.8.3.1

