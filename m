Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6791C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 02:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B26C62083D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 02:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551320347;
	bh=ZhjBG9w+fWIhq4/kz/NnMrvQrRfDggqAzow4FocggjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bSvEOsokj0bjqE2GfBC9dMRSIqX58w9fTki3puX5n3dyThOSeqmYzVrhLzfEJeMOv
	 0c1Z/XNZiLGKYu6yC6KQSVxs0RCa/RTJdvQ1w6c2ufZQd3sHK5rNL8LypV4qMjv/1H
	 uTrtwNToTn9YlWyUPqofuLGV1o3M2L0EG93m+m1M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730835AbfB1CTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 21:19:06 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34375 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730798AbfB1CTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 21:19:02 -0500
Received: by mail-qk1-f194.google.com with SMTP id a15so11200413qkc.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 18:19:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qImDKhW66AzCuoNyqvyprY/jSnw+rPbm4Fv7bWHuvuA=;
        b=ZlMwHzYbDIXKFXiKIjruT7eCivHuOvi1pTejcsA+9wHaHz4HDdznQ641/CUvtWzE1U
         gHaC9rVl2MOv4TLzMQSbXw7OPHvf0i4ZchwUUO1ti2Lp757bPgqLbgrxwBZJ1qrl7wYM
         Vf0bIIuyeraMsBV/45t+P2qM98WLxKKnNMu0y6wmXWKRX5qaWYHb/8xDTz/DnnCmqXBP
         F7NzPNyk8lGdgNIJ4J022fowerVbbG7ajU6WoVlZ9Tb9M2WrmRw75TpNYDHa8BLxMrFf
         c0yR62c58BCfu8Jl0SaFAxZkcYSYo782graN4lbzEm0uf6cIIQd4E5JnrK8UQiIQor7A
         FItg==
X-Gm-Message-State: AHQUAubupjEJa8CYgRI2g1QR+beOjLbKEx0YfN8wDsdAHxRSoeMv75ye
        HAPTiAAk2XOayUTN5lRi1qg=
X-Google-Smtp-Source: AHgI3IYgGWL916vz2qCJL6FgtJg1g1UrnDtKTf9mK0j3zPUUdDEHBIlwVWx5ZLs8juhi27ZLZhRLpg==
X-Received: by 2002:a37:4e97:: with SMTP id c145mr4659307qkb.85.1551320341809;
        Wed, 27 Feb 2019 18:19:01 -0800 (PST)
Received: from localhost.localdomain (cpe-98-13-254-243.nyc.res.rr.com. [98.13.254.243])
        by smtp.gmail.com with ESMTPSA id y21sm12048357qth.90.2019.02.27.18.19.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Feb 2019 18:19:00 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>
Cc:     Vlad Buslov <vladbu@mellanox.com>, kernel-team@fb.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/12] percpu: use chunk scan_hint to skip some scanning
Date:   Wed, 27 Feb 2019 21:18:39 -0500
Message-Id: <20190228021839.55779-13-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20190228021839.55779-1-dennis@kernel.org>
References: <20190228021839.55779-1-dennis@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like blocks, chunks now maintain a scan_hint. This can be used to
skip some scanning by promoting the scan_hint to be the contig_hint.
The chunk's scan_hint is primarily updated on the backside and relies on
full scanning when a block becomes free or the free region spans across
blocks.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 mm/percpu.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index 197479f2c489..40d49d7fb286 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -711,20 +711,31 @@ static void pcpu_block_update_scan(struct pcpu_chunk *chunk, int bit_off,
 /**
  * pcpu_chunk_refresh_hint - updates metadata about a chunk
  * @chunk: chunk of interest
+ * @full_scan: if we should scan from the beginning
  *
  * Iterates over the metadata blocks to find the largest contig area.
- * It also counts the populated pages and uses the delta to update the
- * global count.
+ * A full scan can be avoided on the allocation path as this is triggered
+ * if we broke the contig_hint.  In doing so, the scan_hint will be before
+ * the contig_hint or after if the scan_hint == contig_hint.  This cannot
+ * be prevented on freeing as we want to find the largest area possibly
+ * spanning blocks.
  */
-static void pcpu_chunk_refresh_hint(struct pcpu_chunk *chunk)
+static void pcpu_chunk_refresh_hint(struct pcpu_chunk *chunk, bool full_scan)
 {
 	struct pcpu_block_md *chunk_md = &chunk->chunk_md;
 	int bit_off, bits;
 
-	/* clear metadata */
-	chunk_md->contig_hint = 0;
+	/* promote scan_hint to contig_hint */
+	if (!full_scan && chunk_md->scan_hint) {
+		bit_off = chunk_md->scan_hint_start + chunk_md->scan_hint;
+		chunk_md->contig_hint_start = chunk_md->scan_hint_start;
+		chunk_md->contig_hint = chunk_md->scan_hint;
+		chunk_md->scan_hint = 0;
+	} else {
+		bit_off = chunk_md->first_free;
+		chunk_md->contig_hint = 0;
+	}
 
-	bit_off = chunk_md->first_free;
 	bits = 0;
 	pcpu_for_each_md_free_region(chunk, bit_off, bits) {
 		pcpu_block_update(chunk_md, bit_off, bit_off + bits);
@@ -884,6 +895,13 @@ static void pcpu_block_update_hint_alloc(struct pcpu_chunk *chunk, int bit_off,
 	if (nr_empty_pages)
 		pcpu_update_empty_pages(chunk, -1 * nr_empty_pages);
 
+	if (pcpu_region_overlap(chunk_md->scan_hint_start,
+				chunk_md->scan_hint_start +
+				chunk_md->scan_hint,
+				bit_off,
+				bit_off + bits))
+		chunk_md->scan_hint = 0;
+
 	/*
 	 * The only time a full chunk scan is required is if the chunk
 	 * contig hint is broken.  Otherwise, it means a smaller space
@@ -894,7 +912,7 @@ static void pcpu_block_update_hint_alloc(struct pcpu_chunk *chunk, int bit_off,
 				chunk_md->contig_hint,
 				bit_off,
 				bit_off + bits))
-		pcpu_chunk_refresh_hint(chunk);
+		pcpu_chunk_refresh_hint(chunk, false);
 }
 
 /**
@@ -1005,7 +1023,7 @@ static void pcpu_block_update_hint_free(struct pcpu_chunk *chunk, int bit_off,
 	 * the else condition below.
 	 */
 	if (((end - start) >= PCPU_BITMAP_BLOCK_BITS) || s_index != e_index)
-		pcpu_chunk_refresh_hint(chunk);
+		pcpu_chunk_refresh_hint(chunk, true);
 	else
 		pcpu_block_update(&chunk->chunk_md,
 				  pcpu_block_off_to_off(s_index, start),
@@ -1078,7 +1096,7 @@ static int pcpu_find_block_fit(struct pcpu_chunk *chunk, int alloc_bits,
 	if (bit_off + alloc_bits > chunk_md->contig_hint)
 		return -1;
 
-	bit_off = chunk_md->first_free;
+	bit_off = pcpu_next_hint(chunk_md, alloc_bits);
 	bits = 0;
 	pcpu_for_each_fit_region(chunk, alloc_bits, align, bit_off, bits) {
 		if (!pop_only || pcpu_is_populated(chunk, bit_off, bits,
-- 
2.17.1

