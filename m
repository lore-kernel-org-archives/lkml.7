Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED28C74A41
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 00:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37893214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 00:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562805278;
	bh=8R+/m0sE0I5uj5ZSjtj66c6S6/vD4UOWM1T2cgd3nhk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=CQgcHqCKqNvTgiVWacgXlfs0iCE3GL8QyIto1x6OuGIGhvgnDi5KD+AYil3rHYoOb
	 qS8+buw0ujHcqUFD5BAm1KgxFj8u5sVuIUPp98LYxnZyeWfpNbUndSzFQ0BKG6txUX
	 KSdmfa9EyuWaNKq0GUFGTluPMB6X8PPHPzHgpewg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbfGKAeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 20:34:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:50520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726627AbfGKAeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 20:34:36 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D243F20844;
        Thu, 11 Jul 2019 00:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562805275;
        bh=8R+/m0sE0I5uj5ZSjtj66c6S6/vD4UOWM1T2cgd3nhk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=15cLiRKYElxT+OTfUatRgaL5YnB17vt4q9Nqec0GZOdxw4UEbobab4W4xWvBR2yYX
         1hmIcSdceRphT71xQ/R5fo/NE899HS4lSDrA+ZBYFNQLzwHSzde+pcQAEllBL2ueD2
         Ry/3dtCxF+bpGyUPNm1jzqHsRMdo55TeBzy+bvDs=
Date:   Wed, 10 Jul 2019 17:34:34 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yang Shi <shy828301@gmail.com>
Subject: Re: linux-next: build failure after merge of the akpm-current tree
Message-Id: <20190710173434.8081fa5410ccf0ccd72719b9@linux-foundation.org>
In-Reply-To: <20190710070509.GB29695@dhcp22.suse.cz>
References: <20190709211559.6ffd2f4e@canb.auug.org.au>
        <20190709134233.b50814f5a789244b9bdb573e@linux-foundation.org>
        <20190710070509.GB29695@dhcp22.suse.cz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jul 2019 09:05:09 +0200 Michal Hocko <mhocko@kernel.org> wrote:

> >  	return false;
> >  }
> > +static inline void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
> > +					  int nid, int shrinker_id)
> > +{
> > +}
> >  #endif
> 
> Can we get the full series resent please. I have completely lost track
> of all the follow up fixes.

It's just mm-shrinker-make-shrinker-not-depend-on-memcg-kmem.patch that
had all the little buildy fixes.  Below.

But this patchset seems to have a list handling bug
http://lkml.kernel.org/r/1562795006.8510.19.camel@lca.pw.



From: Yang Shi <yang.shi@linux.alibaba.com>
Subject: mm: shrinker: make shrinker not depend on memcg kmem

Currently shrinker is just allocated and can work when memcg kmem is
enabled.  But, THP deferred split shrinker is not slab shrinker, it
doesn't make too much sense to have such shrinker depend on memcg kmem. 
It should be able to reclaim THP even though memcg kmem is disabled.

Introduce a new shrinker flag, SHRINKER_NONSLAB, for non-slab shrinker. 
When memcg kmem is disabled, just such shrinkers can be called in
shrinking memcg slab.

[akpm@linux-foundation.org: fix build]
  Link: http://lkml.kernel.org/r/201907052120.OGYPhvno%lkp@intel.com
[shy828301@gmail.com: fixes]
  Link: http://lkml.kernel.org/r/CAHbLzkr8h0t+2xs6f7htKZFdKDbsD5F4z-AAt+CDa-uVwSkQ1Q@mail.gmail.com
[akpm@linux-foundation.org: coding style fixes]
[akpm@linux-foundation.org: build fix]
Link: http://lkml.kernel.org/r/1561507361-59349-4-git-send-email-yang.shi@linux.alibaba.com
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/shrinker.h |    3 ++-
 mm/vmscan.c              |   36 +++++++++++++++++++-----------------
 2 files changed, 21 insertions(+), 18 deletions(-)

