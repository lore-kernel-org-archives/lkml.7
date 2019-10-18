Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BF9CA9EB3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6814D21852
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="a0Ye3dCf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408121AbfJRA2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 20:28:55 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53396 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407073AbfJRA2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 20:28:46 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9I0SS6r006818
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 17:28:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=XjP6Hsf0nCO9KA2kBEt8lNgVHBpEkM8eL2jAQ11uV7M=;
 b=a0Ye3dCf0syr/dxXLC3ywDL2waIFIb3ACX1tW45HtrO/O1pE35hQCn1Pvmxbo4sSyxSk
 Rd5nDaGFIE8CyICmU6iDcZ6cUuQqJEehKzEFbZMZNgYqLYqY6umZ56Es0mOzR10ZfVxe
 9bu7hJEz9+T7ZL85gWrV/DNEQXGL2vg026s= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vpsd6atu7-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 17:28:45 -0700
Received: from 2401:db00:12:9028:face:0:29:0 (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 17 Oct 2019 17:28:35 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id EF6B718CE847D; Thu, 17 Oct 2019 17:28:33 -0700 (PDT)
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
Subject: [PATCH 05/16] mm: slub: implement SLUB version of obj_to_index()
Date:   Thu, 17 Oct 2019 17:28:09 -0700
Message-ID: <20191018002820.307763-6-guro@fb.com>
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
 lowpriorityscore=0 mlxlogscore=872 impostorscore=0 mlxscore=0
 clxscore=1015 phishscore=0 suspectscore=3 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1910180001
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit implements SLUB version of the obj_to_index() function,
which will be required to calculate the offset of memcg_ptr in the
mem_cgroup_vec to store/obtain the memcg ownership data.

To make it faster, let's repeat the SLAB's trick introduced by
commit 6a2d7a955d8d ("[PATCH] SLAB: use a multiply instead of a
divide in obj_to_index()") and avoid an expensive division.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 include/linux/slub_def.h | 9 +++++++++
 mm/slub.c                | 1 +
 2 files changed, 10 insertions(+)

diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
index d2153789bd9f..200ea292f250 100644
--- a/include/linux/slub_def.h
+++ b/include/linux/slub_def.h
@@ -8,6 +8,7 @@
  * (C) 2007 SGI, Christoph Lameter
  */
 #include <linux/kobject.h>
+#include <linux/reciprocal_div.h>
 
 enum stat_item {
 	ALLOC_FASTPATH,		/* Allocation from cpu slab */
@@ -86,6 +87,7 @@ struct kmem_cache {
 	unsigned long min_partial;
 	unsigned int size;	/* The size of an object including metadata */
 	unsigned int object_size;/* The size of an object without metadata */
+	struct reciprocal_value reciprocal_size;
 	unsigned int offset;	/* Free pointer offset */
 #ifdef CONFIG_SLUB_CPU_PARTIAL
 	/* Number of per cpu partial objects to keep around */
@@ -182,4 +184,11 @@ static inline void *nearest_obj(struct kmem_cache *cache, struct page *page,
 	return result;
 }
 
+static inline unsigned int obj_to_index(const struct kmem_cache *cache,
+					const struct page *page, void *obj)
+{
+	return reciprocal_divide(kasan_reset_tag(obj) - page_address(page),
+				 cache->reciprocal_size);
+}
+
 #endif /* _LINUX_SLUB_DEF_H */
diff --git a/mm/slub.c b/mm/slub.c
index e810582f5b86..557ea45a5d75 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3600,6 +3600,7 @@ static int calculate_sizes(struct kmem_cache *s, int forced_order)
 	 */
 	size = ALIGN(size, s->align);
 	s->size = size;
+	s->reciprocal_size = reciprocal_value(size);
 	if (forced_order >= 0)
 		order = forced_order;
 	else
-- 
2.21.0

