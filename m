Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA74C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 21:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 612B321871
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 21:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnQkXWhr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387654AbfDQVzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 17:55:04 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33182 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387602AbfDQVzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 17:55:01 -0400
Received: by mail-pg1-f194.google.com with SMTP id k19so174520pgh.0;
        Wed, 17 Apr 2019 14:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NUinwwoqQqqlnaj+hfWxAVvkl/hYr3H9Nu7bos7N4pE=;
        b=TnQkXWhriERaZfgxnd6oMoknEpldpZY4+ddqcjT9GjKwVe5mHq0dOSP71ukwgXypvq
         gzYvkoj5vWdSnXSRCCXCNagTc11B45enD9TrF5IxKI/NmjZLJcINdRJXe//lfyxQlxpA
         g1QIAY14d3wugoG2GI6i9vqpSBFgidozl3m/zEJH2ZbtqH1G7kNtgeATO01BFvh1iAug
         txs59zhsh/UB2k+oPSuUnLxiP6LHaLRttbMVvFmVYUbYIx18owHtFaviC8Mb2QvyP44e
         D/8viFGHj8Ezgc3m9xb9MnAOcO2tPQYTC2AC7tt88lJ76EfU3h1K7a0HOPPF2HSCG/n1
         td9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NUinwwoqQqqlnaj+hfWxAVvkl/hYr3H9Nu7bos7N4pE=;
        b=MBvL2bLFPc4WQlArNh9fgPsuszNMI0UyaHbKp8C45Se1Q4pn5HEFqb0yG/VHVIIWJf
         3zq9+xeb2E2og1zf7ByFO3bOiq7bWb+ZbJ3iZP5q3Gm23YqVy11WNDtql/d+e+FPuFnq
         6qr9qWuh7fnbaZQzlDMcKJPAXe3/O/o7L54tXCUKdda6mubVbuMnFyFfWr3eZsTBJVil
         93bVSHFjrJS+6e/I3vYGgJGPiOZdoS4lsIWfLNw+YslH/QZB0GbMUuYTq9AePF8aiDtk
         mh5jygX4P/rk3DhhjzzMBPqHtA+Ko+FY7JJAaDfmCLqDHjmRD2CVRloxQPOnvXB9q0xM
         aYWQ==
X-Gm-Message-State: APjAAAUN4d5HSrtLMPr5vNBBCrtsdUa1SyxTzRv4StbO207dnCBxQOJ3
        g0Qgx26F/3wSSdMVVMD73+0=
X-Google-Smtp-Source: APXvYqxo8fFyf4UjadiGuY16LsgpI7/aYDRL0AuqAX0+SEjmKOud84TnNLhLUufhyWE4dCeVlf+U9g==
X-Received: by 2002:a63:6a44:: with SMTP id f65mr50910693pgc.354.1555538100889;
        Wed, 17 Apr 2019 14:55:00 -0700 (PDT)
Received: from tower.thefacebook.com ([2620:10d:c090:200::5597])
        by smtp.gmail.com with ESMTPSA id x6sm209024pfb.171.2019.04.17.14.54.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 14:55:00 -0700 (PDT)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>, david@fromorbit.com,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, Roman Gushchin <guro@fb.com>
Subject: [PATCH 5/5] mm: reparent slab memory on cgroup removal
Date:   Wed, 17 Apr 2019 14:54:34 -0700
Message-Id: <20190417215434.25897-6-guro@fb.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190417215434.25897-1-guro@fb.com>
References: <20190417215434.25897-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's reparent memcg slab memory on memcg offlining. This allows us
to release the memory cgroup without waiting for the last outstanding
kernel object (e.g. dentry used by another application).

So instead of reparenting all accounted slab pages, let's do reparent
a relatively small amount of kmem_caches. Reparenting is performed as
the last part of the deactivation process, so it's guaranteed that all
kmem_caches are not active at this moment.

