Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F2FFA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E78E92067B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 11:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403924AbfJPLZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 07:25:01 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:48867 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403826AbfJPLZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 07:25:01 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iKhQJ-0005Pd-IO; Wed, 16 Oct 2019 12:24:59 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iKhQI-0005T4-S5; Wed, 16 Oct 2019 12:24:58 +0100
From:   "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Subject: [PATCH] kthread: make __kthread_queue_delayed_work static
Date:   Wed, 16 Oct 2019 12:24:58 +0100
Message-Id: <20191016112458.20974-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __kthread_queue_delayed_work is not exported so
make it static, to avoid the following sparse warning:

kernel/kthread.c:869:6: warning: symbol '__kthread_queue_delayed_work' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org
---
 kernel/kthread.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 621467c33fef..b262f47046ca 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -866,9 +866,9 @@ void kthread_delayed_work_timer_fn(struct timer_list *t)
 }
 EXPORT_SYMBOL(kthread_delayed_work_timer_fn);
 
-void __kthread_queue_delayed_work(struct kthread_worker *worker,
-				  struct kthread_delayed_work *dwork,
-				  unsigned long delay)
+static void __kthread_queue_delayed_work(struct kthread_worker *worker,
+					 struct kthread_delayed_work *dwork,
+					 unsigned long delay)
 {
 	struct timer_list *timer = &dwork->timer;
 	struct kthread_work *work = &dwork->work;
-- 
2.23.0

