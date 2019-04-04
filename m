Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31410C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7D2D20820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="YHWZ7pws";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lFdHxGNc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbfDDCKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 22:10:41 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:42573 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726559AbfDDCJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 22:09:47 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 571F722738;
        Wed,  3 Apr 2019 22:01:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 03 Apr 2019 22:01:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm3; bh=WZXwx4HISUDgI
        8TfJQzyJVeD3sCMwmp5Girw2m9njPA=; b=YHWZ7pwsO+AQY2MK+dVV1sfc+RQqa
        y0+PemKbFnqlXT3HnwW+jj+8wqbXpEOjA/J9qWo8nIFU0xSIK8+1t5Y+joz9aP9D
        PCwKEP54wy1JUiE4Yx4QyxZSYdca5E5MEHYdFNa9S5f1cVCFnilHQmzvxxOjIcFF
        TaEPskiO88H48XLZ/6DQWZfHgw34G4Gr622cdgH98yrQJSuQpQurdSDqjmGRnclI
        DB0VWw1Q7hYC+V6vfqSFUQfGagLdeQOtsdjQjhlPBkhLclDBi+mGmBhUY7+Lpwkk
        yo6T/QxpNAPxVN/6inaE7rn9+SBVIEgj6ry3kdZK5Sai0F8BBpZOlbvUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=WZXwx4HISUDgI8TfJQzyJVeD3sCMwmp5Girw2m9njPA=; b=lFdHxGNc
        PI7EEvnuiKPmFifQ79uju5ydBluuPGo2k4N1/BRmGvOT6rQN+bHDZ9SqDlO9bp5u
        kVTs63VrcyST5SsloiB3RiWjcOK3LrNS+QhGwV7UKFShTciQXlHvumgq1bV+YYg2
        D5+QYJy26/QDkqvVd+EuaYb+4Qqz8HpYFPEFiKsb34oLFLpYaa9vX0ULkbVNYpue
        9t9a2Adz1hm8inZJr4pNPnM/CupgQnCSkQXyRKDWPoQHHL0SWivq3S0Kv7uDHQff
        31kzoQqO2qAKgtMeCyPVx3ECiAM9swStgwR9u9WVAm3XEOypf2p9FCIq3s85e9HN
        NyZceirh0PvA9w==
X-ME-Sender: <xms:emWlXLagNLXUDfxm-mCuN6YowT-_gPyG_vkQTCAfc5TWqMMT1I14Ww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrtdeggdehudculddtuddrgedutddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhhrggfgsedtkeertdertddt
    necuhfhrohhmpegkihcujggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucfkph
    epvdduiedrvddvkedrudduvddrvddvnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdr
    higrnhesshgvnhhtrdgtohhmnecuvehluhhsthgvrhfuihiivgepje
X-ME-Proxy: <xmx:emWlXAjVHmk0VUHhtG5fGcT4PR95aUJLIS2MdAGBE9UhnJs5nfrQLA>
    <xmx:emWlXEeWF5NSi8DNn_4Rssgo0wzM2dT4yo0oemXhhAZNv52cETtKyg>
    <xmx:emWlXLpbG752MzR94qx3UCp5yqxZEwFw9x8Is5XFlN8QNjib-jN0PQ>
    <xmx:emWlXJfK9TnEM5ag8NlfdhXIIU4mNcpCNkwHS-fu4tfZbQS5YvLMhQ>
Received: from nvrsysarch5.nvidia.com (thunderhill.nvidia.com [216.228.112.22])
        by mail.messagingengine.com (Postfix) with ESMTPA id 615E210319;
        Wed,  3 Apr 2019 22:01:28 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Keith Busch <keith.busch@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        John Hubbard <jhubbard@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        Nitin Gupta <nigupta@nvidia.com>,
        Javier Cabezas <jcabezas@nvidia.com>,
        David Nellans <dnellans@nvidia.com>, Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH 09/25] mm: migrate: Add copy_page_lists_dma_always to support copy a list of pages.
