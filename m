Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093BFC28CC5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 01:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3A49214C6
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 01:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WCEo9J5t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbfFIBzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 21:55:18 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:38958 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbfFIBzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 21:55:17 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x591sWog046594;
        Sun, 9 Jun 2019 01:54:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=twmTY486w6zmLVqDXQq5pqHb47ZM2OA1CcI/8SOEK6Y=;
 b=WCEo9J5tO/oBUY87L0LOhfFNTxLsE0VWPWYA82ox2BZVOfJBgMPLxBONpS0NjZAIrnyi
 XsnINlODL8W23ZFIOAstI0E7SccOLQoGbS7HgTtVi0FWqjDc0RtGR6P7iUSrMQVVqhjR
 n/FuW9yO+FbUUM5JxrbFEmMpBhvo56n7U7XAvpfvh6bCi5Vhw/0mxFjMPMaPTKhs+qpG
 r0B2sjZI4+KrtLQ/tjKVSkIU4nJv2/0EpGZoS+sHmp9BU4Sgj6wWiOHc4z+uU0nqo8Ho
 vRlb6n+22UtDi7Hvv7RYO3i8gMZCn9BgSbaV5knfmTjbqQt2kZOLJbQCp1lWcGaYA157 rQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 2t02hea9wm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 09 Jun 2019 01:54:45 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x591sfdp108962;
        Sun, 9 Jun 2019 01:54:44 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2t04bku22r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 09 Jun 2019 01:54:44 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x591sfNQ030456;
        Sun, 9 Jun 2019 01:54:41 GMT
Received: from smazumda-Precision-T1600.us.oracle.com (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 08 Jun 2019 18:54:40 -0700
From:   subhra mazumdar <subhra.mazumdar@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, daniel.lezcano@linaro.org,
        vincent.guittot@linaro.org, viresh.kumar@linaro.org,
        tim.c.chen@linux.intel.com, mgorman@techsingularity.net
Subject: [PATCH v3 5/7] sched: SIS_CORE to disable idle core search
Date:   Sat,  8 Jun 2019 18:49:52 -0700
Message-Id: <20190609014954.1033-6-subhra.mazumdar@oracle.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20190609014954.1033-1-subhra.mazumdar@oracle.com>
References: <20190609014954.1033-1-subhra.mazumdar@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9282 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=650
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906090012
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9282 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=688 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906090013
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use SIS_CORE to disable idle core search. For some workloads
select_idle_core becomes a scalability bottleneck, removing it improves
throughput. Also there are workloads where disabling it can hurt latency,
so need to have an option.

Signed-off-by: subhra mazumdar <subhra.mazumdar@oracle.com>
---
 kernel/sched/fair.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c1ca88e..6a74808 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6280,9 +6280,11 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	if (!sd)
 		return target;
 
-	i = select_idle_core(p, sd, target);
-	if ((unsigned)i < nr_cpumask_bits)
-		return i;
+	if (sched_feat(SIS_CORE)) {
+		i = select_idle_core(p, sd, target);
+		if ((unsigned)i < nr_cpumask_bits)
+			return i;
+	}
 
 	i = select_idle_cpu(p, sd, target);
 	if ((unsigned)i < nr_cpumask_bits)
-- 
2.9.3

