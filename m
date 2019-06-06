Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D436C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 12:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58EE1207E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 12:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5b2OqFI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbfFFMEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 08:04:30 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45071 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728405AbfFFME2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 08:04:28 -0400
Received: by mail-lf1-f65.google.com with SMTP id u10so576478lfm.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 05:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hN8heN14KFn36Tgwt34d71f18AP1pByemdqgy1yfTBg=;
        b=T5b2OqFIpl41X+/6NaixgUwQTGpSJfO1m0jBd5QXTE0YkoSPKPXiky7VarPASKQgWX
         o6Upa/hE3INXKbEj1fMvcMdk0GvEY71Fs2nUfIXgQvCAlrbRpXTBIjxzMjjKBppJG1Uu
         bplmyhvq1eHATiv/2OiK16rYHiJGrJ+ijZ9cSvVpAY8tl5tq1zyqrmp7pG5uuVaMKP5e
         oBoErgUxhfssbxAPxS2WIJLx31Rgdg96dAxQGrRJxuEUegLjjzP7yiuOIosfPUBsxVaG
         BhK6pj5UDQxqFPAT9em7cxUrwjVX1QFluP7vEwDj6hAow5a7sKD/toAPMvi7SmFSbsjq
         9HJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hN8heN14KFn36Tgwt34d71f18AP1pByemdqgy1yfTBg=;
        b=R1itNfg8F1Fzw4WllrxACQYUsXS3VFcU4PqIF6q3WenXKqMEKnE7f02Ip8+XqOlXB5
         GmbI6FzchX4G6GclnoEcAVvi1rJeo+69u/xeiooZ2GTOHqxHJMzrB7TYVkm7J05PuGmN
         tp+LB+r4sLQKoH4dL/VXRLilw97DpoyTPtc8m718oOMn+BcLQD5N4CaakA8eS5sxf8rv
         cyuDt8a1LPKVcKXrUUdRynD8ool/qdsdlVliM/50BYHJ6mu5AGuZBDCwGiF9fzsYOmyA
         RPUPmTOy/CgdQduVwd1QB3/Nxtc7BWNVCmPxJmYfoJyhjTdZBQYqD7iiNm+IBsu4hqZJ
         xPwQ==
X-Gm-Message-State: APjAAAXfRbNhtiR7Hj9pckl0Ulh2IBymppbJIfe3ZblQde7j27xPg+rx
        jG6Fb8JhHxM2mYW6n26IKEA=
X-Google-Smtp-Source: APXvYqy1buXzU5yUn0yD/K/JRsaa9SXDIeUnKlReC5c7bTWt/TGtheP4yVLgFB6dWRfIGwDjLzFd+Q==
X-Received: by 2002:ac2:4d1c:: with SMTP id r28mr8928103lfi.159.1559822666084;
        Thu, 06 Jun 2019 05:04:26 -0700 (PDT)
Received: from pc636.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id l18sm309036lja.94.2019.06.06.05.04.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 05:04:25 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v5 2/4] mm/vmalloc.c: preload a CPU with one object for split purpose
Date:   Thu,  6 Jun 2019 14:04:09 +0200
Message-Id: <20190606120411.8298-3-urezki@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190606120411.8298-1-urezki@gmail.com>
References: <20190606120411.8298-1-urezki@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the NE_FIT_TYPE split case when it comes to an allocation of one
extra object. We need it in order to build a remaining space. The preload
is done per CPU in non-atomic context with GFP_KERNEL flags.

More permissive parameters can be beneficial for systems which are suffer
from high memory pressure or low memory condition. For example on my KVM
system(4xCPUs, no swap, 256MB RAM) i can simulate the failure of page
allocation with GFP_NOWAIT flags. Using "stress-ng" tool and starting N
workers spinning on fork() and exit(), i can trigger below trace:

