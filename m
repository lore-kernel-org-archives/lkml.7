Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DCAC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F75222CF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573610356;
	bh=FQxdcPlHeuxk12YE2UCy2y47gJFvSt793ga4V9vyrog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oUVJIc8ope8qi9xDSREHxieGcDKl1AuKNFDVYDTCX+vCdz6Atj39cKn3PgZ8CL1AE
	 z4io85UFBGrmwBB15zODSyp9+/spyCft97BLIB4jRxHeL1Pwn5BlqgAo3zlRlj3ZGp
	 25YRnYq62E6n2mcutKxK7FlI6zRwzfIhgI/1GJAI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730235AbfKMB7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 20:59:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:53444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730211AbfKMB7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:59:09 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38F3A2053B;
        Wed, 13 Nov 2019 01:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573610349;
        bh=FQxdcPlHeuxk12YE2UCy2y47gJFvSt793ga4V9vyrog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cXmfd6TjJJiElg2BGv9kKytrjnaTL/jqja8mpZiClLSqWJgMQGdxw1evsyLX0GDQ5
         DiwQsZ0leWtD5r0H1CeKKP5abRrX1FjPXU7KbQFBZfONnaLCYgCaX5dKcbwyMBuSdj
         doFciq+1NeiwHYOpBdOc252A8Ht4i37AaTUECAGY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Timothy E Baldwin <T.E.Baldwin99@members.leeds.ac.uk>,
        Eugene Syromyatnikov <evgsyr@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 100/115] ARM: 8802/1: Call syscall_trace_exit even when system call skipped
Date:   Tue, 12 Nov 2019 20:56:07 -0500
Message-Id: <20191113015622.11592-100-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015622.11592-1-sashal@kernel.org>
References: <20191113015622.11592-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Timothy E Baldwin <T.E.Baldwin99@members.leeds.ac.uk>

[ Upstream commit f18aef742c8fbd68e280dff0a63ba0ca6ee8ad85 ]

On at least x86 and ARM64, and as documented in the ptrace man page
a skipped system call will still cause a syscall exit ptrace stop.

Previous to this commit 32-bit ARM did not, resulting in strace
being confused when seccomp skips system calls.

This change also impacts programs that use ptrace to skip system calls.

Fixes: ad75b51459ae ("ARM: 7579/1: arch/allow a scno of -1 to not cause a SIGILL")
Signed-off-by: Timothy E Baldwin <T.E.Baldwin99@members.leeds.ac.uk>
Signed-off-by: Eugene Syromyatnikov <evgsyr@gmail.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Kees Cook <keescook@chromium.org>
Tested-by: Eugene Syromyatnikov <evgsyr@gmail.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/kernel/entry-common.S | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index d7dc808a3d154..08a7132f56006 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -282,16 +282,15 @@ __sys_trace:
 	cmp	scno, #-1			@ skip the syscall?
 	bne	2b
 	add	sp, sp, #S_OFF			@ restore stack
-	b	ret_slow_syscall
 
-__sys_trace_return:
-	str	r0, [sp, #S_R0 + S_OFF]!	@ save returned r0
+__sys_trace_return_nosave:
+	enable_irq_notrace
 	mov	r0, sp
 	bl	syscall_trace_exit
 	b	ret_slow_syscall
 
-__sys_trace_return_nosave:
-	enable_irq_notrace
+__sys_trace_return:
+	str	r0, [sp, #S_R0 + S_OFF]!	@ save returned r0
 	mov	r0, sp
 	bl	syscall_trace_exit
 	b	ret_slow_syscall
-- 
2.20.1

