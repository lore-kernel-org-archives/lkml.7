Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2E9C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46D3F206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="YkN6uuUR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732377AbfDQOCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:02:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59413 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731960AbfDQOCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:02:38 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3HE1jts3930777
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Apr 2019 07:01:46 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3HE1jts3930777
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041743; t=1555509707;
        bh=tBTT5DJkWl43S2hPiDWbIhsBneWv51Jto2D4cHXtH9s=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=YkN6uuURq2lcXTvYY6umMtK1EjmTQHrZMdG8p/gmBKRXXReqTWRGRHmyvEYh5+DZs
         UVKoPlPVjRfykkJyFf4p1N4r4+x1dyUM66xrLpYlG0sOBtnohuS2fvtR6D0rJ1JG/k
         jDWj2nu2ZPWO+5NmXKzHtnb7P7jwOC25DmyvzRVWlfaov5SQ2C2vrdmbmOLBz8c5bu
         xTbhd6tswjOTDFEvC8TprC7q3it82kL7UhRH/OGIvTimRbKyNaLrra78qU6B/AwPf5
         uroGrFIu+kW2JSVid6rRDS3gM/E2EGVWhuIfiPcPImO7pzsBQAs96TwqLtePkXhYmy
         6Zro0QZeLkbPw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3HE1iNY3930774;
        Wed, 17 Apr 2019 07:01:44 -0700
Date:   Wed, 17 Apr 2019 07:01:44 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Qian Cai <tipbot@zytor.com>
Message-ID: <tip-80552f0f7aebdd8deda8ea455292cbfbf462d655@git.kernel.org>
Cc:     cai@lca.pw, luto@amacapital.net, mingo@kernel.org,
        linux-kernel@vger.kernel.org, bp@suse.de, vbabka@suse.cz,
        akpm@linux-foundation.org, rientjes@google.com, tglx@linutronix.de,
        linux-mm@kvack.org, hpa@zytor.com, iamjoonsoo.kim@lge.com,
        jpoimboe@redhat.com, cl@linux.com, penberg@kernel.org
Reply-To: iamjoonsoo.kim@lge.com, hpa@zytor.com, tglx@linutronix.de,
          linux-mm@kvack.org, penberg@kernel.org, cl@linux.com,
          jpoimboe@redhat.com, vbabka@suse.cz, luto@amacapital.net,
          mingo@kernel.org, linux-kernel@vger.kernel.org, bp@suse.de,
          cai@lca.pw, rientjes@google.com, akpm@linux-foundation.org
In-Reply-To: <20190416142258.18694-1-cai@lca.pw>
References: <20190416142258.18694-1-cai@lca.pw>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/irq] mm/slab: Remove store_stackinfo()
Git-Commit-ID: 80552f0f7aebdd8deda8ea455292cbfbf462d655
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  80552f0f7aebdd8deda8ea455292cbfbf462d655
Gitweb:     https://git.kernel.org/tip/80552f0f7aebdd8deda8ea455292cbfbf462d655
Author:     Qian Cai <cai@lca.pw>
AuthorDate: Tue, 16 Apr 2019 10:22:57 -0400
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Wed, 17 Apr 2019 11:46:27 +0200

mm/slab: Remove store_stackinfo()

store_stackinfo() does not seem used in actual SLAB debugging.
Potentially, it could be added to check_poison_obj() to provide more
information but this seems like an overkill due to the declining
popularity of SLAB, so just remove it instead.

Signed-off-by: Qian Cai <cai@lca.pw>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Christoph Lameter <cl@linux.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: linux-mm <linux-mm@kvack.org>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: rientjes@google.com
Cc: sean.j.christopherson@intel.com
Link: https://lkml.kernel.org/r/20190416142258.18694-1-cai@lca.pw
---
 mm/slab.c | 48 ++++++------------------------------------------
 1 file changed, 6 insertions(+), 42 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index 47a380a486ee..e79ef28396e2 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1467,53 +1467,17 @@ static bool is_debug_pagealloc_cache(struct kmem_cache *cachep)
 }
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
-static void store_stackinfo(struct kmem_cache *cachep, unsigned long *addr,
-			    unsigned long caller)
-{
-	int size = cachep->object_size;
-
-	addr = (unsigned long *)&((char *)addr)[obj_offset(cachep)];
-
-	if (size < 5 * sizeof(unsigned long))
-		return;
-
-	*addr++ = 0x12345678;
-	*addr++ = caller;
-	*addr++ = smp_processor_id();
-	size -= 3 * sizeof(unsigned long);
-	{
-		unsigned long *sptr = &caller;
-		unsigned long svalue;
-
-		while (!kstack_end(sptr)) {
-			svalue = *sptr++;
-			if (kernel_text_address(svalue)) {
-				*addr++ = svalue;
-				size -= sizeof(unsigned long);
-				if (size <= sizeof(unsigned long))
-					break;
-			}
-		}
-
-	}
-	*addr++ = 0x87654321;
-}
-
-static void slab_kernel_map(struct kmem_cache *cachep, void *objp,
-				int map, unsigned long caller)
+static void slab_kernel_map(struct kmem_cache *cachep, void *objp, int map)
 {
 	if (!is_debug_pagealloc_cache(cachep))
 		return;
 
-	if (caller)
-		store_stackinfo(cachep, objp, caller);
-
 	kernel_map_pages(virt_to_page(objp), cachep->size / PAGE_SIZE, map);
 }
 
 #else
 static inline void slab_kernel_map(struct kmem_cache *cachep, void *objp,
-				int map, unsigned long caller) {}
+				int map) {}
 
 #endif
 
@@ -1661,7 +1625,7 @@ static void slab_destroy_debugcheck(struct kmem_cache *cachep,
 
 		if (cachep->flags & SLAB_POISON) {
 			check_poison_obj(cachep, objp);
-			slab_kernel_map(cachep, objp, 1, 0);
+			slab_kernel_map(cachep, objp, 1);
 		}
 		if (cachep->flags & SLAB_RED_ZONE) {
 			if (*dbg_redzone1(cachep, objp) != RED_INACTIVE)
@@ -2434,7 +2398,7 @@ static void cache_init_objs_debug(struct kmem_cache *cachep, struct page *page)
 		/* need to poison the objs? */
 		if (cachep->flags & SLAB_POISON) {
 			poison_obj(cachep, objp, POISON_FREE);
-			slab_kernel_map(cachep, objp, 0, 0);
+			slab_kernel_map(cachep, objp, 0);
 		}
 	}
 #endif
@@ -2813,7 +2777,7 @@ static void *cache_free_debugcheck(struct kmem_cache *cachep, void *objp,
 
 	if (cachep->flags & SLAB_POISON) {
 		poison_obj(cachep, objp, POISON_FREE);
-		slab_kernel_map(cachep, objp, 0, caller);
+		slab_kernel_map(cachep, objp, 0);
 	}
 	return objp;
 }
@@ -3077,7 +3041,7 @@ static void *cache_alloc_debugcheck_after(struct kmem_cache *cachep,
 		return objp;
 	if (cachep->flags & SLAB_POISON) {
 		check_poison_obj(cachep, objp);
-		slab_kernel_map(cachep, objp, 1, 0);
+		slab_kernel_map(cachep, objp, 1);
 		poison_obj(cachep, objp, POISON_INUSE);
 	}
 	if (cachep->flags & SLAB_STORE_USER)
