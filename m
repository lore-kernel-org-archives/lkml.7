Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172D0C10F05
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA9722177E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368090;
	bh=hBhZ51sbggdBWJp56LPsFdr/hEaLS9xoQjAltdQKNl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ux1GZykYxtn2e3NX9+c8fCR0tZ/1xclRyQE+WneBs68mi7tSe90Ve36D9V3do/ezc
	 b0+sreE/lcIp3fcNllFdAvOBWU3KFEwYxdqZSWzxbWNaRxXL2zjneDbjrF1RoKnXD/
	 u0RTnBvOKNCVwZlybTQHUMbXAjWU9Jbu0GZuYsMA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbfDDIyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:54:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:57478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729580AbfDDIyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:54:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACEBB20652;
        Thu,  4 Apr 2019 08:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368085;
        bh=hBhZ51sbggdBWJp56LPsFdr/hEaLS9xoQjAltdQKNl4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S9t89ZRbh9OtJLUcMWYqDA/K82reULk5Mx3lWtnWL9ElNuKInFav6FzjKApKm4kGw
         lJVzOiZjcxwdUMyopd2ClzNy5rBHu/PLGTAZfJGk1Ea+q14p46vVFbX8ahmjhSBavo
         qfou0BV0thBGQX8kqsOtrj3agcp10RnNshoqhGDo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qian Cai <cai@lca.pw>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 024/121] mm/slab.c: kmemleak no scan alien caches
Date:   Thu,  4 Apr 2019 10:46:52 +0200
Message-Id: <20190404084546.675824088@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084545.245659903@linuxfoundation.org>
References: <20190404084545.245659903@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 92d1d07daad65c300c7d0b68bbef8867e9895d54 ]

Kmemleak throws endless warnings during boot due to in
__alloc_alien_cache(),

    alc = kmalloc_node(memsize, gfp, node);
    init_arraycache(&alc->ac, entries, batch);
    kmemleak_no_scan(ac);

Kmemleak does not track the array cache (alc->ac) but the alien cache
(alc) instead, so let it track the latter by lifting kmemleak_no_scan()
out of init_arraycache().

There is another place that calls init_arraycache(), but
alloc_kmem_cache_cpus() uses the percpu allocation where will never be
considered as a leak.

  kmemleak: Found object by alias at 0xffff8007b9aa7e38
  CPU: 190 PID: 1 Comm: swapper/0 Not tainted 5.0.0-rc2+ #2
  Call trace:
   dump_backtrace+0x0/0x168
   show_stack+0x24/0x30
   dump_stack+0x88/0xb0
   lookup_object+0x84/0xac
   find_and_get_object+0x84/0xe4
   kmemleak_no_scan+0x74/0xf4
   setup_kmem_cache_node+0x2b4/0x35c
   __do_tune_cpucache+0x250/0x2d4
   do_tune_cpucache+0x4c/0xe4
   enable_cpucache+0xc8/0x110
   setup_cpu_cache+0x40/0x1b8
   __kmem_cache_create+0x240/0x358
   create_cache+0xc0/0x198
   kmem_cache_create_usercopy+0x158/0x20c
   kmem_cache_create+0x50/0x64
   fsnotify_init+0x58/0x6c
   do_one_initcall+0x194/0x388
   kernel_init_freeable+0x668/0x688
   kernel_init+0x18/0x124
   ret_from_fork+0x10/0x18
  kmemleak: Object 0xffff8007b9aa7e00 (size 256):
  kmemleak:   comm "swapper/0", pid 1, jiffies 4294697137
  kmemleak:   min_count = 1
  kmemleak:   count = 0
  kmemleak:   flags = 0x1
  kmemleak:   checksum = 0
  kmemleak:   backtrace:
       kmemleak_alloc+0x84/0xb8
       kmem_cache_alloc_node_trace+0x31c/0x3a0
       __kmalloc_node+0x58/0x78
       setup_kmem_cache_node+0x26c/0x35c
       __do_tune_cpucache+0x250/0x2d4
       do_tune_cpucache+0x4c/0xe4
       enable_cpucache+0xc8/0x110
       setup_cpu_cache+0x40/0x1b8
       __kmem_cache_create+0x240/0x358
       create_cache+0xc0/0x198
       kmem_cache_create_usercopy+0x158/0x20c
       kmem_cache_create+0x50/0x64
       fsnotify_init+0x58/0x6c
       do_one_initcall+0x194/0x388
       kernel_init_freeable+0x668/0x688
       kernel_init+0x18/0x124
  kmemleak: Not scanning unknown object at 0xffff8007b9aa7e38
  CPU: 190 PID: 1 Comm: swapper/0 Not tainted 5.0.0-rc2+ #2
  Call trace:
   dump_backtrace+0x0/0x168
   show_stack+0x24/0x30
   dump_stack+0x88/0xb0
   kmemleak_no_scan+0x90/0xf4
   setup_kmem_cache_node+0x2b4/0x35c
   __do_tune_cpucache+0x250/0x2d4
   do_tune_cpucache+0x4c/0xe4
   enable_cpucache+0xc8/0x110
   setup_cpu_cache+0x40/0x1b8
   __kmem_cache_create+0x240/0x358
   create_cache+0xc0/0x198
   kmem_cache_create_usercopy+0x158/0x20c
   kmem_cache_create+0x50/0x64
   fsnotify_init+0x58/0x6c
   do_one_initcall+0x194/0x388
   kernel_init_freeable+0x668/0x688
   kernel_init+0x18/0x124
   ret_from_fork+0x10/0x18

Link: http://lkml.kernel.org/r/20190129184518.39808-1-cai@lca.pw
Fixes: 1fe00d50a9e8 ("slab: factor out initialization of array cache")
Signed-off-by: Qian Cai <cai@lca.pw>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/slab.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index 09df506ae830..f4658468b23e 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -563,14 +563,6 @@ static void start_cpu_timer(int cpu)
 
 static void init_arraycache(struct array_cache *ac, int limit, int batch)
 {
-	/*
-	 * The array_cache structures contain pointers to free object.
-	 * However, when such objects are allocated or transferred to another
-	 * cache the pointers are not cleared and they could be counted as
-	 * valid references during a kmemleak scan. Therefore, kmemleak must
-	 * not scan such objects.
-	 */
-	kmemleak_no_scan(ac);
 	if (ac) {
 		ac->avail = 0;
 		ac->limit = limit;
@@ -586,6 +578,14 @@ static struct array_cache *alloc_arraycache(int node, int entries,
 	struct array_cache *ac = NULL;
 
 	ac = kmalloc_node(memsize, gfp, node);
+	/*
+	 * The array_cache structures contain pointers to free object.
+	 * However, when such objects are allocated or transferred to another
+	 * cache the pointers are not cleared and they could be counted as
+	 * valid references during a kmemleak scan. Therefore, kmemleak must
+	 * not scan such objects.
+	 */
+	kmemleak_no_scan(ac);
 	init_arraycache(ac, entries, batchcount);
 	return ac;
 }
@@ -680,6 +680,7 @@ static struct alien_cache *__alloc_alien_cache(int node, int entries,
 
 	alc = kmalloc_node(memsize, gfp, node);
 	if (alc) {
+		kmemleak_no_scan(alc);
 		init_arraycache(&alc->ac, entries, batch);
 		spin_lock_init(&alc->lock);
 	}
-- 
2.19.1



