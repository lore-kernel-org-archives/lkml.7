Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACCDC33CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 20:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDB2B2072E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 20:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="DxQ4dzrd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730489AbgAIU1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 15:27:34 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52142 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730188AbgAIU1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 15:27:16 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 009KNNxb006695
        for <linux-kernel@vger.kernel.org>; Thu, 9 Jan 2020 12:27:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=kuUSAeYgYvAkfecQDeVMqBlrJe8tNG7qYbaRnRkyKhg=;
 b=DxQ4dzrd4EHOz9vk3HNr+L1fFZs54QSfA4+wB1Quz1hD9h7Zng7U7xlO1tHtXVljI9h/
 ssqy2/x8jR1ZNq8zkzq55kBK8r8c9dMx/Q5ZloQ6vD9sleTFHljTRq0VeJQF8eXG/ONM
 r3ana0gczR13saTZFHU3Aj+/rxbApMKX/aM= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2xe7ub9apk-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 12:27:15 -0800
Received: from intmgw001.06.prn3.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Thu, 9 Jan 2020 12:27:12 -0800
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 29EA11D2F0DC6; Thu,  9 Jan 2020 12:27:07 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>
CC:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v2 2/6] mm: kmem: cleanup memcg_kmem_uncharge_memcg() arguments
Date:   Thu, 9 Jan 2020 12:26:55 -0800
Message-ID: <20200109202659.752357-3-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200109202659.752357-1-guro@fb.com>
References: <20200109202659.752357-1-guro@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-09_04:2020-01-09,2020-01-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=958
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001090168
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the unused page argument and put the memcg pointer at the first
place. This make the function consistent with its peers:
__memcg_kmem_uncharge_memcg(), memcg_kmem_charge_memcg(), etc.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 include/linux/memcontrol.h | 4 ++--
 mm/slab.h                  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index c954209fd685..900a9f884260 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1409,8 +1409,8 @@ static inline int memcg_kmem_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp,
 	return 0;
 }
 
-static inline void memcg_kmem_uncharge_memcg(struct page *page, int order,
-					     struct mem_cgroup *memcg)
+static inline void memcg_kmem_uncharge_memcg(struct mem_cgroup *memcg,
+					     int order)
 {
 	if (memcg_kmem_enabled())
 		__memcg_kmem_uncharge_memcg(memcg, 1 << order);
diff --git a/mm/slab.h b/mm/slab.h
index c4c93e991250..e7da63fb8211 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -395,7 +395,7 @@ static __always_inline void memcg_uncharge_slab(struct page *page, int order,
 	if (likely(!mem_cgroup_is_root(memcg))) {
 		lruvec = mem_cgroup_lruvec(memcg, page_pgdat(page));
 		mod_lruvec_state(lruvec, cache_vmstat_idx(s), -(1 << order));
-		memcg_kmem_uncharge_memcg(page, order, memcg);
+		memcg_kmem_uncharge_memcg(memcg, order);
 	} else {
 		mod_node_page_state(page_pgdat(page), cache_vmstat_idx(s),
 				    -(1 << order));
-- 
2.21.1