<snip>
[  179.815161] stress-ng-fork: page allocation failure: order:0, mode:0x40800(GFP_NOWAIT|__GFP_COMP), nodemask=(null),cpuset=/,mems_allowed=0
[  179.815168] CPU: 0 PID: 12612 Comm: stress-ng-fork Not tainted 5.2.0-rc3+ #1003
[  179.815170] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[  179.815171] Call Trace:
[  179.815178]  dump_stack+0x5c/0x7b
[  179.815182]  warn_alloc+0x108/0x190
[  179.815187]  __alloc_pages_slowpath+0xdc7/0xdf0
[  179.815191]  __alloc_pages_nodemask+0x2de/0x330
[  179.815194]  cache_grow_begin+0x77/0x420
[  179.815197]  fallback_alloc+0x161/0x200
[  179.815200]  kmem_cache_alloc+0x1c9/0x570
[  179.815202]  alloc_vmap_area+0x32c/0x990
[  179.815206]  __get_vm_area_node+0xb0/0x170
[  179.815208]  __vmalloc_node_range+0x6d/0x230
[  179.815211]  ? _do_fork+0xce/0x3d0
[  179.815213]  copy_process.part.46+0x850/0x1b90
[  179.815215]  ? _do_fork+0xce/0x3d0
[  179.815219]  _do_fork+0xce/0x3d0
[  179.815226]  ? __do_page_fault+0x2bf/0x4e0
[  179.815229]  do_syscall_64+0x55/0x130
[  179.815231]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  179.815234] RIP: 0033:0x7fedec4c738b
...
[  179.815237] RSP: 002b:00007ffda469d730 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
[  179.815239] RAX: ffffffffffffffda RBX: 00007ffda469d730 RCX: 00007fedec4c738b
[  179.815240] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
[  179.815241] RBP: 00007ffda469d780 R08: 00007fededd6e300 R09: 00007ffda47f50a0
[  179.815242] R10: 00007fededd6e5d0 R11: 0000000000000246 R12: 0000000000000000
[  179.815243] R13: 0000000000000020 R14: 0000000000000000 R15: 0000000000000000
[  179.815245] Mem-Info:
[  179.815249] active_anon:12686 inactive_anon:14760 isolated_anon:0
                active_file:502 inactive_file:61 isolated_file:70
                unevictable:2 dirty:0 writeback:0 unstable:0
                slab_reclaimable:2380 slab_unreclaimable:7520
                mapped:15069 shmem:14813 pagetables:10833 bounce:0
                free:1922 free_pcp:229 free_cma:0
<snip>

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 4 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 6e5e3e39c05e..fcda966589a6 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -365,6 +365,13 @@ static LIST_HEAD(free_vmap_area_list);
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
@@ -951,9 +958,24 @@ adjust_va_to_fit_type(struct vmap_area *va,
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
@@ -1032,7 +1054,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 				unsigned long vstart, unsigned long vend,
 				int node, gfp_t gfp_mask)
 {
-	struct vmap_area *va;
+	struct vmap_area *va, *pva;
 	unsigned long addr;
 	int purged = 0;
 
@@ -1057,7 +1079,32 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	kmemleak_scan_area(&va->rb_node, SIZE_MAX, gfp_mask & GFP_RECLAIM_MASK);
 
 retry:
+	/*
+	 * Preload this CPU with one extra vmap_area object to ensure
+	 * that we have it available when fit type of free area is
+	 * NE_FIT_TYPE.
+	 *
+	 * The preload is done in non-atomic context, thus it allows us
+	 * to use more permissive allocation masks to be more stable under
+	 * low memory condition and high memory pressure.
+	 *
+	 * Even if it fails we do not really care about that. Just proceed
+	 * as it is. "overflow" path will refill the cache we allocate from.
+	 */
+	preempt_disable();
+	if (!__this_cpu_read(ne_fit_preload_node)) {
+		preempt_enable();
+		pva = kmem_cache_alloc_node(vmap_area_cachep, GFP_KERNEL, node);
+		preempt_disable();
+
+		if (__this_cpu_cmpxchg(ne_fit_preload_node, NULL, pva)) {
+			if (pva)
+				kmem_cache_free(vmap_area_cachep, pva);
+		}
+	}
+
 	spin_lock(&vmap_area_lock);
+	preempt_enable();
 
 	/*
 	 * If an allocation fails, the "vend" address is
-- 
2.11.0

