Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C475AC32753
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 19:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 985C9216C8
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 19:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="dj10JLqr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404389AbfHBTWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 15:22:55 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:28822 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2403874AbfHBTWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 15:22:54 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x72JJqFm022956
        for <linux-kernel@vger.kernel.org>; Fri, 2 Aug 2019 12:22:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=19Ja20qRJPcfJ8p53GQiWI0ZYQb3kQ8wKj9C14D15zo=;
 b=dj10JLqr4TfBGwCeyDo/3BMpKggBGMOPO+uvDx1zGiGrxvKvORY5RcF/eebwabL4khdX
 KUGZg43cUkrqp0VajwiIkwPNtKUFyyRNgJ9kfnis1SdSSRq4mUVLf09M9lo8sKdw0CIB
 019IhIbD7iDU9LacYmcloNto77/2U8Abrdo= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2u4s2tgj9n-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 12:22:53 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 2 Aug 2019 12:22:51 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 6989B153186A0; Fri,  2 Aug 2019 12:22:47 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Hillf Danton <hdanton@sina.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v2] mm: memcontrol: switch to rcu protection in drain_all_stock()
Date:   Fri, 2 Aug 2019 12:22:41 -0700
Message-ID: <20190802192241.3253165-1-guro@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-02_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=915 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908020203
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 72f0184c8a00 ("mm, memcg: remove hotplug locking from try_charge")
introduced css_tryget()/css_put() calls in drain_all_stock(),
which are supposed to protect the target memory cgroup from being
released during the mem_cgroup_is_descendant() call.

However, it's not completely safe. In theory, memcg can go away
between reading stock->cached pointer and calling css_tryget().

This can happen if drain_all_stock() races with drain_local_stock()
performed on the remote cpu as a result of a work, scheduled
by the previous invocation of drain_all_stock().

The race is a bit theoretical and there are few chances to trigger
it, but the current code looks a bit confusing, so it makes sense
to fix it anyway. The code looks like as if css_tryget() and
css_put() are used to protect stocks drainage. It's not necessary
because stocked pages are holding references to the cached cgroup.
And it obviously won't work for works, scheduled on other cpus.

So, let's read the stock->cached pointer and evaluate the memory
cgroup inside a rcu read section, and get rid of
css_tryget()/css_put() calls.

v2: added some explanations to the commit message, no code changes

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Hillf Danton <hdanton@sina.com>
---
 mm/memcontrol.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5c7b9facb0eb..d856b64426b7 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2235,21 +2235,22 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
 	for_each_online_cpu(cpu) {
 		struct memcg_stock_pcp *stock = &per_cpu(memcg_stock, cpu);
 		struct mem_cgroup *memcg;
+		bool flush = false;
 
+		rcu_read_lock();
 		memcg = stock->cached;
-		if (!memcg || !stock->nr_pages || !css_tryget(&memcg->css))
-			continue;
-		if (!mem_cgroup_is_descendant(memcg, root_memcg)) {
-			css_put(&memcg->css);
-			continue;
-		}
-		if (!test_and_set_bit(FLUSHING_CACHED_CHARGE, &stock->flags)) {
+		if (memcg && stock->nr_pages &&
+		    mem_cgroup_is_descendant(memcg, root_memcg))
+			flush = true;
+		rcu_read_unlock();
+
+		if (flush &&
+		    !test_and_set_bit(FLUSHING_CACHED_CHARGE, &stock->flags)) {
 			if (cpu == curcpu)
 				drain_local_stock(&stock->work);
 			else
 				schedule_work_on(cpu, &stock->work);
 		}
-		css_put(&memcg->css);
 	}
 	put_cpu();
 	mutex_unlock(&percpu_charge_mutex);
-- 
2.21.0

