Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E3CFC6194
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 22:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF1C217D7
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 22:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="UWC9KHaE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732835AbfKFWwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 17:52:49 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:7648 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727815AbfKFWvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 17:51:47 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA6MmG0F020832
        for <linux-kernel@vger.kernel.org>; Wed, 6 Nov 2019 14:51:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=b0a5BpouPO7gAbWCAkVMisyIA5YcsFbBQ4BU5Ai03bM=;
 b=UWC9KHaEbkVNUgaOoSvyamwSww4roUVDbdPbnYQhZxJ7ke8Sipknv7Bzpb70NkOa250y
 vx2vnKWmC31tAjS4mXDvVo7DrSWpJoKmDiTsG016ZvPhCG+/JJuY8HUc2d9AbGkrw6Uv
 TPh1fqXjxmk9UJWlYzacTYonZu2bTOj+Wis= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2w41vxssww-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 14:51:47 -0800
Received: from 2401:db00:30:6012:face:0:17:0 (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Wed, 6 Nov 2019 14:51:45 -0800
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 60B3D19E16A83; Wed,  6 Nov 2019 14:51:44 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>
CC:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>, <stable@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH 2/2] mm: hugetlb: switch to css_tryget() in hugetlb_cgroup_charge_cgroup()
Date:   Wed, 6 Nov 2019 14:51:31 -0800
Message-ID: <20191106225131.3543616-2-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191106225131.3543616-1-guro@fb.com>
References: <20191106225131.3543616-1-guro@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-06_08:2019-11-06,2019-11-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0 mlxlogscore=752
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911060219
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An exiting task might belong to an offline cgroup. In this case
an attempt to grab a cgroup reference from the task can end up
with an infinite loop in hugetlb_cgroup_charge_cgroup(), because
neither the cgroup will become online, neither the task will
be migrated to a live cgroup.

Fix this by switching over to css_tryget(). As css_tryget_online()
can't guarantee that the cgroup won't go offline, in most cases
the check doesn't make sense. In this particular case users of
hugetlb_cgroup_charge_cgroup() are not affected by this change.

A similar problem is described by commit 18fa84a2db0e ("cgroup: Use
css_tryget() instead of css_tryget_online() in task_get_css()").

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>
---
 mm/hugetlb_cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index f1930fa0b445..2ac38bdc18a1 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -196,7 +196,7 @@ int hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
 again:
 	rcu_read_lock();
 	h_cg = hugetlb_cgroup_from_task(current);
-	if (!css_tryget_online(&h_cg->css)) {
+	if (!css_tryget(&h_cg->css)) {
 		rcu_read_unlock();
 		goto again;
 	}
-- 
2.17.1

