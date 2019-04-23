Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03952C282E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0F3C218DA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h2ZSmpkO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbfDWPoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 11:44:10 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:38958 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727761AbfDWPoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 11:44:10 -0400
Received: by mail-ua1-f73.google.com with SMTP id v5so1739260ual.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 08:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=JXAocCnPjSxHxOedcbkgNjrO0QCzgS2wvknDYgoZYBE=;
        b=h2ZSmpkO455hJucWi8vU9qqGrVVPIxjVUbprWQF8SrXGeUWYEtdRdUMU8GtXSHDesu
         yBKEsZSWWW2KJtcxcOQGMiSVump33fTuW6/iTofr8qsMKD3wNxUE25Gumttajj4KG6nt
         9i8XUWuswqN5ShRuRQz6rIFE3sx7GDC60GZV9NMtx5fQMnA8vz/KtmmChP7ERyHcNzqa
         3ihRs/qlttIu67hSLzNPEXnIblh4e6kWAIycUk70uQHAQ/3oemiOq/slmLGv+N4ENQw5
         NocVBF4+UQPJd9FaFhrexwBmhkObiXRvEgXQ3A9zGp9ScaVICRETZkPyKx2KJD80gIHr
         jL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=JXAocCnPjSxHxOedcbkgNjrO0QCzgS2wvknDYgoZYBE=;
        b=O5aRKKuGemlIt/gocPrSc1r33+nf9XzdNLdy9hkkwnK70yrvYAcrXxA8jlU4vfQOAl
         41zxNkQNJOPq4hrFn/GJlmgY1WYQL5NWX+kBOZwzXa/zQr/7gyMU5HXUSoN5XjzGDHvT
         1HBe3o43nw2kPixYI7Z26J7uZ5/mFB217NtXEzFnQJm9aPvhuA7pxVR8ZS4TuCe5hnzu
         qaub/uf3VO/TgLw1qOO+uODf0cpD+n99kCkx/OlJH6TPSz+X7dewpm482pyc0SFOqzLq
         GTChAt5qaAMBYGqw1aNDp/UhIp0M51T0zNv1Ax1zVCT5MCW8drwQygJbYVAh703ZmH3J
         TZfA==
X-Gm-Message-State: APjAAAVHAo1JMYy8DJEF9XYQTHQMyRI9/MWnAPxB6x3cg3gfnJo6ysBZ
        svHg67iDnBSWv9fekhaiDZJkLDax2Mi00g==
X-Google-Smtp-Source: APXvYqz18sYa2y+Uj6M7CjZ+maaEwP+Bpk8TEQBBch1tuP5pwW66oU1p/mRbW6J4jkzvf13B7Us7G2Wc7DAudw==
X-Received: by 2002:a1f:8991:: with SMTP id l139mr13783395vkd.49.1556034248763;
 Tue, 23 Apr 2019 08:44:08 -0700 (PDT)
Date:   Tue, 23 Apr 2019 08:44:05 -0700
Message-Id: <20190423154405.259178-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH v2] memcg: refill_stock for kmem uncharging too
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
uncharging as well. Though we can bypass the refill for the offlined
memcgs but it may impact the performance of network traffic for the
sockets used by other cgroups.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
Cc: Roman Gushchin <guro@fb.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---

Changelog since v1:
- No need to bypass offline memcgs in the refill.

 mm/memcontrol.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2535e54e7989..2713b45ec3f0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2768,17 +2768,13 @@ void __memcg_kmem_uncharge(struct page *page, int order)
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
2.21.0.593.g511ec345e18-goog

