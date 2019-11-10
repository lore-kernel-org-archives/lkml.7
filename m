Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97505C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 09:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59366207FA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 09:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfKJJYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 04:24:09 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5756 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726641AbfKJJYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 04:24:09 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BD90F7E4D92C20F97566;
        Sun, 10 Nov 2019 17:24:04 +0800 (CST)
Received: from localhost.localdomain (10.175.104.82) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Sun, 10 Nov 2019 17:23:56 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <keescook@chromium.org>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <zhengyongjun3@huawei.com>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] lkdtm: Remove set but not used variable 'byte'
Date:   Sun, 10 Nov 2019 17:22:49 +0800
Message-ID: <20191110092249.182210-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.82]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/misc/lkdtm/bugs.c: In function lkdtm_STACK_GUARD_PAGE_LEADING:
drivers/misc/lkdtm/bugs.c:236:25: warning: variable byte set but not used [-Wunused-but-set-variable]
drivers/misc/lkdtm/bugs.c: In function lkdtm_STACK_GUARD_PAGE_TRAILING:
drivers/misc/lkdtm/bugs.c:250:25: warning: variable byte set but not used [-Wunused-but-set-variable]

byte is never used, so remove it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/misc/lkdtm/bugs.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index 7284a22b1a09..fcd943725b66 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -249,12 +249,9 @@ void lkdtm_STACK_GUARD_PAGE_LEADING(void)
 {
 	const unsigned char *stack = task_stack_page(current);
 	const unsigned char *ptr = stack - 1;
-	volatile unsigned char byte;
 
 	pr_info("attempting bad read from page below current stack\n");
 
-	byte = *ptr;
-
 	pr_err("FAIL: accessed page before stack!\n");
 }
 
@@ -263,12 +260,9 @@ void lkdtm_STACK_GUARD_PAGE_TRAILING(void)
 {
 	const unsigned char *stack = task_stack_page(current);
 	const unsigned char *ptr = stack + THREAD_SIZE;
-	volatile unsigned char byte;
 
 	pr_info("attempting bad read from page above current stack\n");
 
-	byte = *ptr;
-
 	pr_err("FAIL: accessed page after stack!\n");
 }
 
-- 
2.23.0

