Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FD9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 02:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A41F6218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 02:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551320384;
	bh=ReuKHKu+ruGfkqxAcyU6fgpO1RuF/XiIu1ypcOyPET0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uOe8FYsdHkmnQ8tIogHYJMGK0AhoybHggTXJrHZRBeeo24YBMUja86MnqIyd3/0PA
	 XKLCAkvcDaSZ013VjpPRX9u/pTZqkrNiBEyZN2zURVsk/hmGAw3sFQ+M43fGMArHtb
	 0q6+rLK7MTkgzn7fYesaZzHDj6Es48GGRafh+uu4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730912AbfB1CTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 21:19:38 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34858 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730240AbfB1CSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 21:18:50 -0500
Received: by mail-qk1-f193.google.com with SMTP id z13so11213489qki.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 18:18:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Zob00SAWeBYh4oEQ8sirU3S+Sks7fCNmhlxQAAwLhMs=;
        b=IEg4Zwy9ZdTjltUjeRyDaDxQ/uv3ho6jDSiF6s/H7nzCF5qP7t2mu6fanNI7vH2x5o
         u8fa8fq3W8sEd7oJQNOpfImXucEpYqJ+sav4GcgYqeodkj4LcAdfSpvDi7N1gLHkNaNj
         LKiLiaT9oZ33gGxe9HWtZRIAA0uotErODCJjxzm+Nj+2zOqp5ZB1TVUSu1rMHUqrdlcm
         CmC0buna5no/74Xl0YnaSuNK24b/yqIgiAJjPno8jyDmn8ASHmKalOX6t/kvgRWALFC/
         LKGuUTW6A1t891kfGtFzhLJt9+vsDkv7PGx1G+00V11AVmLUkiIuWjqau9vejZ7L5Y5q
         9Kfg==
X-Gm-Message-State: APjAAAWLg5YDv2t2Rl5mEhbs3BDOKDd8stcB0F4T+xyTEWDl+o+mxB7h
        3giUAE47Zli1Qi1M28AkVX0=
X-Google-Smtp-Source: APXvYqxz8+gxkBV2tfV0g1NRbjVNK+SA9NVlrl0RNozpYzGlY83nUOmtsMtX9iAm89FyNgTCaf4oQg==
X-Received: by 2002:a37:4701:: with SMTP id u1mr4545594qka.357.1551320328211;
        Wed, 27 Feb 2019 18:18:48 -0800 (PST)
Received: from localhost.localdomain (cpe-98-13-254-243.nyc.res.rr.com. [98.13.254.243])
        by smtp.gmail.com with ESMTPSA id y21sm12048357qth.90.2019.02.27.18.18.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Feb 2019 18:18:47 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>
Cc:     Vlad Buslov <vladbu@mellanox.com>, kernel-team@fb.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/12] percpu: introduce helper to determine if two regions overlap
Date:   Wed, 27 Feb 2019 21:18:30 -0500
Message-Id: <20190228021839.55779-4-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20190228021839.55779-1-dennis@kernel.org>
References: <20190228021839.55779-1-dennis@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While block hints were always accurate, it's possible when spanning
across blocks that we miss updating the chunk's contig_hint. Rather than
rely on correctness of the boundaries of hints, do a full overlap
comparison.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 mm/percpu.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index 69ca51d238b5..b40112b2fc59 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -546,6 +546,24 @@ static inline int pcpu_cnt_pop_pages(struct pcpu_chunk *chunk, int bit_off,
 	       bitmap_weight(chunk->populated, page_start);
 }
 
+/*
+ * pcpu_region_overlap - determines if two regions overlap
+ * @a: start of first region, inclusive
+ * @b: end of first region, exclusive
+ * @x: start of second region, inclusive
+ * @y: end of second region, exclusive
+ *
+ * This is used to determine if the hint region [a, b) overlaps with the
+ * allocated region [x, y).
+ */
+static inline bool pcpu_region_overlap(int a, int b, int x, int y)
+{
+	if ((x >= a && x < b) || (y > a && y <= b) ||
+	    (x <= a && y >= b))
+		return true;
+	return false;
+}
+
 /**
  * pcpu_chunk_update - updates the chunk metadata given a free area
  * @chunk: chunk of interest
@@ -710,8 +728,11 @@ static void pcpu_block_update_hint_alloc(struct pcpu_chunk *chunk, int bit_off,
 					PCPU_BITMAP_BLOCK_BITS,
 					s_off + bits);
 
-	if (s_off >= s_block->contig_hint_start &&
-	    s_off < s_block->contig_hint_start + s_block->contig_hint) {
+	if (pcpu_region_overlap(s_block->contig_hint_start,
+				s_block->contig_hint_start +
+				s_block->contig_hint,
+				s_off,
+				s_off + bits)) {
 		/* block contig hint is broken - scan to fix it */
 		pcpu_block_refresh_hint(chunk, s_index);
 	} else {
@@ -764,8 +785,10 @@ static void pcpu_block_update_hint_alloc(struct pcpu_chunk *chunk, int bit_off,
 	 * contig hint is broken.  Otherwise, it means a smaller space
 	 * was used and therefore the chunk contig hint is still correct.
 	 */
-	if (bit_off >= chunk->contig_bits_start  &&
-	    bit_off < chunk->contig_bits_start + chunk->contig_bits)
+	if (pcpu_region_overlap(chunk->contig_bits_start,
+				chunk->contig_bits_start + chunk->contig_bits,
+				bit_off,
+				bit_off + bits))
 		pcpu_chunk_refresh_hint(chunk);
 }
 
-- 
2.17.1

