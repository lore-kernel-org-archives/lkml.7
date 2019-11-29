Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7DEC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 13:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A995E20869
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 13:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="GKwPlM0V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfK2NVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 08:21:52 -0500
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:47326 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726608AbfK2NVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 08:21:52 -0500
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id B3C3B2E147E;
        Fri, 29 Nov 2019 16:21:47 +0300 (MSK)
Received: from iva4-c987840161f8.qloud-c.yandex.net (iva4-c987840161f8.qloud-c.yandex.net [2a02:6b8:c0c:3da5:0:640:c987:8401])
        by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id WVdThNk2bC-Lko8mbA5;
        Fri, 29 Nov 2019 16:21:47 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1575033707; bh=jRi6N5+4AEBul8ckE0my3E31N2e5qWBXeGfURkjwdqw=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=GKwPlM0VJuneSyS6ItckX4GQB3y2+YyunBe5XsL2iWgKyP5W1/6KVMQLtmd6k4XVT
         mIclMrp/M93HO73Ls3vGMVE8kOXjFkaiVmp+Wb7/O75lWtQKB8hSVB5CUwjL2t5h9M
         o9mYjZYo7zG7Zb2Yz4UdWeIF9XVlmerlX07p8Dys=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:1009:4fae:ad87:4eae])
        by iva4-c987840161f8.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id tYrfCbqUNY-LkWG38D3;
        Fri, 29 Nov 2019 16:21:46 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH 1/2] kernel: set taint flag 'L' at any kind of lockup
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Sasha Levin <sashal@kernel.org>, Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rcu@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Fri, 29 Nov 2019 16:21:46 +0300
Message-ID: <157503370645.8187.6335564487789994134.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any lockup or stall notifies about unexpected lack of progress.
It's better to know about them for further problem investigations.

Right now only softlockup has own taint flag. Let's generalize it.

This patch renames TAINT_SOFTLOCKUP into TAINT_LOCKUP at sets it for:
- softlockup
- hardlockup
- RCU stalls
- stuck in workqueues
- detected task hung

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 Documentation/admin-guide/sysctl/kernel.rst   |    2 +-
 Documentation/admin-guide/tainted-kernels.rst |    8 ++++++--
 include/linux/kernel.h                        |    2 +-
 kernel/hung_task.c                            |    2 ++
 kernel/panic.c                                |    2 +-
 kernel/rcu/tree_stall.h                       |    1 +
 kernel/watchdog.c                             |    2 +-
 kernel/watchdog_hld.c                         |    1 +
 kernel/workqueue.c                            |    1 +
 tools/debugging/kernel-chktaint               |    2 +-
 10 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 032c7cd3cede..60867ec525a4 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1082,7 +1082,7 @@ ORed together. The letters are seen in "Tainted" line of Oops reports.
   2048  `(I)`  workaround for bug in platform firmware applied
   4096  `(O)`  externally-built ("out-of-tree") module was loaded
   8192  `(E)`  unsigned module was loaded
- 16384  `(L)`  soft lockup occurred
+ 16384  `(L)`  lockup occurred
  32768  `(K)`  kernel has been live patched
  65536  `(X)`  Auxiliary taint, defined and used by for distros
 131072  `(T)`  The kernel was built with the struct randomization plugin
diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
index 71e9184a9079..fc76d0aad9f5 100644
--- a/Documentation/admin-guide/tainted-kernels.rst
+++ b/Documentation/admin-guide/tainted-kernels.rst
@@ -96,7 +96,7 @@ Bit  Log  Number  Reason that got the kernel tainted
  11  _/I    2048  workaround for bug in platform firmware applied
  12  _/O    4096  externally-built ("out-of-tree") module was loaded
  13  _/E    8192  unsigned module was loaded
- 14  _/L   16384  soft lockup occurred
+ 14  _/L   16384  lockup occurred
  15  _/K   32768  kernel has been live patched
  16  _/X   65536  auxiliary taint, defined for and used by distros
  17  _/T  131072  kernel was built with the struct randomization plugin
@@ -152,7 +152,11 @@ More detailed explanation for tainting
  13) ``E`` if an unsigned module has been loaded in a kernel supporting
      module signature.
 
