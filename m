Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A32C04AAD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B9A21530
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="AhQEtlBf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfEGRCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 13:02:18 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47062 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725859AbfEGRCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 13:02:10 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x47GheQ3025445
        for <linux-kernel@vger.kernel.org>; Tue, 7 May 2019 10:02:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=w+nEscO32i51Eb531246QmMr1Ozi4EnG9Bg++oZK6YI=;
 b=AhQEtlBfhbJeJpQU3jmANO/ZJiIuLYkbPUURXLlS9Ewoe0Q0gMZSvFSjV79gxS2IzBPD
 B3dQAYnAmehjd3S1cdR1l/VwIHjlFU3qbSd8RvEDKinnNoesRcsvBCtuRch13BcSRW9u
 bIp0woMLpXCTx55XMfk8PRw+LkALgWZy1Ms= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2sb1yf2evr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 10:02:08 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 7 May 2019 10:02:07 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 8F61111C213D2; Tue,  7 May 2019 10:02:03 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     Tejun Heo <tj@kernel.org>
CC:     Jens Axboe <axboe@kernel.dk>, Song Liu <songliubraving@fb.com>,
        Dennis Zhou <dennis@kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH 1/4] percpu_ref: introduce PERCPU_REF_ALLOW_REINIT flag
Date:   Tue, 7 May 2019 10:01:47 -0700
Message-ID: <20190507170150.64051-1-guro@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-07_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=436 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905070109
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In most cases percpu reference counters are not switched to the
percpu mode after they reach the atomic mode. Some obvious exceptions
are reference counters which are initialized into the atomic
mode (using PERCPU_REF_INIT_ATOMIC and PERCPU_REF_INIT_DEAD flags),
and there are few other exceptions.

But in most cases there is no way back, and once the reference counter
is switched to the atomic mode, there is no reason to wait for
percpu_ref_exit() to release the percpu memory. Of course, the size
of a single counter is not so big, but because it can pin the whole
percpu block in memory, the memory footprint can be noticeable
(e.g. on my 32 CPUs machine a percpu block is 8Mb large).

To make releasing of the percpu memory as early as possible, let's
introduce the PERCPU_REF_ALLOW_REINIT flag with the following semantics:
it has to be set in order to switch a percpu reference counter to the
percpu mode after the initialization. PERCPU_REF_INIT_ATOMIC and
PERCPU_REF_INIT_DEAD flags will implicitly assume PERCPU_REF_ALLOW_REINIT.

This patch doesn't introduce any functional change to avoid any
regressions. It will be done later in the patchset after adjusting
all call sites, which are reviving percpu counters.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 include/linux/percpu-refcount.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
index b297cd1cd4f1..0f0240af8520 100644
--- a/include/linux/percpu-refcount.h
+++ b/include/linux/percpu-refcount.h
@@ -75,14 +75,21 @@ enum {
 	 * operation using percpu_ref_switch_to_percpu().  If initialized
 	 * with this flag, the ref will stay in atomic mode until
 	 * percpu_ref_switch_to_percpu() is invoked on it.
+	 * Implies ALLOW_REINIT.
 	 */
 	PERCPU_REF_INIT_ATOMIC	= 1 << 0,
 
 	/*
 	 * Start dead w/ ref == 0 in atomic mode.  Must be revived with
-	 * percpu_ref_reinit() before used.  Implies INIT_ATOMIC.
+	 * percpu_ref_reinit() before used.  Implies INIT_ATOMIC and
+	 * ALLOW_REINIT.
 	 */
 	PERCPU_REF_INIT_DEAD	= 1 << 1,
+
+	/*
+	 * Allow switching from atomic mode to percpu mode.
+	 */
+	PERCPU_REF_ALLOW_REINIT	= 1 << 2,
 };
 
 struct percpu_ref {
-- 
2.20.1

