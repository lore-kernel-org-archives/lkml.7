Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFF9C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 07:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA64C222FA
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 07:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563781759;
	bh=Gr05QR1hL7O+2tzL84PlqgJUM44tyb63rrhJfu4GtP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SAG99v5OIaNu/JmAxJA+5kl4tRMr74i7LWltyjcWlDndoKS3KQeqvnSsMhaqsp8I2
	 +DjmY/oNHF5LVwFZxSoS591xtNH9oTckaxWVrac07ikgjJpu/pQKxb5r88wMJRYA75
	 ShuSIUuFEH5unzw/aeG0XJp284cnIXE7KKSqVhEk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbfGVHtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 03:49:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:33174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727164AbfGVHtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 03:49:17 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8AC12229C;
        Mon, 22 Jul 2019 07:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563781756;
        bh=Gr05QR1hL7O+2tzL84PlqgJUM44tyb63rrhJfu4GtP0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kEV7DJS52TP6EVFczUmwAz/ukrBdOqPydQi6XOdGzphoTVb3yaak3oCzZCV77IfJj
         evHq82f+uz1VL5mxSm8qATXcNsScSVxwkn+ZxMlEtycjmBOFt+dO0mgYBp4IwApTmH
         M1kKJ7/EOw8MMzNE4yEv4lihH/pwKzlZFz58dNWk=
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
Subject: [PATCH v2 4/4] arm64: Remove unneeded rcu_read_lock from debug handlers
Date:   Mon, 22 Jul 2019 16:49:11 +0900
Message-Id: <156378175027.12011.5591853683946780785.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <156378170297.12011.17385386326930403235.stgit@devnote2>
References: <156378170297.12011.17385386326930403235.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove rcu_read_lock()/rcu_read_unlock() from debug exception
handlers since we are sure those are not preemptible and
interrupts are off.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Paul E. McKenney <paulmck@linux.ibm.com>
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

