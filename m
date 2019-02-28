Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65688C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 02:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 278B52083D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 02:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551320341;
	bh=6WFkylJOI/KsLhpKXyqFgjGOO/DhoHhfxhzZOIibr24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y030Sfx7aL+fWiJf9i/WXbgaAbHMBfviE/kc9IH26v7e5Sy5XmOocrrUSdhp0bVPk
	 csqldNj92SBGtXAY9r3EqqVIuo0IFGEacm3TI323x4pIBTn0g9iqJtTXcNWMLXZU/9
	 p7F/3rVjR56YAVR4mhsXxSg2tFnqgZWGg8bpvA4w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730787AbfB1CTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 21:19:00 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43202 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730741AbfB1CS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 21:18:57 -0500
Received: by mail-qk1-f193.google.com with SMTP id f196so11185131qke.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 18:18:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oDNiSsuPdsF/XOcfjzvj8LVYLn1xaHI/O2WR5uD3c+0=;
        b=plmR7D0mWyqZgPkNBXgRaCR5DxU6zKYqq7GTXR9ky6KHjDPJeKR2gJNFCQrNBKKTSx
         UoK15f+v3kyzMEpWN0Nkwziw71OcvIgDHMfFZbqIBvH1RJXVglA+wKkDZ0y+aExWoRUo
         LGheV03RXAD5T2kPYBFma6E8q5qcMF6OpX7IB9+t2RdE3/mXt6kJJs2w6GstP+vXX6u4
         qXTtkXTPprw6+YIh0KN1KLsSIE+Xj8yLstUxENYsNz7M/3WvvK98UAziTVTdkPCCTz0i
         rHhUUdgpVchbF6rJOugW+iY5Ay8/wTAvPDGdTS+/pZJJlkLK9l4Y0tKJ8S4QXKzUe9Tn
         TOaQ==
X-Gm-Message-State: AHQUAublzfNOlYfkayRWlQHhFTQSwtgx+rzCi8OXO6eT+JhbGBS64WGr
        kZFBn5yj17h9LEeft854Y6w=
X-Google-Smtp-Source: APXvYqyYBVI/T7ds+Dzo/USUVcDodJI0nlbspO0X1XTek/TSd9ZKWp/VHGFig0uB1cuf3Gy8qdZb3A==
X-Received: by 2002:a37:c097:: with SMTP id v23mr4655782qkv.62.1551320335886;
        Wed, 27 Feb 2019 18:18:55 -0800 (PST)
Received: from localhost.localdomain (cpe-98-13-254-243.nyc.res.rr.com. [98.13.254.243])
        by smtp.gmail.com with ESMTPSA id y21sm12048357qth.90.2019.02.27.18.18.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Feb 2019 18:18:55 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>
Cc:     Vlad Buslov <vladbu@mellanox.com>, kernel-team@fb.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/12] percpu: remember largest area skipped during allocation
Date:   Wed, 27 Feb 2019 21:18:35 -0500
Message-Id: <20190228021839.55779-9-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20190228021839.55779-1-dennis@kernel.org>
References: <20190228021839.55779-1-dennis@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Percpu allocations attempt to do first fit by scanning forward from the
first_free of a block. However, fragmentation from allocation requests
can cause holes not seen by block hint update functions. To address
this, create a local version of bitmap_find_next_zero_area_off() that
remembers the largest area skipped over. The caveat is that it only sees
regions skipped over due to not fitting, not regions skipped due to
alignment. Prior to updating the scan_hint, a scan backwards is done to
try and recover free bits skipped due to alignment. While this can cause
scanning to miss earlier possible free areas, smaller allocations will
eventually fill those holes.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 mm/percpu.c | 101 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 99 insertions(+), 2 deletions(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index df1aacf58ac8..dac18968d79f 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -716,6 +716,43 @@ static void pcpu_block_update(struct pcpu_block_md *block, int start, int end)
 	}
 }
 
