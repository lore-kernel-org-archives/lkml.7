Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B41C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ED6A21473
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139990;
	bh=nTZ7eN4MmANlWrKJ2e2sYzQE6Iv7oU7DrrGxEJOpzTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Fh87h0zbA7OdaNQAoAQWmIAdP+wxViHknhUsdR/1geTWqsS3ezomk0mBOt7eCTitx
	 EnPuDp4D35vMXCIpTQ20OvhsqIV0OQxSx7B121Lg6zNUsqEgmERvjQXGQUGx7OoxcK
	 2LoK81RKNstfWzkMFE2ukJq37Aot97fTvl887UYw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733105AbfDARdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:33:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:41676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387576AbfDARdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:33:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F2A620830;
        Mon,  1 Apr 2019 17:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139985;
        bh=nTZ7eN4MmANlWrKJ2e2sYzQE6Iv7oU7DrrGxEJOpzTs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kw9WlpGrkUHr7OnUgQWIEVudG7//UHDeAsYMsRih0fOB51OXxqInyQ0IZZMqv109U
         86f0x2ce+l11hHAIn9SQGxjlbAgFiMl8iLmZvv4uOFhPyfkrXZMkYWzds0YTyLnqre
         IOwQPFiicla7G5h+hKubBGvSqXVq8jjzmKoZiP0g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, sprd-ind-kernel-group@googlegroups.com,
        sanjeev.yadav@spreadtrum.com, Colin Cross <ccross@android.com>,
        Android Kernel Team <kernel-team@android.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Rajmal Menariya <rajmal.menariya@spreadtrum.com>,
        John Stultz <john.stultz@linaro.org>,
        Laura Abbott <labbott@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 071/131] staging: ion: Set minimum carveout heap allocation order to PAGE_SHIFT
Date:   Mon,  1 Apr 2019 19:02:21 +0200
Message-Id: <20190401170058.103648967@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 1328d8efef17d5e16bd6e9cfe59130a833674534 ]

In carveout heap, change minimum allocation order from 12 to
PAGE_SHIFT. After this change each bit in bitmap (genalloc -
General purpose special memory pool) represents one page size
memory.

Cc: sprd-ind-kernel-group@googlegroups.com
Cc: sanjeev.yadav@spreadtrum.com
Cc: Colin Cross <ccross@android.com>
Cc: Android Kernel Team <kernel-team@android.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Signed-off-by: Rajmal Menariya <rajmal.menariya@spreadtrum.com>
[jstultz: Reworked commit message]
Signed-off-by: John Stultz <john.stultz@linaro.org>
Acked-by: Laura Abbott <labbott@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/android/ion/ion_carveout_heap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/android/ion/ion_carveout_heap.c b/drivers/staging/android/ion/ion_carveout_heap.c
index 9156d8238c97..e702ce6461fc 100644
--- a/drivers/staging/android/ion/ion_carveout_heap.c
+++ b/drivers/staging/android/ion/ion_carveout_heap.c
@@ -167,7 +167,7 @@ struct ion_heap *ion_carveout_heap_create(struct ion_platform_heap *heap_data)
 	if (!carveout_heap)
 		return ERR_PTR(-ENOMEM);
 
-	carveout_heap->pool = gen_pool_create(12, -1);
+	carveout_heap->pool = gen_pool_create(PAGE_SHIFT, -1);
 	if (!carveout_heap->pool) {
 		kfree(carveout_heap);
 		return ERR_PTR(-ENOMEM);
-- 
2.19.1



