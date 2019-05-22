Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE0DC282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 15:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A84721479
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 15:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pTaXTTu2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbfEVPJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 11:09:55 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46456 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729815AbfEVPJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 11:09:54 -0400
Received: by mail-lf1-f65.google.com with SMTP id l26so1947189lfh.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 08:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XS/exrL2qtsb1wQlcnKifMlE835u1lj3Ys1udy3P5H4=;
        b=pTaXTTu2glGWzCtLk76Cl7B6tZw4mic9YljjZTNWqawSe1IdcLFtJdXry3pTReF+XP
         jS2hGtc7XmDPY/jxLfqgB2oopz2zMYo1t5ATW0D/YM6xBHS3X1ptj9Atx/I5rdJ6rLAa
         1LGecflzmrOTWL7czlq9qcASE9EbnmfDcTVqqQh2vv5J+rcWAkTmlX2bdylKxCRVPqk4
         QzOm6Eg6M/ZYU8xeGmcD/JHLadKWQeIu6aySuhyGBXUXFwuGj/nH7Peu3UnfPgs80Xax
         rSDrs1IFJINGs0egfYiEhho7OP6+0AxPZdIY/2d/E69jBS0ptLrfxDtUWaDRPHfkW1Q2
         OmYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XS/exrL2qtsb1wQlcnKifMlE835u1lj3Ys1udy3P5H4=;
        b=TnFW2BNDEeJcOBzOGpKhMXlNtfdIpzO44wJPbqOF+xnxTfYk6UgVj/dYLUy+WsFgzG
         TAO53Rm1MJ5CSHDwN+obPHz+QvfGs2a0cMBZxodvaplCATY6CCFiCur/JPZT2H0nivqm
         0HXVy+TppBk949WdMrguqRG2Lw3+OANmUi7Ozo1JUNx5NQRVQ0DrP9JCKdNYgtgtvdMh
         08aUZh+16ZmYSskC/5avAcS4CbFnGx9cQNL62Jiq25LCkvLmUYhNeNIbaDUpB+KKT0eG
         kCwRbOtcRyE0n/dqptYGdNZlRMQYCQ8pKgoTsZSLhn05k21XEglPpqoC6XSfElzuhjmz
         Acbw==
X-Gm-Message-State: APjAAAUbfFr27Gm/sh9CNt0d0xAs8I+ry5gjNexDp9MyH9/vhv9vyp5D
        AlvT4Yg8R57k+8jfyB1kmFc=
X-Google-Smtp-Source: APXvYqw+RiBtacL9aZIC5RAbtHUdu2UF9erfKWA6sEHVLiTrV/brXIweM3I0dA9/b8+ynfOjSkNLVg==
X-Received: by 2002:ac2:4a6e:: with SMTP id q14mr7392786lfp.46.1558537791665;
        Wed, 22 May 2019 08:09:51 -0700 (PDT)
Received: from pc636.semobile.internal ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id t22sm5303615lje.58.2019.05.22.08.09.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 08:09:51 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Roman Gushchin <guro@fb.com>, Uladzislau Rezki <urezki@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/4] mm/vmap: preload a CPU with one object for split purpose
Date:   Wed, 22 May 2019 17:09:37 +0200
Message-Id: <20190522150939.24605-2-urezki@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190522150939.24605-1-urezki@gmail.com>
References: <20190522150939.24605-1-urezki@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce ne_fit_preload()/ne_fit_preload_end() functions
for preloading one extra vmap_area object to ensure that
we have it available when fit type is NE_FIT_TYPE.

The preload is done per CPU and with GFP_KERNEL permissive
allocation masks, which allow to be more stable under low
memory condition and high memory pressure.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 78 insertions(+), 3 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index ea1b65fac599..5302e1b79c7b 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -364,6 +364,13 @@ static LIST_HEAD(free_vmap_area_list);
  */
 static struct rb_root free_vmap_area_root = RB_ROOT;
 