+/*
+ * pcpu_block_update_scan - update a block given a free area from a scan
+ * @chunk: chunk of interest
+ * @bit_off: chunk offset
+ * @bits: size of free area
+ *
+ * Finding the final allocation spot first goes through pcpu_find_block_fit()
+ * to find a block that can hold the allocation and then pcpu_alloc_area()
+ * where a scan is used.  When allocations require specific alignments,
+ * we can inadvertently create holes which will not be seen in the alloc
+ * or free paths.
+ *
+ * This takes a given free area hole and updates a block as it may change the
+ * scan_hint.  We need to scan backwards to ensure we don't miss free bits
+ * from alignment.
+ */
+static void pcpu_block_update_scan(struct pcpu_chunk *chunk, int bit_off,
+				   int bits)
+{
+	int s_off = pcpu_off_to_block_off(bit_off);
+	int e_off = s_off + bits;
+	int s_index, l_bit;
+	struct pcpu_block_md *block;
+
+	if (e_off > PCPU_BITMAP_BLOCK_BITS)
+		return;
+
+	s_index = pcpu_off_to_block_index(bit_off);
+	block = chunk->md_blocks + s_index;
+
+	/* scan backwards in case of alignment skipping free bits */
+	l_bit = find_last_bit(pcpu_index_alloc_map(chunk, s_index), s_off);
+	s_off = (s_off == l_bit) ? 0 : l_bit + 1;
+
+	pcpu_block_update(block, s_off, e_off);
+}
+
 /**
  * pcpu_block_refresh_hint
  * @chunk: chunk of interest
@@ -1064,6 +1101,62 @@ static int pcpu_find_block_fit(struct pcpu_chunk *chunk, int alloc_bits,
 	return bit_off;
 }
 
+/*
+ * pcpu_find_zero_area - modified from bitmap_find_next_zero_area_off
+ * @map: the address to base the search on
+ * @size: the bitmap size in bits
+ * @start: the bitnumber to start searching at
+ * @nr: the number of zeroed bits we're looking for
+ * @align_mask: alignment mask for zero area
+ * @largest_off: offset of the largest area skipped
+ * @largest_bits: size of the largest area skipped
+ *
+ * The @align_mask should be one less than a power of 2.
+ *
+ * This is a modified version of bitmap_find_next_zero_area_off() to remember
+ * the largest area that was skipped.  This is imperfect, but in general is
+ * good enough.  The largest remembered region is the largest failed region
+ * seen.  This does not include anything we possibly skipped due to alignment.
+ * pcpu_block_update_scan() does scan backwards to try and recover what was
+ * lost to alignment.  While this can cause scanning to miss earlier possible
+ * free areas, smaller allocations will eventually fill those holes.
+ */
+static unsigned long pcpu_find_zero_area(unsigned long *map,
+					 unsigned long size,
+					 unsigned long start,
+					 unsigned long nr,
+					 unsigned long align_mask,
+					 unsigned long *largest_off,
+					 unsigned long *largest_bits)
+{
+	unsigned long index, end, i, area_off, area_bits;
+again:
+	index = find_next_zero_bit(map, size, start);
+
+	/* Align allocation */
+	index = __ALIGN_MASK(index, align_mask);
+	area_off = index;
+
+	end = index + nr;
+	if (end > size)
+		return end;
+	i = find_next_bit(map, end, index);
+	if (i < end) {
+		area_bits = i - area_off;
+		/* remember largest unused area with best alignment */
+		if (area_bits > *largest_bits ||
+		    (area_bits == *largest_bits && *largest_off &&
+		     (!area_off || __ffs(area_off) > __ffs(*largest_off)))) {
+			*largest_off = area_off;
+			*largest_bits = area_bits;
+		}
+
+		start = i + 1;
+		goto again;
+	}
+	return index;
+}
+
 /**
  * pcpu_alloc_area - allocates an area from a pcpu_chunk
  * @chunk: chunk of interest
@@ -1087,6 +1180,7 @@ static int pcpu_alloc_area(struct pcpu_chunk *chunk, int alloc_bits,
 			   size_t align, int start)
 {
 	size_t align_mask = (align) ? (align - 1) : 0;
+	unsigned long area_off = 0, area_bits = 0;
 	int bit_off, end, oslot;
 
 	lockdep_assert_held(&pcpu_lock);
@@ -1098,11 +1192,14 @@ static int pcpu_alloc_area(struct pcpu_chunk *chunk, int alloc_bits,
 	 */
 	end = min_t(int, start + alloc_bits + PCPU_BITMAP_BLOCK_BITS,
 		    pcpu_chunk_map_bits(chunk));
-	bit_off = bitmap_find_next_zero_area(chunk->alloc_map, end, start,
-					     alloc_bits, align_mask);
+	bit_off = pcpu_find_zero_area(chunk->alloc_map, end, start, alloc_bits,
+				      align_mask, &area_off, &area_bits);
 	if (bit_off >= end)
 		return -1;
 
+	if (area_bits)
+		pcpu_block_update_scan(chunk, area_off, area_bits);
+
 	/* update alloc map */
 	bitmap_set(chunk->alloc_map, bit_off, alloc_bits);
 
-- 
2.17.1

