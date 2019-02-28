Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67094C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 16:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3855F218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 16:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="ZAGBYz8G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733146AbfB1QbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 11:31:13 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:41855 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732716AbfB1Qao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 11:30:44 -0500
Received: by mail-yw1-f65.google.com with SMTP id q128so11528750ywg.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 08:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NxReYuZN9DV/fcdnYYWinsazWkVL2jKBNqgEJlRIVkI=;
        b=ZAGBYz8GP7xIIzJFVPTadJPGGMIowtbAf7+EPG3yvgRIeRyXKmFnQnaswl/xN6iA1h
         Stype2OdeKY7ecFjCOIUKdyiqmYipTgueLOOP9OfEcLkTklZQs71jTxnDHOs/Afca+Ff
         dh99RRH2hehKyyfIpmHBwk1bsz20KaPjXYYkmNhguy18yadeh7dnamP67D/VmkLw2nUb
         ktqdqI4pYdDPvQjETyKp9zSCQqE+VSyjVVX6OecZlKOlxHzVlzveix/BhPrzCNSZJyS+
         CdTvtK4NOJvO4/kPQ5/PxHPZu0t7yQiJLF5gQi2Q3xs2G+vSxFcKWfWRHeCrCn8bRNfR
         8bZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NxReYuZN9DV/fcdnYYWinsazWkVL2jKBNqgEJlRIVkI=;
        b=ryhTxadqcXNBPHs9MI9+l/f6aAvkgEyxJLZVh0sxfZDxVWJy8YKWiYNG5Kz+KH5MDy
         WLLKSYmTjuHBlVXg87UsPsR9muu6eYgBGIQyiEuB5+DvTsX8i6gxKfyOF2HYnm8cEghi
         FIxs52asOeDdZVZWxT0mbsHrHsDN9VJFp2tJkAWkOGUXnsl1QNQ3G5LYKat2qolLROSJ
         Y/ea2A/PC9DHtvdnI3/7FzgKLpTjSHFXp7ODE97RGlMTAoq4R9NNHXxc1WPm57Q8XzUH
         te+QmuNOFmxXRwf27mu4vxFg+3kwA5baI1pnysjARTG4OlOrUXpkIM1YI/5CGZV6NDlT
         7n4A==
X-Gm-Message-State: APjAAAVdlneGg/w7Z5h2a+KOSAFIzQEjjFpI0HkVtH40CyoCVTy+OLvX
        Ge4rdv+Qc70s0qyh4qXrGFw0QQ==
X-Google-Smtp-Source: APXvYqyeHHEs3NCGgQH9pHOJZbtgFB/JeWqSzcj6DKjRixvKM6LESsPz5wgeJvfex5scPRevDjuqDg==
X-Received: by 2002:a5b:348:: with SMTP id q8mr166652ybp.479.1551371443602;
        Thu, 28 Feb 2019 08:30:43 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::3:da64])
        by smtp.gmail.com with ESMTPSA id r77sm6517577ywg.10.2019.02.28.08.30.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 08:30:42 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/6] mm: memcontrol: replace zone summing with lruvec_page_state()
Date:   Thu, 28 Feb 2019 11:30:16 -0500
Message-Id: <20190228163020.24100-3-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190228163020.24100-1-hannes@cmpxchg.org>
References: <20190228163020.24100-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of adding up the zone counters, use lruvec_page_state() to get
the node state directly. This is a bit cheaper and more stream-lined.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/memcontrol.h | 18 ------------------
 mm/memcontrol.c            |  2 +-
 mm/vmscan.c                |  2 +-
 3 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 534267947664..5050d281f67d 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -517,19 +517,6 @@ void mem_cgroup_update_lru_size(struct lruvec *lruvec, enum lru_list lru,
 unsigned long mem_cgroup_node_nr_lru_pages(struct mem_cgroup *memcg,
 					   int nid, unsigned int lru_mask);
 
-static inline
-unsigned long mem_cgroup_get_lru_size(struct lruvec *lruvec, enum lru_list lru)
-{
-	struct mem_cgroup_per_node *mz;
-	unsigned long nr_pages = 0;
-	int zid;
-
-	mz = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
-	for (zid = 0; zid < MAX_NR_ZONES; zid++)
-		nr_pages += mz->lru_zone_size[zid][lru];
-	return nr_pages;
-}
-
 static inline
 unsigned long mem_cgroup_get_zone_lru_size(struct lruvec *lruvec,
 		enum lru_list lru, int zone_idx)
@@ -985,11 +972,6 @@ static inline bool mem_cgroup_online(struct mem_cgroup *memcg)
 	return true;
 }
 
-static inline unsigned long
-mem_cgroup_get_lru_size(struct lruvec *lruvec, enum lru_list lru)
-{
-	return 0;
-}
 static inline
 unsigned long mem_cgroup_get_zone_lru_size(struct lruvec *lruvec,
 		enum lru_list lru, int zone_idx)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5fc2e1a7d4d2..d85a41cfee60 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -737,7 +737,7 @@ unsigned long mem_cgroup_node_nr_lru_pages(struct mem_cgroup *memcg,
 	for_each_lru(lru) {
 		if (!(BIT(lru) & lru_mask))
 			continue;
-		nr += mem_cgroup_get_lru_size(lruvec, lru);
+		nr += lruvec_page_state(lruvec, NR_LRU_BASE + lru);
 	}
 	return nr;
 }
diff --git a/mm/vmscan.c b/mm/vmscan.c
index ac4806f0f332..cdf8d92e6b89 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -346,7 +346,7 @@ unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone
 	int zid;
 
 	if (!mem_cgroup_disabled())
-		lru_size = mem_cgroup_get_lru_size(lruvec, lru);
+		lru_size = lruvec_page_state(lruvec, NR_LRU_BASE + lru);
 	else
 		lru_size = node_page_state(lruvec_pgdat(lruvec), NR_LRU_BASE + lru);
 
-- 
2.20.1

