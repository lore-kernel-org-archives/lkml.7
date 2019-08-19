Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00589C3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE0932147A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="BOlBzzoL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfHSLWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 07:22:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47867 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbfHSLWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 07:22:35 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7JBM7E94114244
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 19 Aug 2019 04:22:08 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7JBM7E94114244
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1566213728;
        bh=iTq0Qt1POXu8C2JzCGJoRFCzdRhsh147MBhk8KR+y5E=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=BOlBzzoLQFUDG6n3Hy3L4KChScm7xXu3Szjby9DMoq4ueaxptvkCPb21rH1HX3bmb
         Nkah1/lSMCsIF92m5wagOKr+n0VYyeZ6WlrugUpMfn9OaYmWd/sdZULwNtSy5nDVPb
         6N4LmT4uWWj/iXZ6qZ9nH/AnOWPx+OsR9k4NDVYBIkAQRoVLZJThjVB875Lm4pg5QZ
         Fie4/JByQHe7124zulMgLgVkNzmuyi39LERNBBfHCzv7Q53WKrrCZjpzOSWMC7snSG
         5DJNO1h+hpjxLc6QwugvpebhG4chXtQGFiN/47nwI0tPrLlHLxPFNK5pAIVM/yAL3i
         ZCtyM+8IiTLwA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7JBM6ZI4114239;
        Mon, 19 Aug 2019 04:22:06 -0700
Date:   Mon, 19 Aug 2019 04:22:06 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andrea Righi <tipbot@zytor.com>
Message-ID: <tip-f1c6ece23729257fb46562ff9224cf5f61b818da@git.kernel.org>
Cc:     anil.s.keshavamurthy@intel.com, andrea.righi@canonical.com,
        naveen.n.rao@linux.ibm.com, hpa@zytor.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        torvalds@linux-foundation.org, mhiramat@kernel.org,
        peterz@infradead.org, mingo@kernel.org
Reply-To: hpa@zytor.com, tglx@linutronix.de, andrea.righi@canonical.com,
          naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
          peterz@infradead.org, torvalds@linux-foundation.org,
          mhiramat@kernel.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org, davem@davemloft.net
In-Reply-To: <20190812184302.GA7010@xps-13>
References: <20190812184302.GA7010@xps-13>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] kprobes: Fix potential deadlock in
 kprobe_optimizer()
Git-Commit-ID: f1c6ece23729257fb46562ff9224cf5f61b818da
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  f1c6ece23729257fb46562ff9224cf5f61b818da
Gitweb:     https://git.kernel.org/tip/f1c6ece23729257fb46562ff9224cf5f61b818da
Author:     Andrea Righi <andrea.righi@canonical.com>
AuthorDate: Mon, 12 Aug 2019 20:43:02 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 19 Aug 2019 12:22:19 +0200

kprobes: Fix potential deadlock in kprobe_optimizer()

lockdep reports the following deadlock scenario:

 WARNING: possible circular locking dependency detected

 kworker/1:1/48 is trying to acquire lock:
 000000008d7a62b2 (text_mutex){+.+.}, at: kprobe_optimizer+0x163/0x290

 but task is already holding lock:
 00000000850b5e2d (module_mutex){+.+.}, at: kprobe_optimizer+0x31/0x290

 which lock already depends on the new lock.

 the existing dependency chain (in reverse order) is:

 -> #1 (module_mutex){+.+.}:
        __mutex_lock+0xac/0x9f0
        mutex_lock_nested+0x1b/0x20
        set_all_modules_text_rw+0x22/0x90
        ftrace_arch_code_modify_prepare+0x1c/0x20
        ftrace_run_update_code+0xe/0x30
        ftrace_startup_enable+0x2e/0x50
        ftrace_startup+0xa7/0x100
        register_ftrace_function+0x27/0x70
        arm_kprobe+0xb3/0x130
        enable_kprobe+0x83/0xa0
        enable_trace_kprobe.part.0+0x2e/0x80
        kprobe_register+0x6f/0xc0
        perf_trace_event_init+0x16b/0x270
        perf_kprobe_init+0xa7/0xe0
        perf_kprobe_event_init+0x3e/0x70
        perf_try_init_event+0x4a/0x140
        perf_event_alloc+0x93a/0xde0
        __do_sys_perf_event_open+0x19f/0xf30
        __x64_sys_perf_event_open+0x20/0x30
        do_syscall_64+0x65/0x1d0
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

 -> #0 (text_mutex){+.+.}:
        __lock_acquire+0xfcb/0x1b60
        lock_acquire+0xca/0x1d0
        __mutex_lock+0xac/0x9f0
        mutex_lock_nested+0x1b/0x20
        kprobe_optimizer+0x163/0x290
        process_one_work+0x22b/0x560
        worker_thread+0x50/0x3c0
        kthread+0x112/0x150
        ret_from_fork+0x3a/0x50

 other info that might help us debug this:

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(module_mutex);
                                lock(text_mutex);
                                lock(module_mutex);
   lock(text_mutex);

  *** DEADLOCK ***

