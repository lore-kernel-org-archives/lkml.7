Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68743C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3563C214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W6r6NVsS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbfGaSiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 14:38:02 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34621 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbfGaSiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 14:38:02 -0400
Received: by mail-pg1-f196.google.com with SMTP id n9so26258643pgc.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 11:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zjtC8sWjZNJx0P6yMG+1aWsfMer3nnMRaqwuNWwAHUA=;
        b=W6r6NVsSM3sfuwYaY4kLS85qQNfzYFtMTI130jGDvP1R+VuOuUwQtF64QwOqDNzNEt
         +DuF4HJThWpun+jqGczik3D9VNSKQCBCESg+3xiq8E8J1ZB2EhQaOgtof/TD83ybsb8D
         JqLs+CG/oEYkAQUr1z4npXyg6V7qU7Ftr6UBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zjtC8sWjZNJx0P6yMG+1aWsfMer3nnMRaqwuNWwAHUA=;
        b=khoAjaoV/NW0i3kG6HefLP5y9vRISjijtLoK5s9Qq+v2aA8zQQF0xVcHtYrnsJwIWj
         lBOuvL8PuVUIYRRpHa9NR6w2qfORKyQZn7kAOyKUzurjwg0VExNczqE2QeG8w6wiRUqn
         KXqK3aw8vjAsFUu0SbFGO1GJ8XsVMk++PQSCorUkkn8LQVieRW9pHm9cSoc1zSO3pvMM
         xndcHfG8K1b4fXLNiKQ1AOpkg6oQk+YgaHLS+BJR8CqcH/ggL+UPnXjc/sb5W5srfrPh
         aWT9QCqUElmEGxzK4S89+8R9ya+MSZCsJVtm5pTe74A6xTG8bAdaKxgbMe/vRah5jAyL
         NTwg==
X-Gm-Message-State: APjAAAVGGaq5PXmcToOYu5G36LqQLfZlL1PBmgGbw48UyeV2IHSC/8pz
        31DhFHnD3xdysDepWyDSEa2w0iwdwmo=
X-Google-Smtp-Source: APXvYqz2lOY5ye/a8/v4SX9s061hy4NQdE6wREGK6sZ1cqPFLmnEgkpDzKvR/YCGdE18IDSL0nneVg==
X-Received: by 2002:aa7:8007:: with SMTP id j7mr48381112pfi.154.1564598281165;
        Wed, 31 Jul 2019 11:38:01 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id u69sm91315929pgu.77.2019.07.31.11.38.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 11:38:00 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Douglas Anderson <dianders@chromium.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] kdb: Fix stack crawling on 'running' CPUs that aren't the master
Date:   Wed, 31 Jul 2019 11:37:32 -0700
Message-Id: <20190731183732.178134-1-dianders@chromium.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In kdb when you do 'btc' (back trace on CPU) it doesn't necessarily
give you the right info.  Specifically on many architectures
(including arm64, where I tested) you can't dump the stack of a
"running" process that isn't the process running on the current CPU.
This can be seen by this:

 echo SOFTLOCKUP > /sys/kernel/debug/provoke-crash/DIRECT
 # wait 2 seconds
 <sysrq>g

Here's what I see now on rk3399-gru-kevin.  I see the stack crawl for
the CPU that handled the sysrq but everything else just shows me stuck
in __switch_to() which is bogus:

======

[0]kdb> btc
btc: cpu status: Currently on cpu 0
Available cpus: 0, 1-3(I), 4, 5(I)
Stack traceback for pid 0
0xffffff801101a9c0        0        0  1    0   R  0xffffff801101b3b0 *swapper/0
Call trace:
 dump_backtrace+0x0/0x138
 ...
 kgdb_compiled_brk_fn+0x34/0x44
 ...
 sysrq_handle_dbg+0x34/0x5c
Stack traceback for pid 0
0xffffffc0f175a040        0        0  1    1   I  0xffffffc0f175aa30  swapper/1
Call trace:
 __switch_to+0x1e4/0x240
 0xffffffc0f65616c0
Stack traceback for pid 0
0xffffffc0f175d040        0        0  1    2   I  0xffffffc0f175da30  swapper/2
Call trace:
 __switch_to+0x1e4/0x240
 0xffffffc0f65806c0
Stack traceback for pid 0
0xffffffc0f175b040        0        0  1    3   I  0xffffffc0f175ba30  swapper/3
Call trace:
 __switch_to+0x1e4/0x240
 0xffffffc0f659f6c0
Stack traceback for pid 1474
0xffffffc0dde8b040     1474      727  1    4   R  0xffffffc0dde8ba30  bash
Call trace:
 __switch_to+0x1e4/0x240
 __schedule+0x464/0x618
 0xffffffc0dde8b040
Stack traceback for pid 0
0xffffffc0f17b0040        0        0  1    5   I  0xffffffc0f17b0a30  swapper/5
Call trace:
 __switch_to+0x1e4/0x240
 0xffffffc0f65dd6c0

===

The problem is that 'btc' eventually boils down to
  show_stack(task_struct, NULL);

...and show_stack() doesn't work for "running" CPUs because their
registers haven't been stashed.

