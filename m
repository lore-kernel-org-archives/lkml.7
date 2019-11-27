Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82ACCC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 05:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51D9120835
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 05:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574834232;
	bh=2LCywgeMJXg7y4ZWRrSFYRw5cDi6k86r0DUii6K/vjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CMlD3AV5rI4TrH2RgwALyrSd/csJc1OmpUyY3YwWQ0EbTF0/A5BQNe1DgtKMm6SX5
	 zKr9huoUNYVPxEztcICpZh5swmc1gvpzjE6mdAjZ1ualMXgbgezLm1kZY2ruTMRTIF
	 nVLTZqO1tiwmSK75aR9pK7FRwfh38mphuQoIJ/1w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfK0F5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 00:57:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:57974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbfK0F5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 00:57:10 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9799207DD;
        Wed, 27 Nov 2019 05:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574834229;
        bh=2LCywgeMJXg7y4ZWRrSFYRw5cDi6k86r0DUii6K/vjQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GVK6QVOleKWWTwSsGfvWyZAUIusPFRz9VktM8OyoBWN1OZx/DBMYBzLXgMJn7yrKp
         ZbqPznc9YfnfDMmHPFDlye1kkp6egzAmsPNYHweuE+uQvG7e6FHnbG+HZ2LtVwnlgE
         3FD1LbKAuTdFdsTiS7MxvzFkjqCr3sIduLM0jeRo=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, namit@vmware.com, hpa@zytor.com,
        luto@kernel.org, ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        jeyu@kernel.org, alexei.starovoitov@gmail.com,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH -tip 2/2] kprobes: Set unoptimized flag after unoptimizing code
Date:   Wed, 27 Nov 2019 14:57:04 +0900
Message-Id: <157483422375.25881.13508326028469515760.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157483420094.25881.9190014521050510942.stgit@devnote2>
References: <157483420094.25881.9190014521050510942.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to set unoptimized flag after confirming the code is completely
unoptimized. Without this fix, when a kprobe hits the intermediate
modified instruction (the first byte is replaced by int3, but
latter bytes still be a jump address operand) while unoptimizing,
it can return to the middle byte of the modified code. And it causes
an invalid instruction exception in the kernel.

Usually, this is a rare case, but if we put a probe on the function
called while text patching, it always causes a kernel panic as below.
(text_poke() is used for patching the code in optprobe)

 # echo p text_poke+5 > kprobe_events
 # echo 1 > events/kprobes/enable
 # echo 0 > events/kprobes/enable
 invalid opcode: 0000 [#1] PREEMPT SMP PTI
 CPU: 7 PID: 137 Comm: kworker/7:1 Not tainted 5.4.0-rc8+ #29
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
 Workqueue: events kprobe_optimizer
 RIP: 0010:text_poke+0x9/0x50
 Code: 01 00 00 5b 5d 41 5c 41 5d c3 89 c0 0f b7 4c 02 fe 66 89 4c 05 fe e9 31 ff ff ff e8 71 ac 03 00 90 55 48 89 f5 53 cc 30 cb fd <1e> ec 08 8b 05 72 98 31 01 85 c0 75 11 48 83 c4 08 48 89 ee 48 89
 RSP: 0018:ffffc90000343df0 EFLAGS: 00010686
 RAX: 0000000000000000 RBX: ffffffff81025796 RCX: 0000000000000000
 RDX: 0000000000000004 RSI: ffff88807c983148 RDI: ffffffff81025796
 RBP: ffff88807c983148 R08: 0000000000000001 R09: 0000000000000000
 R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff82284fe0
 R13: ffff88807c983138 R14: ffffffff82284ff0 R15: 0ffff88807d9eee0
 FS:  0000000000000000(0000) GS:ffff88807d9c0000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 000000000058158b CR3: 000000007b372000 CR4: 00000000000006a0
 Call Trace:
  arch_unoptimize_kprobe+0x22/0x28
  arch_unoptimize_kprobes+0x39/0x87
  kprobe_optimizer+0x6e/0x290
  process_one_work+0x2a0/0x610
  worker_thread+0x28/0x3d0
  ? process_one_work+0x610/0x610
  kthread+0x10d/0x130
  ? kthread_park+0x80/0x80
  ret_from_fork+0x3a/0x50
 Modules linked in:
 ---[ end trace 83b34b22a228711b ]---

This can happen even if we blacklist text_poke() and other functions,
because there is a small time window which showing the intermediate
code to other CPUs.

Fixes: 6274de4984a6 ("kprobes: Support delayed unoptimizing")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/kprobes.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 53534aa258a6..34e28b236d68 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -510,6 +510,8 @@ static void do_unoptimize_kprobes(void)
 	arch_unoptimize_kprobes(&unoptimizing_list, &freeing_list);
 	/* Loop free_list for disarming */
 	list_for_each_entry_safe(op, tmp, &freeing_list, list) {
+		/* Switching from detour code to origin */
+		op->kp.flags &= ~KPROBE_FLAG_OPTIMIZED;
 		/* Disarm probes if marked disabled */
 		if (kprobe_disabled(&op->kp))
 			arch_disarm_kprobe(&op->kp);
@@ -649,6 +651,7 @@ static void force_unoptimize_kprobe(struct optimized_kprobe *op)
 {
 	lockdep_assert_cpus_held();
 	arch_unoptimize_kprobe(op);
+	op->kp.flags &= ~KPROBE_FLAG_OPTIMIZED;
 	if (kprobe_disabled(&op->kp))
 		arch_disarm_kprobe(&op->kp);
 }
@@ -676,7 +679,6 @@ static void unoptimize_kprobe(struct kprobe *p, bool force)
 		return;
 	}
 
-	op->kp.flags &= ~KPROBE_FLAG_OPTIMIZED;
 	if (!list_empty(&op->list)) {
 		/* Dequeue from the optimization queue */
 		list_del_init(&op->list);

