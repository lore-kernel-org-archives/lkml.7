Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E039C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 05:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 614AB21849
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 05:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563428643;
	bh=gfhHae/Itpt4cAnEUBWjU+vv/jZ4knj9Gh5tlJZH32w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y72fiv5GwWkCzA5sKaFiPvq0YG027WulgkOdIQksA+R+Ah+Eq1E3nJh1GPoGIiFwb
	 CLnHtZvNN2Oe/y1yIm1CS/+QP3qdu2ygnwkM3/ALfgy5BCkNnxD4zoT1VmtY9ZcDow
	 K/b3AfPWwAdnERrRoTw8yJYFvtErQliwoeugb0aM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388738AbfGRFoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 01:44:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:59818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfGRFoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 01:44:01 -0400
Received: from localhost.localdomain (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB1742077C;
        Thu, 18 Jul 2019 05:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563428641;
        bh=gfhHae/Itpt4cAnEUBWjU+vv/jZ4knj9Gh5tlJZH32w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NbZK2rcN4p4Do4xNZrSCrpocqmzJSvw185NluBokppvstd5PDELeRoeBvlxWmbx/j
         5Z86mXbG9w36rFsAnbjFo6pNCtSmcdmZCEl3JBF6w4BplF9d9OaxK4npYS1TQtZzq+
         o6puJrBaLviuSqMUn4YcVdYNnFDnm7ukvjVfqNoU=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     mhiramat@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Dan Rue <dan.rue@linaro.org>,
        Matt Hart <matthew.hart@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Daniel Diaz <daniel.diaz@linaro.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH 3/3] arm64: debug: Remove rcu_read_lock from debug exception
Date:   Thu, 18 Jul 2019 14:43:58 +0900
Message-Id: <156342863822.8565.7624877983728871995.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <156342860634.8565.14804606041960884732.stgit@devnote2>
References: <156342860634.8565.14804606041960884732.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove rcu_read_lock()/rcu_read_unlock() from debug exception
handlers since the software breakpoint can be hit on idle task.

Actually, we don't need it because those handlers run in exception
context where the interrupts are disabled. This means those are never
preempted.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Paul E. McKenney <paulmck@linux.ibm.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/arm64/kernel/debug-monitors.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index f8719bd30850..48222a4760c2 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -207,16 +207,16 @@ static int call_step_hook(struct pt_regs *regs, unsigned int esr)
 
 	list = user_mode(regs) ? &user_step_hook : &kernel_step_hook;
 
-	rcu_read_lock();
-
+	/*
+	 * Since single-step exception disables interrupt, this function is
+	 * entirely not preemptible, and we can use rcu list safely here.
+	 */
 	list_for_each_entry_rcu(hook, list, node)	{
 		retval = hook->fn(regs, esr);
 		if (retval == DBG_HOOK_HANDLED)
 			break;
 	}
 
-	rcu_read_unlock();
-
 	return retval;
 }
 NOKPROBE_SYMBOL(call_step_hook);
@@ -305,14 +305,16 @@ static int call_break_hook(struct pt_regs *regs, unsigned int esr)
 
 	list = user_mode(regs) ? &user_break_hook : &kernel_break_hook;
 
-	rcu_read_lock();
+	/*
+	 * Since brk exception disables interrupt, this function is
+	 * entirely not preemptible, and we can use rcu list safely here.
+	 */
 	list_for_each_entry_rcu(hook, list, node) {
 		unsigned int comment = esr & ESR_ELx_BRK64_ISS_COMMENT_MASK;
 
 		if ((comment & ~hook->mask) == hook->imm)
 			fn = hook->fn;
 	}
-	rcu_read_unlock();
 
 	return fn ? fn(regs, esr) : DBG_HOOK_ERROR;
 }

