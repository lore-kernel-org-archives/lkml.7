Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E3DC04AAB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC1B205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 17:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="CtOFOsaD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfEGRCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 13:02:13 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60876 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727202AbfEGRCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 13:02:12 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x47Ggb7U005384
        for <linux-kernel@vger.kernel.org>; Tue, 7 May 2019 10:02:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=U/VMxmWAJXjalXY8tz+XfL3xCK5Mwk3eUbs6HAnh4Mk=;
 b=CtOFOsaDdfr57LAZ/rCTJTqVQ8XjRKhfx5MV5nLl3xUdtiFlewBkOtslvFJ+Y3qqySoO
 WzgqQADpj/UPierp5wk2d0vgOqnr4hN7qjH98/egXxvEJzLywJJjXA/RMsjg8m5eMWjw
 GW0pnjeziDKW6FtSSfUeWGkU3t0I3XU5J6A= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2sbd0rra04-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 10:02:10 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 7 May 2019 10:02:08 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 91A9811C213D4; Tue,  7 May 2019 10:02:03 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     Tejun Heo <tj@kernel.org>
CC:     Jens Axboe <axboe@kernel.dk>, Song Liu <songliubraving@fb.com>,
        Dennis Zhou <dennis@kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH 2/4] io_uring: initialize percpu refcounters using PERCU_REF_ALLOW_REINIT
Date:   Tue, 7 May 2019 10:01:48 -0700
Message-ID: <20190507170150.64051-2-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190507170150.64051-1-guro@fb.com>
References: <20190507170150.64051-1-guro@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-07_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=568 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905070109
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Percpu reference counters should now be initialized with the
PERCPU_REF_ALLOW_REINIT in order to allow switching them to the
percpu mode from the atomic mode. This is exactly what
percpu_ref_reinit() called from __io_uring_register() is supposed to
do. So let's initialize percpu refcounters with the
PERCU_REF_ALLOW_REINIT flag.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 fs/io_uring.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 452e35357865..9a9df175af31 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -397,7 +397,8 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 	if (!ctx)
 		return NULL;
 
-	if (percpu_ref_init(&ctx->refs, io_ring_ctx_ref_free, 0, GFP_KERNEL)) {
+	if (percpu_ref_init(&ctx->refs, io_ring_ctx_ref_free,
+			    PERCPU_REF_ALLOW_REINIT, GFP_KERNEL)) {
 		kfree(ctx);
 		return NULL;
 	}
-- 
2.20.1

