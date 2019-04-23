Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41F3C10F11
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 01:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E33F2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 01:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbfDWBaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 21:30:04 -0400
Received: from mail4.tencent.com ([183.57.53.109]:37324 "EHLO
        mail4.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfDWBaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 21:30:03 -0400
X-Greylist: delayed 375 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Apr 2019 21:30:02 EDT
Received: from EXHUB-SZMail01.tencent.com (unknown [10.14.6.21])
        by mail4.tencent.com (Postfix) with ESMTP id 6CECE5062D;
        Tue, 23 Apr 2019 09:23:35 +0800 (CST)
Received: from localhost.localdomain (10.35.10.40) by
 EXHUB-SZMail01.tencent.com (10.14.6.21) with Microsoft SMTP Server id
 14.3.408.0; Tue, 23 Apr 2019 09:23:34 +0800
From:   Jiang Biao <benbjiang@tencent.com>
To:     <paulmck@linux.ibm.com>, <josh@joshtriplett.org>
CC:     <linux-kernel@vger.kernel.org>, <benbjiang@tencent.com>
Subject: [PATCH] rcu/srcutree: make __call_srcu static
Date:   Tue, 23 Apr 2019 09:22:56 +0800
Message-ID: <20190423012256.30743-1-benbjiang@tencent.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.35.10.40]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__call_srcu() is only used in current file, just make it static.

Signed-off-by: Jiang Biao <benbjiang@tencent.com>
---
 kernel/rcu/srcutree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index a60b8ba9e1ac..a2ade0c6cd87 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -835,7 +835,7 @@ static void srcu_leak_callback(struct rcu_head *rhp)
  * srcu_read_lock(), and srcu_read_unlock() that are all passed the same
  * srcu_struct structure.
  */
-void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
+static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 		 rcu_callback_t func, bool do_norm)
 {
 	unsigned long flags;
-- 
2.17.2 (Apple Git-113)

