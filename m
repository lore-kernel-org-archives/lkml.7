Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3431FC341AB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75BC524723
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfLMMNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 07:13:37 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7232 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726851AbfLMMNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 07:13:36 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 43BF251F2FFBC74BD80D;
        Fri, 13 Dec 2019 20:13:32 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Fri, 13 Dec 2019
 20:13:21 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>, <luto@kernel.org>, <riel@surriel.com>,
        <alexander.h.duyck@linux.intel.com>, <mtosatti@redhat.com>
CC:     <yukuai3@huawei.com>, <zhengbin13@huawei.com>,
        <yi.zhang@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/process: remove set but not used varibles 'prev' and 'next'
Date:   Fri, 13 Dec 2019 20:12:53 +0800
Message-ID: <20191213121253.10072-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

arch/x86/kernel/process.c: In function ‘__switch_to_xtra’:
arch/x86/kernel/process.c:618:31: warning: variable ‘next’ set
but not used [-Wunused-but-set-variable]
arch/x86/kernel/process.c:618:24: warning: variable ‘prev’ set
but not used [-Wunused-but-set-variable]

They are never used, and so can be removed.

Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 arch/x86/kernel/process.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 61e93a318983..839b5244e3b7 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -615,12 +615,8 @@ void speculation_ctrl_update_current(void)
 
 void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p)
 {
-	struct thread_struct *prev, *next;
 	unsigned long tifp, tifn;
 
-	prev = &prev_p->thread;
-	next = &next_p->thread;
-
 	tifn = READ_ONCE(task_thread_info(next_p)->flags);
 	tifp = READ_ONCE(task_thread_info(prev_p)->flags);
 
-- 
2.17.2

