Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942F7FA372B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64E232168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 09:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QE5ek4pV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404369AbfJPJyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 05:54:51 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36463 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728556AbfJPJyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 05:54:50 -0400
Received: by mail-lj1-f194.google.com with SMTP id v24so23325230ljj.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 02:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bdoCE4EoxSLapTmXd4+oVGs4R70YFCwt9DjIODBWD6I=;
        b=QE5ek4pVPZfLzXJzV28P6nJ+0ySzes/vJ33aguYDmlDCotZp11VGmfub55bpIPwULu
         445YzJByyi9BRAIfThepb5GU9gtU2sJw66rXQq2NXUn/K4dZOUAT1hnRMFbHniqB+JiG
         weY5ynwlgmCL0ItKNN1Ahe0Uxaw+QL7EQRIy+gWWoG2biYMDsmURA9GzkizOBx9Q5MAR
         GlB4hTBjI240TBfNo3FXNft53oV6xc4OyN+9u6a7TZYNCfNM55vYO4oSixwfV6A2LWAu
         ho2FLuaKimvVybjSGJRrV8X58Dg13nlrNVPA5wSaWe7KAy3j8b6QuhgnmpgQs7k4Bdn1
         mP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bdoCE4EoxSLapTmXd4+oVGs4R70YFCwt9DjIODBWD6I=;
        b=DDbEM/kahS1AIWRtHjVVfl/dyPMa+i6lo87HZKP2Nh1wqEkx9bB1kn+JJZ5v72cHG5
         tTgjs8Ci19v/ZYC/a0/ZrvNfwIq7jvnkLbzg7vhy9a63faGyU8PuyhnU9Z3YxoU/kDJX
         HF39BOIurns0UkXVh9hTGhqhsy5Pf8o/m2Bxb2jaAp9+5mMXLDlCac7Wg+KHzLEjrh6K
         KxYoZqc2XPfR4sysTf/237Xa8+ywbtsqbSq6QXPkivXF6B47YW4P6abAR2DPm3ZV7Ix0
         WceTBPz2ZwtGF8N+ch+H9XQncvPuS/bONWCH4O+0yBHwVcdV8Nure91KqFD8rSkDE6EK
         mxOg==
X-Gm-Message-State: APjAAAWLdVYc4VcwcUQeOqB5xqrHNVMkZHSID/cczuDcV4aQEWIeImqu
        dlAO4x9fzMzYZNf75yfSqNM=
X-Google-Smtp-Source: APXvYqxiDS53+QyM7r3Br5Xxnwu0u7VAzS+Uv9ERxHSO38DcMbzVXfh6Mfhp0Z22QaporVWAcWkmBQ==
X-Received: by 2002:a2e:9d83:: with SMTP id c3mr25563346ljj.237.1571219688236;
        Wed, 16 Oct 2019 02:54:48 -0700 (PDT)
Received: from pc636.semobile.internal ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id b2sm886452lfq.27.2019.10.16.02.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 02:54:47 -0700 (PDT)
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
Subject: [PATCH v3 1/3] mm/vmalloc: remove preempt_disable/enable when do preloading
Date:   Wed, 16 Oct 2019 11:54:36 +0200
Message-Id: <20191016095438.12391-1-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some background. The preemption was disabled before to guarantee
that a preloaded object is available for a CPU, it was stored for.

The aim was to not allocate in atomic context when spinlock
is taken later, for regular vmap allocations. But that approach
conflicts with CONFIG_PREEMPT_RT philosophy. It means that
calling spin_lock() with disabled preemption is forbidden
in the CONFIG_PREEMPT_RT kernel.

Therefore, get rid of preempt_disable() and preempt_enable() when
the preload is done for splitting purpose. As a result we do not
guarantee now that a CPU is preloaded, instead we minimize the
case when it is not, with this change.

For example i run the special test case that follows the preload
pattern and path. 20 "unbind" threads run it and each does
1000000 allocations. Only 3.5 times among 1000000 a CPU was
not preloaded. So it can happen but the number is negligible.

V2 - > V3:
    - update the commit message

V1 -> V2:
  - move __this_cpu_cmpxchg check when spin_lock is taken,
    as proposed by Andrew Morton
  - add more explanation in regard of preloading
  - adjust and move some comments

Fixes: 82dd23e84be3 ("mm/vmalloc.c: preload a CPU with one object for split purpose")
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index e92ff5f7dd8b..b7b443bfdd92 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1078,31 +1078,34 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 
 retry:
 	/*
-	 * Preload this CPU with one extra vmap_area object to ensure
-	 * that we have it available when fit type of free area is
-	 * NE_FIT_TYPE.
+	 * Preload this CPU with one extra vmap_area object. It is used
+	 * when fit type of free area is NE_FIT_TYPE. Please note, it
+	 * does not guarantee that an allocation occurs on a CPU that
+	 * is preloaded, instead we minimize the case when it is not.
+	 * It can happen because of cpu migration, because there is a
+	 * race until the below spinlock is taken.
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

