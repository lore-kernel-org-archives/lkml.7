Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE91C10F03
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A59C12183E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbfCVPr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:47:28 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:50135 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727438AbfCVPr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:47:27 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mz9hF-1glrBT0Dlz-00wEbJ; Fri, 22 Mar 2019 16:46:56 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     stable@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        James Morse <james.morse@arm.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Andrey Konovalov <andreyknvl@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [BACKPORT 4.4.y 10/25] arm64: mm: Add trace_irqflags annotations to do_debug_exception()
Date:   Fri, 22 Mar 2019 16:44:01 +0100
Message-Id: <20190322154425.3852517-11-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190322154425.3852517-1-arnd@arndb.de>
References: <20190322154425.3852517-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ZFpF8CAe8AmBwG8PGJWPFop0PRfjbeBIlad56HwVq67hsFHJ0tt
 /vTMl2X1z7FjJcfBD0yN8KM2IpfFg+j50kqftvc8+oe9L9ijCZIB96BSaGpzYkwAB3tKm5x
 QsQSsWeUgJ4gewKBKXcbAFOG+noCIE8Jlpu1KFR853UTVguO/qJWsuPHpuFMH4tfXZccPsR
 OKODfg19h+O9i3y9U71xQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vhym0IdyrDA=:IagoDTjJ/AZm8MOUQihw/h
 lfjIfsiKuAjcr0YkJUa3nKwnT87irDoj13onxU3W5TDW0hf4b9zn9hX/tbM+y3Kd3QZY9nW4P
 ENXHg/s6eOeXdL/57nJ3gRv4nWemwtl58VGfkAJ/9GQRdeb4RZO3oaMPLSBP6XDcsIdZ+Idp4
 jXvlvemWe6/NVlMZMALxF3//wuKh9mj0yT0WuAeKNOJ0BYycfiAxtLPnnJr8rJnw58QvCZ0ZF
 MK26TbIvudgq7V25j37GDFSAUKSfLEhsaFJEPlHPH0eO+OeycXf2dsU4DhLSVSXw59ibyHzwU
 SEni14uvrS8VhclQLU6h69oKllWXhaY2F+GpDcxxdxPb+KglXhXgMOFZO/IrrjUlZPzx0nDud
 cf6sj3qJA69QviQTQgygrApzKDiROW/IS1pABbOvyJoMLmyfP4b7ykMmYlWnorrgqwdh0+KSH
 OU3zPAxbKIWvkr2g+XuRnAa9d9lC005SfdyTJjBwS2PuBjfWJpNBRgISiNe82vigjFLRYl0gP
 m736lhhI/A7M2uTQBr/PhBhc+UsBteTXBV5ZG+7u/fx7jIRqNVOChl+BElMvlbSrgkbbVKIGq
 y86Da3naDGq/+sZryHTJZ143Z1/7CHhrrG7g00LrJ7pJoIu7jiyjVVUPIdQVv5LEgAW6HE20B
 Bjs4+SlMn0PTY8zvXnTC7v+YAPGsRnOWEKL1Y0kMjEc/X2G1vOMH91h1y3J+fc2lVvvHsiFT9
 ccvN6lPlR10SMbWu8ROHz45cwbajO7eTSOlrjw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Morse <james.morse@arm.com>

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
(cherry picked from commit 6afedcd23cfd7ac56c011069e4a8db37b46e4623)
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/mm/fault.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index be7f8416809f..04c4b88706d8 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -595,20 +595,33 @@ asmlinkage int __exception do_debug_exception(unsigned long addr,
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
+
+		info.si_signo = inf->sig;
+		info.si_errno = 0;
+		info.si_code  = inf->code;
+		info.si_addr  = (void __user *)addr;
+		arm64_notify_die("", regs, &info, 0);
+		rv = 0;
+	}
 
-	info.si_signo = inf->sig;
-	info.si_errno = 0;
-	info.si_code  = inf->code;
-	info.si_addr  = (void __user *)addr;
-	arm64_notify_die("", regs, &info, 0);
+	if (interrupts_enabled(regs))
+		trace_hardirqs_on();
 
-	return 0;
+	return rv;
 }
 
 #ifdef CONFIG_ARM64_PAN
-- 
2.20.0

