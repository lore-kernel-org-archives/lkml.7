Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73FBCA9EC8
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B29CD21852
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ehEiL+RE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407389AbfJRA2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 20:28:53 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:8898 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407057AbfJRA2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 20:28:44 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9I0NP8N030781
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 17:28:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=s80/47kE6++tjdDNDZ71sdnneLbV+d8/4baGT5d2jWI=;
 b=ehEiL+REFcXkCl2jWCZJFBSXuMYLEyM+eas/WM3mqQKdRJZWL25klYW7SKcCrJ+ir401
 4b3tJ5z55pf7S6abaWORhsVi7EKlGS42C+F1BHdPUWFz0b+78yNQQ0/mjxtPlizmU+sm
 5JbcfjwOV0OrPQxZp8788aZu9uHmoOev9iI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vpj8rvkye-14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 17:28:44 -0700
Received: from 2401:db00:30:600c:face:0:39:0 (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 17 Oct 2019 17:28:35 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 05BC618CE8483; Thu, 17 Oct 2019 17:28:34 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     <linux-mm@kvack.org>
CC:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Christoph Lameter <cl@linux.com>, Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH 08/16] mm: memcg: introduce __mod_lruvec_memcg_state()
Date:   Thu, 17 Oct 2019 17:28:12 -0700
Message-ID: <20191018002820.307763-9-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191018002820.307763-1-guro@fb.com>
References: <20191018002820.307763-1-guro@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-17_07:2019-10-17,2019-10-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=761
 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=3 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910180001
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prepare for per-object accounting of slab objects, let's introduce
__mod_lruvec_memcg_state() and mod_lruvec_memcg_state() helpers,
which are similar to mod_lruvec_state(), but do not update global
node counters, only lruvec and per-cgroup.

It's necessary because soon node slab counters will be used for
accounting of all memory used by slab pages, however on memcg level
only the actually used memory will be counted. Free space will be
shared between all cgroups, so it can't be accounted to any.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 include/linux/memcontrol.h | 22 ++++++++++++++++++++++
 mm/memcontrol.c            | 37 +++++++++++++++++++++++++++----------
 2 files changed, 49 insertions(+), 10 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 7a6713dc52ce..bf1fcf85abd8 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -738,6 +738,8 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 
 void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 			int val);
+void __mod_lruvec_memcg_state(struct lruvec *lruvec, enum node_stat_item idx,
+			      int val);
 void __mod_lruvec_slab_state(void *p, enum node_stat_item idx, int val);
 
 static inline void mod_lruvec_state(struct lruvec *lruvec,
@@ -750,6 +752,16 @@ static inline void mod_lruvec_state(struct lruvec *lruvec,
 	local_irq_restore(flags);
 }
 
+static inline void mod_lruvec_memcg_state(struct lruvec *lruvec,
+					  enum node_stat_item idx, int val)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	__mod_lruvec_memcg_state(lruvec, idx, val);
+	local_irq_restore(flags);
+}
+
 static inline void __mod_lruvec_page_state(struct page *page,
 					   enum node_stat_item idx, int val)
 {
@@ -1142,6 +1154,16 @@ static inline void mod_lruvec_state(struct lruvec *lruvec,
 	mod_node_page_state(lruvec_pgdat(lruvec), idx, val);
 }
 
+static inline void __mod_lruvec_memcg_state(struct lruvec *lruvec,
+					    enum node_stat_item idx, int val)
+{
+}
+
+static inline void mod_lruvec_memcg_state(struct lruvec *lruvec,
+					  enum node_stat_item idx, int val)
+{
+}
+
 static inline void __mod_lruvec_page_state(struct page *page,
 					   enum node_stat_item idx, int val)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d9d5f77a783d..ebaa4ff36e0c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -787,16 +787,16 @@ parent_nodeinfo(struct mem_cgroup_per_node *pn, int nid)
 }
 
 /**
- * __mod_lruvec_state - update lruvec memory statistics
+ * __mod_lruvec_memcg_state - update lruvec memory statistics
  * @lruvec: the lruvec
  * @idx: the stat item
  * @val: delta to add to the counter, can be negative
  *
  * The lruvec is the intersection of the NUMA node and a cgroup. This
- * function updates the all three counters that are affected by a
- * change of state at this level: per-node, per-cgroup, per-lruvec.
+ * function updates the two of three counters that are affected by a
+ * change of state at this level: per-cgroup and per-lruvec.
  */
-void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
+void __mod_lruvec_memcg_state(struct lruvec *lruvec, enum node_stat_item idx,
 			int val)
 {
 	pg_data_t *pgdat = lruvec_pgdat(lruvec);
@@ -804,12 +804,6 @@ void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 	struct mem_cgroup *memcg;
 	long x, threshold = MEMCG_CHARGE_BATCH;
 
-	/* Update node */
-	__mod_node_page_state(pgdat, idx, val);
-
-	if (mem_cgroup_disabled())
-		return;
-
 	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
 	memcg = pn->memcg;
 
@@ -833,6 +827,29 @@ void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 	__this_cpu_write(pn->lruvec_stat_cpu->count[idx], x);
 }
 
+/**
+ * __mod_lruvec_state - update lruvec memory statistics
+ * @lruvec: the lruvec
+ * @idx: the stat item
+ * @val: delta to add to the counter, can be negative
+ *
+ * The lruvec is the intersection of the NUMA node and a cgroup. This
+ * function updates the all three counters that are affected by a
+ * change of state at this level: per-node, per-cgroup, per-lruvec.
+ */
+void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
+			int val)
+{
+	pg_data_t *pgdat = lruvec_pgdat(lruvec);
+
+	/* Update node */
+	__mod_node_page_state(pgdat, idx, val);
+
+	/* Update per-cgroup and per-lruvec stats */
+	if (!mem_cgroup_disabled())
+		__mod_lruvec_memcg_state(lruvec, idx, val);
+}
+
 void __mod_lruvec_slab_state(void *p, enum node_stat_item idx, int val)
 {
 	struct page *page = virt_to_head_page(p);
-- 
2.21.0

