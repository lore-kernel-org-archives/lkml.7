Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4AEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E842205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413985;
	bh=wJmdfS7ysZwSSRO31A+G560/wlPvm2VP0ZxnDziHm4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J8DpRpGajEynP4GdORVAZWZENT7DTRL2fkzbCVA8ZHrbSIWZaZO2HREH7Uo9IcwQG
	 RRiO4Uur9wJfi4dBByzTIbPHb+hUpR9rcmH4+1t92d+Qgyw6bPVPI8D7gD+DDQ69Km
	 iJ82w4oILqVVpY4aUa/mMAAUBD1Hfgp5w3NZaLR8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbfCLSGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:06:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:47848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727511AbfCLRMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:12:32 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E75DA217D8;
        Tue, 12 Mar 2019 17:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410751;
        bh=wJmdfS7ysZwSSRO31A+G560/wlPvm2VP0ZxnDziHm4U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dwBBKCQAH3WSsdLDTL1Zqitc4xom2xxMoUtmWbnOn861iequFGKEp3Nm7ysOTPW0B
         yWjEB9JGJabMFMb507KHYoj86cZyhZqUVhk0EJi4qiuWQo1nIH+xS8MmyqHTVG7MFe
         21UayPfrcDsPer34N4gxoGeVQVPFOVs+eH/8YehE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 078/171] signal: Make siginmask safe when passed a signal of 0
Date:   Tue, 12 Mar 2019 10:07:38 -0700
Message-Id: <20190312170354.787824796@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit ee17e5d6201c66492a0e8053190fca2ed2b8457d ]

Eric Biggers reported:
> The following commit, which went into v4.20, introduced undefined behavior when
> sys_rt_sigqueueinfo() is called with sig=0:
>
> commit 4ce5f9c9e7546915c559ffae594e6d73f918db00
> Author: Eric W. Biederman <ebiederm@xmission.com>
> Date:   Tue Sep 25 12:59:31 2018 +0200
>
>     signal: Use a smaller struct siginfo in the kernel
>
> In sig_specific_sicodes(), used from known_siginfo_layout(), the expression
> '1ULL << ((sig)-1)' is undefined as it evaluates to 1ULL << 4294967295.
>
> Reproducer:
>
> #include <signal.h>
> #include <sys/syscall.h>
> #include <unistd.h>
>
> int main(void)
> {
> 	siginfo_t si = { .si_code = 1 };
> 	syscall(__NR_rt_sigqueueinfo, 0, 0, &si);
> }
>
> UBSAN report for v5.0-rc1:
>
> UBSAN: Undefined behaviour in kernel/signal.c:2946:7
> shift exponent 4294967295 is too large for 64-bit type 'long unsigned int'
> CPU: 2 PID: 346 Comm: syz_signal Not tainted 5.0.0-rc1 #25
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x70/0xa5 lib/dump_stack.c:113
>  ubsan_epilogue+0xd/0x40 lib/ubsan.c:159
>  __ubsan_handle_shift_out_of_bounds+0x12c/0x170 lib/ubsan.c:425
>  known_siginfo_layout+0xae/0xe0 kernel/signal.c:2946
>  post_copy_siginfo_from_user kernel/signal.c:3009 [inline]
>  __copy_siginfo_from_user+0x35/0x60 kernel/signal.c:3035
>  __do_sys_rt_sigqueueinfo kernel/signal.c:3553 [inline]
>  __se_sys_rt_sigqueueinfo kernel/signal.c:3549 [inline]
>  __x64_sys_rt_sigqueueinfo+0x31/0x70 kernel/signal.c:3549
>  do_syscall_64+0x4c/0x1b0 arch/x86/entry/common.c:290
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x433639
> Code: c4 18 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b 27 00 00 c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007fffcb289fc8 EFLAGS: 00000246 ORIG_RAX: 0000000000000081
> RAX: ffffffffffffffda RBX: 00000000004002e0 RCX: 0000000000433639
> RDX: 00007fffcb289fd0 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 00000000006b2018 R08: 000000000000004d R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401560
> R13: 00000000004015f0 R14: 0000000000000000 R15: 0000000000000000

I have looked at the other callers of siginmask and they all appear to
in locations where sig can not be zero.

I have looked at the code generation of adding an extra test against
zero and gcc was able with a simple decrement instruction to combine
the two tests together. So the at most adding this test cost a single
cpu cycle.  In practice that decrement instruction was already present
as part of the mask comparison, so the only change was when the
instruction was executed.

So given that it is cheap, and obviously correct to update siginmask
to verify the signal is not zero.  Fix this issue there to avoid any
future problems.

Reported-by: Eric Biggers <ebiggers@kernel.org>
Fixes: 4ce5f9c9e754 ("signal: Use a smaller struct siginfo in the kernel")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/signal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/signal.h b/include/linux/signal.h
index f428e86f4800..b5d99482d3fe 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -388,7 +388,7 @@ extern bool unhandled_signal(struct task_struct *tsk, int sig);
 #endif
 
 #define siginmask(sig, mask) \
-	((sig) < SIGRTMIN && (rt_sigmask(sig) & (mask)))
+	((sig) > 0 && (sig) < SIGRTMIN && (rt_sigmask(sig) & (mask)))
 
 #define SIG_KERNEL_ONLY_MASK (\
 	rt_sigmask(SIGKILL)   |  rt_sigmask(SIGSTOP))
-- 
2.19.1