Since the parent cgroup is already charged, everything we need to do
is to move the kmem_cache to the parent's kmem_caches list,
swap the memcg pointer, bump parent's css refcounter and drop
the cgroup's refcounter. Quite simple.

We can't race with the slab allocation path, and if we race with
deallocation path, it's not a big deal: parent's charge and slab stats
are always correct*, and we don't care anymore about the child usage
and stats. The child cgroup is already offline, so we don't use or
show it anywhere.

* please, look at the comment in kmemcg_cache_deactivate_after_rcu()
  for some additional details

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 mm/memcontrol.c  |  4 +++-
 mm/slab.h        |  4 +++-
 mm/slab_common.c | 28 ++++++++++++++++++++++++++++
 3 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 87c06e342e05..2f61d13df0c4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3239,7 +3239,6 @@ static void memcg_free_kmem(struct mem_cgroup *memcg)
 	if (memcg->kmem_state == KMEM_ALLOCATED) {
 		WARN_ON(!list_empty(&memcg->kmem_caches));
 		static_branch_dec(&memcg_kmem_enabled_key);
-		WARN_ON(page_counter_read(&memcg->kmem));
 	}
 }
 #else
@@ -4651,6 +4650,9 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 
 	/* The following stuff does not apply to the root */
 	if (!parent) {
+#ifdef CONFIG_MEMCG_KMEM
+		INIT_LIST_HEAD(&memcg->kmem_caches);
+#endif
 		root_mem_cgroup = memcg;
 		return &memcg->css;
 	}
diff --git a/mm/slab.h b/mm/slab.h
index 1f49945f5c1d..be4f04ef65f9 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -329,10 +329,12 @@ static __always_inline void memcg_uncharge_slab(struct page *page, int order,
 		return;
 	}
 
-	memcg = s->memcg_params.memcg;
+	rcu_read_lock();
+	memcg = READ_ONCE(s->memcg_params.memcg);
 	lruvec = mem_cgroup_lruvec(page_pgdat(page), memcg);
 	mod_lruvec_state(lruvec, idx, -(1 << order));
 	memcg_kmem_uncharge_memcg(page, order, memcg);
+	rcu_read_unlock();
 
 	kmemcg_cache_put_many(s, 1 << order);
 }
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 3fdd02979a1c..fc2e86de402f 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -745,7 +745,35 @@ void kmemcg_queue_cache_shutdown(struct kmem_cache *s)
 
 static void kmemcg_cache_deactivate_after_rcu(struct kmem_cache *s)
 {
+	struct mem_cgroup *memcg, *parent;
+
 	__kmemcg_cache_deactivate_after_rcu(s);
+
+	memcg = s->memcg_params.memcg;
+	parent = parent_mem_cgroup(memcg);
+	if (!parent)
+		parent = root_mem_cgroup;
+
+	if (memcg == parent)
+		return;
+
+	/*
+	 * Let's reparent the kmem_cache. It's already deactivated, so we
+	 * can't race with memcg_charge_slab(). We still can race with
+	 * memcg_uncharge_slab(), but it's not a problem. The parent cgroup
+	 * is already charged, so it's ok to uncharge either the parent cgroup
+	 * directly, either recursively.
+	 * The same is true for recursive vmstats. Local vmstats are not use
+	 * anywhere, except count_shadow_nodes(). But reparenting will not
+	 * cahnge anything for count_shadow_nodes(): on memcg removal
+	 * shrinker lists are reparented, so it always returns SHRINK_EMPTY
+	 * for non-leaf dead memcgs. For the parent memcgs local slab stats
+	 * are always 0 now, so reparenting will not change anything.
+	 */
+	list_move(&s->memcg_params.kmem_caches_node, &parent->kmem_caches);
+	s->memcg_params.memcg = parent;
+	css_get(&parent->css);
+	css_put(&memcg->css);
 }
 
 static void kmemcg_cache_deactivate(struct kmem_cache *s)
-- 
2.20.1

