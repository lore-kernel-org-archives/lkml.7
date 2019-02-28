Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEE5C10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 16:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8CE9218CD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 16:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="DEAtdOPW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733078AbfB1Qa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 11:30:56 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:43293 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732829AbfB1Qaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 11:30:52 -0500
Received: by mail-yw1-f66.google.com with SMTP id u200so11523522ywu.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 08:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z2sRN7pljcgc3IEs1HOIZy7cq4U6Vg2axPUdXHMU2lE=;
        b=DEAtdOPWiEo0uOoF/kNQdPF0USk1MRsY3/VKt8/mJQFicjBli6ttNVH8RkvHkOg7wY
         ByBYfX+mPzOz9P8Dn43tEMTeRXyvR12moI751Uv096CLMEY6EjSZA+WEDf1fNGD8fukR
         hI3+VbOhIJVPNA3hgzNYNYZIqwq8/bYnBQQFyYaygDjHRN0w9ne2jfjL/rrEuW2UgLZx
         ePVPYNWL+E839Gw74yrULf1nuqJO6jmJUWceXhvNVkSQYCxL+N+qwhDGHo4wc3vE1NnZ
         uvoFdHHWn7bP1Lkywedfry5vLXo9gAO6JiqCgHzo8jp3u2/gXV2IhksYFvEo+pcToDvJ
         XK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z2sRN7pljcgc3IEs1HOIZy7cq4U6Vg2axPUdXHMU2lE=;
        b=t/vWnRWeQiVJyxgUZxEqscGV2l33wzhRDLsZZlGrA6laj9vjgVcXhFjqI7Wm/5smpm
         TKpERV5p6Jb487DmAS8u2WFCXrmj5g1+eiTbMNyee1nS1pG/qyFhQtO/9FvIGFxDQagQ
         BqpIkJrNEBaHNHXWEVK8tjLhdem15RnyrcuIpFttjgbzVWroS7Iw4+yKKkZZKULhHdtP
         y3uxm9Jnpcoh97+nOuSdislVR6xucLziwbNQG76diY10uuetSJqKsoY0UwRk6pNaqYeE
         zUw/BbyWXmiEQAKetxvqj3QnXt+IGqOJRj/t1cQS94Gma0jj+mS71swbufzH7WVPCT8B
         4NXg==
X-Gm-Message-State: APjAAAWk2oZGIZQMG5KzSxQ6/l5nCTUU1M3B9EuljKlcjXlqtJyfLxki
        VveDrHFMC2Xhi7zQbXFETmuqek6NdOY=
X-Google-Smtp-Source: APXvYqyNcyZYPdtjY9m+2V16Yk0I+x1bw52PllT0bSsmtOHA4mF7H5azCPmD+vCWxBwj1x3AcONkCQ==
X-Received: by 2002:a25:804a:: with SMTP id a10mr234343ybn.150.1551371450712;
        Thu, 28 Feb 2019 08:30:50 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::3:da64])
        by smtp.gmail.com with ESMTPSA id l202sm4189232ywb.72.2019.02.28.08.30.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 08:30:50 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 6/6] mm: memcontrol: quarantine the mem_cgroup_[node_]nr_lru_pages() API
Date:   Thu, 28 Feb 2019 11:30:20 -0500
Message-Id: <20190228163020.24100-7-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190228163020.24100-1-hannes@cmpxchg.org>
References: <20190228163020.24100-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only memcg_numa_stat_show() uses those wrappers and the lru bitmasks,
group them together.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/mmzone.h |  5 ----
 mm/memcontrol.c        | 67 +++++++++++++++++++++++-------------------
 2 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 2fd4247262e9..4f92d32c26a7 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -305,11 +305,6 @@ struct lruvec {
 #endif
 };
 
-/* Mask used at gathering information at once (see memcontrol.c) */
-#define LRU_ALL_FILE (BIT(LRU_INACTIVE_FILE) | BIT(LRU_ACTIVE_FILE))
-#define LRU_ALL_ANON (BIT(LRU_INACTIVE_ANON) | BIT(LRU_ACTIVE_ANON))
-#define LRU_ALL	     ((1 << NR_LRU_LISTS) - 1)
-
 /* Isolate unmapped file */
 #define ISOLATE_UNMAPPED	((__force isolate_mode_t)0x2)
 /* Isolate for asynchronous migration */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 76f599fbbbe8..84243831b738 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -725,37 +725,6 @@ static void mem_cgroup_charge_statistics(struct mem_cgroup *memcg,
 	__this_cpu_add(memcg->vmstats_percpu->nr_page_events, nr_pages);
 }
 
-static unsigned long mem_cgroup_node_nr_lru_pages(struct mem_cgroup *memcg,
-					   int nid, unsigned int lru_mask)
-{
-	struct lruvec *lruvec = mem_cgroup_lruvec(NODE_DATA(nid), memcg);
-	unsigned long nr = 0;
-	enum lru_list lru;
-
-	VM_BUG_ON((unsigned)nid >= nr_node_ids);
-
-	for_each_lru(lru) {
-		if (!(BIT(lru) & lru_mask))
-			continue;
-		nr += lruvec_page_state(lruvec, NR_LRU_BASE + lru);
-	}
-	return nr;
-}
-
-static unsigned long mem_cgroup_nr_lru_pages(struct mem_cgroup *memcg,
-			unsigned int lru_mask)
-{
-	unsigned long nr = 0;
-	enum lru_list lru;
-
-	for_each_lru(lru) {
-		if (!(BIT(lru) & lru_mask))
-			continue;
-		nr += memcg_page_state(memcg, NR_LRU_BASE + lru);
-	}
-	return nr;
-}
-
 static bool mem_cgroup_event_ratelimit(struct mem_cgroup *memcg,
 				       enum mem_cgroup_events_target target)
 {
@@ -3357,6 +3326,42 @@ static int mem_cgroup_move_charge_write(struct cgroup_subsys_state *css,
 #endif
 
 #ifdef CONFIG_NUMA
+
+#define LRU_ALL_FILE (BIT(LRU_INACTIVE_FILE) | BIT(LRU_ACTIVE_FILE))
+#define LRU_ALL_ANON (BIT(LRU_INACTIVE_ANON) | BIT(LRU_ACTIVE_ANON))
+#define LRU_ALL	     ((1 << NR_LRU_LISTS) - 1)
+
+static unsigned long mem_cgroup_node_nr_lru_pages(struct mem_cgroup *memcg,
+					   int nid, unsigned int lru_mask)
+{
+	struct lruvec *lruvec = mem_cgroup_lruvec(NODE_DATA(nid), memcg);
+	unsigned long nr = 0;
+	enum lru_list lru;
+
+	VM_BUG_ON((unsigned)nid >= nr_node_ids);
+
+	for_each_lru(lru) {
+		if (!(BIT(lru) & lru_mask))
+			continue;
+		nr += lruvec_page_state(lruvec, NR_LRU_BASE + lru);
+	}
+	return nr;
+}
+
+static unsigned long mem_cgroup_nr_lru_pages(struct mem_cgroup *memcg,
+					     unsigned int lru_mask)
+{
+	unsigned long nr = 0;
+	enum lru_list lru;
+
+	for_each_lru(lru) {
+		if (!(BIT(lru) & lru_mask))
+			continue;
+		nr += memcg_page_state(memcg, NR_LRU_BASE + lru);
+	}
+	return nr;
+}
+
 static int memcg_numa_stat_show(struct seq_file *m, void *v)
 {
 	struct numa_stat {
-- 
2.20.1

