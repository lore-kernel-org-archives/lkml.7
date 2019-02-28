Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62810C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25750218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551374125;
	bh=ArK/Qd2PbUM9rN6W2Ae4Zj1aDNhJYwtJoSVtKeoWs3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t9+M0mLnC5i1jv9jQ2JCDYzD2ltC6iRmRAypxplfvR3hbpiOL9DU0PVEdUosQL5+B
	 +zAMC3EYnxSz5vOIxk7ihRAAqO2rGsNlY/FGiNiQb9f6clVQB7TCgpFKBrSyhlXEfN
	 3EbryDDQW/vpUGeKOL0yPetj6ymunkbmtGOUIN6A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388204AbfB1RPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:15:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:59644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388057AbfB1ROs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 12:14:48 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F469218AE;
        Thu, 28 Feb 2019 17:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551374087;
        bh=ArK/Qd2PbUM9rN6W2Ae4Zj1aDNhJYwtJoSVtKeoWs3o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qTzmlA01mKsv8QPi8ZamjDMh4zfnp0c1s8tho6Jes4JaCwenKWp/s99w97wFGnq6J
         FlY0n1kFyfynG2ShbShGiqVs3ltHq5bICTvtE75oOSFu5PYBISTgsokCCgJeBWz5L1
         rhw29jZPlGUTmHv5NfyBJmyh4Wj9ibQkNOGOgnZM=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 33/37] locking/lockdep: Update check_flags() according to new layout
Date:   Thu, 28 Feb 2019 18:12:38 +0100
Message-Id: <20190228171242.32144-34-frederic@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190228171242.32144-1-frederic@kernel.org>
References: <20190228171242.32144-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

current->softirqs_enabled used to mean that either all or no softirqs
are enabled. Now things are getting a bit different with the new per
vector masking extension after which current->softirqs_enabled will
stay on as long as there is a single vector still enabled.

Let's adapt the check to the updated semantics. We can't deduce much
from softirq_count() alone anymore except when it's 0.

Reviewed-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Pavan Kondeti <pkondeti@codeaurora.org>
Cc: Paul E . McKenney <paulmck@linux.vnet.ibm.com>
Cc: David S . Miller <davem@davemloft.net>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/locking/lockdep.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index ce027d436651..aab634b07d67 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3911,13 +3911,8 @@ static void check_flags(unsigned long flags)
 	 * check if not in hardirq contexts:
 	 */
 	if (!hardirq_count()) {
-		if (softirq_count()) {
-			/* like the above, but with softirqs */
-			DEBUG_LOCKS_WARN_ON(current->softirqs_enabled);
-		} else {
-			/* lick the above, does it taste good? */
+		if (!softirq_count())
 			DEBUG_LOCKS_WARN_ON(!current->softirqs_enabled);
-		}
 	}
 
 	if (!debug_locks)
-- 
2.21.0

