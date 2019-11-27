Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E07C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 08:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40DA220674
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 08:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kKS/gyC2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfK0Iko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 03:40:44 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:57032 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfK0Ikn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 03:40:43 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAR8diPW098182;
        Wed, 27 Nov 2019 08:39:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=qgB41Ahd8fkfj9DCrb0acci8sQ/6nxDp8iC0TStjsYs=;
 b=kKS/gyC2wrkG6iJvxjNwh38z6ghKNTvoxsGkjfL676Xfs3hzDVYRUgEer7BYsA+R95LX
 h7+NlWJ6U9Nx+HjGwf4RPmDNIqlzgbhnCgUnNqwWDwkRYNZj+MS05oBGvVa6XZZ+Za4y
 koFwrD+jvdWiMifwoH+d9+aG5sjEp/ZR71OOkKXfZqmKL5Mp9mGtGj0etM53I2n0h70H
 0t+PAeQBJ2Nyos3E9sVOjxU1FwjQJDu/W7xx4V52g5e6JrVd24UoOmJpbrSEPjK/qel4
 XJ7qto8CB12qSmBNJ4ZrLQlzVa04C9t4s0GZ9FcN2waK0oIPUuqOXZmktUHr4R+fFQAH HQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2wewdrbxbk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Nov 2019 08:39:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAR8dgZi060741;
        Wed, 27 Nov 2019 08:39:54 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2wgvhbr6su-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Nov 2019 08:39:51 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAR8cRor013061;
        Wed, 27 Nov 2019 08:38:28 GMT
Received: from z2.cn.oracle.com (/10.182.71.218)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 27 Nov 2019 00:38:27 -0800
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>
Subject: [PATCH] sched/clock: use static_branch_likely() check at sched_clock_running
Date:   Wed, 27 Nov 2019 16:37:28 +0800
Message-Id: <1574843848-26825-1-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9453 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911270073
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9453 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911270073
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sched_clock_running is enabled early at bootup stage and never
disabled. So hints that to compiler by using static_branch_likely()
rather than static_branch_unlikely().

Fixes: 46457ea464f5 ("sched/clock: Use static key for sched_clock_running")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
---
 kernel/sched/clock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
index 1152259..12bca64 100644
--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -370,7 +370,7 @@ u64 sched_clock_cpu(int cpu)
 	if (sched_clock_stable())
 		return sched_clock() + __sched_clock_offset;
 
-	if (!static_branch_unlikely(&sched_clock_running))
+	if (!static_branch_likely(&sched_clock_running))
 		return sched_clock();
 
 	preempt_disable_notrace();
@@ -393,7 +393,7 @@ void sched_clock_tick(void)
 	if (sched_clock_stable())
 		return;
 
-	if (!static_branch_unlikely(&sched_clock_running))
+	if (!static_branch_likely(&sched_clock_running))
 		return;
 
 	lockdep_assert_irqs_disabled();
@@ -460,7 +460,7 @@ void __init sched_clock_init(void)
 
 u64 sched_clock_cpu(int cpu)
 {
-	if (!static_branch_unlikely(&sched_clock_running))
+	if (!static_branch_likely(&sched_clock_running))
 		return 0;
 
 	return sched_clock();
-- 
1.8.3.1

