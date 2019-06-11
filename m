Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0473EC31E44
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 23:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3F8D2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 23:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="nGjePryA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408094AbfFKXS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 19:18:59 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50214 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2407991AbfFKXS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 19:18:26 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5BNBnD3008431
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 16:18:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=nplAGvztvw22AKN56QTMhELHdT1v5h5cxoHCBLrrDqI=;
 b=nGjePryAVos7TNaTWm7Id2mKsFVe++WTr9Nx9tvWflQTJRXzdEZ7izOhgXCWOrU/hMd0
 6nQ0ltd9AFZiFoYBID3dSUrtudltOGCtZ5QcdFLz1SG3Fb3izAuKX7H2AHxa0jysu9Yi
 M8M71Rx5vvpj7yVk3ONEglGL1MVrxKcR5iE= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2t2dkmsy3b-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 16:18:25 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Tue, 11 Jun 2019 16:18:21 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 3ED11130CBF71; Tue, 11 Jun 2019 16:18:20 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Waiman Long <longman@redhat.com>, Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v7 06/10] mm: don't check the dying flag on kmem_cache creation
Date:   Tue, 11 Jun 2019 16:18:09 -0700
Message-ID: <20190611231813.3148843-7-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190611231813.3148843-1-guro@fb.com>
References: <20190611231813.3148843-1-guro@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-11_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=780 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906110151
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point in checking the root_cache->memcg_params.dying
flag on kmem_cache creation path. New allocations shouldn't be
performed using a dead root kmem_cache, so no new memcg kmem_cache
creation can be scheduled after the flag is set. And if it was
scheduled before, flush_memcg_workqueue() will wait for it anyway.

So let's drop this check to simplify the code.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 mm/slab_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 5e7638f495d1..9383104651cd 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -640,7 +640,7 @@ void memcg_create_kmem_cache(struct mem_cgroup *memcg,
 	 * The memory cgroup could have been offlined while the cache
 	 * creation work was pending.
 	 */
-	if (memcg->kmem_state != KMEM_ONLINE || root_cache->memcg_params.dying)
+	if (memcg->kmem_state != KMEM_ONLINE)
 		goto out_unlock;
 
 	idx = memcg_cache_id(memcg);
-- 
2.21.0

