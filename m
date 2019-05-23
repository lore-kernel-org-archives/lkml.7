Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CBDC04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 05:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2362A20881
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 05:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Vw6rlYbl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbfEWFeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 01:34:44 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38560 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725786AbfEWFeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 01:34:44 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4N5UEcs030582
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 22:34:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=a0uF7x09L2/WjWeppBCueqrZ16Oc1jezGkJgcOEFv98=;
 b=Vw6rlYblhLg7w2L4eqUFjvG9YJrMiFg9xSflmW2R1zbMvq75wAQeKilI5+1qaKNOqkWg
 I3kPpUshbsKzVHBBCrwhbBlzEJON7z/qYtO+IAIAnVFMcYq7iGTjZMFzapPItYaD++xB
 iAIRyw0W6AvPSwjjoiF69rjXnAfURCA+niA= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2sngqdrqtu-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 22:34:43 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Wed, 22 May 2019 22:34:33 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 69A9F62E2CA2; Wed, 22 May 2019 22:34:31 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
CC:     <kernel-team@fb.com>, Song Liu <songliubraving@fb.com>,
        Kairui Song <kasong@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2] perf/x86: always include regs->ip in callchain
Date:   Wed, 22 May 2019 22:34:29 -0700
Message-ID: <20190523053429.3567376-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-23_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=761 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905230039
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d15d356887e7 removes regs->ip for !perf_hw_regs(regs) case. This
patch adds regs->ip back.

Fixes: d15d356887e7 ("perf/x86: Make perf callchains work without CONFIG_FRAME_POINTER")
Cc: Kairui Song <kasong@redhat.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 arch/x86/events/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index f315425d8468..7b8a9eb4d5fd 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2402,9 +2402,9 @@ perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *re
 		return;
 	}
 
+	if (perf_callchain_store(entry, regs->ip))
+		return;
 	if (perf_hw_regs(regs)) {
-		if (perf_callchain_store(entry, regs->ip))
-			return;
 		unwind_start(&state, current, regs, NULL);
 	} else {
 		unwind_start(&state, current, NULL, (void *)regs->sp);
-- 
2.17.1

