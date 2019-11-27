Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE76C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 14:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF357206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 14:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiD7wVli"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfK0OWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 09:22:20 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33044 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfK0OWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 09:22:20 -0500
Received: by mail-lf1-f65.google.com with SMTP id d6so17342805lfc.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 06:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1ueKGNrZq9k5CAhuDKF0UemrCbj1DCqBbGnBf2zTeN8=;
        b=LiD7wVliol4JBaFNF5iQsLBWwl2fPcg4c0y+Sanhx3VYe3K1c9XiMQGBdJhwRicVkC
         drsVbAmx3ccSsK+EMri63sqmqTtDq1BzSMbB37X0vg4cGT4AA2UMN9y3iEdNdCauseoe
         W9ZcP3hdjy1DLrQzXLCitdqOu+3KPX38dU3zkK/IFCXjEVEd3kg8Lhehs+zGgvdbuZZI
         F1tohcfdEkBCWYN74A0rjMH5daupj2rAeavcgKrpUcJqH62BqpXIm/KRiTpDyBFDAwjo
         1+ITbTDY4LQYwd/fZbZJwrneofyYAbo9OAueDrPgIcdlH5iyYmhV4cpoAKcebOLKELfk
         d+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1ueKGNrZq9k5CAhuDKF0UemrCbj1DCqBbGnBf2zTeN8=;
        b=V8h1Rj2y4Hj+4qQ33eGGC2P+ioHfpAoENQaOYYyIWD4pl4lxS/hOQjcrUAGpLQFW4Z
         G5Y6LngUHwGxYkyEg2dsj4WJ6U5Qt0ves/N12CkaGhTHxFQTH9TtLvPZLX+D1jmxON4t
         Bg3Ibm5TnZL8nwc0BdfdSp2UEJb+DUwyxa2PQLbgNBHHXsMSEAgukpbXYxJ4cGRns/lU
         WgbjDTC1fx+4ougnFtHIvddP84Y1xH+9zyYsruckajanqodT8SLxmQnSjPUqZ8FbcafA
         YK/5/xKtsp6RdXGUgpGnR4PnaII/JEVhMhHfdjH5wCUSptns14tU0K7F4Yap7Byw+Sft
         NNDg==
X-Gm-Message-State: APjAAAVWQ8PdNDd2sadQMNNOF4RwuNSro8e0r4D6Irn9Ys6BQFCp116U
        2Zsbbywh7Ju4jeSSjGIJ0DM=
X-Google-Smtp-Source: APXvYqxoDGM2pTjkXU7EFq31NdlZMDDL+QXhB5NtEwqztyorARwYt7dKhqs0xkXQ+f7uB2oxBnZ6hQ==
X-Received: by 2002:ac2:51b5:: with SMTP id f21mr28773344lfk.159.1574864538094;
        Wed, 27 Nov 2019 06:22:18 -0800 (PST)
Received: from seldlx21914.corpusers.net ([37.139.156.40])
        by smtp.gmail.com with ESMTPSA id x9sm7032158lfn.21.2019.11.27.06.22.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2019 06:22:17 -0800 (PST)
Date:   Wed, 27 Nov 2019 15:22:16 +0100
From:   Vitaly Wool <vitalywool@gmail.com>
To:     <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 2/3] z3fold: compact objects more accurately
Message-Id: <20191127152216.6ad33745a21ba71c53606acb@gmail.com>
In-Reply-To: <20191127152012.17a4b35f9e7f6e50f9aaca9c@gmail.com>
References: <20191127152012.17a4b35f9e7f6e50f9aaca9c@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several small things to be considered regarding the
new inter-page compaction mechanism. First, we better set the
relevant size in chunks to 0 in the old z3fold header for the
object that has been moved to another z3fold page. Then, we
shouldn't do inter-page compaction if an object is mapped.
Lastly, free_handle should happen before release_z3fold_page
(but not in case the page is under reclaim, it will the handle
will be freed by reclaim then).

This patch addresses all three issues.

Signed-off-by: Vitaly Wool <vitaly.vul@sony.com>
---
 mm/z3fold.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 36bd2612f609..f2a75418e248 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -670,6 +670,7 @@ static struct z3fold_header *compact_single_buddy(struct z3fold_header *zhdr)
 	int first_idx = __idx(zhdr, FIRST);
 	int middle_idx = __idx(zhdr, MIDDLE);
 	int last_idx = __idx(zhdr, LAST);
+	unsigned short *moved_chunks = NULL;
 
 	/*
 	 * No need to protect slots here -- all the slots are "local" and
@@ -679,14 +680,17 @@ static struct z3fold_header *compact_single_buddy(struct z3fold_header *zhdr)
 		p += ZHDR_SIZE_ALIGNED;
 		sz = zhdr->first_chunks << CHUNK_SHIFT;
 		old_handle = (unsigned long)&zhdr->slots->slot[first_idx];
+		moved_chunks = &zhdr->first_chunks;
 	} else if (zhdr->middle_chunks && zhdr->slots->slot[middle_idx]) {
 		p += zhdr->start_middle << CHUNK_SHIFT;
 		sz = zhdr->middle_chunks << CHUNK_SHIFT;
 		old_handle = (unsigned long)&zhdr->slots->slot[middle_idx];
+		moved_chunks = &zhdr->middle_chunks;
 	} else if (zhdr->last_chunks && zhdr->slots->slot[last_idx]) {
 		p += PAGE_SIZE - (zhdr->last_chunks << CHUNK_SHIFT);
 		sz = zhdr->last_chunks << CHUNK_SHIFT;
 		old_handle = (unsigned long)&zhdr->slots->slot[last_idx];
+		moved_chunks = &zhdr->last_chunks;
 	}
 
 	if (sz > 0) {
@@ -743,6 +747,8 @@ static struct z3fold_header *compact_single_buddy(struct z3fold_header *zhdr)
 		write_unlock(&zhdr->slots->lock);
 		add_to_unbuddied(pool, new_zhdr);
 		z3fold_page_unlock(new_zhdr);
+
+		*moved_chunks = 0;
 	}
 
 	return new_zhdr;
@@ -840,7 +846,7 @@ static void do_compact_page(struct z3fold_header *zhdr, bool locked)
 	}
 
 	if (!zhdr->foreign_handles && buddy_single(zhdr) &&
-			compact_single_buddy(zhdr)) {
+	    zhdr->mapped_count == 0 && compact_single_buddy(zhdr)) {
 		if (kref_put(&zhdr->refcount, release_z3fold_page_locked))
 			atomic64_dec(&pool->pages_nr);
 		else
@@ -1254,6 +1260,8 @@ static void z3fold_free(struct z3fold_pool *pool, unsigned long handle)
 		return;
 	}
 
+	if (!page_claimed)
+		free_handle(handle);
 	if (kref_put(&zhdr->refcount, release_z3fold_page_locked_list)) {
 		atomic64_dec(&pool->pages_nr);
 		return;
@@ -1263,7 +1271,6 @@ static void z3fold_free(struct z3fold_pool *pool, unsigned long handle)
 		z3fold_page_unlock(zhdr);
 		return;
 	}
-	free_handle(handle);
 	if (unlikely(PageIsolated(page)) ||
 	    test_and_set_bit(NEEDS_COMPACTING, &page->private)) {
 		put_z3fold_header(zhdr);
-- 
2.17.1
