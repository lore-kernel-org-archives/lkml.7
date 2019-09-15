Return-Path: <SRS0=lz0T=XK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44738C2BA1D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 21:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 076822077C
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Sep 2019 21:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQzCzvJE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfIOVqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 17:46:53 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43867 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfIOVqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 17:46:52 -0400
Received: by mail-lj1-f194.google.com with SMTP id d5so31885760lja.10
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 14:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=vGboY1Ug06nQuNjlAhHa47y6oO8ayp/E0vNzgPvoh2A=;
        b=AQzCzvJEMAzqcUzPAr43Ed9/PeX6iMi2hO/b3aNeOYvSLVO0JbcxrCkbT6TWj3TN5I
         8gpSrmKYXqvGXkUOntFotwFmLqag7WHFXr3MjgC7JwoMYUT15QWm++9aPiCkklpV1lyo
         yfvLBWN56y7mgDCLVUb0MR+vKnVteGL0TI2Dz2B/gmXMFZwuQntU2XqEG7IHX0dEuyeW
         cT4ox7H9LOArjbYVYw94FKzC4k6bxQ347yuzk75Wf/hzgNP0jsp4YYYsQZzkA8dS3n5o
         UedX4RqvHMygSkQtpiu5Ob3tYtTRTEDBdpkF9mWO4Lvp7Hlcs0C74PCXNrz3eQ0JJxkk
         SYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-transfer-encoding;
        bh=vGboY1Ug06nQuNjlAhHa47y6oO8ayp/E0vNzgPvoh2A=;
        b=eOF0GdpVsySgzwUcrE4UlmwwnNMwBaZ2g2n0LCCR5SW1EkhrRWvgWEtGFmykqyDvFK
         oH/GG/XXIx0cfD5RkfSOiyu+QZB3ARzuWshD6cLGT5oYmw2uXEcP3ohgrBBwg+2uKcGg
         XS5uzHInlG4K1ZZfvSn3eqt73pfmQUOP/6gxL65oVml/Y/HKdmfkCtGw3AaJd4L9yBQM
         gXWmeskNj0C8Hnl7hDnnWInIdrkbtV/2l/kv8HpLRGkp1gE+KUkWauv1DgEbdKknp6t6
         MFtAXkG0Pl2/iFeu8Qx50vHtLO5ysbOm7Ks9ESnJHNrsS9YWYBu326jLnAJXkRRcVZEp
         cm9Q==
X-Gm-Message-State: APjAAAW/pm4M+WqxLUiG2nYV+/2X0/tVfe+VhnW98eN7XZMpMshqrmM5
        beiA/ve5RHQ6GOTnzPyFGf0OcGLIy5Y=
X-Google-Smtp-Source: APXvYqwFNn6c8zkLpgJmIk5huSj1K2GFhJIlyaZSseoTobOGvx/CIHfcSOG7spXLVGIIBLBvZL8bvA==
X-Received: by 2002:a2e:2d5:: with SMTP id y82mr11309975lje.230.1568584010767;
        Sun, 15 Sep 2019 14:46:50 -0700 (PDT)
Received: from vitaly-Dell-System-XPS-L322X ([188.150.241.161])
        by smtp.gmail.com with ESMTPSA id r19sm8012861ljd.95.2019.09.15.14.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2019 14:46:49 -0700 (PDT)
Date:   Mon, 16 Sep 2019 00:46:40 +0300
From:   Vitaly Wool <vitalywool@gmail.com>
To:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Dan Streetman <ddstreet@ieee.org>,
        Seth Jennings <sjenning@redhat.com>
Subject: [PATCH/RFC] zswap: do not map same object twice
Message-Id: <20190916004640.b453167d3556c4093af4cf7d@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zswap_writeback_entry() maps a handle to read swpentry first, and
then in the most common case it would map the same handle again.
This is ok when zbud is the backend since its mapping callback is
plain and simple, but it slows things down for z3fold.

Since there's hardly a point in unmapping a handle _that_ fast as
zswap_writeback_entry() does when it reads swpentry, the
suggestion is to keep the handle mapped till the end.

Signed-off-by: Vitaly Wool <vitalywool@gmail.com>
---
 mm/zswap.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 0e22744a76cb..b35464bc7315 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -856,7 +856,6 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
 	/* extract swpentry from data */
 	zhdr = zpool_map_handle(pool, handle, ZPOOL_MM_RO);
 	swpentry = zhdr->swpentry; /* here */
-	zpool_unmap_handle(pool, handle);
 	tree = zswap_trees[swp_type(swpentry)];
 	offset = swp_offset(swpentry);
 
@@ -866,6 +865,7 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
 	if (!entry) {
 		/* entry was invalidated */
 		spin_unlock(&tree->lock);
+		zpool_unmap_handle(pool, handle);
 		return 0;
 	}
 	spin_unlock(&tree->lock);
@@ -886,15 +886,13 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
 	case ZSWAP_SWAPCACHE_NEW: /* page is locked */
 		/* decompress */
 		dlen = PAGE_SIZE;
-		src = (u8 *)zpool_map_handle(entry->pool->zpool, entry->handle,
-				ZPOOL_MM_RO) + sizeof(struct zswap_header);
+		src = (u8 *)zhdr + sizeof(struct zswap_header);
 		dst = kmap_atomic(page);
 		tfm = *get_cpu_ptr(entry->pool->tfm);
 		ret = crypto_comp_decompress(tfm, src, entry->length,
 					     dst, &dlen);
 		put_cpu_ptr(entry->pool->tfm);
 		kunmap_atomic(dst);
-		zpool_unmap_handle(entry->pool->zpool, entry->handle);
 		BUG_ON(ret);
 		BUG_ON(dlen != PAGE_SIZE);
 
@@ -940,6 +938,7 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
 	spin_unlock(&tree->lock);
 
 end:
+	zpool_unmap_handle(pool, handle);
 	return ret;
 }
 
-- 
2.17.1
