Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2487C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 23:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD122083B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 23:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="UtF/4RBO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388464AbfHAXfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 19:35:36 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:26998 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388358AbfHAXfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 19:35:36 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71NYnCM020080
        for <linux-kernel@vger.kernel.org>; Thu, 1 Aug 2019 16:35:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=g/Rgv57lvtxG23ofGeQDm93gIRbsXPOoCEItv72iPRg=;
 b=UtF/4RBO9NZBzoW3hA/GQ+cMoTOJqaha2gcaVmntid4VG57wjzN84AQk3tzTQuPcWh7O
 L9/zm0uoB6Jq2WAiff2Z6F0iVvQvwK0PykAGOXPvbXHUACGwtvRaUgBflRqvjeqq5XS0
 7NeoNyh/6cGf5gl3uuJAL3fU9YsZhQu93FY= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2u485k0brn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 16:35:35 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Thu, 1 Aug 2019 16:35:34 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id D13D01528F19F; Thu,  1 Aug 2019 16:35:33 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH] mm: workingset: fix vmstat counters for shadow nodes
Date:   Thu, 1 Aug 2019 16:35:32 -0700
Message-ID: <20190801233532.138743-1-guro@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010250
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memcg counters for shadow nodes are broken because the memcg pointer is
obtained in a wrong way. The following approach is used:
	virt_to_page(xa_node)->mem_cgroup

Since commit 4d96ba353075 ("mm: memcg/slab: stop setting page->mem_cgroup
pointer for slab pages") page->mem_cgroup pointer isn't set for slab pages,
so memcg_from_slab_page() should be used instead.

Also I doubt that it ever worked correctly: virt_to_head_page() should be
used instead of virt_to_page(). Otherwise objects residing on tail pages
are not accounted, because only the head page contains a valid mem_cgroup
pointer. That was a case since the introduction of these counters by the
commit 68d48e6a2df5 ("mm: workingset: add vmstat counter for shadow nodes").

Fixes: 4d96ba353075 ("mm: memcg/slab: stop setting page->mem_cgroup pointer for slab pages")
Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/memcontrol.h | 19 +++++++++++++++++++
 mm/memcontrol.c            | 20 ++++++++++++++++++++
 mm/workingset.c            | 10 ++++------
 3 files changed, 43 insertions(+), 6 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 2cbce1fe7780..40f30ea30925 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -683,6 +683,7 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 
 void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 			int val);
+void __mod_lruvec_slab_state(void *p, enum node_stat_item idx, int val);
 
 static inline void mod_lruvec_state(struct lruvec *lruvec,
 				    enum node_stat_item idx, int val)
@@ -1098,6 +1099,14 @@ static inline void mod_lruvec_page_state(struct page *page,
 	mod_node_page_state(page_pgdat(page), idx, val);
 }
 
+static inline void __mod_lruvec_slab_state(void *p, enum node_stat_item idx,
+					   int val)
+{
+	struct page *page = virt_to_head_page(p);
+
+	__mod_node_page_state(page_pgdat(page), idx, val);
+}
+
 static inline
 unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 					    gfp_t gfp_mask,
@@ -1185,6 +1194,16 @@ static inline void __dec_lruvec_page_state(struct page *page,
 	__mod_lruvec_page_state(page, idx, -1);
 }
 
+static inline void __inc_lruvec_slab_state(void *p, enum node_stat_item idx)
+{
+	__mod_lruvec_slab_state(p, idx, 1);
+}
+
+static inline void __dec_lruvec_slab_state(void *p, enum node_stat_item idx)
+{
+	__mod_lruvec_slab_state(p, idx, -1);
+}
+
 /* idx can be of type enum memcg_stat_item or node_stat_item */
 static inline void inc_memcg_state(struct mem_cgroup *memcg,
 				   int idx)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5c7b9facb0eb..4fca83d51134 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -769,6 +769,26 @@ void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 	__this_cpu_write(pn->lruvec_stat_cpu->count[idx], x);
 }
 
+void __mod_lruvec_slab_state(void *p, enum node_stat_item idx, int val)
+{
+	struct page *page = virt_to_head_page(p);
+	pg_data_t *pgdat = page_pgdat(page);
+	struct mem_cgroup *memcg;
+	struct lruvec *lruvec;
+
+	rcu_read_lock();
+	memcg = memcg_from_slab_page(page);
+
+	/* Untracked pages have no memcg, no lruvec. Update only the node */
+	if (!memcg || memcg == root_mem_cgroup) {
+		__mod_node_page_state(pgdat, idx, val);
+	} else {
+		lruvec = mem_cgroup_lruvec(pgdat, memcg);
+		__mod_lruvec_state(lruvec, idx, val);
+	}
+	rcu_read_unlock();
+}
+
 /**
  * __count_memcg_events - account VM events in a cgroup
  * @memcg: the memory cgroup
diff --git a/mm/workingset.c b/mm/workingset.c
index e0b4edcb88c8..c963831d354f 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -380,14 +380,12 @@ void workingset_update_node(struct xa_node *node)
 	if (node->count && node->count == node->nr_values) {
 		if (list_empty(&node->private_list)) {
 			list_lru_add(&shadow_nodes, &node->private_list);
-			__inc_lruvec_page_state(virt_to_page(node),
-						WORKINGSET_NODES);
+			__inc_lruvec_slab_state(node, WORKINGSET_NODES);
 		}
 	} else {
 		if (!list_empty(&node->private_list)) {
 			list_lru_del(&shadow_nodes, &node->private_list);
-			__dec_lruvec_page_state(virt_to_page(node),
-						WORKINGSET_NODES);
+			__dec_lruvec_slab_state(node, WORKINGSET_NODES);
 		}
 	}
 }
@@ -480,7 +478,7 @@ static enum lru_status shadow_lru_isolate(struct list_head *item,
 	}
 
 	list_lru_isolate(lru, item);
-	__dec_lruvec_page_state(virt_to_page(node), WORKINGSET_NODES);
+	__dec_lruvec_slab_state(node, WORKINGSET_NODES);
 
 	spin_unlock(lru_lock);
 
@@ -503,7 +501,7 @@ static enum lru_status shadow_lru_isolate(struct list_head *item,
 	 * shadow entries we were tracking ...
 	 */
 	xas_store(&xas, NULL);
-	__inc_lruvec_page_state(virt_to_page(node), WORKINGSET_NODERECLAIM);
+	__inc_lruvec_slab_state(node, WORKINGSET_NODERECLAIM);
 
 out_invalid:
 	xa_unlock_irq(&mapping->i_pages);
-- 
2.21.0

