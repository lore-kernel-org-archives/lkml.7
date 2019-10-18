Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB6ACA9ECC
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17B0821D7D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="TCsA+F1Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438052AbfJRA2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 20:28:48 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:38490 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406862AbfJRA2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 20:28:40 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9I0Nd6o008603
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 17:28:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=Qs1RRBJ36X/lNHlDnmRHWqTueV2yUJoMy2nQbVSGZMo=;
 b=TCsA+F1YHYLvNAxWQvYDf1t1dqysl+sA/9t5wF7RXCv2fv/kBt4u6CQonvWTFUaVl9+y
 ABml43luRYZYUeLWTYYj3QrzGeNYg7QTHBwUiJxKVhWEUGMxLdy5G2p01EMgWgjzf79F
 MCTgT+sa6lrXQOGbBGI+0FCHlKmtSDaxGnA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vpw9r9fab-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 17:28:38 -0700
Received: from 2401:db00:30:600c:face:0:1f:0 (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 17 Oct 2019 17:28:35 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 01E5418CE8481; Thu, 17 Oct 2019 17:28:34 -0700 (PDT)
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
Subject: [PATCH 07/16] mm: memcg: move memcg_kmem_bypass() to memcontrol.h
Date:   Thu, 17 Oct 2019 17:28:11 -0700
Message-ID: <20191018002820.307763-8-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191018002820.307763-1-guro@fb.com>
References: <20191018002820.307763-1-guro@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-17_07:2019-10-17,2019-10-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=981
 lowpriorityscore=0 mlxscore=0 suspectscore=1 phishscore=0 clxscore=1015
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910180001
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make the memcg_kmem_bypass() function available outside of
the memcontrol.c, let's move it to memcontrol.h. The function
is small and nicely fits into static inline sort of functions.

It will be used from the slab code.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 include/linux/memcontrol.h | 7 +++++++
 mm/memcontrol.c            | 7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index f4cb844005a5..7a6713dc52ce 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1432,6 +1432,13 @@ static inline bool memcg_kmem_enabled(void)
 	return static_branch_unlikely(&memcg_kmem_enabled_key);
 }
 
+static inline bool memcg_kmem_bypass(void)
+{
+	if (in_interrupt() || !current->mm || (current->flags & PF_KTHREAD))
+		return true;
+	return false;
+}
+
 static inline int memcg_kmem_charge(struct page *page, gfp_t gfp, int order)
 {
 	if (memcg_kmem_enabled())
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 47a30db94869..d9d5f77a783d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3000,13 +3000,6 @@ static void memcg_schedule_kmem_cache_create(struct mem_cgroup *memcg,
 	queue_work(memcg_kmem_cache_wq, &cw->work);
 }
 
-static inline bool memcg_kmem_bypass(void)
-{
-	if (in_interrupt() || !current->mm || (current->flags & PF_KTHREAD))
-		return true;
-	return false;
-}
-
 /**
  * memcg_kmem_get_cache: select the correct per-memcg cache for allocation
  * @cachep: the original global kmem cache
-- 
2.21.0

