Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8286FC48BE8
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 02:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C34220674
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 02:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="N+TLmvmb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfFXCa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 22:30:58 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:63420 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727095AbfFXCa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 22:30:57 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5O2TsmI019090
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2019 19:30:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=bpILMdP2uBYpNaxU5hQBPe9bYg5iEeP0N6JPrK/Suf4=;
 b=N+TLmvmbpp7d3MgSj0rYFpGOd5VNGfg+7XMXrub4SvwIdvKToaOzdxqPcKY9L5ccZIWj
 vqmg/ubcQaz5hPx8Omte5oBMVAxlJJHlBtn/mP0dLGXOgVZuAkZekKCDfdW/gEjuzKPQ
 YipN0rsHwjOIoXFKz5h2McnsFuj2nUW+idM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2t9hubvb1y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2019 19:30:56 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 23 Jun 2019 19:30:55 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 7C8D6139E9C20; Sun, 23 Jun 2019 19:30:53 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Tejun Heo <tj@kernel.org>, <bpf@vger.kernel.org>
CC:     <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next] bpf: fix cgroup bpf release synchronization
Date:   Sun, 23 Jun 2019 19:30:51 -0700
Message-ID: <20190624023051.4168487-1-guro@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-24_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=876 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906240019
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 4bfc0bb2c60e ("bpf: decouple the lifetime of cgroup_bpf
from cgroup itself"), cgroup_bpf release occurs asynchronously
(from a worker context), and before the release of the cgroup itself.

This introduced a previously non-existing race between the release
and update paths. E.g. if a leaf's cgroup_bpf is released and a new
bpf program is attached to the one of ancestor cgroups at the same
time. The race may result in double-free and other memory corruptions.

To fix the problem, let's protect the body of cgroup_bpf_release()
with cgroup_mutex, as it was effectively previously, when all this
code was called from the cgroup release path with cgroup mutex held.

Also make sure, that we don't leave already freed pointers to the
effective prog arrays. Otherwise, they can be released again by
the update path. It wasn't necessary before, because previously
the update path couldn't see such a cgroup, as cgroup_bpf and cgroup
itself were released together.

Big thanks for Tejun Heo for discovering and debugging of this
problem!

Fixes: 4bfc0bb2c60e ("bpf: decouple the lifetime of cgroup_bpf from
cgroup itself")
Reported-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Roman Gushchin <guro@fb.com>
---
 kernel/bpf/cgroup.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 1b65ab0df457..3128770c0f47 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -19,6 +19,8 @@
 #include <linux/bpf-cgroup.h>
 #include <net/sock.h>
 
+#include "../cgroup/cgroup-internal.h"
+
 DEFINE_STATIC_KEY_FALSE(cgroup_bpf_enabled_key);
 EXPORT_SYMBOL(cgroup_bpf_enabled_key);
 
@@ -41,6 +43,8 @@ static void cgroup_bpf_release(struct work_struct *work)
 	struct bpf_prog_array *old_array;
 	unsigned int type;
 
+	mutex_lock(&cgroup_mutex);
+
 	for (type = 0; type < ARRAY_SIZE(cgrp->bpf.progs); type++) {
 		struct list_head *progs = &cgrp->bpf.progs[type];
 		struct bpf_prog_list *pl, *tmp;
@@ -57,10 +61,13 @@ static void cgroup_bpf_release(struct work_struct *work)
 		}
 		old_array = rcu_dereference_protected(
 				cgrp->bpf.effective[type],
-				percpu_ref_is_dying(&cgrp->bpf.refcnt));
+				lockdep_is_held(&cgroup_mutex));
+		RCU_INIT_POINTER(cgrp->bpf.effective[type], NULL);
 		bpf_prog_array_free(old_array);
 	}
 
+	mutex_unlock(&cgroup_mutex);
+
 	percpu_ref_exit(&cgrp->bpf.refcnt);
 	cgroup_put(cgrp);
 }
-- 
2.21.0

