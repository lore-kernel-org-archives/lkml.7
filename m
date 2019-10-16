Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED577FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C79922168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hh2BQR9H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404380AbfJPJyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 05:54:53 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42322 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728672AbfJPJyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 05:54:52 -0400
Received: by mail-lf1-f68.google.com with SMTP id c195so16918490lfg.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 02:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8BWvlmXa5Itb4HNOlJ7mNfofmk+n7/jwhwr224X7wkA=;
        b=hh2BQR9H/TttXyKoEjHs8VBNq116FbnDFbRYWngV3I1sbmyuCJJ0vQH83n9YmJgHQS
         USutVgNbliEBrCahSr2saDHdP9vgSwJOLG8mjfs+fEW3aFx4aduW3klPJGYQsa2F3DnQ
         P2KzeoYK2UXDFk9PzwqjjggtmuIrxibVzQClvj8qnA9Q7L72eManT4pLUm2JFW/CvjgK
         eM87O72+RoLgxEDvHpa4Nn6Mxt33vFRsd/Fcc5ic0fnnZqgX5PNG/YQcBURfbDSMckxf
         xIDEtnk1d6jfkScKnA5gc/H63GJYsDi+B0OLWl+qIKqqsK7SFX+yLlCvDEeav2dSA1r4
         c6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8BWvlmXa5Itb4HNOlJ7mNfofmk+n7/jwhwr224X7wkA=;
        b=A03GclTzbs9V6x6l58N0AZrvbsDObQP3RgeMOc8uF74oIz1QLBqzbmTYdmPxM8LWrk
         s7XQbDKjyt3xBhZaTAYQY/pLFTnhADP+Sx7B4qYn6KMEVewYjExxC540M8eBLQ1z/5fi
         SH1+b19BqHs1VCKOPg9OzWve1P4B9R7gfD/S0z03P0FP0WqAFeDCfPDSnc3FpQkvXDCf
         FlO/zgVFULSYwwx08N8bslcvjep6re1ypWPQpBQPxRuN+C9rEw4tql9dT9Y9aAaelRPu
         LFRDHST80Ztpjv73aJflZwXgKC4igJ6rUFryTctFRghD+uUsVdOIy66l/YLMvntHARvi
         tbtg==
X-Gm-Message-State: APjAAAWusBQyyZW9BLgzQCuzBKiJ1Wh4ZOrRxTzcjmpeEX2eNGeCxQl7
        VXkS7RqSEbek7kA5YN8I4XU=
X-Google-Smtp-Source: APXvYqyHqhSJPrwVPXwEIlMetVVFuIqlUxsmBmpW3xM6pBv558tYFejHW/wi29csutcwzsGqsNpstg==
X-Received: by 2002:ac2:4c38:: with SMTP id u24mr1294786lfq.45.1571219689589;
        Wed, 16 Oct 2019 02:54:49 -0700 (PDT)
Received: from pc636.semobile.internal ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id b2sm886452lfq.27.2019.10.16.02.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 02:54:48 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Daniel Wagner <dwagner@suse.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v3 2/3] mm/vmalloc: respect passed gfp_mask when do preloading
Date:   Wed, 16 Oct 2019 11:54:37 +0200
Message-Id: <20191016095438.12391-2-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191016095438.12391-1-urezki@gmail.com>
References: <20191016095438.12391-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alloc_vmap_area() is given a gfp_mask for the page allocator.
Let's respect that mask and consider it even in the case when
doing regular CPU preloading, i.e. where a context can sleep.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index b7b443bfdd92..593bf554518d 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1064,9 +1064,9 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 		return ERR_PTR(-EBUSY);
 
 	might_sleep();
+	gfp_mask = gfp_mask & GFP_RECLAIM_MASK;
 
-	va = kmem_cache_alloc_node(vmap_area_cachep,
-			gfp_mask & GFP_RECLAIM_MASK, node);
+	va = kmem_cache_alloc_node(vmap_area_cachep, gfp_mask, node);
 	if (unlikely(!va))
 		return ERR_PTR(-ENOMEM);
 
@@ -1074,7 +1074,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	 * Only scan the relevant parts containing pointers to other objects
 	 * to avoid false negatives.
 	 */
-	kmemleak_scan_area(&va->rb_node, SIZE_MAX, gfp_mask & GFP_RECLAIM_MASK);
+	kmemleak_scan_area(&va->rb_node, SIZE_MAX, gfp_mask);
 
 retry:
 	/*
@@ -1100,7 +1100,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 		 * Just proceed as it is. If needed "overflow" path
 		 * will refill the cache we allocate from.
 		 */
-		pva = kmem_cache_alloc_node(vmap_area_cachep, GFP_KERNEL, node);
+		pva = kmem_cache_alloc_node(vmap_area_cachep, gfp_mask, node);
 
 	spin_lock(&vmap_area_lock);
 
-- 
2.20.1

