Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCF0C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F36CF217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610823;
	bh=oo1K0SzyEzU0X3cLiQaDZl14jRRMsaOX7C0MUi2rzi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LPmMVmMw2e8qNPZ3Vi1+ZzLV4qnnhPkcqZ8j80vJCyeFxAXNHuNAmaw03Db5RUTrZ
	 3LpoeLL/LuapXWYibskbUs6gAEdJ57OM14LQhRB7bSBwkERQjKf9sykvZ3xHDmXsQg
	 hkaiunNPwE8PE4iXesjmOWYNG9AhqrmGz+/Kb18Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391572AbfDRSHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:07:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:37076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391559AbfDRSG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:06:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0F18218A1;
        Thu, 18 Apr 2019 18:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610818;
        bh=oo1K0SzyEzU0X3cLiQaDZl14jRRMsaOX7C0MUi2rzi0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s4QgqtPeUOHiB7xahhuiMZ1PKP40ZEmdlqpMDNRPUCrIMMRcsZPKOacSnCbsd38I6
         43VLYcIicXfnCBCbPvi3+oXyP7gqhB5dQkvD/94+ABVHZp+bdKFrDoDADBV7D+kGfL
         ir1qIaKp36QzQywoEqevHZ1MJll24lX95z8/g5EI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Craig Gallek <kraig@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Balbir Singh <sblbir@amzn.com>
Subject: [PATCH 4.14 75/92] bpf: fix verifier NULL pointer dereference
Date:   Thu, 18 Apr 2019 19:57:33 +0200
Message-Id: <20190418160436.792400030@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160430.325165109@linuxfoundation.org>
References: <20190418160430.325165109@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Craig Gallek <kraig@google.com>

commit 8c01c4f896aa3404af948880dcb29a2d51c833dc upstream.

do_check() can fail early without allocating env->cur_state under
memory pressure.  Syzkaller found the stack below on the linux-next
tree because of this.

  kasan: CONFIG_KASAN_INLINE enabled
  kasan: GPF could be caused by NULL-ptr deref or user memory access
  general protection fault: 0000 [#1] SMP KASAN
  Dumping ftrace buffer:
     (ftrace buffer empty)
  Modules linked in:
  CPU: 1 PID: 27062 Comm: syz-executor5 Not tainted 4.14.0-rc7+ #106
  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
  task: ffff8801c2c74700 task.stack: ffff8801c3e28000
  RIP: 0010:free_verifier_state kernel/bpf/verifier.c:347 [inline]
  RIP: 0010:bpf_check+0xcf4/0x19c0 kernel/bpf/verifier.c:4533
  RSP: 0018:ffff8801c3e2f5c8 EFLAGS: 00010202
  RAX: dffffc0000000000 RBX: 00000000fffffff4 RCX: 0000000000000000
  RDX: 0000000000000070 RSI: ffffffff817d5aa9 RDI: 0000000000000380
  RBP: ffff8801c3e2f668 R08: 0000000000000000 R09: 1ffff100387c5d9f
  R10: 00000000218c4e80 R11: ffffffff85b34380 R12: ffff8801c4dc6a28
  R13: 0000000000000000 R14: ffff8801c4dc6a00 R15: ffff8801c4dc6a20
  FS:  00007f311079b700(0000) GS:ffff8801db300000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00000000004d4a24 CR3: 00000001cbcd0000 CR4: 00000000001406e0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  Call Trace:
   bpf_prog_load+0xcbb/0x18e0 kernel/bpf/syscall.c:1166
   SYSC_bpf kernel/bpf/syscall.c:1690 [inline]
   SyS_bpf+0xae9/0x4620 kernel/bpf/syscall.c:1652
   entry_SYSCALL_64_fastpath+0x1f/0xbe
  RIP: 0033:0x452869
  RSP: 002b:00007f311079abe8 EFLAGS: 00000212 ORIG_RAX: 0000000000000141
  RAX: ffffffffffffffda RBX: 0000000000758020 RCX: 0000000000452869
  RDX: 0000000000000030 RSI: 0000000020168000 RDI: 0000000000000005
  RBP: 00007f311079aa20 R08: 0000000000000000 R09: 0000000000000000
  R10: 0000000000000000 R11: 0000000000000212 R12: 00000000004b7550
  R13: 00007f311079ab58 R14: 00000000004b7560 R15: 0000000000000000
  Code: df 48 c1 ea 03 80 3c 02 00 0f 85 e6 0b 00 00 4d 8b 6e 20 48 b8 00 00 00 00 00 fc ff df 49 8d bd 80 03 00 00 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 b6 0b 00 00 49 8b bd 80 03 00 00 e8 d6 0c 26
  RIP: free_verifier_state kernel/bpf/verifier.c:347 [inline] RSP: ffff8801c3e2f5c8
  RIP: bpf_check+0xcf4/0x19c0 kernel/bpf/verifier.c:4533 RSP: ffff8801c3e2f5c8
  ---[ end trace c8d37f339dc64004 ]---

Fixes: 638f5b90d460 ("bpf: reduce verifier memory consumption")
Fixes: 1969db47f8d0 ("bpf: fix verifier memory leaks")
Signed-off-by: Craig Gallek <kraig@google.com>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Balbir Singh <sblbir@amzn.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/bpf/verifier.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4777,8 +4777,10 @@ int bpf_check(struct bpf_prog **prog, un
 	env->allow_ptr_leaks = capable(CAP_SYS_ADMIN);
 
 	ret = do_check(env);
-	free_verifier_state(env->cur_state, true);
-	env->cur_state = NULL;
+	if (env->cur_state) {
+		free_verifier_state(env->cur_state, true);
+		env->cur_state = NULL;
+	}
 
 skip_full_check:
 	while (!pop_stack(env, NULL, NULL));
@@ -4887,8 +4889,10 @@ int bpf_analyzer(struct bpf_prog *prog,
 	env->allow_ptr_leaks = capable(CAP_SYS_ADMIN);
 
 	ret = do_check(env);
-	free_verifier_state(env->cur_state, true);
-	env->cur_state = NULL;
+	if (env->cur_state) {
+		free_verifier_state(env->cur_state, true);
+		env->cur_state = NULL;
+	}
 
 skip_full_check:
 	while (!pop_stack(env, NULL, NULL));


