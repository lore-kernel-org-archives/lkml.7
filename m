Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB16C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 21:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DC75217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 21:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oaWnOGJj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfDRVmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 17:42:43 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:52187 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfDRVmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 17:42:42 -0400
Received: by mail-qt1-f201.google.com with SMTP id l26so3203345qtk.18
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 14:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=605MB47TGZE7++nkg35APlvJ7LvXGdU0fZst7n36xg0=;
        b=oaWnOGJjefDF9ALhsI0TQQYT+yASuFR/0cQfdkTMFbKQL5kxt0lWvB0UfR/e/diMWA
         L5aPgj1ojrRz7lNhejHhqNQsMGPu/6Nzv3/CY8Qx7pKQUaD3AWxi3LJasbtot5BmbPyf
         daKcD6r5a3Sisc7gFSEVTCzEpZ7IY8yDAGe9uWnkIw6nBUdXrfbFSC7p+0YhkpPTQR0F
         kJmDsmSOyvV4y8m65E31wdOVUl2B7auUkm5c9a5Uif1GgOSo9YJSEgTZtwEjZfbBTqAo
         q3hfAfXohgmVx1vGKRM6jzTXjRjAGaBsl07x0Gnx7qDTyX6wRXxGFxin8gxl1bSzIwkl
         aY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=605MB47TGZE7++nkg35APlvJ7LvXGdU0fZst7n36xg0=;
        b=Mh3CWTYFsU6j8XymwO8TgAYvJCvaOvKxKc3kxGHudH52hyN0JTKzGqbqYrlufCX1pv
         6sfKFSAmpTUm27deCo/YqOWuJN2u0rRuJ3OT8FwgnOpS2bPcDaXBE9euU65r59k9TxSv
         re+4QaFCMvPtgRQGtDrkWYMb9GGtzzUbi6Z9Z7bhw/kx7KHvWAOqdksn9SqUARmNPzcm
         joBhcJZVxwYCDWGe7uxKt/VeAoRrSBP62eim5xuKRnNofCv9YUDtWOkNG8ey06qx/tC0
         Us9OVQZXSh1LHXC+PidOf4YCdyAxxA+Zt+wAA6gVxZB+XspR4fkOQBQZFXWGClISGDJK
         6LIA==
X-Gm-Message-State: APjAAAXe8NEXhKebnhYWXE7OvOW8nQbJ8nE2seTFCtq0cgw6MwbqBJti
        9uwdpZuzdLPcqcE6O8f1M6dPrMhG8EpM2A==
X-Google-Smtp-Source: APXvYqwoo51/pygjywuTIOUu6emXG8qvgN27gaAs1GFwF5lpCnhgwa8++3Zml2MqfC8VgSCoWvlvInqJyrPa3g==
X-Received: by 2002:a37:5a46:: with SMTP id o67mr290481qkb.31.1555623761557;
 Thu, 18 Apr 2019 14:42:41 -0700 (PDT)
Date:   Thu, 18 Apr 2019 14:42:24 -0700
Message-Id: <20190418214224.61900-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH] memcg: refill_stock for kmem uncharging too
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 475d0487a2ad ("mm: memcontrol: use per-cpu stocks for socket
memory uncharging") added refill_stock() for skmem uncharging path to
optimize workloads having high network traffic. Do the same for the kmem
uncharging as well. However bypass the refill for offlined memcgs to not
cause zombie apocalypse.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 mm/memcontrol.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2535e54e7989..7b8de091f572 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -178,6 +178,7 @@ struct mem_cgroup_event {
 
 static void mem_cgroup_threshold(struct mem_cgroup *memcg);
 static void mem_cgroup_oom_notify(struct mem_cgroup *memcg);
+static void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages);
 
 /* Stuffs for move charges at task migration. */
 /*
@@ -2097,10 +2098,7 @@ static void drain_stock(struct memcg_stock_pcp *stock)
 	struct mem_cgroup *old = stock->cached;
 
 	if (stock->nr_pages) {
-		page_counter_uncharge(&old->memory, stock->nr_pages);
-		if (do_memsw_account())
-			page_counter_uncharge(&old->memsw, stock->nr_pages);
-		css_put_many(&old->css, stock->nr_pages);
+		cancel_charge(old, stock->nr_pages);
 		stock->nr_pages = 0;
 	}
 	stock->cached = NULL;
@@ -2133,6 +2131,11 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 	struct memcg_stock_pcp *stock;
 	unsigned long flags;
 
+	if (unlikely(!mem_cgroup_online(memcg))) {
+		cancel_charge(memcg, nr_pages);
+		return;
+	}
+
 	local_irq_save(flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
@@ -2768,17 +2771,13 @@ void __memcg_kmem_uncharge(struct page *page, int order)
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		page_counter_uncharge(&memcg->kmem, nr_pages);
 
-	page_counter_uncharge(&memcg->memory, nr_pages);
-	if (do_memsw_account())
-		page_counter_uncharge(&memcg->memsw, nr_pages);
-
 	page->mem_cgroup = NULL;
 
 	/* slab pages do not have PageKmemcg flag set */
 	if (PageKmemcg(page))
 		__ClearPageKmemcg(page);
 
-	css_put_many(&memcg->css, nr_pages);
+	refill_stock(memcg, nr_pages);
 }
 #endif /* CONFIG_MEMCG_KMEM */
 
-- 
2.21.0.392.gf8f6787159e-goog

