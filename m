Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BODY_QUOTE_MALF_MSGID,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38264C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 20:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F14A721D7F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 20:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mvymCA6A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392685AbfIYUC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 16:02:57 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45314 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443255AbfIYUCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 16:02:55 -0400
Received: by mail-pg1-f193.google.com with SMTP id q7so99119pgi.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 13:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YRt/eEJ29XhNKtyI1qPJ2Nb4RWiKnBfQoOt31k2/Z4s=;
        b=mvymCA6AIlDSmZ98IG9iMxIgvZsncwKTDeN77JJWZZHOAshG9W85FTpVLwDDadzYQI
         zcZ3NeUXHTFlxGv5z2kxk5S/U91yYigT/8nlgfxWpkoR01v9I0RfGbOXYoX+NATtdPd7
         wZb5MNKvn0Bluq6+BasmMQUShLZkQQw+NdZQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YRt/eEJ29XhNKtyI1qPJ2Nb4RWiKnBfQoOt31k2/Z4s=;
        b=jTG1FxLQs71uIeviJT7AmQwNFX68fLnrAdRvw3d8j3/WV84GEwsk2MZkG0KLZHQYFM
         M5eT/mHyUjWEo2SjGImbUqB9t+BNPz5zvwnKLV1UNSw+yOJ3lFiPgE8/zDoEfAO4+RRG
         l74fdBqGhoUxLiSVmwaKfQmLYvh8bAiTmopWA8fTgVOIyVr488i7sZ3g/WRGXWKR7Ppk
         3Re7lufAU2HjQPyORBJK0Rs7yZQglFRhM6HvW+T+ihTTYlMT1bombG4PG/BWFF39s52W
         Bx0idI0HWTdYy6vzbdv9Red/N9BMH4FcGWCVZqDlbEhrQkSqZYUM2zsErQzpnuIuKaAo
         8jDA==
X-Gm-Message-State: APjAAAUFT67OxKupjnJGWlP70XVppPcx6Mx9NHKPonKNqmf11nbJ3zdr
        p3mrFcsR1T2mXWQbz0hGxpFZjw==
X-Google-Smtp-Source: APXvYqwHCU7VIXvdQR2iZggvDKwvnxx7yxqiC1zNImVIOaOqVwGEcVg+tDTfBUR2WryxgLvIrKYP4g==
X-Received: by 2002:a62:583:: with SMTP id 125mr338507pff.69.1569441773971;
        Wed, 25 Sep 2019 13:02:53 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id d76sm458113pga.80.2019.09.25.13.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 13:02:53 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Douglas Anderson <dianders@chromium.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] kdb: Fix stack crawling on 'running' CPUs that aren't the master
Date:   Wed, 25 Sep 2019 13:02:20 -0700
Message-Id: <20190925125811.v3.4.I2cbda6675dcce5ec366e3436bb964b3ab22a4309@changeid>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
In-Reply-To: <20190925200220.157670-1-dianders@chromium.org>
References: <20190925200220.157670-1-dianders@chromium.org>
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

Changes in v3:
- Use exception state instead of new dbg_slave_dumpstack_cpu var.
- Move horror to debug core, cleaning up control flow.
- Avoid need for timeout by only waiting for CPUs marked as slaves.

Changes in v2:
- Totally new approach; now arch agnostic.

 kernel/debug/debug_core.c | 34 ++++++++++++++++++++++++++++++++++
 kernel/debug/debug_core.h |  2 ++
 kernel/debug/kdb/kdb_bt.c | 19 +++++++------------
 3 files changed, 43 insertions(+), 12 deletions(-)

diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 10f1187b3907..5456e09d9354 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -441,6 +441,37 @@ int dbg_remove_all_break(void)
 	return 0;
 }
 
+#ifdef CONFIG_KGDB_KDB
+void kdb_dump_stack_on_cpu(int cpu)
+{
+	if (cpu == raw_smp_processor_id()) {
+		dump_stack();
+		return;
+	}
+
+	if (!(kgdb_info[cpu].exception_state & DCPU_IS_SLAVE)) {
+		kdb_printf("ERROR: Task on cpu %d didn't stop in the debugger\n",
+			   cpu);
+		return;
+	}
+
+	/*
+	 * In general, architectures don't support dumping the stack of a
+	 * "running" process that's not the current one.  From the point of
+	 * view of the Linux, kernel processes that are looping in the kgdb
+	 * slave loop are still "running".  There's also no API (that actually
+	 * works across all architectures) that can do a stack crawl based
+	 * on registers passed as a parameter.
+	 *
+	 * Solve this conundrum by asking slave CPUs to do the backtrace
+	 * themselves.
+	 */
+	kgdb_info[cpu].exception_state |= DCPU_WANT_BT;
+	while (kgdb_info[cpu].exception_state & DCPU_WANT_BT)
+		cpu_relax();
+}
+#endif
+
 /*
  * Return true if there is a valid kgdb I/O module.  Also if no
  * debugger is attached a message can be printed to the console about
@@ -580,6 +611,9 @@ static int kgdb_cpu_enter(struct kgdb_state *ks, struct pt_regs *regs,
 				atomic_xchg(&kgdb_active, cpu);
 				break;
 			}
+		} else if (kgdb_info[cpu].exception_state & DCPU_WANT_BT) {
+			dump_stack();
+			kgdb_info[cpu].exception_state &= ~DCPU_WANT_BT;
 		} else if (kgdb_info[cpu].exception_state & DCPU_IS_SLAVE) {
 			if (!raw_spin_is_locked(&dbg_slave_lock))
 				goto return_normal;
diff --git a/kernel/debug/debug_core.h b/kernel/debug/debug_core.h
index 804b0fe5a0ba..cd22b5f68831 100644
--- a/kernel/debug/debug_core.h
+++ b/kernel/debug/debug_core.h
@@ -33,6 +33,7 @@ struct kgdb_state {
 #define DCPU_WANT_MASTER 0x1 /* Waiting to become a master kgdb cpu */
 #define DCPU_NEXT_MASTER 0x2 /* Transition from one master cpu to another */
 #define DCPU_IS_SLAVE    0x4 /* Slave cpu enter exception */
+#define DCPU_WANT_BT     0x8 /* Slave cpu should backtrace then clear flag */
 
 struct debuggerinfo_struct {
 	void			*debuggerinfo;
@@ -75,6 +76,7 @@ extern int kdb_stub(struct kgdb_state *ks);
 extern int kdb_parse(const char *cmdstr);
 extern int kdb_common_init_state(struct kgdb_state *ks);
 extern int kdb_common_deinit_state(void);
+extern void kdb_dump_stack_on_cpu(int cpu);
 #else /* ! CONFIG_KGDB_KDB */
 static inline int kdb_stub(struct kgdb_state *ks)
 {
diff --git a/kernel/debug/kdb/kdb_bt.c b/kernel/debug/kdb/kdb_bt.c
index d9af139f9a31..0e94efe07b72 100644
--- a/kernel/debug/kdb/kdb_bt.c
+++ b/kernel/debug/kdb/kdb_bt.c
@@ -22,20 +22,15 @@
 static void kdb_show_stack(struct task_struct *p, void *addr)
 {
 	int old_lvl = console_loglevel;
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
-	} else {
-		show_stack(p, NULL);
-	}
+
+	if (!addr && kdb_task_has_cpu(p))
+		kdb_dump_stack_on_cpu(kdb_process_cpu(p));
+	else
+		show_stack(p, addr);
+
 	console_loglevel = old_lvl;
 	kdb_trap_printk--;
 }
-- 
2.23.0.351.gc4317032e6-goog

