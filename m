Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A175C4740A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 03:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6954C20820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 03:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405659AbfIWDUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 23:20:10 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2704 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404564AbfIWDUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 23:20:10 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 80629B436215A611CC56;
        Mon, 23 Sep 2019 11:20:07 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Mon, 23 Sep 2019 11:19:57 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <casey@schaufler-ca.com>
CC:     <jmorris@namei.org>, <serge@hallyn.com>,
        <linux-security-module@vger.kernel.org>, <zhongjiang@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] smack: fix an compile error in smack_post_notification
Date:   Mon, 23 Sep 2019 11:16:47 +0800
Message-ID: <1569208607-23263-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I hit the following error when compile the kernel.

security/smack/smack_lsm.c: In function smack_post_notification:
security/smack/smack_lsm.c:4383:7: error: dereferencing pointer to incomplete type struct watch_notification
  if (n->type == WATCH_TYPE_META)
       ^~
security/smack/smack_lsm.c:4383:17: error: WATCH_TYPE_META undeclared (first use in this function); did you mean TCA_PIE_BETA?
  if (n->type == WATCH_TYPE_META)
                 ^~~~~~~~~~~~~~~
                 TCA_PIE_BETA
security/smack/smack_lsm.c:4383:17: note: each undeclared identifier is reported only once for each function it appears in

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 security/smack/smack.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/smack/smack.h b/security/smack/smack.h
index 62529f3..02b05a2 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -21,6 +21,7 @@
 #include <linux/rculist.h>
 #include <linux/lsm_audit.h>
 #include <linux/msg.h>
+#include <linux/watch_queue.h>
 
 /*
  * Use IPv6 port labeling if IPv6 is enabled and secmarks
-- 
1.7.12.4

