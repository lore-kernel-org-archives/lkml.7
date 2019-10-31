Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD35CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 01:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAF3F20659
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 01:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="IXQH4Gd1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfJaBWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 21:22:02 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54472 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725867AbfJaBWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 21:22:02 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9V1DmsM022161
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 18:22:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=CV4Ax6uE22QPaR0xNwsjh/6y9+9ZiGdXaF/PQy3OPVA=;
 b=IXQH4Gd1sSvX7kK49VJTnR3X0k1v5c6CsxBTdgqd9U2rCYByoPk6KLjusb1stbEKZIdb
 1AVy+CuFKv0WOhrK8Ui41LnF/JN5Oi1y231UCRZHIcEh5t9RY21G7jQPj9xQxTgavi1Y
 JuKcZlsnRXMLB23K+dHuY+5z3o10lHo3rSM= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2vybrebb1t-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 18:22:01 -0700
Received: from 2401:db00:30:600c:face:0:1f:0 (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Wed, 30 Oct 2019 18:21:52 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 6178E1960A610; Wed, 30 Oct 2019 18:21:52 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>
CC:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v2] mm: slab: make page_cgroup_ino() to recognize non-compound slab pages properly
Date:   Wed, 30 Oct 2019 18:21:51 -0700
Message-ID: <20191031012151.2722280-1-guro@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-30_10:2019-10-30,2019-10-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 mlxscore=0 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910310009
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

page_cgroup_ino() doesn't return a valid memcg pointer for non-compound
slab pages, because it depends on PgHead AND PgSlab flags to be set
to determine the memory cgroup from the kmem_cache.
It's correct for compound pages, but not for generic small pages. Those
don't have PgHead set, so it ends up returning zero.

Fix this by replacing the condition to PageSlab() && !PageTail().

Before this patch:
[root@localhost ~]# ./page-types -c /sys/fs/cgroup/user.slice/user-0.slice/user@0.service/ | grep slab
0x0000000000000080	        38        0  _______S___________________________________	slab

After this patch:
[root@localhost ~]# ./page-types -c /sys/fs/cgroup/user.slice/user-0.slice/user@0.service/ | grep slab
0x0000000000000080	       147        0  _______S___________________________________	slab

Fixes: 4d96ba353075 ("mm: memcg/slab: stop setting page->mem_cgroup pointer for slab pages")
Signed-off-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
---
 mm/memcontrol.c | 2 +-
 mm/slab.h       | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ea085877c548..00b4188b1bed 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -476,7 +476,7 @@ ino_t page_cgroup_ino(struct page *page)
 	unsigned long ino = 0;
 
 	rcu_read_lock();
-	if (PageHead(page) && PageSlab(page))
+	if (PageSlab(page) && !PageTail(page))
 		memcg = memcg_from_slab_page(page);
 	else
 		memcg = READ_ONCE(page->mem_cgroup);
diff --git a/mm/slab.h b/mm/slab.h
index 3eb29ae75743..8b77f973a6ab 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -323,8 +323,8 @@ static inline struct kmem_cache *memcg_root_cache(struct kmem_cache *s)
  * Expects a pointer to a slab page. Please note, that PageSlab() check
  * isn't sufficient, as it returns true also for tail compound slab pages,
  * which do not have slab_cache pointer set.
- * So this function assumes that the page can pass PageHead() and PageSlab()
- * checks.
+ * So this function assumes that the page can pass PageSlab() && !PageTail()
+ * check.
  *
  * The kmem_cache can be reparented asynchronously. The caller must ensure
  * the memcg lifetime, e.g. by taking rcu_read_lock() or cgroup_mutex.
-- 
2.17.1

