Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFED1C606AC
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 12:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9FA42086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 12:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730879AbfGHMmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 08:42:21 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:46413 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbfGHMmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 08:42:21 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mduym-1iKMCm2862-00az91; Mon, 08 Jul 2019 14:41:26 +0200
From:   Arnd Bergmann <arnd@arndb.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Roman Gushchin <guro@fb.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] vmscan: fix memcg_kmem build failure
Date:   Mon,  8 Jul 2019 14:41:03 +0200
Message-Id: <20190708124120.3400683-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8VkSE5EXRvXhg4WTtl1yfmQwLxnuqIVBWC3O64OvYEpHsptKShz
 liGdVTsfLuFY0hhVyQVWbff5R3bnb6E1HJhu20u8pAvj9sk57oG0RsiWEA+A1bIP/Uugd9q
 2kMCOc7ttYjFkbS/CznPsTeFSIM1mWM86j4G6IquKv0/qHs1LJEQyDFHh4E7ePwwl6mD2aj
 jfri59CV9WSdBmPT0jJfA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BR6pqYPidxU=:IRaEjSZOktumWrt9EMStya
 IX38wDJ+IcfvW5pYQ44mrAN4pOG+fQBfdEpJjdSIiZkiiXgMWlz9OIiqV5DdcIp1mHsdwhTA9
 rtdTNxE957ciTEuUFcKJ3CMh6m/HMNfwb9KVY+QAVUGrwqr3ACpvagXxvl8xUcs3nevzRuERn
 rW0cF4laMbGlGWPzYD/E+eKlXk/TJDTKR8xGf4VfXa6DO4goKEHDJ1sKXj+o0I+QPV9ZbBJoH
 i96a7Zpg6KHtjYR7CkgUCmcwVzdkpAidWvro3JmDTPB/Xpm8XSLkJRoRUTO+qOld4Gt1YN0KO
 TPv5QgcYo34HcdMQppjFYyVe35Tn4bslNyZlESRD4UHV6zcUhDfgAIWd4Yc58B4hBFi7NNefD
 bw3ai4opAWaOE+iE2O5tMhwrPgKUpcy+xnCLPA4f4mTZf8VUaix5mzL4Rf0qotuQAbjPIosJ8
 zHTUCS0DxAJ4YTGxlKa9IWbst0+jW6ydHXPf+rZhQhlkLfSx3oHdSNaAaYGLwZG0998vvn7EP
 zrba2rn2a2fSR0fyAD5KSxXfoVqQfL413Q9mnGnKlTIWGrU6R/L7KPzHiSi761jL2euFRRVES
 effFfk1ECatHuTe8ZS7Ub5HMvBajqf0re1k1O9S3vlL+AbwNzwhAyXbCHpJ4gl04+uOvzzLhJ
 QWf7Y6snVpnfNAu3wMawsKQjVoz3bb4dDGiCEMKdpV+eZRnJnSmHlCIGpER7rTpkmEAPExn5c
 tdmnEbVumZyGVWj5RoAWRbXyX4mivgOuqISEGg==
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_MEMCG_KMEM is disabled, we get a build failure
for calling a nonexisting memcg_expand_shrinker_maps():

mm/vmscan.c:220:7: error: implicit declaration of function 'memcg_expand_shrinker_maps' [-Werror,-Wimplicit-function-declaration]
                if (memcg_expand_shrinker_maps(id)) {
                    ^
mm/vmscan.c:220:7: error: this function declaration is not a prototype [-Werror,-Wstrict-prototypes]
mm/vmscan.c:608:56: error: no member named 'shrinker_map' in 'struct mem_cgroup_per_node'
        map = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_map,
                                        ~~~~~~~~~~~~~~~~~~~~  ^
include/linux/rcupdate.h:498:31: note: expanded from macro 'rcu_dereference_protected'
        __rcu_dereference_protected((p), (c), __rcu)
                                     ^
include/linux/rcupdate.h:321:12: note: expanded from macro '__rcu_dereference_protected'
        ((typeof(*p) __force __kernel *)(p)); \
                  ^
mm/vmscan.c:608:6: error: assigning to 'struct memcg_shrinker_map *' from incompatible type 'void'
        map = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_map,

and another issue trying to access invalid struct fields:

mm/vmscan.c:608:56: error: no member named 'shrinker_map' in 'struct mem_cgroup_per_node'
        map = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_map,
                                        ~~~~~~~~~~~~~~~~~~~~  ^
include/linux/rcupdate.h:498:31: note: expanded from macro 'rcu_dereference_protected'
        __rcu_dereference_protected((p), (c), __rcu)
                                     ^
include/linux/rcupdate.h:321:12: note: expanded from macro '__rcu_dereference_protected'
        ((typeof(*p) __force __kernel *)(p)); \
                  ^
mm/vmscan.c:608:6: error: assigning to 'struct memcg_shrinker_map *' from incompatible type 'void'
        map = rcu_dereference_protected(memcg->nodeinfo[nid]->shrinker_map,

Add a dummy definition for memcg_expand_shrinker_maps() that always fails,
and hide the obviously nonworking shrink_slab_memcg() function.

Fixes: 8236f517d69e ("mm: shrinker: make shrinker not depend on memcg kmem")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
No idea what the intended behavior is supposed to be for this case.
Rather than failing, should we actually provide that function?
Or maybe a more elaborate change is needed?
---
 include/linux/memcontrol.h | 5 +++++
 mm/vmscan.c                | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 5901a90f58eb..6b15e2066fc7 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1407,6 +1407,11 @@ static inline void memcg_put_cache_ids(void)
 {
 }
 
+static inline int memcg_expand_shrinker_maps(int new_id)
+{
+	return -ENOMEM;
+}
+
 static inline void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
 					  int nid, int shrinker_id) { }
 #endif /* CONFIG_MEMCG_KMEM */
diff --git a/mm/vmscan.c b/mm/vmscan.c
index a0301edd8d03..323a9c50c0fe 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -591,7 +591,7 @@ static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
 	return freed;
 }
 
-#ifdef CONFIG_MEMCG
+#ifdef CONFIG_MEMCG_KMEM
 static unsigned long shrink_slab_memcg(gfp_t gfp_mask, int nid,
 			struct mem_cgroup *memcg, int priority)
 {
-- 
2.20.0

