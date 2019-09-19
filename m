Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E33CC49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 05:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28505218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 05:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="F9KTVUqr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731385AbfISFyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 01:54:12 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:20058 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731171AbfISFyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 01:54:11 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8J5jgn5017033
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 22:54:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=qoIfaq0yE8OIwpJ2DpJzQWe83nfZ+Iy15Q/fJpXKkFI=;
 b=F9KTVUqraScd6kE6mCKxhNNtfbd755iTJ2GxKJGUXIJmH9WdP3b5In50U83R2zAi/eYc
 OZ/c1MWujuKSW32qirwV31bbN2kC2W9quq+0R25dOtGUGkXASP0lAQYAiROX2N5SlcGf
 H9Ia61eUKWTzFJI7PLfDVuOv9+jWLgjHzBY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2v3vdu1j9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 22:54:11 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 18 Sep 2019 22:54:09 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id E1DE262E1C78; Wed, 18 Sep 2019 22:54:02 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>, <kernel-team@fb.com>,
        <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH] x86/mm/pti: Handle unaligned addr to PMD-mapped page in pti_clone_pgtable
Date:   Wed, 18 Sep 2019 22:53:12 -0700
Message-ID: <20190919055312.3020652-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-19_02:2019-09-18,2019-09-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 spamscore=0 clxscore=1015 malwarescore=0 mlxscore=0 adultscore=0
 mlxlogscore=520 lowpriorityscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1909190054
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To clone page table of PMD-mapped pages, pti_clone_pgtable() requires PMD
aligned start address. [1] adds warning for unaligned addresses. However,
there is still no warning for unaligned address to valid huge pmd [2].

Add alignment check in valid pmd_large() case. If the address is
unaligned, round it down to the nearest PMD aligned address and show
warning.

[1] commit 825d0b73cd75 ("x86/mm/pti: Handle unaligned address gracefully
                          in pti_clone_pagetable()")
[2] https://lore.kernel.org/lkml/156864062019.3407.14798418565580024723.tglx@nanos.tec.linutronix.de/

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 arch/x86/mm/pti.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 7f2140414440..d224115c350d 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -343,6 +343,10 @@ pti_clone_pgtable(unsigned long start, unsigned long end,
 		}
 
 		if (pmd_large(*pmd) || level == PTI_CLONE_PMD) {
+			/* warn and round_down() unaligned addr */
+			if (WARN_ON_ONCE(addr & ~PMD_MASK))
+				addr &= PMD_MASK;
+
 			target_pmd = pti_user_pagetable_walk_pmd(addr);
 			if (WARN_ON(!target_pmd))
 				return;
-- 
2.17.1

