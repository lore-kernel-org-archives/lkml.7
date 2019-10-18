Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBE9CA9EC8
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EAF821D7D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Jwpxkv3q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408708AbfJRA3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 20:29:18 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:4982 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406973AbfJRA2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 20:28:42 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9I0SS6j006818
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 17:28:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=duc2IEN0723Bf+DfQiHMMxAa0jjXCQi8qfL9v6lQ4f8=;
 b=Jwpxkv3qQNTm8Wz4uauszEJvnvAyxZf0zjjhE00dQNNJhI6t0lAnWS1E0YxGe9XcDWRm
 yl4hbhjJRwmcdV9f1PluH8bubiWnkt8rYXxBsnijho8okBcsBIwUCHgMZROHstPkcQ4F
 3lEnaMznq4UwysFP9H/tisA6SFVdFKaHaNQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vpsd6atu7-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 17:28:41 -0700
Received: from 2401:db00:12:9028:face:0:29:0 (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 17 Oct 2019 17:28:35 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id E4FCA18CE8477; Thu, 17 Oct 2019 17:28:33 -0700 (PDT)
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
Subject: [PATCH 02/16] mm: vmstat: use s32 for vm_node_stat_diff in struct per_cpu_nodestat
Date:   Thu, 17 Oct 2019 17:28:06 -0700
Message-ID: <20191018002820.307763-3-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191018002820.307763-1-guro@fb.com>
References: <20191018002820.307763-1-guro@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-17_07:2019-10-17,2019-10-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 mlxscore=0
 clxscore=1015 phishscore=0 suspectscore=1 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1910180001
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently s8 type is used for per-cpu caching of per-node statistics.
It works fine because the overfill threshold can't exceed 125.

But if some counters are in bytes (and the next commit in the series
will convert slab counters to bytes), it's not gonna work:
value in bytes can easily exceed s8 without exceeding the threshold
converted to bytes. So to avoid overfilling per-cpu caches and breaking
vmstats correctness, let's use s32 instead.

This doesn't affect per-zone statistics. There are no plans to use
zone-level byte-sized counters, so no reasons to change anything.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 include/linux/mmzone.h |  2 +-
 mm/vmstat.c            | 16 ++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index d4ca03b93373..4d8adaa5d59c 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -353,7 +353,7 @@ struct per_cpu_pageset {
 
 struct per_cpu_nodestat {
 	s8 stat_threshold;
-	s8 vm_node_stat_diff[NR_VM_NODE_STAT_ITEMS];
+	s32 vm_node_stat_diff[NR_VM_NODE_STAT_ITEMS];
 };
 
 #endif /* !__GENERATING_BOUNDS.H */
diff --git a/mm/vmstat.c b/mm/vmstat.c
index b2fd344d2fcf..3375e7f45891 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -337,7 +337,7 @@ void __mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
 				long delta)
 {
 	struct per_cpu_nodestat __percpu *pcp = pgdat->per_cpu_nodestats;
-	s8 __percpu *p = pcp->vm_node_stat_diff + item;
+	s32 __percpu *p = pcp->vm_node_stat_diff + item;
 	long x;
 	long t;
 
@@ -395,13 +395,13 @@ void __inc_zone_state(struct zone *zone, enum zone_stat_item item)
 void __inc_node_state(struct pglist_data *pgdat, enum node_stat_item item)
 {
 	struct per_cpu_nodestat __percpu *pcp = pgdat->per_cpu_nodestats;
-	s8 __percpu *p = pcp->vm_node_stat_diff + item;
-	s8 v, t;
+	s32 __percpu *p = pcp->vm_node_stat_diff + item;
+	s32 v, t;
 
 	v = __this_cpu_inc_return(*p);
 	t = __this_cpu_read(pcp->stat_threshold);
 	if (unlikely(v > t)) {
-		s8 overstep = t >> 1;
+		s32 overstep = t >> 1;
 
 		node_page_state_add(v + overstep, pgdat, item);
 		__this_cpu_write(*p, -overstep);
@@ -439,13 +439,13 @@ void __dec_zone_state(struct zone *zone, enum zone_stat_item item)
 void __dec_node_state(struct pglist_data *pgdat, enum node_stat_item item)
 {
 	struct per_cpu_nodestat __percpu *pcp = pgdat->per_cpu_nodestats;
-	s8 __percpu *p = pcp->vm_node_stat_diff + item;
-	s8 v, t;
+	s32 __percpu *p = pcp->vm_node_stat_diff + item;
+	s32 v, t;
 
 	v = __this_cpu_dec_return(*p);
 	t = __this_cpu_read(pcp->stat_threshold);
 	if (unlikely(v < - t)) {
-		s8 overstep = t >> 1;
+		s32 overstep = t >> 1;
 
 		node_page_state_add(v - overstep, pgdat, item);
 		__this_cpu_write(*p, overstep);
@@ -538,7 +538,7 @@ static inline void mod_node_state(struct pglist_data *pgdat,
        enum node_stat_item item, int delta, int overstep_mode)
 {
 	struct per_cpu_nodestat __percpu *pcp = pgdat->per_cpu_nodestats;
-	s8 __percpu *p = pcp->vm_node_stat_diff + item;
+	s32 __percpu *p = pcp->vm_node_stat_diff + item;
 	long o, n, t, z;
 
 	do {
-- 
2.21.0