+/*
+ * Preload a CPU with one object for "no edge" split case. The
+ * aim is to get rid of allocations from the atomic context, thus
+ * to use more permissive allocation masks.
+ */
+static DEFINE_PER_CPU(struct vmap_area *, ne_fit_preload_node);
+
 static __always_inline unsigned long
 va_size(struct vmap_area *va)
 {
@@ -950,9 +957,24 @@ adjust_va_to_fit_type(struct vmap_area *va,
 		 *   L V  NVA  V R
 		 * |---|-------|---|
 		 */
-		lva = kmem_cache_alloc(vmap_area_cachep, GFP_NOWAIT);
-		if (unlikely(!lva))
-			return -1;
+		lva = __this_cpu_xchg(ne_fit_preload_node, NULL);
+		if (unlikely(!lva)) {
+			/*
+			 * For percpu allocator we do not do any pre-allocation
+			 * and leave it as it is. The reason is it most likely
+			 * never ends up with NE_FIT_TYPE splitting. In case of
+			 * percpu allocations offsets and sizes are aligned to
+			 * fixed align request, i.e. RE_FIT_TYPE and FL_FIT_TYPE
+			 * are its main fitting cases.
+			 *
+			 * There are few exceptions though, as en example it is
+			 * a first allocation(early boot up) when we have "one"
+			 * big free space that has to be split.
+			 */
+			lva = kmem_cache_alloc(vmap_area_cachep, GFP_NOWAIT);
+			if (!lva)
+				return -1;
+		}
 
 		/*
 		 * Build the remainder.
@@ -1023,6 +1045,50 @@ __alloc_vmap_area(unsigned long size, unsigned long align,
 }
 
 /*
+ * Preload this CPU with one extra vmap_area object to ensure
+ * that we have it available when fit type of free area is
+ * NE_FIT_TYPE.
+ *
+ * The preload is done in non-atomic context thus, it allows us
+ * to use more permissive allocation masks, therefore to be more
+ * stable under low memory condition and high memory pressure.
+ *
+ * If success, it returns zero with preemption disabled. In case
+ * of error, (-ENOMEM) is returned with preemption not disabled.
+ * Note it has to be paired with alloc_vmap_area_preload_end().
+ */
+static void
+ne_fit_preload(int *preloaded)
+{
+	preempt_disable();
+
+	if (!__this_cpu_read(ne_fit_preload_node)) {
+		struct vmap_area *node;
+
+		preempt_enable();
+		node = kmem_cache_alloc(vmap_area_cachep, GFP_KERNEL);
+		if (node == NULL) {
+			*preloaded = 0;
+			return;
+		}
+
+		preempt_disable();
+
+		if (__this_cpu_cmpxchg(ne_fit_preload_node, NULL, node))
+			kmem_cache_free(vmap_area_cachep, node);
+	}
+
+	*preloaded = 1;
+}
+
+static void
+ne_fit_preload_end(int preloaded)
+{
+	if (preloaded)
+		preempt_enable();
+}
+
+/*
  * Allocate a region of KVA of the specified size and alignment, within the
  * vstart and vend.
  */
@@ -1034,6 +1100,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	struct vmap_area *va;
 	unsigned long addr;
 	int purged = 0;
+	int preloaded;
 
 	BUG_ON(!size);
 	BUG_ON(offset_in_page(size));
@@ -1056,6 +1123,12 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	kmemleak_scan_area(&va->rb_node, SIZE_MAX, gfp_mask & GFP_RECLAIM_MASK);
 
 retry:
+	/*
+	 * Even if it fails we do not really care about that.
+	 * Just proceed as it is. "overflow" path will refill
+	 * the cache we allocate from.
+	 */
+	ne_fit_preload(&preloaded);
 	spin_lock(&vmap_area_lock);
 
 	/*
@@ -1063,6 +1136,8 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	 * returned. Therefore trigger the overflow path.
 	 */
 	addr = __alloc_vmap_area(size, align, vstart, vend);
+	ne_fit_preload_end(preloaded);
+
 	if (unlikely(addr == vend))
 		goto overflow;
 
-- 
2.11.0

