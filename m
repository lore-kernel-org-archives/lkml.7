Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F8EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6661B20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551689044;
	bh=3cF/Yiq5ee9rCDPnZdE60Sgu5RFuQnyZmb82eGccUd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lWUFy0N4emH547YvSfag7n2hb5dwW0YYuWCylGGLE8M3MsYezla8CC5/XCe9frJTb
	 HEuaSaaYbksTGqW2V7jdE/gBfY+z+ZsxEvNgBAi9ybs2XHx6clONNc0lQq6PY/qoNV
	 YWAoZbMBr8H8/IPxyLC2foIgDblUE+gOM2LoiDFc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfCDI3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:29:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:55564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726724AbfCDI3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:29:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28DFF20823;
        Mon,  4 Mar 2019 08:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688155;
        bh=3cF/Yiq5ee9rCDPnZdE60Sgu5RFuQnyZmb82eGccUd0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KXMbMEl2bpLF+QjByqdKyy1YigJMJmDjJJezu8dVX2EdU9fO/zVxaf4/Q+emIdx+4
         JxzC6oS0yAZCyiaPkgE1b6z3NvI63dFUmdmwvksnreVSz10coi1xnpd7+MXSO+BaVt
         bEqy88pG/Brx0ufjO0cPGgLL/PBtVGTKO7+ETP7A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Prateek Sood <prsood@codeaurora.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 35/78] sched/wait: Fix rcuwait_wake_up() ordering
Date:   Mon,  4 Mar 2019 09:22:18 +0100
Message-Id: <20190304081627.070497480@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081625.508788074@linuxfoundation.org>
References: <20190304081625.508788074@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 6dc080eeb2ba01973bfff0d79844d7a59e12542e ]

For some peculiar reason rcuwait_wake_up() has the right barrier in
the comment, but not in the code.

This mistake has been observed to cause a deadlock in the following
situation:

    P1					P2

    percpu_up_read()			percpu_down_write()
      rcu_sync_is_idle() // false
					  rcu_sync_enter()
					  ...
      __percpu_up_read()

[S] ,-  __this_cpu_dec(*sem->read_count)
    |   smp_rmb();
[L] |   task = rcu_dereference(w->task) // NULL
    |
    |				    [S]	    w->task = current
    |					    smp_mb();
    |				    [L]	    readers_active_check() // fail
    `-> <store happens here>

Where the smp_rmb() (obviously) fails to constrain the store.

[ peterz: Added changelog. ]

Signed-off-by: Prateek Sood <prsood@codeaurora.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Acked-by: Davidlohr Bueso <dbueso@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 8f95c90ceb54 ("sched/wait, RCU: Introduce rcuwait machinery")
Link: https://lkml.kernel.org/r/1543590656-7157-1-git-send-email-prsood@codeaurora.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/exit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 55b4fa6d01ebd..d607e23fd0c3e 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -307,7 +307,7 @@ void rcuwait_wake_up(struct rcuwait *w)
 	 *        MB (A)	      MB (B)
 	 *    [L] cond		  [L] tsk
 	 */
-	smp_rmb(); /* (B) */
+	smp_mb(); /* (B) */
 
 	/*
 	 * Avoid using task_rcu_dereference() magic as long as we are careful,
-- 
2.19.1



