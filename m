Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2748EC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E221B217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Klhb8HsQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390314AbfHHUgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 16:36:09 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:64550 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727649AbfHHUgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 16:36:09 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x78KSBsu018710
        for <linux-kernel@vger.kernel.org>; Thu, 8 Aug 2019 13:36:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=ZZ49snpRr7mPFov6Hyh1szaiWFNeYUXmStPACJSKaRA=;
 b=Klhb8HsQt8tPCzbKC7dpZtIacTMOTpYT4pc2p8Tcic7LcrC108eBMpYxKh8SS7y7Kn+z
 cJHuBZsGf8FfTFeBcx14dC9nlU283r1TajQD/Krg9UVSLcYyzEurDKXfexf7xNLMedQS
 L7b3z0Lv1v2HURbgIuv/sa5YilgtfroT8g8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2u8qpk8uhb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 13:36:08 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 8 Aug 2019 13:36:07 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 7A07C1619126F; Thu,  8 Aug 2019 13:36:05 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH] mm: memcontrol: flush slab vmstats on kmem offlining
Date:   Thu, 8 Aug 2019 13:36:04 -0700
Message-ID: <20190808203604.3413318-1-guro@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-08_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=593 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908080181
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've noticed that the "slab" value in memory.stat is sometimes 0,
even if some children memory cgroups have a non-zero "slab" value.
The following investigation showed that this is the result
of the kmem_cache reparenting in combination with the per-cpu
batching of slab vmstats.

At the offlining some vmstat value may leave in the percpu cache,
not being propagated upwards by the cgroup hierarchy. It means
that stats on ancestor levels are lower than actual. Later when
slab pages are released, the precise number of pages is substracted
on the parent level, making the value negative. We don't show negative
values, 0 is printed instead.

To fix this issue, let's flush percpu slab memcg and lruvec stats
on memcg offlining. This guarantees that numbers on all ancestor
levels are accurate and match the actual number of outstanding
slab pages.

Fixes: fb2f2b0adb98 ("mm: memcg/slab: reparent memcg kmem_caches on cgroup removal")
Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 3e821f34399f..3a5f6f486cdf 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3412,6 +3412,50 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
 	return 0;
 }
 
+static void memcg_flush_slab_node_stats(struct mem_cgroup *memcg, int node)
+{
+	struct mem_cgroup_per_node *pn = memcg->nodeinfo[node];
+	struct mem_cgroup_per_node *pi;
+	unsigned long recl = 0, unrecl = 0;
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		recl += raw_cpu_read(
+			pn->lruvec_stat_cpu->count[NR_SLAB_RECLAIMABLE]);
+		unrecl += raw_cpu_read(
+			pn->lruvec_stat_cpu->count[NR_SLAB_UNRECLAIMABLE]);
+	}
+
+	for (pi = pn; pi; pi = parent_nodeinfo(pi, node)) {
+		atomic_long_add(recl,
+				&pi->lruvec_stat[NR_SLAB_RECLAIMABLE]);
+		atomic_long_add(unrecl,
+				&pi->lruvec_stat[NR_SLAB_UNRECLAIMABLE]);
+	}
+}
+
+static void memcg_flush_slab_vmstats(struct mem_cgroup *memcg)
+{
+	struct mem_cgroup *mi;
+	unsigned long recl = 0, unrecl = 0;
+	int node, cpu;
+
+	for_each_possible_cpu(cpu) {
+		recl += raw_cpu_read(
+			memcg->vmstats_percpu->stat[NR_SLAB_RECLAIMABLE]);
+		unrecl += raw_cpu_read(
+			memcg->vmstats_percpu->stat[NR_SLAB_UNRECLAIMABLE]);
+	}
+
+	for (mi = memcg; mi; mi = parent_mem_cgroup(mi)) {
+		atomic_long_add(recl, &mi->vmstats[NR_SLAB_RECLAIMABLE]);
+		atomic_long_add(unrecl, &mi->vmstats[NR_SLAB_UNRECLAIMABLE]);
+	}
+
+	for_each_node(node)
+		memcg_flush_slab_node_stats(memcg, node);
+}
+
 static void memcg_offline_kmem(struct mem_cgroup *memcg)
 {
 	struct cgroup_subsys_state *css;
@@ -3432,7 +3476,14 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
 	if (!parent)
 		parent = root_mem_cgroup;
 
+	/*
+	 * Deactivate and reparent kmem_caches. Then Flush percpu
+	 * slab statistics to have precise values at the parent and
+	 * all ancestor levels. It's required to keep slab stats
+	 * accurate after the reparenting of kmem_caches.
+	 */
 	memcg_deactivate_kmem_caches(memcg, parent);
+	memcg_flush_slab_vmstats(memcg);
 
 	kmemcg_id = memcg->kmemcg_id;
 	BUG_ON(kmemcg_id < 0);
-- 
2.21.0

