Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD69AC004C9
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 12:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A59E220673
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 12:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbfD2MWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 08:22:19 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7141 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727710AbfD2MWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 08:22:16 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9D18AF454F8671C87392;
        Mon, 29 Apr 2019 20:22:12 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Mon, 29 Apr 2019
 20:22:02 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <will.deacon@arm.com>,
        <linux-kernel@vger.kernel.org>
CC:     <houtao1@huawei.com>
Subject: [PATCH] lockdep: remove unnecessary unlikely()
Date:   Mon, 29 Apr 2019 20:26:31 +0800
Message-ID: <1556540791-23110-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DEBUG_LOCKS_WARN_ON() already contains an unlikely(), there is no need
for another one.

Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 kernel/locking/lockdep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index e221be7..1522034 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3157,7 +3157,7 @@ void lockdep_hardirqs_on(unsigned long ip)
 	/*
 	 * See the fine text that goes along with this variable definition.
 	 */
-	if (DEBUG_LOCKS_WARN_ON(unlikely(early_boot_irqs_disabled)))
+	if (DEBUG_LOCKS_WARN_ON(early_boot_irqs_disabled))
 		return;

 	/*
--
2.7.4