Date:   Wed,  3 Apr 2019 19:00:30 -0700
Message-Id: <20190404020046.32741-10-zi.yan@sent.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190404020046.32741-1-zi.yan@sent.com>
References: <20190404020046.32741-1-zi.yan@sent.com>
Reply-To: ziy@nvidia.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

Both src and dst page lists should match the page size at each
page and the length of both lists is shared.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/copy_page.c | 166 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 mm/internal.h  |   4 ++
 2 files changed, 170 insertions(+)

diff --git a/mm/copy_page.c b/mm/copy_page.c
index 5e7a797..84f1c02 100644
--- a/mm/copy_page.c
+++ b/mm/copy_page.c
@@ -417,3 +417,169 @@ int copy_page_dma(struct page *to, struct page *from, int nr_pages)
 
 	return copy_page_dma_always(to, from, nr_pages);
 }
+
+/*
+ * Use DMA copy a list of pages to a new location
+ *
+ * Just put each page into individual DMA channel.
+ *
+ * */
+int copy_page_lists_dma_always(struct page **to, struct page **from, int nr_items)
+{
+	struct dma_async_tx_descriptor **tx = NULL;
+	dma_cookie_t *cookie = NULL;
+	enum dma_ctrl_flags flags[NUM_AVAIL_DMA_CHAN] = {0};
+	struct dmaengine_unmap_data *unmap[NUM_AVAIL_DMA_CHAN] = {0};
+	int ret_val = 0;
+	int total_available_chans = NUM_AVAIL_DMA_CHAN;
+	int i;
+	int page_idx;
+
+	for (i = 0; i < NUM_AVAIL_DMA_CHAN; ++i) {
+		if (!copy_chan[i]) {
+			total_available_chans = i;
+		}
+	}
+	if (total_available_chans != NUM_AVAIL_DMA_CHAN) {
+		pr_err("%d channels are missing\n", NUM_AVAIL_DMA_CHAN - total_available_chans);
+	}
+	if (limit_dma_chans < total_available_chans)
+		total_available_chans = limit_dma_chans;
+
+	/* round down to closest 2^x value  */
+	total_available_chans = 1<<ilog2(total_available_chans);
+
+	total_available_chans = min_t(int, total_available_chans, nr_items);
+
+
+	tx = kzalloc(sizeof(struct dma_async_tx_descriptor*)*nr_items, GFP_KERNEL);
+	if (!tx) {
+		ret_val = -ENOMEM;
+		goto out;
+	}
+	cookie = kzalloc(sizeof(dma_cookie_t)*nr_items, GFP_KERNEL);
+	if (!cookie) {
+		ret_val = -ENOMEM;
+		goto out_free_tx;
+	}
+
+	for (i = 0; i < total_available_chans; ++i) {
+		int num_xfer_per_dev = nr_items / total_available_chans;
+
+		if (i < (nr_items % total_available_chans))
+			num_xfer_per_dev += 1;
+
+		if (num_xfer_per_dev > 128) {
+			ret_val = -ENOMEM;
+			pr_err("%s: too many pages to be transferred\n", __func__);
+			goto out_free_both;
+		}
+
+		unmap[i] = dmaengine_get_unmap_data(copy_dev[i]->dev,
+						2 * num_xfer_per_dev, GFP_NOWAIT);
+		if (!unmap[i]) {
+			pr_err("%s: no unmap data at chan %d\n", __func__, i);
+			ret_val = -ENODEV;
+			goto unmap_dma;
+		}
+	}
+
+	page_idx = 0;
+	for (i = 0; i < total_available_chans; ++i) {
+		int num_xfer_per_dev = nr_items / total_available_chans;
+		int xfer_idx;
+
+		if (i < (nr_items % total_available_chans))
+			num_xfer_per_dev += 1;
+
+		unmap[i]->to_cnt = num_xfer_per_dev;
+		unmap[i]->from_cnt = num_xfer_per_dev;
+		unmap[i]->len = hpage_nr_pages(from[i]) * PAGE_SIZE;
+
+		for (xfer_idx = 0; xfer_idx < num_xfer_per_dev; ++xfer_idx, ++page_idx) {
+			size_t page_len = hpage_nr_pages(from[page_idx]) * PAGE_SIZE;
+
+			BUG_ON(page_len != hpage_nr_pages(to[page_idx]) * PAGE_SIZE);
+			BUG_ON(unmap[i]->len != page_len);
+
+			unmap[i]->addr[xfer_idx] =
+				 dma_map_page(copy_dev[i]->dev, from[page_idx],
+							  0,
+							  page_len,
+							  DMA_TO_DEVICE);
+
+			unmap[i]->addr[xfer_idx+num_xfer_per_dev] =
+				 dma_map_page(copy_dev[i]->dev, to[page_idx],
+							  0,
+							  page_len,
+							  DMA_FROM_DEVICE);
+		}
+	}
+
+	page_idx = 0;
+	for (i = 0; i < total_available_chans; ++i) {
+		int num_xfer_per_dev = nr_items / total_available_chans;
+		int xfer_idx;
+
+		if (i < (nr_items % total_available_chans))
+			num_xfer_per_dev += 1;
+
+		for (xfer_idx = 0; xfer_idx < num_xfer_per_dev; ++xfer_idx, ++page_idx) {
+
+			tx[page_idx] = copy_dev[i]->device_prep_dma_memcpy(copy_chan[i],
+								unmap[i]->addr[xfer_idx + num_xfer_per_dev],
+								unmap[i]->addr[xfer_idx],
+								unmap[i]->len,
+								flags[i]);
+			if (!tx[page_idx]) {
+				pr_err("%s: no tx descriptor at chan %d xfer %d\n",
+					   __func__, i, xfer_idx);
+				ret_val = -ENODEV;
+				goto unmap_dma;
+			}
+
+			cookie[page_idx] = tx[page_idx]->tx_submit(tx[page_idx]);
+
+			if (dma_submit_error(cookie[page_idx])) {
+				pr_err("%s: submission error at chan %d xfer %d\n",
+					   __func__, i, xfer_idx);
+				ret_val = -ENODEV;
+				goto unmap_dma;
+			}
+		}
+
+		dma_async_issue_pending(copy_chan[i]);
+	}
+
+	page_idx = 0;
+	for (i = 0; i < total_available_chans; ++i) {
+		int num_xfer_per_dev = nr_items / total_available_chans;
+		int xfer_idx;
+
+		if (i < (nr_items % total_available_chans))
+			num_xfer_per_dev += 1;
+
+		for (xfer_idx = 0; xfer_idx < num_xfer_per_dev; ++xfer_idx, ++page_idx) {
+
+			if (dma_sync_wait(copy_chan[i], cookie[page_idx]) != DMA_COMPLETE) {
+				ret_val = -6;
+				pr_err("%s: dma does not complete at chan %d, xfer %d\n",
+					   __func__, i, xfer_idx);
+			}
+		}
+	}
+
+unmap_dma:
+	for (i = 0; i < total_available_chans; ++i) {
+		if (unmap[i])
+			dmaengine_unmap_put(unmap[i]);
+	}
+
+out_free_both:
+	kfree(cookie);
+out_free_tx:
+	kfree(tx);
+out:
+
+	return ret_val;
+}
diff --git a/mm/internal.h b/mm/internal.h
index 9eeaf2b..cb1a610 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -555,4 +555,8 @@ static inline bool is_migrate_highatomic_page(struct page *page)
 
 void setup_zone_pageset(struct zone *zone);
 extern struct page *alloc_new_node_page(struct page *page, unsigned long node);
+
+extern int copy_page_lists_dma_always(struct page **to,
+			struct page **from, int nr_pages);
+
 #endif	/* __MM_INTERNAL_H */
-- 
2.7.4

