Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A486BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 02:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF98218CD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 02:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551320354;
	bh=gzS0LnigP6eG+W/mqro4ta/rNeyLQ2bb5S0Knm9W6SU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0t+FaKPh4LQ9PkL6x9XzDRdvS5iNe4/q89ikkb4fPX658U5A9+hO4oick6RhzxMhc
	 f+xjuSr80zvj9sJ8I0ZOvYN9We67Zg4Vekyt3zmWcSQqHqmUvTEx9sktIYFk9TVReC
	 a/ACZjFohjvDQZMqGIgUgvxgSEzrdCJUBhty7k2A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730806AbfB1CTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 21:19:03 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34374 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730779AbfB1CTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 21:19:00 -0500
Received: by mail-qk1-f196.google.com with SMTP id a15so11200364qkc.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 18:18:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a1MxtiVBC/R1K9jFEg6/xTwsmtYqOsSXFAxjGkPQwuE=;
        b=tJUmN87nyywjdj0DTJRjR0GAN1N9EUgwJc4/a4xvoU23PhnsmAKKxP0++EzR1X35Sq
         Uwvjetpk7FwhdbinSwl84U+PKultRRUr007jxqa9H/k6yrcBElG5+BF6ucRkQNoHwV3e
         RAzonV8vIaxh/9F2GVrj+jpa3qnsnbCvl3bcIruhUXrekpxwyu6237bUpJ68k9RRKLqs
         /Cm4sEMWz4idcDfH8YixjIpmPwewirvFS3UX3i9FKdgj2edwQvMjrXBStat9QPERVfzE
         i+xRo/UGvY//BJLpclQOUQc09dOJZZhR5blsZu4/OXtqiDf7IMo1L8N1YCHMiETAZnzs
         7Jiw==
X-Gm-Message-State: AHQUAubJK4uPN4wslAskNd7cpdsLqNw2/fRueFg1oBQHM3aNeyvy7uNP
        0jKXNL+21+yPZXYOjbGX+9Y=
X-Google-Smtp-Source: APXvYqwPqhzmoh6GEfoGzQtsXP/iOmZeY0a+Lec5XpOorPIszYP54avqBFyXUbatJXA0jjRU7OtQYg==
X-Received: by 2002:a37:e30b:: with SMTP id y11mr4833349qki.25.1551320338781;
        Wed, 27 Feb 2019 18:18:58 -0800 (PST)
Received: from localhost.localdomain (cpe-98-13-254-243.nyc.res.rr.com. [98.13.254.243])
        by smtp.gmail.com with ESMTPSA id y21sm12048357qth.90.2019.02.27.18.18.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Feb 2019 18:18:57 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>
Cc:     Vlad Buslov <vladbu@mellanox.com>, kernel-team@fb.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/12] percpu: make pcpu_block_md generic
Date:   Wed, 27 Feb 2019 21:18:37 -0500
Message-Id: <20190228021839.55779-11-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20190228021839.55779-1-dennis@kernel.org>
References: <20190228021839.55779-1-dennis@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In reality, a chunk is just a block covering a larger number of bits.
The hints themselves are one in the same. Rather than maintaining the
hints separately, first introduce nr_bits to genericize
pcpu_block_update() to correctly maintain block->right_free. The next
patch will convert chunk hints to be managed as a pcpu_block_md.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 mm/percpu-internal.h |  1 +
 mm/percpu.c          | 20 +++++++++++++-------
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/mm/percpu-internal.h b/mm/percpu-internal.h
index ec58b244545d..119bd1119aa7 100644
--- a/mm/percpu-internal.h
+++ b/mm/percpu-internal.h
@@ -28,6 +28,7 @@ struct pcpu_block_md {
 	int                     right_free;     /* size of free space along
 						   the right side of the block */
 	int                     first_free;     /* block position of first free */
+	int			nr_bits;	/* total bits responsible for */
 };
 
 struct pcpu_chunk {
diff --git a/mm/percpu.c b/mm/percpu.c
index e51c151ed692..7cdf14c242de 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -658,7 +658,7 @@ static void pcpu_block_update(struct pcpu_block_md *block, int start, int end)
 	if (start == 0)
 		block->left_free = contig;
 
-	if (end == PCPU_BITMAP_BLOCK_BITS)
+	if (end == block->nr_bits)
 		block->right_free = contig;
 
 	if (contig > block->contig_hint) {
@@ -1271,18 +1271,24 @@ static void pcpu_free_area(struct pcpu_chunk *chunk, int off)
 	pcpu_chunk_relocate(chunk, oslot);
 }
 
+static void pcpu_init_md_block(struct pcpu_block_md *block, int nr_bits)
+{
+	block->scan_hint = 0;
+	block->contig_hint = nr_bits;
+	block->left_free = nr_bits;
+	block->right_free = nr_bits;
+	block->first_free = 0;
+	block->nr_bits = nr_bits;
+}
+
 static void pcpu_init_md_blocks(struct pcpu_chunk *chunk)
 {
 	struct pcpu_block_md *md_block;
 
 	for (md_block = chunk->md_blocks;
 	     md_block != chunk->md_blocks + pcpu_chunk_nr_blocks(chunk);
-	     md_block++) {
-		md_block->scan_hint = 0;
-		md_block->contig_hint = PCPU_BITMAP_BLOCK_BITS;
-		md_block->left_free = PCPU_BITMAP_BLOCK_BITS;
-		md_block->right_free = PCPU_BITMAP_BLOCK_BITS;
-	}
+	     md_block++)
+		pcpu_init_md_block(md_block, PCPU_BITMAP_BLOCK_BITS);
 }
 
 /**
-- 
2.17.1

