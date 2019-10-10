Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3308ECE58D
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 22:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81815214E0
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 22:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vJeXf3az"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfJJWdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 18:33:31 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44350 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfJJWda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 18:33:30 -0400
Received: by mail-lj1-f196.google.com with SMTP id m13so7800263ljj.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 15:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TAvn4d+6F76ruJCv+xI5LO/P/Y+59nUm5AGlvaTi8Qw=;
        b=vJeXf3azUyrJDmPHgSurrI5ADTbYih+86/WFbg8dxAp7IHN3cdZWYjBLR60qwZ5WDv
         +7zEknqFxZF8ZKQBs5ulbxKt9GQz6IiGJO4107AQWREr75bdRb2+pqZd/WouJkMySosy
         bKzS9qmyQq++va8SBxc+B05JbhbbfSnBoXlPzP2MUzc6PpJRFps+LbQwi54hbrdNemyi
         yv6YVRDj33bT3RROfu4d77Ug71GRpwU1E83SVN+5W9BgV9wJpPu15TrVAkYRIRQ8QLdk
         NH9pWVNjc6mgh14iNXiBtnqiZzq6toTZsDPEw08v3Wr48zoh3VWbDh8ejlHbntKinseP
         4aQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TAvn4d+6F76ruJCv+xI5LO/P/Y+59nUm5AGlvaTi8Qw=;
        b=m2fw6CpZFVx5/iqHEiCV2ltgCFRXIal7axJfxltqIr4JzFV5rooQNDojgYBLD8mVRA
         PvLf35E3RE4DD7ZuDO2N75/Q5TcVhuQl/3BjzR2h7mgL6ru1lE+4h007PTmr9lY1esmJ
         0ECoU9GP8iiRHrne1pGlR/1ye9R93xZ5neNVHzAryHesP7hfYM3ektdGDQhcp7xd8v3u
         Lo+dZTusBUAHZNnD1kN/L1QfpZSoUkAfL2mKXUK8mHfBWtqLSEdZaiZjCNQSHTpyVMWN
         hkevyZU0IGO4VRR1U5pYXh72LFS6dcVAmBmjiCch9kEfzrBj6+gbch0NGsM378OtQgNE
         QFSg==
X-Gm-Message-State: APjAAAXj2ow1QJCa5Ykisq2mx0LRIPco7h1dq8JTIkDSBzSzIVeAExuc
        UNKVWFO3osA0ybafeFmIXAg=
X-Google-Smtp-Source: APXvYqwLfOoXtt3G/Kcf9WrLtPl4oTNYwUgcoETwkfA3rEAYZyw4U95S9dGoHtCwrxFX6ktf3C6YvQ==
X-Received: by 2002:a2e:9d56:: with SMTP id y22mr7786051ljj.37.1570746807968;
        Thu, 10 Oct 2019 15:33:27 -0700 (PDT)
Received: from pc636.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id h2sm1530033ljm.26.2019.10.10.15.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 15:33:26 -0700 (PDT)
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
Subject: [PATCH v2 1/1] mm/vmalloc: remove preempt_disable/enable when do preloading
Date:   Fri, 11 Oct 2019 00:33:18 +0200
Message-Id: <20191010223318.28115-1-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of preempt_disable() and preempt_enable() when the
preload is done for splitting purpose. The reason is that
calling spin_lock() with disabled preemtion is forbidden in
CONFIG_PREEMPT_RT kernel.

Therefore, we do not guarantee that a CPU is preloaded, instead
we minimize the case when it is not with this change.

For example i run the special test case that follows the preload
pattern and path. 20 "unbind" threads run it and each does
1000000 allocations. Only 3.5 times among 1000000 a CPU was
not preloaded. So it can happen but the number is negligible.

V1 -> V2:
  - move __this_cpu_cmpxchg check when spin_lock is taken,
    as proposed by Andrew Morton
  - add more explanation in regard of preloading
  - adjust and move some comments

Fixes: 82dd23e84be3 ("mm/vmalloc.c: preload a CPU with one object for split purpose")
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 50 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 17 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index e92ff5f7dd8b..f48cd0711478 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -969,6 +969,19 @@ adjust_va_to_fit_type(struct vmap_area *va,
 			 * There are a few exceptions though, as an example it is
 			 * a first allocation (early boot up) when we have "one"
 			 * big free space that has to be split.
+			 *
+			 * Also we can hit this path in case of regular "vmap"
+			 * allocations, if "this" current CPU was not preloaded.
+			 * See the comment in alloc_vmap_area() why. If so, then
+			 * GFP_NOWAIT is used instead to get an extra object for
+			 * split purpose. That is rare and most time does not
+			 * occur.
+			 *
+			 * What happens if an allocation gets failed. Basically,
+			 * an "overflow" path is triggered to purge lazily freed
+			 * areas to free some memory, then, the "retry" path is
+			 * triggered to repeat one more time. See more details
+			 * in alloc_vmap_area() function.
 			 */
 			lva = kmem_cache_alloc(vmap_area_cachep, GFP_NOWAIT);
 			if (!lva)
@@ -1078,31 +1091,34 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 
 retry:
 	/*
-	 * Preload this CPU with one extra vmap_area object to ensure
-	 * that we have it available when fit type of free area is
-	 * NE_FIT_TYPE.
+	 * Preload this CPU with one extra vmap_area object. It is used
+	 * when fit type of free area is NE_FIT_TYPE. Please note, it
+	 * does not guarantee that an allocation occurs on a CPU that
+	 * is preloaded, instead we minimize the case when it is not.
+	 * It can happen because of migration, because there is a race
+	 * until the below spinlock is taken.
 	 *
 	 * The preload is done in non-atomic context, thus it allows us
 	 * to use more permissive allocation masks to be more stable under
-	 * low memory condition and high memory pressure.
+	 * low memory condition and high memory pressure. In rare case,
+	 * if not preloaded, GFP_NOWAIT is used.
 	 *
-	 * Even if it fails we do not really care about that. Just proceed
-	 * as it is. "overflow" path will refill the cache we allocate from.
+	 * Set "pva" to NULL here, because of "retry" path.
 	 */
-	preempt_disable();
-	if (!__this_cpu_read(ne_fit_preload_node)) {
-		preempt_enable();
-		pva = kmem_cache_alloc_node(vmap_area_cachep, GFP_KERNEL, node);
-		preempt_disable();
+	pva = NULL;
 
-		if (__this_cpu_cmpxchg(ne_fit_preload_node, NULL, pva)) {
-			if (pva)
-				kmem_cache_free(vmap_area_cachep, pva);
-		}
-	}
+	if (!this_cpu_read(ne_fit_preload_node))
+		/*
+		 * Even if it fails we do not really care about that.
+		 * Just proceed as it is. If needed "overflow" path
+		 * will refill the cache we allocate from.
+		 */
+		pva = kmem_cache_alloc_node(vmap_area_cachep, GFP_KERNEL, node);
 
 	spin_lock(&vmap_area_lock);
-	preempt_enable();
+
+	if (pva && __this_cpu_cmpxchg(ne_fit_preload_node, NULL, pva))
+		kmem_cache_free(vmap_area_cachep, pva);
 
 	/*
 	 * If an allocation fails, the "vend" address is
-- 
2.20.1

