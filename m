Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6049C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 18:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8640F20684
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 18:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbfHLSnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 14:43:08 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54224 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfHLSnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 14:43:08 -0400
Received: from mail-wm1-f72.google.com ([209.85.128.72])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <andrea.righi@canonical.com>)
        id 1hxFHd-0002W0-8q
        for linux-kernel@vger.kernel.org; Mon, 12 Aug 2019 18:43:05 +0000
Received: by mail-wm1-f72.google.com with SMTP id r9so151269wme.8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 11:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=zOSc9bmVuG5obO3oziTzKmJN7+pvSQBbPqrqY+V06TY=;
        b=AG00wf73f7w/p7Iyd6X5XHgAj2xss0Dn0VVBSn2itkiiZ7v2Dfr4BA0/Uevtb9y5BH
         VdMcl2ws4fQhHb2LW16fzus0I9vUpAz34mPzpg9yGnsMkqLtqaIPVVaZDyhLaizMo+Cc
         rDLFZGtuXbiJ0ArYmwNOdUjCyOVpq/9425xrD2QMEpjKetHSIoWQHKFk0ImOdOA7numU
         ZwMsLAsKsp73dNFLMhwK/BIh3cj8CAzD6TCcCuS+8tdCQgDloZavP0XZrIyOIyoBJC/7
         +ukmEi9I92Z8BQjnT9ZHJoH4pY0u+rB3ztVCa67f6los9rrJOdaykmPHzA+gzFUQxkep
         UpLw==
X-Gm-Message-State: APjAAAVhxFS81KIp4g8zK3jzOR94b+oWX6NPZuXnr+S8Vtx4v2oIFqXG
        BQgO6fP0rtQcb0T9NX+YDGKW4bLFGtgfTfQJh1AZSPe8SdAhLTxuLVFinJpyP6bKAgV3+AOPHli
        OwEQey6qErZHPS4eA0E+al0Onz0neUWhhzetmwcex9A==
X-Received: by 2002:a05:600c:21ca:: with SMTP id x10mr724456wmj.112.1565635384883;
        Mon, 12 Aug 2019 11:43:04 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwUy+BZVTbWFU/tgHThf47/KnVxiM5rhVfDdJ9a4Eq8ftNgf57M/gzIJZV/Fo5M63ZGq0rzRQ==
X-Received: by 2002:a05:600c:21ca:: with SMTP id x10mr724435wmj.112.1565635384567;
        Mon, 12 Aug 2019 11:43:04 -0700 (PDT)
Received: from localhost ([95.238.207.169])
        by smtp.gmail.com with ESMTPSA id l3sm26644952wrb.41.2019.08.12.11.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2019 11:43:04 -0700 (PDT)
Date:   Mon, 12 Aug 2019 20:43:02 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] kprobes: fix potential deadlock in kprobe_optimizer()
Message-ID: <20190812184302.GA7010@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lockdep reports the following:

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

Fixes: d5b844a2cf50 ("ftrace/x86: Remove possible deadlock between register_kprobe() and ftrace_run_update_code()")
Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
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
 
-- 
2.20.1

