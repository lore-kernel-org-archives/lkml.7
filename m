Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB53C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECEC920856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139815;
	bh=zSrnYiL5OwQjDytkXpn8x3JAC1eugB9gO1N7jis0Qdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0XhHhTN3z1V5EISLSRwA9nxornuTBi5E+9wMkB2J7uV/B/eCDT+wTKx/Iy+kXZOOg
	 3Dh/KRcZQnkW12XmWvfU34GEiDwdXMtVc6OlI6qK3QhNIs/qLrW2+QK5WDrISpeH1o
	 DAA0ZfDMJ03H3RztfiNhPfR+fuoUzCn4ga5kMigc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733056AbfDARaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:30:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:36968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732856AbfDARaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:30:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3C532146E;
        Mon,  1 Apr 2019 17:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139809;
        bh=zSrnYiL5OwQjDytkXpn8x3JAC1eugB9gO1N7jis0Qdo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w6q6yexNn1kw2VBgRoQ8uKzfVQeWCf1SQlkbAwAYAYKb/cVEAPF2gxvP6/vU95qCd
         RKnf/bTmA1o99li+JxVLmBccNonzzAeMoHdi/TNFkRyHMEef0qmaJDL5SlbweF+lpR
         kGGUtIQEYqX4t5YD2wn5D+wNk5JQbn9kVhcJeazM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Morse <james.morse@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.4 021/131] arm64: mm: Add trace_irqflags annotations to do_debug_exception()
Date:   Mon,  1 Apr 2019 19:01:31 +0200
Message-Id: <20190401170053.773108923@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Morse <james.morse@arm.com>

commit 6afedcd23cfd7ac56c011069e4a8db37b46e4623 upstream.

With CONFIG_PROVE_LOCKING, CONFIG_DEBUG_LOCKDEP and CONFIG_TRACE_IRQFLAGS
enabled, lockdep will compare current->hardirqs_enabled with the flags from
local_irq_save().

When a debug exception occurs, interrupts are disabled in entry.S, but
lockdep isn't told, resulting in:
DEBUG_LOCKS_WARN_ON(current->hardirqs_enabled)
------------[ cut here ]------------
WARNING: at ../kernel/locking/lockdep.c:3523
Modules linked in:
CPU: 3 PID: 1752 Comm: perf Not tainted 4.5.0-rc4+ #2204
Hardware name: ARM Juno development board (r1) (DT)
task: ffffffc974868000 ti: ffffffc975f40000 task.ti: ffffffc975f40000
PC is at check_flags.part.35+0x17c/0x184
LR is at check_flags.part.35+0x17c/0x184
pc : [<ffffff80080fc93c>] lr : [<ffffff80080fc93c>] pstate: 600003c5
[...]
---[ end trace 74631f9305ef5020 ]---
Call trace:
[<ffffff80080fc93c>] check_flags.part.35+0x17c/0x184
[<ffffff80080ffe30>] lock_acquire+0xa8/0xc4
[<ffffff8008093038>] breakpoint_handler+0x118/0x288
[<ffffff8008082434>] do_debug_exception+0x3c/0xa8
[<ffffff80080854b4>] el1_dbg+0x18/0x6c
[<ffffff80081e82f4>] do_filp_open+0x64/0xdc
[<ffffff80081d6e60>] do_sys_open+0x140/0x204
[<ffffff80081d6f58>] SyS_openat+0x10/0x18
[<ffffff8008085d30>] el0_svc_naked+0x24/0x28
possible reason: unannotated irqs-off.
irq event stamp: 65857
hardirqs last  enabled at (65857): [<ffffff80081fb1c0>] lookup_mnt+0xf4/0x1b4
hardirqs last disabled at (65856): [<ffffff80081fb188>] lookup_mnt+0xbc/0x1b4
softirqs last  enabled at (65790): [<ffffff80080bdca4>] __do_softirq+0x1f8/0x290
softirqs last disabled at (65757): [<ffffff80080be038>] irq_exit+0x9c/0xd0

This patch adds the annotations to do_debug_exception(), while trying not
to call trace_hardirqs_off() if el1_dbg() interrupted a task that already
had irqs disabled.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/mm/fault.c |   33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -595,20 +595,33 @@ asmlinkage int __exception do_debug_exce
 {
 	const struct fault_info *inf = debug_fault_info + DBG_ESR_EVT(esr);
 	struct siginfo info;
+	int rv;
 
-	if (!inf->fn(addr, esr, regs))
-		return 1;
+	/*
+	 * Tell lockdep we disabled irqs in entry.S. Do nothing if they were
+	 * already disabled to preserve the last enabled/disabled addresses.
+	 */
+	if (interrupts_enabled(regs))
+		trace_hardirqs_off();
 
-	pr_alert("Unhandled debug exception: %s (0x%08x) at 0x%016lx\n",
-		 inf->name, esr, addr);
+	if (!inf->fn(addr, esr, regs)) {
+		rv = 1;
+	} else {
+		pr_alert("Unhandled debug exception: %s (0x%08x) at 0x%016lx\n",
+			 inf->name, esr, addr);
 
-	info.si_signo = inf->sig;
-	info.si_errno = 0;
-	info.si_code  = inf->code;
-	info.si_addr  = (void __user *)addr;
-	arm64_notify_die("", regs, &info, 0);
+		info.si_signo = inf->sig;
+		info.si_errno = 0;
+		info.si_code  = inf->code;
+		info.si_addr  = (void __user *)addr;
+		arm64_notify_die("", regs, &info, 0);
+		rv = 0;
+	}
 
-	return 0;
+	if (interrupts_enabled(regs))
+		trace_hardirqs_on();
+
+	return rv;
 }
 
 #ifdef CONFIG_ARM64_PAN


