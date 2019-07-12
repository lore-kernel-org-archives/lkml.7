Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453EAC742A5
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 06:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1081120863
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 06:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sBxoqPDX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbfGLGhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 02:37:24 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34787 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbfGLGhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 02:37:24 -0400
Received: by mail-pl1-f196.google.com with SMTP id i2so4296391plt.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 23:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9fgLR31T2kJ7ByeAcyeu1jTET3a3Az2KgII9UYX7QS4=;
        b=sBxoqPDXu79GyIN83gqFvlOD8ZHmRtzdZstCyRXyHO9B2E1nMqqBiWvC0jVA3cm31V
         fPQgy9hD8jqllKrNvGVQg8Sk44E6VqOC5uAab+osHEk1qP/V4guf8AnM3K1oiBLBugoY
         KubIQQLK3vNOYqtK8h/C5dkmTFTbfFdnqXDxz513rCe2r1SPksvbwlIifKGr6gC5lzYK
         eZ2Fg9zUPEnFAjryZV6PAr9N/lCa3Vif4f+oejO2glcrjdpVRWSMK6p87iy5OeooKNN0
         eFB87W5D48LmLccHHOQLKjd9nJQjlJ1K3bWk7g2IekStCm+o+YEl+U8duDA8WXzZuCye
         Mr4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=9fgLR31T2kJ7ByeAcyeu1jTET3a3Az2KgII9UYX7QS4=;
        b=S5bFhZGvR2j7SvRMAi17XT5rmvbHndrJcWqT+GkjBnfOCzFK46zA2/FoHuDwOkcWq+
         61nYTeHsALv6SZBLO0aQk+ji/zsKcvT53LZKSEfWoIpkM+UDdYfgGcPt9CFM397txve4
         hzIUvM3HTeAaeOCO2gqOSJ6TFy5ge7rtvtnSaSctTLCbO5pnudr5Mk66u1WcUbrzq/cI
         UP4F7wgZLq2VVqoKnJVOxmTJSEZwubNxcwoy9Tk+VmdqbzLmpqerp/B/44VnZ+jZS3ki
         6WmJ1YDZem1crMLWDsu99DB9G8U6gBjn+aJCY4O+EpdH28zScx1gU7WknUgH4XEvPGP8
         ukmA==
X-Gm-Message-State: APjAAAXU9sKKAa1g4Ap5g99Yu+LrRddAkN7kFCKWhTx1F7rGy9aFSC6V
        A09uwSNQMnHpbSUsNbwNdh0=
X-Google-Smtp-Source: APXvYqxkpWXZ8Vmqsb8usZU+CD3WNVTb4QPIM1Ql1geulqzEjlHZnEzRFtJGH9W35wR/6NeBVcRYWA==
X-Received: by 2002:a17:902:7781:: with SMTP id o1mr9466218pll.205.1562913443380;
        Thu, 11 Jul 2019 23:37:23 -0700 (PDT)
Received: from sultan-box.hsd1.ca.comcast.net ([2601:200:c001:5f40:3dac:1a9b:f47c:b78e])
        by smtp.gmail.com with ESMTPSA id 125sm11825010pfg.23.2019.07.11.23.37.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 23:37:22 -0700 (PDT)
From:   Sultan Alsawaf <sultan@kerneltoast.com>
X-Google-Original-From: Sultan Alsawaf
Cc:     Sultan Alsawaf <sultan@kerneltoast.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Ming Lei <ming.lei@redhat.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Gal Pressman <galpress@amazon.com>,
        Allison Randal <allison@lohutok.net>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scatterlist: Allocate a contiguous array instead of chaining
Date:   Thu, 11 Jul 2019 23:36:56 -0700
Message-Id: <20190712063657.17088-1-sultan@kerneltoast.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sultan Alsawaf <sultan@kerneltoast.com>

Typically, drivers allocate sg lists of sizes up to a few MiB in size.
The current algorithm deals with large sg lists by splitting them into
several smaller arrays and chaining them together. But if the sg list
allocation is large, and we know the size ahead of time, sg chaining is
both inefficient and unnecessary.

Rather than calling kmalloc hundreds of times in a loop for chaining
tiny arrays, we can simply do it all at once with kvmalloc, which has
the proper tradeoff on when to stop using kmalloc and instead use
vmalloc.

Abusing repeated kmallocs to produce a large allocation puts strain on
the slab allocator, when kvmalloc can be used instead. The single
kvmalloc allocation for all sg lists reduces the burden on the slab and
page allocators, since for large sg list allocations, this commit
replaces numerous kmalloc calls with one kvmalloc call.

The sg chaining is effectively disabled by changing SG_MAX_SINGLE_ALLOC
to UINT_MAX, which causes sg list allocations to never be split into
chains, since no allocation is larger than UINT_MAX. We then plumb
kvmalloc into the allocation functions so that it is used.

Signed-off-by: Sultan Alsawaf <sultan@kerneltoast.com>
---
 include/linux/scatterlist.h |  2 +-
 lib/scatterlist.c           | 23 ++---------------------
 2 files changed, 3 insertions(+), 22 deletions(-)

diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index 6eec50fb36c8..e2e26c53c441 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -310,7 +310,7 @@ size_t sg_zero_buffer(struct scatterlist *sgl, unsigned int nents,
  * Maximum number of entries that will be allocated in one piece, if
  * a list larger than this is required then chaining will be utilized.
  */
-#define SG_MAX_SINGLE_ALLOC		(PAGE_SIZE / sizeof(struct scatterlist))
+#define SG_MAX_SINGLE_ALLOC		(UINT_MAX)
 
 /*
  * The maximum number of SG segments that we will put inside a
diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index c2cf2c311b7d..bf76854a34aa 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -148,31 +148,12 @@ EXPORT_SYMBOL(sg_init_one);
  */
 static struct scatterlist *sg_kmalloc(unsigned int nents, gfp_t gfp_mask)
 {
-	if (nents == SG_MAX_SINGLE_ALLOC) {
-		/*
-		 * Kmemleak doesn't track page allocations as they are not
-		 * commonly used (in a raw form) for kernel data structures.
-		 * As we chain together a list of pages and then a normal
-		 * kmalloc (tracked by kmemleak), in order to for that last
-		 * allocation not to become decoupled (and thus a
-		 * false-positive) we need to inform kmemleak of all the
-		 * intermediate allocations.
-		 */
-		void *ptr = (void *) __get_free_page(gfp_mask);
-		kmemleak_alloc(ptr, PAGE_SIZE, 1, gfp_mask);
-		return ptr;
-	} else
-		return kmalloc_array(nents, sizeof(struct scatterlist),
-				     gfp_mask);
+	return kvmalloc_array(nents, sizeof(struct scatterlist), gfp_mask);
 }
 
 static void sg_kfree(struct scatterlist *sg, unsigned int nents)
 {
-	if (nents == SG_MAX_SINGLE_ALLOC) {
-		kmemleak_free(sg);
-		free_page((unsigned long) sg);
-	} else
-		kfree(sg);
+	kvfree(sg);
 }
 
 /**
-- 
2.22.0

