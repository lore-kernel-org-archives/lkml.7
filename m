Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BA3C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 970FE20825
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="BMYzx8Po"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfEGRCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 13:02:08 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60810 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725859AbfEGRCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 13:02:08 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x47Ggb7L005384
        for <linux-kernel@vger.kernel.org>; Tue, 7 May 2019 10:02:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=vitOO7OwnftNXjnC+6jXyI8tHpXb/oZC9oEpjEzqAdk=;
 b=BMYzx8PoazQPk4IOcYhuSTYButTTsGfV9FSbP673WfL/6DT5VUy7desq17/9Xbpae6c8
 HC4w0RFnqe7SQJVarRZz28rnWDyboc2xHRtPP19xfyN6yyV7V7nX1UJFDYaz7k3rD6qt
 20fETY3A9P3t2BAndyIqCzNUPX2LFM1znOo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2sbd0rra04-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 10:02:07 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 7 May 2019 10:02:04 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 982E311C213DA; Tue,  7 May 2019 10:02:03 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     Tejun Heo <tj@kernel.org>
CC:     Jens Axboe <axboe@kernel.dk>, Song Liu <songliubraving@fb.com>,
        Dennis Zhou <dennis@kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH 4/4] percpu_ref: release percpu memory early without PERCPU_REF_ALLOW_REINIT
Date:   Tue, 7 May 2019 10:01:50 -0700
Message-ID: <20190507170150.64051-4-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190507170150.64051-1-guro@fb.com>
References: <20190507170150.64051-1-guro@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-07_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=536 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905070109
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Release percpu memory after finishing the switch to the atomic mode
if only PERCPU_REF_ALLOW_REINIT isn't set.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 include/linux/percpu-refcount.h |  1 +
 lib/percpu-refcount.c           | 13 +++++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
index 0f0240af8520..7aef0abc194a 100644
--- a/include/linux/percpu-refcount.h
+++ b/include/linux/percpu-refcount.h
@@ -102,6 +102,7 @@ struct percpu_ref {
 	percpu_ref_func_t	*release;
 	percpu_ref_func_t	*confirm_switch;
 	bool			force_atomic:1;
+	bool			allow_reinit:1;
 	struct rcu_head		rcu;
 };
 
diff --git a/lib/percpu-refcount.c b/lib/percpu-refcount.c
index da54318d3b55..47f0aeb136c4 100644
--- a/lib/percpu-refcount.c
+++ b/lib/percpu-refcount.c
@@ -69,11 +69,14 @@ int percpu_ref_init(struct percpu_ref *ref, percpu_ref_func_t *release,
 		return -ENOMEM;
 
 	ref->force_atomic = flags & PERCPU_REF_INIT_ATOMIC;
+	ref->allow_reinit = flags & PERCPU_REF_ALLOW_REINIT;
 
-	if (flags & (PERCPU_REF_INIT_ATOMIC | PERCPU_REF_INIT_DEAD))
+	if (flags & (PERCPU_REF_INIT_ATOMIC | PERCPU_REF_INIT_DEAD)) {
 		ref->percpu_count_ptr |= __PERCPU_REF_ATOMIC;
-	else
+		ref->allow_reinit = true;
+	} else {
 		start_count += PERCPU_COUNT_BIAS;
+	}
 
 	if (flags & PERCPU_REF_INIT_DEAD)
 		ref->percpu_count_ptr |= __PERCPU_REF_DEAD;
@@ -119,6 +122,9 @@ static void percpu_ref_call_confirm_rcu(struct rcu_head *rcu)
 	ref->confirm_switch = NULL;
 	wake_up_all(&percpu_ref_switch_waitq);
 
+	if (!ref->allow_reinit)
+		percpu_ref_exit(ref);
+
 	/* drop ref from percpu_ref_switch_to_atomic() */
 	percpu_ref_put(ref);
 }
@@ -194,6 +200,9 @@ static void __percpu_ref_switch_to_percpu(struct percpu_ref *ref)
 	if (!(ref->percpu_count_ptr & __PERCPU_REF_ATOMIC))
 		return;
 
+	if (WARN_ON_ONCE(!ref->allow_reinit))
+		return;
+
 	atomic_long_add(PERCPU_COUNT_BIAS, &ref->count);
 
 	/*
-- 
2.20.1

