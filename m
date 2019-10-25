Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412D8CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 23:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1455421872
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 23:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="WqnNccPH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbfJYX2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 19:28:37 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:19410 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725847AbfJYX2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 19:28:36 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9PNNu5W012210
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 16:28:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=ZG/Rp0U9V1GZOvfP/+5tTW4GxOxccc3k62QOVqXPKFw=;
 b=WqnNccPHtxf/h2T43Jhgq/aMjlDc8eyeqXajd6mZqGvxeNk/wHtUIYP99KYCMc9dE7ye
 qlUZT7/cKlbgZnJlEj1UlCkniS7ZJXbVzHILjKw5FoQtwaBiC7+VI8DDz6rp1k36Y9vC
 AEHNNYpHSrtnNkfaalyYCKGwk8BhzxCpPng= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vv7ah8w71-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 16:28:35 -0700
Received: from 2401:db00:30:6007:face:0:1:0 (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 25 Oct 2019 16:28:34 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 89D70192BA24C; Fri, 25 Oct 2019 16:28:31 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     <linux-mm@kvack.org>
CC:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH] mm: slab: make page_cgroup_ino() to recognize non-compound slab pages properly
Date:   Fri, 25 Oct 2019 16:27:10 -0700
Message-ID: <20191025232710.4081957-1-guro@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-25_11:2019-10-25,2019-10-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 spamscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 impostorscore=0 suspectscore=1
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910250215
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

page_cgroup_ino() doesn't return a valid memcg pointer for non-compund
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
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Shakeel Butt <shakeelb@google.com>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
2.17.1

