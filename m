Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD90BC07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 09:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5DFF2175B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 09:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sUmGQPCg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfE0Ji7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 05:38:59 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33708 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfE0Ji4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 05:38:56 -0400
Received: by mail-lf1-f65.google.com with SMTP id y17so3714475lfe.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 02:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MSM6WbF67OdKB/w9seZTGzSuynUfhCF7zBIV2w+Az9Q=;
        b=sUmGQPCg1h4G78WjpktomzL1vsZjD0vSyk4a/TMHRWTP028OvSlppVxZRdtKGtzAdE
         dylJ9B0jJSDE4NcUiWzqLubR3R3IS1TrLXMmlTpGoe8Qo7FKO7MmDhH9Nu7psaV6+gq4
         hI1D22BOnCwUFc9siRF0Jyq/8y/Ujmz9NQtUKgTo/4yT+EiJE2Ai5NQaj385hImHrFMy
         I1BEQGZRmVHol66Bjz+NAC4ueF4Soqnx8L3y+Y8g6CwqNEJYL7ej4SKK6unwW2/17slz
         xuWVzqyjXSDEfPkHdHJLNbCb5A/XaaaOpimcUqBzhavLqVIsDrW8K7bkXeyMjwIAncPp
         85xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MSM6WbF67OdKB/w9seZTGzSuynUfhCF7zBIV2w+Az9Q=;
        b=PlH6MO3cQ5m04RrP5Yn2oecuZV+r/m4A2DQIuK/VWYXEmQm0XjejwM6mtNl5Z6p6lu
         OIGcXMZDhzizLerUlMbzL19fZLvrcr5a6ezhGnXQs7QBB5pnIg/kmncycelBAH1/2V5b
         54dP+CeddZXgJpNrvDi+ar209lqPrYpuVcZgdtp0WFDmR9HG7C5EYOm3zTKd/PO/KHZ/
         B3TW8EYind+VPI1wJQAS9JdPQU+09x0TtmJIxqa2h/kA2wwakb8ofCxO8l8T5A5aBv/l
         WCPSiOYLYIaDgpHdNdMxk0vNeVW3T9+Jp5QET+8ayU/jD9M/zLPZSmi/f76rEnCkoily
         2rfA==
X-Gm-Message-State: APjAAAVx2qVpG6iwKmWQ862I3siCSq3hyEc4WfxLLaVfT8bl2g3YJMaq
        7T0L8UbTOulJngb8+qmpoBI=
X-Google-Smtp-Source: APXvYqzERAbBtlp4Er6Lh4C9w2h4kNRVuBtp0mnWStcvdQ80Dpqy67L/LVB/6darmfplemsj1nipog==
X-Received: by 2002:a19:7716:: with SMTP id s22mr2343486lfc.64.1558949933874;
        Mon, 27 May 2019 02:38:53 -0700 (PDT)
Received: from pc636.semobile.internal ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id z26sm2176293lfg.31.2019.05.27.02.38.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 02:38:53 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Roman Gushchin <guro@fb.com>, Uladzislau Rezki <urezki@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: [PATCH v3 2/4] mm/vmap: preload a CPU with one object for split purpose
Date:   Mon, 27 May 2019 11:38:40 +0200
Message-Id: <20190527093842.10701-3-urezki@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190527093842.10701-1-urezki@gmail.com>
References: <20190527093842.10701-1-urezki@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the NE_FIT_TYPE split case when it comes to an
allocation of one extra object. We need it in order to
build a remaining space.

Introduce ne_fit_preload()/ne_fit_preload_end() functions
for preloading one extra vmap_area object to ensure that
we have it available when fit type is NE_FIT_TYPE.

The preload is done per CPU in non-atomic context thus with
GFP_KERNEL allocation masks. More permissive parameters can
be beneficial for systems which are suffer from high memory
pressure or low memory condition.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 76 insertions(+), 3 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index ea1b65fac599..b553047aa05b 100644
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
+			 * There are a few exceptions though, as an example it is
+			 * a first allocation (early boot up) when we have "one"
+			 * big free space that has to be split.
+			 */
+			lva = kmem_cache_alloc(vmap_area_cachep, GFP_NOWAIT);
+			if (!lva)
+				return -1;
+		}
 
 		/*
 		 * Build the remainder.
@@ -1023,6 +1045,48 @@ __alloc_vmap_area(unsigned long size, unsigned long align,
 }
 
 /*
+ * Preload this CPU with one extra vmap_area object to ensure
+ * that we have it available when fit type of free area is
+ * NE_FIT_TYPE.
+ *
+ * The preload is done in non-atomic context, thus it allows us
+ * to use more permissive allocation masks to be more stable under
+ * low memory condition and high memory pressure.
+ *
+ * If success it returns 1 with preemption disabled. In case
+ * of error 0 is returned with preemption not disabled. Note it
+ * has to be paired with ne_fit_preload_end().
+ */
+static int
+ne_fit_preload(int nid)
+{
+	preempt_disable();
+
+	if (!__this_cpu_read(ne_fit_preload_node)) {
+		struct vmap_area *node;
+
+		preempt_enable();
+		node = kmem_cache_alloc_node(vmap_area_cachep, GFP_KERNEL, nid);
+		if (node == NULL)
+			return 0;
+
+		preempt_disable();
+
+		if (__this_cpu_cmpxchg(ne_fit_preload_node, NULL, node))
+			kmem_cache_free(vmap_area_cachep, node);
+	}
+
+	return 1;
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
@@ -1034,6 +1098,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	struct vmap_area *va;
 	unsigned long addr;
 	int purged = 0;
+	int preloaded;
 
 	BUG_ON(!size);
 	BUG_ON(offset_in_page(size));
@@ -1056,6 +1121,12 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	kmemleak_scan_area(&va->rb_node, SIZE_MAX, gfp_mask & GFP_RECLAIM_MASK);
 
 retry:
+	/*
+	 * Even if it fails we do not really care about that.
+	 * Just proceed as it is. "overflow" path will refill
+	 * the cache we allocate from.
+	 */
+	preloaded = ne_fit_preload(node);
 	spin_lock(&vmap_area_lock);
 
 	/*
@@ -1063,6 +1134,8 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	 * returned. Therefore trigger the overflow path.
 	 */
 	addr = __alloc_vmap_area(size, align, vstart, vend);
+	ne_fit_preload_end(preloaded);
+
 	if (unlikely(addr == vend))
 		goto overflow;
 
-- 
2.11.0

