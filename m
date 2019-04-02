Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFFFC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C4AA208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554220978;
	bh=pHkwdNRsjNDAbq6he40wqMIDRU0Idtw3/CZrsqj7p/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DWte9mRFpSNRELkvPMzyq6JjQ207Jtj8hfqwtbkGpbacmDW7NNmzNigG6r47EtDvc
	 0AK5npPfvCdZ26oWfOfRLgDbD+rPUxtKGZpFQNvQNzuKs0N3uM1uzCI85AEQj4jxSl
	 PC0tdfZAADGus4A89bfyGaiUj/Po+PU2bXIO9WKU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730403AbfDBQC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:02:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:42782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729060AbfDBQCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:02:54 -0400
Received: from lenoir.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F20B20840;
        Tue,  2 Apr 2019 16:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554220973;
        bh=pHkwdNRsjNDAbq6he40wqMIDRU0Idtw3/CZrsqj7p/A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=StmfowuHc+IYGT3F3dY455qByAhrA0A0WzMfOGV8sk37SRDanuSihhuNjqLN0vSef
         +evlIVx05raHiyVgK/NdTkkzyVBUdmVCF3B1aggswEqU8/RK5XkHmubj2MJCJVxcBN
         WjTQzT0lxNgGt7NyaNXjrvbBs4419RiVXUuYAdFI=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 1/4] locking/lockdep: Move valid_state() inside CONFIG_TRACE_IRQFLAGS && CONFIG_PROVE_LOCKING
Date:   Tue,  2 Apr 2019 18:02:41 +0200
Message-Id: <20190402160244.32434-2-frederic@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190402160244.32434-1-frederic@kernel.org>
References: <20190402160244.32434-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

valid_state() and print_usage_bug*() functions are not used beyond
irq locking correctness checks under
CONFIG_TRACE_IRQFLAGS && CONFIG_PROVE_LOCKING.
Sadly the "unused function" warning wouldn't fire because valid_state()
is inline so the unused case has remained unseen until now.

So move them inside the appropriate
CONFIG_TRACE_IRQFLAGS && CONFIG_PROVE_LOCKING section.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/locking/lockdep.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 34cdcbedda49..9c5819ef4a28 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2784,6 +2784,12 @@ static void check_chain_key(struct task_struct *curr)
 #endif
 }
 
+static int mark_lock(struct task_struct *curr, struct held_lock *this,
+		     enum lock_usage_bit new_bit);
+
+#if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING)
+
+
 static void
 print_usage_bug_scenario(struct held_lock *lock)
 {
@@ -2853,10 +2859,6 @@ valid_state(struct task_struct *curr, struct held_lock *this,
 	return 1;
 }
 
-static int mark_lock(struct task_struct *curr, struct held_lock *this,
-		     enum lock_usage_bit new_bit);
-
-#if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_PROVE_LOCKING)
 
 /*
  * print irq inversion bug:
-- 
2.21.0

