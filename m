Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D798C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E5B206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbfC0RaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 13:30:03 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58366 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726803AbfC0RaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 13:30:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 543CD80D;
        Wed, 27 Mar 2019 10:30:02 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63F773F557;
        Wed, 27 Mar 2019 10:30:00 -0700 (PDT)
Date:   Wed, 27 Mar 2019 17:29:57 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org, cl@linux.com,
        willy@infradead.org, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] kmemleak: survive in a low-memory situation
Message-ID: <20190327172955.GB17247@arrakis.emea.arm.com>
References: <20190327005948.24263-1-cai@lca.pw>
 <20190327084432.GA11927@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327084432.GA11927@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 09:44:32AM +0100, Michal Hocko wrote:
> On Tue 26-03-19 20:59:48, Qian Cai wrote:
> [...]
> > Unless there is a brave soul to reimplement the kmemleak to embed it's
> > metadata into the tracked memory itself in a foreseeable future,

Revisiting the kmemleak memory scanning code, that's not actually
possible without some long periods with kmemleak_lock held. The scanner
relies on the kmemleak_object (refcounted) being around even when the
actual memory block has been freed.

> > this
> > provides a good balance between enabling kmemleak in a low-memory
> > situation and not introducing too much hackiness into the existing
> > code for now. Another approach is to fail back the original allocation
> > once kmemleak_alloc() failed, but there are too many call sites to
> > deal with which makes it error-prone.
> 
> As long as there is an implicit __GFP_NOFAIL then kmemleak is simply
> broken no matter what other gfp flags you play with. Has anybody looked
> at some sort of preallocation where gfpflags_allow_blocking context
> allocate objects into a pool that non-sleeping allocations can eat from?

Quick attempt below and it needs some more testing (pretty random pick
of the EMERGENCY_POOL_SIZE value). Also, with __GFP_NOFAIL removed, are
the other flags safe or we should trim them further?

---------------8<-------------------------------
From dc4194539f8191bb754901cea74c86e7960886f8 Mon Sep 17 00:00:00 2001
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Wed, 27 Mar 2019 17:20:57 +0000
Subject: [PATCH] mm: kmemleak: Add an emergency allocation pool for kmemleak
 objects

This patch adds an emergency pool for struct kmemleak_object in case the
normal kmem_cache_alloc() fails under the gfp constraints passed by the
slab allocation caller. The patch also removes __GFP_NOFAIL which does
not play well with other gfp flags (introduced by commit d9570ee3bd1d,
"kmemleak: allow to coexist with fault injection").

Suggested-by: Michal Hocko <mhocko@kernel.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 mm/kmemleak.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 57 insertions(+), 2 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 6c318f5ac234..366a680cff7c 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -127,7 +127,7 @@
 /* GFP bitmask for kmemleak internal allocations */
 #define gfp_kmemleak_mask(gfp)	(((gfp) & (GFP_KERNEL | GFP_ATOMIC)) | \
 				 __GFP_NORETRY | __GFP_NOMEMALLOC | \
-				 __GFP_NOWARN | __GFP_NOFAIL)
+				 __GFP_NOWARN)
 
 /* scanning area inside a memory block */
 struct kmemleak_scan_area {
@@ -191,11 +191,16 @@ struct kmemleak_object {
 #define HEX_ASCII		1
 /* max number of lines to be printed */
 #define HEX_MAX_LINES		2
+/* minimum emergency pool size */
+#define EMERGENCY_POOL_SIZE	(NR_CPUS * 4)
 
 /* the list of all allocated objects */
 static LIST_HEAD(object_list);
 /* the list of gray-colored objects (see color_gray comment below) */
 static LIST_HEAD(gray_list);
+/* emergency pool allocation */
+static LIST_HEAD(emergency_list);
+static int emergency_pool_size;
 /* search tree for object boundaries */
 static struct rb_root object_tree_root = RB_ROOT;
 /* rw_lock protecting the access to object_list and object_tree_root */
@@ -467,6 +472,43 @@ static int get_object(struct kmemleak_object *object)
 	return atomic_inc_not_zero(&object->use_count);
 }
 
+/*
+ * Emergency pool allocation and freeing. kmemleak_lock must not be held.
+ */
+static struct kmemleak_object *emergency_alloc(void)
+{
+	unsigned long flags;
+	struct kmemleak_object *object;
+
+	write_lock_irqsave(&kmemleak_lock, flags);
+	object = list_first_entry_or_null(&emergency_list, typeof(*object), object_list);
+	if (object) {
+		list_del(&object->object_list);
+		emergency_pool_size--;
+	}
+	write_unlock_irqrestore(&kmemleak_lock, flags);
+
+	return object;
+}
+
+/*
+ * Return true if object added to the emergency pool, false otherwise.
+ */
+static bool emergency_free(struct kmemleak_object *object)
+{
+	unsigned long flags;
+
+	if (emergency_pool_size >= EMERGENCY_POOL_SIZE)
+		return false;
+
+	write_lock_irqsave(&kmemleak_lock, flags);
+	list_add(&object->object_list, &emergency_list);
+	emergency_pool_size++;
+	write_unlock_irqrestore(&kmemleak_lock, flags);
+
+	return true;
+}
+
 /*
  * RCU callback to free a kmemleak_object.
  */
@@ -485,7 +527,8 @@ static void free_object_rcu(struct rcu_head *rcu)
 		hlist_del(&area->node);
 		kmem_cache_free(scan_area_cache, area);
 	}
-	kmem_cache_free(object_cache, object);
+	if (!emergency_free(object))
+		kmem_cache_free(object_cache, object);
 }
 
 /*
@@ -577,6 +620,8 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
 	unsigned long untagged_ptr;
 
 	object = kmem_cache_alloc(object_cache, gfp_kmemleak_mask(gfp));
+	if (!object)
+		object = emergency_alloc();
 	if (!object) {
 		pr_warn("Cannot allocate a kmemleak_object structure\n");
 		kmemleak_disable();
@@ -2127,6 +2172,16 @@ void __init kmemleak_init(void)
 			kmemleak_warning = 0;
 		}
 	}
+
+	/* populate the emergency allocation pool */
+	while (emergency_pool_size < EMERGENCY_POOL_SIZE) {
+		struct kmemleak_object *object;
+
+		object = kmem_cache_alloc(object_cache, GFP_KERNEL);
+		if (!object)
+			break;
+		emergency_free(object);
+	}
 }
 
 /*
