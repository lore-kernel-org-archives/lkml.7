Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9182C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 769C12087F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578430801;
	bh=PW1R0kCwObUs5ugOMMm2hMtOWrAcVFJshBPjuKNsFGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CyKDt54lP6MiCcSp9hHNNqUBHClcnKHisREhIEqSn2J/fkiQh9oUSKb2jV18aOp1N
	 ringldMT//GBCfHlKyNKkkFV6vqwI8Xaip8zKtBgPya4Xx9iiv9Zccjmzm5BJitE4B
	 BixKbpIpaozjKDTTUdXCtiqLF0H9KG6wnxsL6qaQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbgAGVAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:00:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:33708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728219AbgAGU74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 15:59:56 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C53812081E;
        Tue,  7 Jan 2020 20:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578430795;
        bh=PW1R0kCwObUs5ugOMMm2hMtOWrAcVFJshBPjuKNsFGk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v1nEGe/ZN8DX1/LThJnGa/Hz57RYbnCx9rdYkFpU60Hte5+mzT/YvrOFOJTB5dNlr
         rALppzSaqXvT4qfd+yLU7hftljC+6+xfbUrA4wt9G6XX0i8q5Hfhp4DaxqzscuvypR
         ToH9qf3Nv/FVcHAOJTDkMwvU+rCIwuCYh49j2iA4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Mason <clm@fb.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.4 100/191] block: fix splitting segments on boundary masks
Date:   Tue,  7 Jan 2020 21:53:40 +0100
Message-Id: <20200107205338.341621494@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205332.984228665@linuxfoundation.org>
References: <20200107205332.984228665@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

commit 429120f3df2dba2bf3a4a19f4212a53ecefc7102 upstream.

We ran into a problem with a mpt3sas based controller, where we would
see random (and hard to reproduce) file corruption). The issue seemed
specific to this controller, but wasn't specific to the file system.
After a lot of debugging, we find out that it's caused by segments
spanning a 4G memory boundary. This shouldn't happen, as the default
setting for segment boundary masks is 4G.

Turns out there are two issues in get_max_segment_size():

1) The default segment boundary mask is bypassed

2) The segment start address isn't taken into account when checking
   segment boundary limit

Fix these two issues by removing the bypass of the segment boundary
check even if the mask is set to the default value, and taking into
account the actual start address of the request when checking if a
segment needs splitting.

Cc: stable@vger.kernel.org # v5.1+
Reviewed-by: Chris Mason <clm@fb.com>
Tested-by: Chris Mason <clm@fb.com>
Fixes: dcebd755926b ("block: use bio_for_each_bvec() to compute multi-page bvec count")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Dropped const on the page pointer, ppc page_to_phys() doesn't mark the
page as const...
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/blk-merge.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -157,16 +157,14 @@ static inline unsigned get_max_io_size(s
 	return sectors & (lbs - 1);
 }
 
-static unsigned get_max_segment_size(const struct request_queue *q,
-				     unsigned offset)
+static inline unsigned get_max_segment_size(const struct request_queue *q,
+					    struct page *start_page,
+					    unsigned long offset)
 {
 	unsigned long mask = queue_segment_boundary(q);
 
-	/* default segment boundary mask means no boundary limit */
-	if (mask == BLK_SEG_BOUNDARY_MASK)
-		return queue_max_segment_size(q);
-
-	return min_t(unsigned long, mask - (mask & offset) + 1,
+	offset = mask & (page_to_phys(start_page) + offset);
+	return min_t(unsigned long, mask - offset + 1,
 		     queue_max_segment_size(q));
 }
 
@@ -201,7 +199,8 @@ static bool bvec_split_segs(const struct
 	unsigned seg_size = 0;
 
 	while (len && *nsegs < max_segs) {
-		seg_size = get_max_segment_size(q, bv->bv_offset + total_len);
+		seg_size = get_max_segment_size(q, bv->bv_page,
+						bv->bv_offset + total_len);
 		seg_size = min(seg_size, len);
 
 		(*nsegs)++;
@@ -404,7 +403,8 @@ static unsigned blk_bvec_map_sg(struct r
 
 	while (nbytes > 0) {
 		unsigned offset = bvec->bv_offset + total;
-		unsigned len = min(get_max_segment_size(q, offset), nbytes);
+		unsigned len = min(get_max_segment_size(q, bvec->bv_page,
+					offset), nbytes);
 		struct page *page = bvec->bv_page;
 
 		/*


