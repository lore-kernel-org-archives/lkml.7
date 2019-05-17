Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3CFC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 21:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B07720657
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 21:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbfEQVWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 17:22:50 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:50614 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727664AbfEQVWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 17:22:50 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Chamillionaire.breakpoint.cc with esmtp (Exim 4.89)
        (envelope-from <sebastian@breakpoint.cc>)
        id 1hRkJS-00048P-EE; Fri, 17 May 2019 23:22:46 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>, tglx@linutronix.de,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] locking/lockdep: Don't complain about wrong name for no validate class
Date:   Fri, 17 May 2019 23:22:34 +0200
Message-Id: <20190517212234.32611-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Breakpoint-Spam-Score: -1.0
X-Breakpoint-Spam-Level: -
X-Breakpoint-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,HEADER_FROM_DIFFERENT_DOMAINS=0.001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible to ignore the validation for a certain log be using
	lockdep_set_novalidate_class()

on it. Each invocation will assign a new name to the class it created
for created __lockdep_no_validate__. That means that once
lockdep_set_novalidate_class() has been used on two locks then
class->name won't match lock->name for the first lock triggering the
warning.

Ignoring changed non-matching ->name pointer for the
__lockdep_no_validate__ class.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/locking/lockdep.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index d06190fa50822..38be69d344f7f 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -731,7 +731,8 @@ look_up_lock_class(const struct lockdep_map *lock, unsigned int subclass)
 			 * Huh! same key, different name? Did someone trample
 			 * on some memory? We're most confused.
 			 */
-			WARN_ON_ONCE(class->name != lock->name);
+			WARN_ON_ONCE(class->name != lock->name &&
+				     lock->key != &__lockdep_no_validate__);
 			return class;
 		}
 	}
-- 
2.20.1