--- a/include/linux/shrinker.h~mm-shrinker-make-shrinker-not-depend-on-memcg-kmem
+++ a/include/linux/shrinker.h
@@ -69,7 +69,7 @@ struct shrinker {
 
 	/* These are for internal use */
 	struct list_head list;
-#ifdef CONFIG_MEMCG_KMEM
+#ifdef CONFIG_MEMCG
 	/* ID in shrinker_idr */
 	int id;
 #endif
@@ -81,6 +81,7 @@ struct shrinker {
 /* Flags */
 #define SHRINKER_NUMA_AWARE	(1 << 0)
 #define SHRINKER_MEMCG_AWARE	(1 << 1)
+#define SHRINKER_NONSLAB	(1 << 2)
 
 extern int prealloc_shrinker(struct shrinker *shrinker);
 extern void register_shrinker_prepared(struct shrinker *shrinker);
--- a/mm/vmscan.c~mm-shrinker-make-shrinker-not-depend-on-memcg-kmem
+++ a/mm/vmscan.c
@@ -174,8 +174,7 @@ unsigned long vm_total_pages;
 static LIST_HEAD(shrinker_list);
 static DECLARE_RWSEM(shrinker_rwsem);
 
-#ifdef CONFIG_MEMCG_KMEM
-
+#ifdef CONFIG_MEMCG
 /*
  * We allow subsystems to populate their shrinker-related
  * LRU lists before register_shrinker_prepared() is called
@@ -227,18 +226,7 @@ static void unregister_memcg_shrinker(st
 	idr_remove(&shrinker_idr, id);
 	up_write(&shrinker_rwsem);
 }
-#else /* CONFIG_MEMCG_KMEM */
-static int prealloc_memcg_shrinker(struct shrinker *shrinker)
-{
-	return 0;
-}
 
-static void unregister_memcg_shrinker(struct shrinker *shrinker)
-{
-}
-#endif /* CONFIG_MEMCG_KMEM */
-
-#ifdef CONFIG_MEMCG
 static bool global_reclaim(struct scan_control *sc)
 {
 	return !sc->target_mem_cgroup;
@@ -293,6 +281,15 @@ static bool memcg_congested(pg_data_t *p
 
 }
 #else
+static int prealloc_memcg_shrinker(struct shrinker *shrinker)
+{
+	return 0;
+}
+
+static void unregister_memcg_shrinker(struct shrinker *shrinker)
+{
+}
+
 static bool global_reclaim(struct scan_control *sc)
 {
 	return true;
@@ -579,7 +576,7 @@ static unsigned long do_shrink_slab(stru
 	return freed;
 }
 
-#ifdef CONFIG_MEMCG_KMEM
+#ifdef CONFIG_MEMCG
 static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 			struct mem_cgroup *memcg, int priority)
 {
@@ -587,7 +584,7 @@ static unsigned long shrink_slab_memcg(g
 	unsigned long ret, freed = 0;
 	int i;
 
-	if (!memcg_kmem_enabled() || !mem_cgroup_online(memcg))
+	if (!mem_cgroup_online(memcg))
 		return 0;
 
 	if (!down_read_trylock(&shrinker_rwsem))
@@ -613,6 +610,11 @@ static unsigned long shrink_slab_memcg(g
 			continue;
 		}
 
+		/* Call non-slab shrinkers even though kmem is disabled */
+		if (!memcg_kmem_enabled() &&
+		    !(shrinker->flags & SHRINKER_NONSLAB))
+			continue;
+
 		ret = do_shrink_slab(&sc, shrinker, priority);
 		if (ret == SHRINK_EMPTY) {
 			clear_bit(i, map->map);
@@ -649,13 +651,13 @@ unlock:
 	up_read(&shrinker_rwsem);
 	return freed;
 }
-#else /* CONFIG_MEMCG_KMEM */
+#else /* CONFIG_MEMCG */
 static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 			struct mem_cgroup *memcg, int priority)
 {
 	return 0;
 }
-#endif /* CONFIG_MEMCG_KMEM */
+#endif /* CONFIG_MEMCG */
 
 /**
  * shrink_slab - shrink slab caches
_

