Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A40FC28D18
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 02:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D5620851
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 02:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ZH2TXFP5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfFECpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 22:45:07 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46404 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726536AbfFECpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 22:45:03 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x552hZua009253
        for <linux-kernel@vger.kernel.org>; Tue, 4 Jun 2019 19:45:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=nRQ8E2xsdPMn6A3dTdY86dEXrfQWn/mxew8g7sZDO2Y=;
 b=ZH2TXFP5HplCQcFb8fKTo705zDaomejANIkeVDEfi+eT9bkz/E/mo6EKWMQJWSm56Wop
 t6J0TxVTU+IuYGg522NC14setthkTEunGANNRnhXr+tpOQCz+p96U+h/61T3qcq7ATFn
 yhr6xk7Vm4ohJ6zLtKK9Z41q5ZPwiRPycHg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2sx0j78sds-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 19:45:02 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 4 Jun 2019 19:45:00 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 7928012C7FDC2; Tue,  4 Jun 2019 19:44:58 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>, Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v6 01/10] mm: add missing smp read barrier on getting memcg kmem_cache pointer
Date:   Tue, 4 Jun 2019 19:44:45 -0700
Message-ID: <20190605024454.1393507-2-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190605024454.1393507-1-guro@fb.com>
References: <20190605024454.1393507-1-guro@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-05_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906050015
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes noticed that reading the memcg kmem_cache pointer in
cache_from_memcg_idx() is performed using READ_ONCE() macro,
which doesn't implement a SMP barrier, which is required
by the logic.

Add a proper smp_rmb() to be paired with smp_wmb() in
memcg_create_kmem_cache().

The same applies to memcg_create_kmem_cache() itself,
which reads the same value without barriers and READ_ONCE().

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Roman Gushchin <guro@fb.com>
---
 mm/slab.h        | 1 +
 mm/slab_common.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/slab.h b/mm/slab.h
index 739099af6cbb..1176b61bb8fc 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -260,6 +260,7 @@ cache_from_memcg_idx(struct kmem_cache *s, int idx)
 	 * memcg_caches issues a write barrier to match this (see
 	 * memcg_create_kmem_cache()).
 	 */
+	smp_rmb();
 	cachep = READ_ONCE(arr->entries[idx]);
 	rcu_read_unlock();
 
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 58251ba63e4a..8092bdfc05d5 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -652,7 +652,8 @@ void memcg_create_kmem_cache(struct mem_cgroup *memcg,
 	 * allocation (see memcg_kmem_get_cache()), several threads can try to
 	 * create the same cache, but only one of them may succeed.
 	 */
-	if (arr->entries[idx])
+	smp_rmb();
+	if (READ_ONCE(arr->entries[idx]))
 		goto out_unlock;
 
 	cgroup_name(css->cgroup, memcg_name_buf, sizeof(memcg_name_buf));
-- 
2.20.1

