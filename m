Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE5EC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E74A7205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cuH0cvj7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbfG3WSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 18:18:23 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36731 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727221AbfG3WSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 18:18:23 -0400
Received: by mail-pg1-f194.google.com with SMTP id l21so30765647pgm.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 15:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sxiBOB7zsr4sYYglcbcr65xES486R1b5ubVrYLCx9MI=;
        b=cuH0cvj7FQ+GpEQKL8ugXdx3wyPTXJSpKN9VZSQy/NOZUhCpj/MnEoPIYQWDumfepk
         SXkr29or2GlRyB6D4kGxSM5fqCA0aYmYiF/zHTR6cQuZg5AWtLGfuH6/GuQcHnzL+LZq
         eG4FGz9exx6D+FI7ZOtIl1H9t+gUwZ+JC/XcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sxiBOB7zsr4sYYglcbcr65xES486R1b5ubVrYLCx9MI=;
        b=mG9p8UV8gl4nsyHJARavVHf9jSTKtpT8G9SBAj6wDZc5x3qRD8Iqv2sO4ABfGFwdAn
         amOUZ+QXXsr4o1W8ztGTSgtPpTHGONgwfJJ0D8fQvqi6WXON4m+womLF2DSOnnv+Qi6t
         ShDGWasNab+NT5Obnk3qzbKRRBCviCRMAWfDQgWinWzCBwvnqGIajNOHb3EouzVMPWmD
         ZRWBVffwrp7xQAbvs+/5+aN5MHJkVk9dqn0vhtJSF8RKow/Y1ytiUXl2XxoKmTp9GT2m
         GkyfoTH8ZwkVFT+THJ0bHg/e78btTAz0wxaGEfE4HwfIcYAOGVaFhIlaqNS004KAg0pG
         nATw==
X-Gm-Message-State: APjAAAWqdn036mcqb1b7SzjKU1q4AlWwNqzSpNmYkQGl0nrx6la3Bp2B
        Se+MBN1r6uMrSQ/s8E1G3UtsoA==
X-Google-Smtp-Source: APXvYqwqDLmwcsVdJQqAK5+voPBrSQMRxT/BTbm6YQUKW/crdO6p9v7vxNjvrFFCLR1wwUrOngXA+g==
X-Received: by 2002:a63:dd16:: with SMTP id t22mr79512317pgg.140.1564525102190;
        Tue, 30 Jul 2019 15:18:22 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id u7sm58455696pfm.96.2019.07.30.15.18.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 15:18:21 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: debug: Make 'btc' and similar work in kdb
Date:   Tue, 30 Jul 2019 15:18:00 -0700
Message-Id: <20190730221800.28326-1-dianders@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In kdb when you do 'btc' (back trace on CPU) it doesn't give you the
right info.  This can be seen by this:

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

In this patch I fix the problems by stashing the "pt_regs" into the
"cpu_context" when a CPU enters the debugger.  Now all the normal stack
crawling code will be able to find it.  This is possible because:
* When a task is "running" nobody else is using the "cpu_context"
* The task isn't really "running" (it's in the debugger) so there are
  actually some sane registers to save.

This patch works without any extra kgdb API changes by just
implementing the weak kgdb_call_nmi_hook().  I don't try to address
the existing caveat in kgdb_call_nmi_hook() around pt_regs, so I copy
the comment from the generic code.

After this patch the same test shows much more sane stack crawls.  The
idle tasks now show:

Stack traceback for pid 0
0xffffffc0f175b040        0        0  1    3   I  0xffffffc0f175ba30  swapper/3
Call trace:
 cpuidle_enter_state+0x284/0x428
 cpuidle_enter+0x38/0x4c
 do_idle+0x168/0x29c
 cpu_startup_entry+0x24/0x28
 secondary_start_kernel+0x140/0x14c

...and the locked task:

Stack traceback for pid 1603
0xffffffc0d98c7040     1603      724  1    4   R  0xffffffc0d98c7a30  bash
Call trace:
 lkdtm_SOFTLOCKUP+0x1c/0x24
 lkdtm_do_action+0x24/0x44
 direct_entry+0x130/0x178
 full_proxy_write+0x60/0xb4
 __vfs_write+0x54/0x18c
 vfs_write+0xcc/0x174
 ksys_write+0x7c/0xe4
 __arm64_sys_write+0x20/0x2c
 el0_svc_common+0x9c/0x14c
 el0_svc_compat_handler+0x28/0x34
 el0_svc_compat+0x8/0x10

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/kernel/kgdb.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index 43119922341f..b666210fbc75 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -148,6 +148,45 @@ sleeping_thread_to_gdb_regs(unsigned long *gdb_regs, struct task_struct *task)
 	gdb_regs[32] = cpu_context->pc;
 }
 
+void kgdb_call_nmi_hook(void *ignored)
+{
+	struct pt_regs *regs;
+
+	/*
+	 * NOTE: get_irq_regs() is supposed to get the registers from
+	 * before the IPI interrupt happened and so is supposed to
+	 * show where the processor was.  In some situations it's
+	 * possible we might be called without an IPI, so it might be
+	 * safer to figure out how to make kgdb_breakpoint() work
+	 * properly here.
+	 */
+	regs = get_irq_regs();
+
+	/*
+	 * Some commands (like 'btc') assume that they can find info about
+	 * a task in the 'cpu_context'.  Unfortunately that's only valid
+	 * for sleeping tasks.  ...but let's make it work anyway by just
+	 * writing the registers to the right place.  This is safe because
+	 * nobody else is using the 'cpu_context' for a running task.
+	 */
+	current->thread.cpu_context.x19 = regs->regs[19];
+	current->thread.cpu_context.x20 = regs->regs[20];
+	current->thread.cpu_context.x21 = regs->regs[21];
+	current->thread.cpu_context.x22 = regs->regs[22];
+	current->thread.cpu_context.x23 = regs->regs[23];
+	current->thread.cpu_context.x24 = regs->regs[24];
+	current->thread.cpu_context.x25 = regs->regs[25];
+	current->thread.cpu_context.x26 = regs->regs[26];
+	current->thread.cpu_context.x27 = regs->regs[27];
+	current->thread.cpu_context.x28 = regs->regs[28];
+	current->thread.cpu_context.fp = regs->regs[29];
+
+	current->thread.cpu_context.sp = regs->sp;
+	current->thread.cpu_context.pc = regs->pc;
+
+	kgdb_nmicallback(raw_smp_processor_id(), regs);
+}
+
 void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long pc)
 {
 	regs->pc = pc;
-- 
2.22.0.709.g102302147b-goog

