Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FEC3CA9EB3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4360821D7D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="jC/28qs+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504016AbfJRA3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 20:29:35 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60300 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406860AbfJRA2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 20:28:39 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9I0OM34013489
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 17:28:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=60IWhRr3yus20Qr3RXUIWm4DFv2NBY+p0fIoG5TahZs=;
 b=jC/28qs+RLG9bX6pwPbX7DBL9H6RNFtHs/A4TF2VpB2254sqm0+RrIApA+FS031Bqi0G
 XhQZXKgjmnZuYpv/9s2TwaT/eZLhpd1NlxnWOScGOnhDgBV2fDjdRYBgJqUbTwOjSK+y
 Yysjovi72pPzcRtMebRi4TNac7OGy5ZafRo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vpufxt2ku-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 17:28:38 -0700
Received: from 2401:db00:12:9028:face:0:29:0 (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 17 Oct 2019 17:28:35 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 0CE3618CE8487; Thu, 17 Oct 2019 17:28:34 -0700 (PDT)
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
Subject: [PATCH 10/16] mm: memcg: move get_mem_cgroup_from_current() to memcontrol.h
Date:   Thu, 17 Oct 2019 17:28:14 -0700
Message-ID: <20191018002820.307763-11-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191018002820.307763-1-guro@fb.com>
References: <20191018002820.307763-1-guro@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-17_07:2019-10-17,2019-10-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=1 clxscore=1015 bulkscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910180001
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move get_mem_cgroup_from_current() to memcontrol.h to make it
available for use outside of the memcontrol.c. The function is
small and marked as __always_inline, so it's better to place
it into memcontrol.h.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 include/linux/memcontrol.h | 17 +++++++++++++++++
 mm/memcontrol.c            | 17 -----------------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index bf1fcf85abd8..a75980559a47 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -453,6 +453,23 @@ struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm);
 
 struct mem_cgroup *get_mem_cgroup_from_page(struct page *page);
 
+/**
+ * If current->active_memcg is non-NULL, do not fallback to current->mm->memcg.
+ */
+static __always_inline struct mem_cgroup *get_mem_cgroup_from_current(void)
+{
+	if (unlikely(current->active_memcg)) {
+		struct mem_cgroup *memcg = root_mem_cgroup;
+
+		rcu_read_lock();
+		if (css_tryget_online(&current->active_memcg->css))
+			memcg = current->active_memcg;
+		rcu_read_unlock();
+		return memcg;
+	}
+	return get_mem_cgroup_from_mm(current->mm);
+}
+
 static inline
 struct mem_cgroup *mem_cgroup_from_css(struct cgroup_subsys_state *css){
 	return css ? container_of(css, struct mem_cgroup, css) : NULL;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ebaa4ff36e0c..8a753a336efd 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1074,23 +1074,6 @@ struct mem_cgroup *get_mem_cgroup_from_page(struct page *page)
 }
 EXPORT_SYMBOL(get_mem_cgroup_from_page);
 
-/**
- * If current->active_memcg is non-NULL, do not fallback to current->mm->memcg.
- */
-static __always_inline struct mem_cgroup *get_mem_cgroup_from_current(void)
-{
-	if (unlikely(current->active_memcg)) {
-		struct mem_cgroup *memcg = root_mem_cgroup;
-
-		rcu_read_lock();
-		if (css_tryget_online(&current->active_memcg->css))
-			memcg = current->active_memcg;
-		rcu_read_unlock();
-		return memcg;
-	}
-	return get_mem_cgroup_from_mm(current->mm);
-}
-
 /**
  * mem_cgroup_iter - iterate over memory cgroup hierarchy
  * @root: hierarchy root
-- 
2.21.0

