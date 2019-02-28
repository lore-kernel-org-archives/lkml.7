Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780FEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 16:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 465F6218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 16:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="qZBcQtun"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732961AbfB1Qaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 11:30:55 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:41866 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732789AbfB1Qat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 11:30:49 -0500
Received: by mail-yw1-f65.google.com with SMTP id q128so11528984ywg.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 08:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xYRD3i2lO0S8FmpT0yhEIbRdeHMhHjlJuWkUHWcpJsw=;
        b=qZBcQtunj0HpdKLEyd50kzMF5u4hwQOvpkuAEd9NtT3C1jIdB7SHj5Wu9SVJiJwk3c
         efLEI5hR9LP5jqeXRHv91q1Cfi7QKY7YBX/nYdAjWaCkhg0/6IEOPiQBjKAq0bfilI3N
         6+YUWT4QM7QuO2aTXzGCOAO03Gu8MEqoAFGi1AsO2Gy+6MSFPDuRjpmStKdiUf3gl9WQ
         rYJWUi4TxMM1rVZuaDh8gqG2aQjHBJ/peVLRMFwX1ONsJbyvqNoiueg8XQ0q6ZlZTrDO
         AmmgTrAeqcwX3nf/JCr/thMhQEdk6+oBM8aZcyfJ5f8xItULOYhkQICIPL/RS7FEkfXS
         5ByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xYRD3i2lO0S8FmpT0yhEIbRdeHMhHjlJuWkUHWcpJsw=;
        b=f+21zEXnhUeYqgsjjWccpXFOHXYoh2IZQnzuLR/jOtypWff0eqXH8/Lot6O0fEVZiP
         GeEIJz5Zmwe+keo7Z+SLiqlyX/BgsfgDSCy5rAd7uoEqEPILzCehJhKrACs0Y0uS323R
         +HQ8blUI2dqRfCtsXZ8iI34w5OkP6ugtPEpR2FMRkVIN2Ds8OU01mpIocImsu/UAyIJK
         g6yvcB9rhR5k1xJ4muBzYB0ZUbRgYlIj3FXJ2lvf2BklrK6NfXKaX8XTIwfZfzCRBjXc
         LYdOL02P5zUO0GFM+3A7Id8IqvJTzLL9X5AqgaJ7MEhSi2Ahg57OHHe3BrKhCsK5COTh
         Lb7Q==
X-Gm-Message-State: AHQUAubNLGoOcmsvYcB9b1LdZ9V0UxWLUvtqPZt+165/ZpwWPpOZHfIw
        dsSJh8j4KRiLem/y3nFWRhouJw==
X-Google-Smtp-Source: AHgI3IZPWS72vZA70SN28U7DTHABb87bYm9NNCIuTp6WKnKk1uOxy49S6BuAC7Fr2XXiYD0cttc+bQ==
X-Received: by 2002:a81:3083:: with SMTP id w125mr6232560yww.170.1551371448843;
        Thu, 28 Feb 2019 08:30:48 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::3:da64])
        by smtp.gmail.com with ESMTPSA id e3sm6679734ywe.33.2019.02.28.08.30.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 08:30:48 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 5/6] mm: memcontrol: push down mem_cgroup_nr_lru_pages()
Date:   Thu, 28 Feb 2019 11:30:19 -0500
Message-Id: <20190228163020.24100-6-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190228163020.24100-1-hannes@cmpxchg.org>
References: <20190228163020.24100-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mem_cgroup_nr_lru_pages() is just a convenience wrapper around
memcg_page_state() that takes bitmasks of lru indexes and aggregates
the counts for those.

Replace callsites where the bitmask is simple enough with direct
memcg_page_state() call(s).

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ad6214b3d20b..76f599fbbbe8 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1361,7 +1361,7 @@ void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
 
 		for (i = 0; i < NR_LRU_LISTS; i++)
 			pr_cont(" %s:%luKB", mem_cgroup_lru_names[i],
-				K(mem_cgroup_nr_lru_pages(iter, BIT(i))));
+				K(memcg_page_state(iter, NR_LRU_BASE + i)));
 
 		pr_cont("\n");
 	}
@@ -3016,8 +3016,8 @@ static void accumulate_vmstats(struct mem_cgroup *memcg,
 				? acc->vmevents_array[i] : i);
 
 		for (i = 0; i < NR_LRU_LISTS; i++)
-			acc->lru_pages[i] +=
-				mem_cgroup_nr_lru_pages(mi, BIT(i));
+			acc->lru_pages[i] += memcg_page_state(mi,
+							      NR_LRU_BASE + i);
 	}
 }
 
@@ -3447,7 +3447,8 @@ static int memcg_stat_show(struct seq_file *m, void *v)
 
 	for (i = 0; i < NR_LRU_LISTS; i++)
 		seq_printf(m, "%s %lu\n", mem_cgroup_lru_names[i],
-			   mem_cgroup_nr_lru_pages(memcg, BIT(i)) * PAGE_SIZE);
+			   memcg_page_state(memcg, NR_LRU_BASE + i) *
+			   PAGE_SIZE);
 
 	/* Hierarchical information */
 	memory = memsw = PAGE_COUNTER_MAX;
@@ -3937,8 +3938,8 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
 
 	/* this should eventually include NR_UNSTABLE_NFS */
 	*pwriteback = memcg_page_state(memcg, NR_WRITEBACK);
-	*pfilepages = mem_cgroup_nr_lru_pages(memcg, (1 << LRU_INACTIVE_FILE) |
-						     (1 << LRU_ACTIVE_FILE));
+	*pfilepages = memcg_page_state(memcg, NR_INACTIVE_FILE) +
+		memcg_page_state(memcg, NR_ACTIVE_FILE);
 	*pheadroom = PAGE_COUNTER_MAX;
 
 	while ((parent = parent_mem_cgroup(memcg))) {
-- 
2.20.1

