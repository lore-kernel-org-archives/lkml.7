Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05524C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD9C7217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553710057;
	bh=tl42kwFAFR+iPHn8laL8wOEP4kiIf0qgujs/5nh7pQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RMOlWgvCVP+d/d+CmBY71hZsN/umsanDjwxAkUasG+maay/27rXifBPu+ndENfdDI
	 VE49H35ph4/bWTPxfAicwVQB5oyFD6msA0XwYYxwyUFN0bWxv4hAWSeWZnPnWWH7ug
	 u/EUoHhQNWqSUwaoWehDkVXoGK8xoFgvqaF6/8CA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388223AbfC0SHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:07:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:49378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387685AbfC0SHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:07:31 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49FA32070B;
        Wed, 27 Mar 2019 18:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710050;
        bh=tl42kwFAFR+iPHn8laL8wOEP4kiIf0qgujs/5nh7pQk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J1KLjW7CgWLYY77gDtyL1u3v1iwUFagi+syGiBeLS6BaB3M6V7MOXH8sVMZy/wejc
         HexcngFiOuXLdwyMYDV/YtfOKS8f7YubfJoZh5sH6MWxd5HDHKBGenAI1+RLnLxkEj
         C8iYnPnrbx2S5LvNsZpL3MWpLqOiL6ipcsuAY+RM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Breno Leitao <leitao@debian.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.0 174/262] powerpc/ptrace: Mitigate potential Spectre v1
Date:   Wed, 27 Mar 2019 14:00:29 -0400
Message-Id: <20190327180158.10245-174-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Breno Leitao <leitao@debian.org>

[ Upstream commit ebb0e13ead2ddc186a80b1b0235deeefc5a1a667 ]

'regno' is directly controlled by user space, hence leading to a potential
exploitation of the Spectre variant 1 vulnerability.

On PTRACE_SETREGS and PTRACE_GETREGS requests, user space passes the
register number that would be read or written. This register number is
called 'regno' which is part of the 'addr' syscall parameter.

This 'regno' value is checked against the maximum pt_regs structure size,
and then used to dereference it, which matches the initial part of a
Spectre v1 (and Spectre v1.1) attack. The dereferenced value, then,
is returned to userspace in the GETREGS case.

This patch sanitizes 'regno' before using it to dereference pt_reg.

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Signed-off-by: Breno Leitao <leitao@debian.org>
Acked-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/ptrace.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 53151698bfe0..d9ac7d94656e 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -33,6 +33,7 @@
 #include <linux/hw_breakpoint.h>
 #include <linux/perf_event.h>
 #include <linux/context_tracking.h>
+#include <linux/nospec.h>
 
 #include <linux/uaccess.h>
 #include <linux/pkeys.h>
@@ -274,6 +275,8 @@ static int set_user_trap(struct task_struct *task, unsigned long trap)
  */
 int ptrace_get_reg(struct task_struct *task, int regno, unsigned long *data)
 {
+	unsigned int regs_max;
+
 	if ((task->thread.regs == NULL) || !data)
 		return -EIO;
 
@@ -297,7 +300,9 @@ int ptrace_get_reg(struct task_struct *task, int regno, unsigned long *data)
 	}
 #endif
 
-	if (regno < (sizeof(struct user_pt_regs) / sizeof(unsigned long))) {
+	regs_max = sizeof(struct user_pt_regs) / sizeof(unsigned long);
+	if (regno < regs_max) {
+		regno = array_index_nospec(regno, regs_max);
 		*data = ((unsigned long *)task->thread.regs)[regno];
 		return 0;
 	}
@@ -321,6 +326,7 @@ int ptrace_put_reg(struct task_struct *task, int regno, unsigned long data)
 		return set_user_dscr(task, data);
 
 	if (regno <= PT_MAX_PUT_REG) {
+		regno = array_index_nospec(regno, PT_MAX_PUT_REG + 1);
 		((unsigned long *)task->thread.regs)[regno] = data;
 		return 0;
 	}
-- 
2.19.1

