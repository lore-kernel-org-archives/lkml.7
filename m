Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3532FC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F29CE20674
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zHZtVFnZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfDBVAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 17:00:34 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56180 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfDBVAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 17:00:34 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x32Kd5We164028;
        Tue, 2 Apr 2019 20:44:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=S3/NdFYbeXH44L9JBwqlhAYuzDTUjFxD7HwZ/en50So=;
 b=zHZtVFnZgKoe6ZZd0qgP5F20qgLYeOWz6WFuuVG1k0+N66MfV1nudJiuz+2DI13M9n+/
 o8CI9whu2KiVn5rsBvVo65JdlCfmh/T4jcsa/xM75AbqoeT7a4yrN2L2Bng8UYCQ6a2H
 De5IK40aPpSq6rT8IeBkUYHuDbtluEkDJy2L7Dltwn9fOJZ6KxL0Rk012ZdOtvzjspr1
 ZzGaDPdeUr4ec142YXkU37CGcy1HoStLQN7kJRtmodw6pDGhK5iwrUlP8utTFopsOkcs
 B4H4S1vHoByx7sZUZwJ2bDnQ8wcEYq95jACbPC/r64EKK7ZZzW4zat4swwLjYtWQhc+g bA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2rj0dnm0bj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Apr 2019 20:44:21 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x32KfGOl064850;
        Tue, 2 Apr 2019 20:42:21 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2rm8f4yjyv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Apr 2019 20:42:20 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x32KgJlj031428;
        Tue, 2 Apr 2019 20:42:19 GMT
Received: from localhost.localdomain (/73.60.114.248)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 02 Apr 2019 13:42:19 -0700
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     akpm@linux-foundation.org
Cc:     daniel.m.jordan@oracle.com, Alexey Kardashevskiy <aik@ozlabs.ru>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Davidlohr Bueso <dave@stgolabs.net>, linux-mm@kvack.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] vfio/spapr_tce: drop mmap_sem now that locked_vm is atomic
Date:   Tue,  2 Apr 2019 16:41:55 -0400
Message-Id: <20190402204158.27582-4-daniel.m.jordan@oracle.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190402204158.27582-1-daniel.m.jordan@oracle.com>
References: <20190402204158.27582-1-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9215 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=29 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904020138
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9215 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=29 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904020138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With locked_vm now an atomic, there is no need to take mmap_sem as
writer.  Delete and refactor accordingly.

Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: <linux-mm@kvack.org>
Cc: <kvm@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
---
 drivers/vfio/vfio_iommu_spapr_tce.c | 36 ++++++++++++-----------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index e7d787e5d839..7675a3b28410 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -36,8 +36,9 @@ static void tce_iommu_detach_group(void *iommu_data,
 
 static long try_increment_locked_vm(struct mm_struct *mm, long npages)
 {
-	long ret = 0, lock_limit;
+	long ret = 0;
 	s64 locked;
+	unsigned long lock_limit;
 
 	if (WARN_ON_ONCE(!mm))
 		return -EPERM;
@@ -45,39 +46,32 @@ static long try_increment_locked_vm(struct mm_struct *mm, long npages)
 	if (!npages)
 		return 0;
 
-	down_write(&mm->mmap_sem);
-	locked = atomic64_read(&mm->locked_vm) + npages;
+	locked = atomic64_add_return(npages, &mm->locked_vm);
 	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
-	if (locked > lock_limit && !capable(CAP_IPC_LOCK))
+	if (locked > lock_limit && !capable(CAP_IPC_LOCK)) {
 		ret = -ENOMEM;
-	else
-		atomic64_add(npages, &mm->locked_vm);
-
-	pr_debug("[%d] RLIMIT_MEMLOCK +%ld %ld/%ld%s\n", current->pid,
-			npages << PAGE_SHIFT,
-			atomic64_read(&mm->locked_vm) << PAGE_SHIFT,
-			rlimit(RLIMIT_MEMLOCK),
-			ret ? " - exceeded" : "");
+		atomic64_sub(npages, &mm->locked_vm);
+	}
 
-	up_write(&mm->mmap_sem);
+	pr_debug("[%d] RLIMIT_MEMLOCK +%ld %lld/%lu%s\n", current->pid,
+			npages << PAGE_SHIFT, locked << PAGE_SHIFT,
+			lock_limit, ret ? " - exceeded" : "");
 
 	return ret;
 }
 
 static void decrement_locked_vm(struct mm_struct *mm, long npages)
 {
+	s64 locked;
+
 	if (!mm || !npages)
 		return;
 
-	down_write(&mm->mmap_sem);
-	if (WARN_ON_ONCE(npages > atomic64_read(&mm->locked_vm)))
-		npages = atomic64_read(&mm->locked_vm);
-	atomic64_sub(npages, &mm->locked_vm);
-	pr_debug("[%d] RLIMIT_MEMLOCK -%ld %ld/%ld\n", current->pid,
-			npages << PAGE_SHIFT,
-			atomic64_read(&mm->locked_vm) << PAGE_SHIFT,
+	locked = atomic64_sub_return(npages, &mm->locked_vm);
+	WARN_ON_ONCE(locked < 0);
+	pr_debug("[%d] RLIMIT_MEMLOCK -%ld %lld/%lu\n", current->pid,
+			npages << PAGE_SHIFT, locked << PAGE_SHIFT,
 			rlimit(RLIMIT_MEMLOCK));
-	up_write(&mm->mmap_sem);
 }
 
 /*
-- 
2.21.0