On x86 things might work better (I haven't tested) because kdb has a
special case for x86 in kdb_show_stack() where it passes the stack
pointer to show_stack().  This wouldn't work on arm64 where the stack
crawling function seems needs the "fp" and "pc", not the "sp" which is
presumably why arm64's show_stack() function totally ignores the "sp"
parameter.

NOTE: we _can_ get a good stack dump for all the cpus if we manually
switch each one to the kdb master and do a back trace.  AKA:
  cpu 4
  bt
...will give the expected trace.  That's because now arm64's
dump_backtrace will now see that "tsk == current" and go through a
different path.

In this patch I fix the problems by catching a request to stack crawl
a task that's running on a CPU and then I ask that CPU to do the stack
crawl.

NOTE: this will (presumably) change what stack crawls are printed for
x86 machines.  Now kdb functions will show up in the stack crawl.
Presumably this is OK but if it's not we can go back and add a special
case for x86 again.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Totally new approach; now arch agnostic.

 kernel/debug/debug_core.c |  5 +++++
 kernel/debug/debug_core.h |  1 +
 kernel/debug/kdb/kdb_bt.c | 44 ++++++++++++++++++++++++++++++---------
 3 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 5cc608de6883..a89c72714fe6 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -92,6 +92,8 @@ static int kgdb_use_con;
 bool dbg_is_early = true;
 /* Next cpu to become the master debug core */
 int dbg_switch_cpu;
+/* cpu number of slave we request a stack crawl of */
+int dbg_slave_dumpstack_cpu = -1;
 
 /* Use kdb or gdbserver mode */
 int dbg_kdb_mode = 1;
@@ -580,6 +582,9 @@ static int kgdb_cpu_enter(struct kgdb_state *ks, struct pt_regs *regs,
 				atomic_xchg(&kgdb_active, cpu);
 				break;
 			}
+		} else if (dbg_slave_dumpstack_cpu == cpu) {
+			dump_stack();
+			dbg_slave_dumpstack_cpu = -1;
 		} else if (kgdb_info[cpu].exception_state & DCPU_IS_SLAVE) {
 			if (!raw_spin_is_locked(&dbg_slave_lock))
 				goto return_normal;
diff --git a/kernel/debug/debug_core.h b/kernel/debug/debug_core.h
index b4a7c326d546..dca74d5caef2 100644
--- a/kernel/debug/debug_core.h
+++ b/kernel/debug/debug_core.h
@@ -62,6 +62,7 @@ extern int dbg_io_get_char(void);
 /* Switch from one cpu to another */
 #define DBG_SWITCH_CPU_EVENT -123456
 extern int dbg_switch_cpu;
+extern int dbg_slave_dumpstack_cpu;
 
 /* gdbstub interface functions */
 extern int gdb_serial_stub(struct kgdb_state *ks);
diff --git a/kernel/debug/kdb/kdb_bt.c b/kernel/debug/kdb/kdb_bt.c
index 7e2379aa0a1e..10095ae05826 100644
--- a/kernel/debug/kdb/kdb_bt.c
+++ b/kernel/debug/kdb/kdb_bt.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/ctype.h>
+#include <linux/delay.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
 #include <linux/sched/signal.h>
@@ -22,20 +23,43 @@
 static void kdb_show_stack(struct task_struct *p, void *addr)
 {
 	int old_lvl = console_loglevel;
+	int time_left;
+	int cpu;
+
 	console_loglevel = CONSOLE_LOGLEVEL_MOTORMOUTH;
 	kdb_trap_printk++;
-	kdb_set_current_task(p);
-	if (addr) {
-		show_stack((struct task_struct *)p, addr);
-	} else if (kdb_current_regs) {
-#ifdef CONFIG_X86
-		show_stack(p, &kdb_current_regs->sp);
-#else
-		show_stack(p, NULL);
-#endif
+
+	if (!addr && kdb_task_has_cpu(p)) {
+		cpu = kdb_process_cpu(p);
+
+		if (cpu == raw_smp_processor_id()) {
+			dump_stack();
+			goto exit;
+		}
+
+		/*
+		 * In general architectures don't support dumping the stack
+		 * of a "running" process that's not the current one so if
+		 * we want to dump the stack of a running process that's not
+		 * the master then we'll set a global letting the slave
+		 * (which should be looping) know to dump its own stack.
+		 */
+		dbg_slave_dumpstack_cpu = cpu;
+		for (time_left = MSEC_PER_SEC; time_left; time_left--) {
+			udelay(1000);
+			if (dbg_slave_dumpstack_cpu == -1)
+				break;
+		}
+		if (dbg_slave_dumpstack_cpu != -1) {
+			kdb_printf("ERROR: Timeout dumping CPU %d stack\n",
+				   cpu);
+			dbg_slave_dumpstack_cpu = -1;
+		}
 	} else {
-		show_stack(p, NULL);
+		show_stack(p, addr);
 	}
+
+exit:
 	console_loglevel = old_lvl;
 	kdb_trap_printk--;
 }
-- 
2.22.0.770.g0f2c4a37fd-goog

