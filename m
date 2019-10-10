Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D787BC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 06:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF6FB2190F
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 06:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="qdBc0B/l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732925AbfJJGT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 02:19:29 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47682 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726973AbfJJGT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 02:19:28 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9A68gbi009426
        for <linux-kernel@vger.kernel.org>; Wed, 9 Oct 2019 23:19:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=s6eyAOhaBTbzLObZLe6B53V9ygLx91hA9w5VlVF+Gg4=;
 b=qdBc0B/lFm9WTk8wnmdA/F6tqTpvpC2EL4tjVdr8VPq5NO/zT2bbgWTu6IP1nLrA+3w8
 ETFRYAGFqNew3l1fucQnFfO2s+D9/2Sb6+KnB/ji8X0VBj7n5k3kQFha4Kn4mMWxQJqi
 WLoAFg4hIfM9g4AuO8q71NAscqmlua5UntM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vhfsdv54y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 23:19:27 -0700
Received: from 2401:db00:30:6007:face:0:1:0 (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 9 Oct 2019 23:19:25 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id EF1F662E3559; Wed,  9 Oct 2019 23:19:23 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <netdev@vger.kernel.org>
CC:     <kernel-team@fb.com>, Song Liu <songliubraving@fb.com>,
        <stable@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Tejun Heo <tj@kernel.org>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 1/2] sched: introduce this_rq_is_locked()
Date:   Wed, 9 Oct 2019 23:19:15 -0700
Message-ID: <20191010061916.198761-2-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191010061916.198761-1-songliubraving@fb.com>
References: <20191010061916.198761-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-10_03:2019-10-08,2019-10-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 phishscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=999 spamscore=0 mlxscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910100058
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this_rq_is_locked() is introduced to check whether current CPU is holding
rq_lock(). This will be used in bpf/stackmap.c to decide whether is safe
to call up_read(), which may call rq_lock() for the same CPU.

Fixes: commit 615755a77b24 ("bpf: extend stackmap to save binary_build_id+offset instead of address")
Cc: stable@vger.kernel.org # v4.17+
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 include/linux/sched.h | 1 +
 kernel/sched/core.c   | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 2c2e56bd8913..fb0fcbd1b6f6 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1995,4 +1995,5 @@ int sched_trace_rq_cpu(struct rq *rq);

 const struct cpumask *sched_trace_rd_span(struct root_domain *rd);

+bool this_rq_is_locked(void);
 #endif
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7880f4f64d0e..577cbe7c05fc 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -138,6 +138,14 @@ struct rq *task_rq_lock(struct task_struct *p, struct rq_flags *rf)
 	}
 }

+bool this_rq_is_locked(void)
+{
+	struct rq *rq;
+
+	rq = this_rq();
+	return raw_spin_is_locked(&rq->lock);
+}
+
 /*
  * RQ-clock updating methods:
  */
--
2.17.1
