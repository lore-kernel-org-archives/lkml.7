Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCDEC76191
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 07:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B9D020840
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 07:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbfGYHJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 03:09:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40808 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729527AbfGYHJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 03:09:11 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6P76ZEB067170
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 03:09:10 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ty4tpq2nv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 03:09:09 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Thu, 25 Jul 2019 08:09:07 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 25 Jul 2019 08:09:04 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6P793t939387256
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jul 2019 07:09:03 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 980924C058;
        Thu, 25 Jul 2019 07:09:03 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2CD544C040;
        Thu, 25 Jul 2019 07:09:02 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.35.169])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 25 Jul 2019 07:09:01 +0000 (GMT)
From:   Parth Shah <parth@linux.ibm.com>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        patrick.bellasi@arm.com, dietmar.eggemann@arm.com,
        daniel.lezcano@linaro.org, subhra.mazumdar@oracle.com
Subject: [RFC v4 2/8] sched: Introduce switch to enable TurboSched mode
Date:   Thu, 25 Jul 2019 12:38:51 +0530
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190725070857.6639-1-parth@linux.ibm.com>
References: <20190725070857.6639-1-parth@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19072507-0008-0000-0000-00000300961B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072507-0009-0000-0000-0000226E2951
Message-Id: <20190725070857.6639-3-parth@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-25_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907250085
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a static key which allows to enable or disable TurboSched feature at
runtime.

This key is added in order to enable the TurboSched feature only when
required. This helps in optimizing the scheduler fast-path when the
TurboSched feature is disabled.

Also provide get/put methods to keep track of the tasks using the
TurboSched feature and also refcount jitter tasks. This allows to enable
the feature on setting first task classified as jitter, similarly disable
the feature on unsetting of such last task.

Signed-off-by: Parth Shah <parth@linux.ibm.com>
---
 kernel/sched/core.c  | 20 ++++++++++++++++++++
 kernel/sched/sched.h |  9 +++++++++
 2 files changed, 29 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e7cda4aa8696..ee5980b4e150 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -72,6 +72,26 @@ __read_mostly int scheduler_running;
  */
 int sysctl_sched_rt_runtime = 950000;
 
+DEFINE_STATIC_KEY_FALSE(__turbo_sched_enabled);
+static DEFINE_MUTEX(turbo_sched_lock);
+static int turbo_sched_count;
+
+void turbo_sched_get(void)
+{
+	mutex_lock(&turbo_sched_lock);
+	if (!turbo_sched_count++)
+		static_branch_enable(&__turbo_sched_enabled);
+	mutex_unlock(&turbo_sched_lock);
+}
+
+void turbo_sched_put(void)
+{
+	mutex_lock(&turbo_sched_lock);
+	if (!--turbo_sched_count)
+		static_branch_disable(&__turbo_sched_enabled);
+	mutex_unlock(&turbo_sched_lock);
+}
+
 /*
  * __task_rq_lock - lock the rq @p resides on.
  */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 802b1f3405f2..4a0b90ea8652 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2423,3 +2423,12 @@ static inline bool sched_energy_enabled(void)
 static inline bool sched_energy_enabled(void) { return false; }
 
 #endif /* CONFIG_ENERGY_MODEL && CONFIG_CPU_FREQ_GOV_SCHEDUTIL */
+
+void turbo_sched_get(void);
+void turbo_sched_put(void);
+DECLARE_STATIC_KEY_FALSE(__turbo_sched_enabled);
+
+static inline bool is_turbosched_enabled(void)
+{
+	return static_branch_unlikely(&__turbo_sched_enabled);
+}
-- 
2.17.1

