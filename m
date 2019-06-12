Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16F8C31E44
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 01:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9300B20883
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 01:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392048AbfFLBtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 21:49:15 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:18131 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729044AbfFLBtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 21:49:15 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E8849EB679BB46D72185;
        Wed, 12 Jun 2019 09:49:10 +0800 (CST)
Received: from RH5885H-V3.huawei.com (10.90.53.225) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Wed, 12 Jun 2019 09:48:57 +0800
From:   ZhangXiaoxu <zhangxiaoxu5@huawei.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <peterz@infradead.org>,
        <dvhart@infradead.org>, <linux-kernel@vger.kernel.org>,
        <zhangxiaoxu5@huawei.com>
Subject: [PATCH] futex: Fix futex lock the wrong page
Date:   Wed, 12 Jun 2019 09:54:25 +0800
Message-ID: <1560304465-68966-1-git-send-email-zhangxiaoxu5@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upstram commit 65d8fc777f6d ("futex: Remove requirement
for lock_page() in get_futex_key()") use variable 'page' as
the page head, when merge it to stable branch, the variable
`page_head` is page head.

In the stable branch, the variable `page` not means the page
head, when lock the page head, we should lock 'page_head',
rather than 'page'.

It maybe lead a hung task problem.

Signed-off-by: ZhangXiaoxu <zhangxiaoxu5@huawei.com>
Cc: stable@vger.kernel.org
---
 kernel/futex.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index ec9df5b..15d850f 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -593,8 +593,8 @@ again:
 		 * applies. If this is really a shmem page then the page lock
 		 * will prevent unexpected transitions.
 		 */
-		lock_page(page);
-		shmem_swizzled = PageSwapCache(page) || page->mapping;
+		lock_page(page_head);
+		shmem_swizzled = PageSwapCache(page_head) || page_head->mapping;
 		unlock_page(page_head);
 		put_page(page_head);
 
-- 
2.7.4