- 14) ``L`` if a soft lockup has previously occurred on the system.
+ 14) ``L`` if some kind of lockup has previously occurred on the system:
+     - soft/hardlockup, see Documentation/admin-guide/lockup-watchdogs.rst
+     - RCU stall, see Documentation/RCU/stallwarn.txt
+     - hung task detected, see CONFIG_DETECT_HUNG_TASK
+     - kernel workqueue lockup, see CONFIG_WQ_WATCHDOG
 
  15) ``K`` if the kernel has been live patched.
 
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index d83d403dac2e..e8a6808e4f2f 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -591,7 +591,7 @@ extern enum system_states {
 #define TAINT_FIRMWARE_WORKAROUND	11
 #define TAINT_OOT_MODULE		12
 #define TAINT_UNSIGNED_MODULE		13
-#define TAINT_SOFTLOCKUP		14
+#define TAINT_LOCKUP			14
 #define TAINT_LIVEPATCH			15
 #define TAINT_AUX			16
 #define TAINT_RANDSTRUCT		17
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 14a625c16cb3..521eb2fbf5fc 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -139,6 +139,8 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 		hung_task_show_lock = true;
 	}
 
+	add_taint(TAINT_LOCKUP, LOCKDEP_STILL_OK);
+
 	touch_nmi_watchdog();
 }
 
diff --git a/kernel/panic.c b/kernel/panic.c
index f470a038b05b..d7750a45ca8d 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -372,7 +372,7 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
 	[ TAINT_FIRMWARE_WORKAROUND ]	= { 'I', ' ', false },
 	[ TAINT_OOT_MODULE ]		= { 'O', ' ', true },
 	[ TAINT_UNSIGNED_MODULE ]	= { 'E', ' ', true },
-	[ TAINT_SOFTLOCKUP ]		= { 'L', ' ', false },
+	[ TAINT_LOCKUP ]		= { 'L', ' ', false },
 	[ TAINT_LIVEPATCH ]		= { 'K', ' ', true },
 	[ TAINT_AUX ]			= { 'X', ' ', true },
 	[ TAINT_RANDSTRUCT ]		= { 'T', ' ', true },
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index c0b8c458d8a6..181495efff80 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -74,6 +74,7 @@ early_initcall(check_cpu_stall_init);
 /* If so specified via sysctl, panic, yielding cleaner stall-warning output. */
 static void panic_on_rcu_stall(void)
 {
+	add_taint(TAINT_LOCKUP, LOCKDEP_STILL_OK);
 	if (sysctl_panic_on_rcu_stall)
 		panic("RCU Stall\n");
 }
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index f41334ef0971..d60b195708f7 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -466,7 +466,7 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 			smp_mb__after_atomic();
 		}
 
-		add_taint(TAINT_SOFTLOCKUP, LOCKDEP_STILL_OK);
+		add_taint(TAINT_LOCKUP, LOCKDEP_STILL_OK);
 		if (softlockup_panic)
 			panic("softlockup: hung tasks");
 		__this_cpu_write(soft_watchdog_warn, true);
diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
index 247bf0b1582c..f77256f47422 100644
--- a/kernel/watchdog_hld.c
+++ b/kernel/watchdog_hld.c
@@ -152,6 +152,7 @@ static void watchdog_overflow_callback(struct perf_event *event,
 				!test_and_set_bit(0, &hardlockup_allcpu_dumped))
 			trigger_allbutself_cpu_backtrace();
 
+		add_taint(TAINT_LOCKUP, LOCKDEP_STILL_OK);
 		if (hardlockup_panic)
 			nmi_panic(regs, "Hard LOCKUP");
 
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index bc2e09a8ea61..825a92893882 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5741,6 +5741,7 @@ static void wq_watchdog_timer_fn(struct timer_list *unused)
 			pr_cont_pool_info(pool);
 			pr_cont(" stuck for %us!\n",
 				jiffies_to_msecs(jiffies - pool_ts) / 1000);
+			add_taint(TAINT_LOCKUP, LOCKDEP_STILL_OK);
 		}
 	}
 
diff --git a/tools/debugging/kernel-chktaint b/tools/debugging/kernel-chktaint
index 2240cb56e6e5..9f24719d8c80 100755
--- a/tools/debugging/kernel-chktaint
+++ b/tools/debugging/kernel-chktaint
@@ -168,7 +168,7 @@ if [ `expr $T % 2` -eq 0 ]; then
 	addout " "
 else
 	addout "L"
-	echo " * soft lockup occurred (#14)"
+	echo " * lockup occurred (#14)"
 fi
 
 T=`expr $T / 2`

