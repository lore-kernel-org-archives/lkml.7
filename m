Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CA8C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A00A620652
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfCGJQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 04:16:01 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:58063 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfCGJQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 04:16:00 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MavF5-1gVWVq1TCt-00cUMs; Thu, 07 Mar 2019 10:15:33 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mikael Pettersson <mikpe@it.uu.se>,
        Mikael Pettersson <mikpelinux@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: futex: make futex_detect_cmpxchg more reliable
Date:   Thu,  7 Mar 2019 10:14:49 +0100
Message-Id: <20190307091514.2489338-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190307091514.2489338-1-arnd@arndb.de>
References: <20190307091514.2489338-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:d8KGsnS5I5jJ69letBdYqJMsef6CKlINAH4fRowUoENhI3Wj5Oz
 XQzXp+l7Zv0gYInCjyd3uARXmT6Dz0ERe80AM40RF0ipFK4jBAF+/1bOH+W/X9myqZpdQ3t
 ovCX5yOkGgDRJJXGWQPdIFbRGyzhBmeHqo4vm0J8gnT8G9QvNHxUlwgrQOtlqkJBtVijf+G
 nQisNIXf/OnQwkH/rnp4Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zcJO1LULneg=:37AzrR9WoMpjoMCrxyWa08
 zJKL7raTOs/Vaht+hOTaY87qL5QvUbW9tib1GjK8WfUAo76qh5rrvvS6/yDoqF8JBNIeXUUgv
 MBmIyq2oNNJN8oBI7iy7ExGk+PLZy+NDs7BQFMbkKMJp/lTulMXKMfhOhuzkjiuiRCI6kAFHF
 SGUZQyeAkzf/Ql2sif15cIsEBSRDo9rX1CiS3G9fsPLgpymnBkMrNkrBeT45OTH8eD04sVLmT
 LNFfYhveQ+9mSpptIn+knDxhK7MDzdmBX7bOV4mOzazZOoOZthl3YWz2MU/SodJdLxpkl716I
 Fo/fPIFQWWYRu8Qn/NJfi7qHG8c7ecavvyqtiErHv5bz/y5Mkmy/WILVFlf2y4ljFwXCD2cFV
 2QX3ZZlG8MZLcnGzahakZildLgjRlfWpRTj6V00nN7p7f6dxZEd0NHffpZ8DUAkUHncuUblWT
 92YtibFG6rX3hiDUpiNln0cllH9z3Q4ydka5d3jSPSgfNyJZyAnEHXzT/jNWhTmxaU4gtxt19
 wOj5NWEnb0/q5NdVpA7LYh7M67v9bZdGrbAqli8bEvoqhSIeuVyzd6DOmRp9U7QHn+Url8jIL
 47asrP6AHLijJor9S59D/l+5nRlmMa7ngCCtb0flx4p8SSjzj6hj7QPRkvH3WjqM62efDNkzY
 5bspvKYd3rE7Z0Q6ZyyzHoEs37bXqZbQ2bdSzIr74RwwYwO7PuCyUQXspmqwFxv3tnVko9Cfn
 dqFQgE0nNcLniH3o3yaRXtVqcwz9Ehlsk84RpA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Passing registers containing zero as both the address (NULL pointer)
and data into cmpxchg_futex_value_locked() leads clang to assign
the same register for both inputs on ARM, which triggers a warning
explaining that this instruction has unpredictable behavior on ARMv5.

/tmp/futex-7e740e.s: Assembler messages:
/tmp/futex-7e740e.s:12713: Warning: source register same as write-back base

This patch was suggested by Mikael Pettersson back in 2011 (!) with gcc-4.4,
as Mikael wrote:
 "One way of fixing this is to make uaddr an input/output register, since
 "that prevents it from overlapping any other input or output."

but then withdrawn as the warning was determined to be harmless, and it
apparently never showed up again with later gcc versions.

Now the same problem is back when compiling with clang, and we are trying
to get clang to build the kernel without warnings, as gcc normally does.

Cc: Mikael Pettersson <mikpe@it.uu.se>
Cc: Mikael Pettersson <mikpelinux@gmail.com>
Cc: Dave Martin <Dave.Martin@arm.com>
Link: https://lore.kernel.org/linux-arm-kernel/20009.45690.158286.161591@pilspetsen.it.uu.se/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/asm/futex.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/futex.h b/arch/arm/include/asm/futex.h
index 0a46676b4245..79790912974e 100644
--- a/arch/arm/include/asm/futex.h
+++ b/arch/arm/include/asm/futex.h
@@ -110,13 +110,13 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 	preempt_disable();
 	__ua_flags = uaccess_save_and_enable();
 	__asm__ __volatile__("@futex_atomic_cmpxchg_inatomic\n"
-	"1:	" TUSER(ldr) "	%1, [%4]\n"
-	"	teq	%1, %2\n"
+	"1:	" TUSER(ldr) "	%1, [%2]\n"
+	"	teq	%1, %3\n"
 	"	it	eq	@ explicit IT needed for the 2b label\n"
-	"2:	" TUSER(streq) "	%3, [%4]\n"
+	"2:	" TUSER(streq) "	%4, [%2]\n"
 	__futex_atomic_ex_table("%5")
-	: "+r" (ret), "=&r" (val)
-	: "r" (oldval), "r" (newval), "r" (uaddr), "Ir" (-EFAULT)
+	: "+&r" (ret), "=&r" (val), "+&r" (uaddr)
+	: "r" (oldval), "r" (newval), "Ir" (-EFAULT)
 	: "cc", "memory");
 	uaccess_restore(__ua_flags);
 
-- 
2.20.0