As a reproducer I've been using bcc's funccount.py
(https://github.com/iovisor/bcc/blob/master/tools/funccount.py),
for example:

 # ./funccount.py '*interrupt*'

That immediately triggers the lockdep splat.

Fix by acquiring text_mutex before module_mutex in kprobe_optimizer().

Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: d5b844a2cf50 ("ftrace/x86: Remove possible deadlock between register_kprobe() and ftrace_run_update_code()")
Link: http://lkml.kernel.org/r/20190812184302.GA7010@xps-13
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/kprobes.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 9873fc627d61..d9770a5393c8 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -470,6 +470,7 @@ static DECLARE_DELAYED_WORK(optimizing_work, kprobe_optimizer);
  */
 static void do_optimize_kprobes(void)
 {
+	lockdep_assert_held(&text_mutex);
 	/*
 	 * The optimization/unoptimization refers online_cpus via
 	 * stop_machine() and cpu-hotplug modifies online_cpus.
@@ -487,9 +488,7 @@ static void do_optimize_kprobes(void)
 	    list_empty(&optimizing_list))
 		return;
 
-	mutex_lock(&text_mutex);
 	arch_optimize_kprobes(&optimizing_list);
-	mutex_unlock(&text_mutex);
 }
 
 /*
@@ -500,6 +499,7 @@ static void do_unoptimize_kprobes(void)
 {
 	struct optimized_kprobe *op, *tmp;
 
+	lockdep_assert_held(&text_mutex);
 	/* See comment in do_optimize_kprobes() */
 	lockdep_assert_cpus_held();
 
@@ -507,7 +507,6 @@ static void do_unoptimize_kprobes(void)
 	if (list_empty(&unoptimizing_list))
 		return;
 
-	mutex_lock(&text_mutex);
 	arch_unoptimize_kprobes(&unoptimizing_list, &freeing_list);
 	/* Loop free_list for disarming */
 	list_for_each_entry_safe(op, tmp, &freeing_list, list) {
@@ -524,7 +523,6 @@ static void do_unoptimize_kprobes(void)
 		} else
 			list_del_init(&op->list);
 	}
-	mutex_unlock(&text_mutex);
 }
 
 /* Reclaim all kprobes on the free_list */
@@ -556,6 +554,7 @@ static void kprobe_optimizer(struct work_struct *work)
 {
 	mutex_lock(&kprobe_mutex);
 	cpus_read_lock();
+	mutex_lock(&text_mutex);
 	/* Lock modules while optimizing kprobes */
 	mutex_lock(&module_mutex);
 
@@ -583,6 +582,7 @@ static void kprobe_optimizer(struct work_struct *work)
 	do_free_cleaned_kprobes();
 
 	mutex_unlock(&module_mutex);
+	mutex_unlock(&text_mutex);
 	cpus_read_unlock();
 	mutex_unlock(&kprobe_mutex);
 
