Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10ADDC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 21:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6EB9208E4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 21:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="e7lptsGC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730453AbfIDVqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 17:46:32 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:22900 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729626AbfIDVqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 17:46:31 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x84LPGfi031095
        for <linux-kernel@vger.kernel.org>; Wed, 4 Sep 2019 14:46:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=TzE5W3eqTtOsBBkx638/fn6BtEgf/jR//x4WCHCokyg=;
 b=e7lptsGC+xk7s4mZ/XfItQBSyUjAkMuS2x55u7xlArSsMZhmxlC5Wag14VsSO+9BOt7R
 k3O3kZ+SSZksz8Gs0AYBMZMwhY3ySVVgYU37edANIM1L3KtwGUnCxYU5NOt2FRgI+KB7
 D4If0vfRTFJVlWhqU399XamUXfoMRSqs1Yo= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2utkkpgqb8-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 14:46:27 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Wed, 4 Sep 2019 14:46:27 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 75DBD62E2A5C; Wed,  4 Sep 2019 14:46:24 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>
CC:     <kernel-team@fb.com>, Song Liu <songliubraving@fb.com>,
        Jie Meng <jmeng@fb.com>, Peter Zijlstra <peterz@infradead.org>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH] perf: rework memory accounting in perf_mmap()
Date:   Wed, 4 Sep 2019 14:46:18 -0700
Message-ID: <20190904214618.3795672-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-04_05:2019-09-04,2019-09-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 adultscore=0 mlxlogscore=868 phishscore=0
 clxscore=1015 suspectscore=3 impostorscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1906280000 definitions=main-1909040210
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf_mmap() always increases user->locked_vm. As a result, "extra" could
grow bigger than "user_extra", which doesn't make sense. Here is an
example case:

Note: Assume "user_lock_limit" is very small.
| # of perf_mmap calls |vma->vm_mm->pinned_vm|user->locked_vm|
| 0                    | 0                   | 0             |
| 1                    | user_extra          | user_extra    |
| 2                    | 3 * user_extra      | 2 * user_extra|
| 3                    | 6 * user_extra      | 3 * user_extra|
| 4                    | 10 * user_extra     | 4 * user_extra|

Fix this by maintaining proper user_extra and extra.

Reported-by: Hechao Li <hechaol@fb.com>
Cc: Jie Meng <jmeng@fb.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 kernel/events/core.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 0463c1151bae..a0120bdbce17 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5585,7 +5585,8 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 	 * undo the VM accounting.
 	 */
 
-	atomic_long_sub((size >> PAGE_SHIFT) + 1, &mmap_user->locked_vm);
+	atomic_long_sub((size >> PAGE_SHIFT) + 1 - mmap_locked,
+			&mmap_user->locked_vm);
 	atomic64_sub(mmap_locked, &vma->vm_mm->pinned_vm);
 	free_uid(mmap_user);
 
@@ -5729,8 +5730,20 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 
 	user_locked = atomic_long_read(&user->locked_vm) + user_extra;
 
-	if (user_locked > user_lock_limit)
+	if (user_locked <= user_lock_limit) {
+		/* charge all to locked_vm */
+	} else if (atomic_long_read(&user->locked_vm) >= user_lock_limit) {
+		/* charge all to pinned_vm */
+		extra = user_extra;
+		user_extra = 0;
+	} else {
+		/*
+		 * charge locked_vm until it hits user_lock_limit;
+		 * charge the rest from pinned_vm
+		 */
 		extra = user_locked - user_lock_limit;
+		user_extra -= extra;
+	}
 
 	lock_limit = rlimit(RLIMIT_MEMLOCK);
 	lock_limit >>= PAGE_SHIFT;
-- 
2.17.1

