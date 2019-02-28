Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD740C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B0B9218D9
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551374010;
	bh=iyUIa1aDiQk42irvoZ625fHXyfJoI++0Nv683fpdB6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=19mLL5j4Cj0Da+rsn8edY+b2G6nvM26jl9Tym0JiaobAEvIzkQ+rE9pOYwIHcuYeZ
	 L7j7k0DibRHq4qLegezFdPUoMVNJBWY4i6aNswfy9SfcEVD/2yuQtzP6+EboDbYWb2
	 MtC22cN58NOI5CfnA/obYdsJ0u8HjXztUQsh/QP0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387685AbfB1RN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:13:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:58196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732847AbfB1RN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 12:13:27 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B648218CD;
        Thu, 28 Feb 2019 17:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551374006;
        bh=iyUIa1aDiQk42irvoZ625fHXyfJoI++0Nv683fpdB6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IMN+sjKy2JXMDcclvBYTPYagmm2jvzKYa61rgOq7grM/sfr3zvzjEEsN4zSJDOZzA
         HEfeGX17/2/UAtdBvoMd6UJkYt2+FhK+ZbMhpvw8eZELO9Z7nXVcIaBgbWJVRynGVE
         YXOJ88fSSU24vF4dqXaiCyasLZNDXbItWQgfpKKo=
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
Subject: [PATCH 10/37] locking/lockdep: Make mark_lock() fastpath to work with multiple usage at once
Date:   Thu, 28 Feb 2019 18:12:15 +0100
Message-Id: <20190228171242.32144-11-frederic@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190228171242.32144-1-frederic@kernel.org>
References: <20190228171242.32144-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that mark_lock() is going to handle multiple softirq vectors at
once for a given lock usage, the current fast path optimization that
simply check if the new bit usage is already present won't work anymore.

Indeed if the new usage is only partially present, such as for some
softirq vectors and not for others, we may spuriously ignore all the
verifications for the new vectors.

What we must check instead is a bit different: we have to make sure that
the new usage with all its vectors are entirely present in the current
usage mask before ignoring further checks.

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
 kernel/locking/lockdep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 0988de06a7ed..9a5f2dbc3812 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3159,7 +3159,7 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 	 * If already set then do not dirty the cacheline,
 	 * nor do any checks:
 	 */
-	if (likely(hlock_class(this)->usage_mask & new_mask))
+	if (likely(!(new_mask & ~hlock_class(this)->usage_mask)))
 		return 1;
 
 	if (!graph_lock())
@@ -3167,7 +3167,7 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 	/*
 	 * Make sure we didn't race:
 	 */
-	if (unlikely(hlock_class(this)->usage_mask & new_mask)) {
+	if (unlikely(!(new_mask & ~hlock_class(this)->usage_mask))) {
 		graph_unlock();
 		return 1;
 	}
-- 
2.21.0

