Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93852C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63C27217D4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369321;
	bh=arQQroCuE3Tz40RLNSGqCBRyf0pJwzkFjGW8/PrcC0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nfKaQ3x5zrfL2F2vFOCvNBj6LRWtKy/kNOtayyfZ0PIMclK96xiEFZaqRfj/trcdM
	 mUODwqoPsGZUql4ztQRYoSv28MWohdpYTO8cFPduNWqyojdd1Kxx0n0yPRxXmUXcd6
	 KOY2uv1HDFEkCYMD+XaDMsYgLnDe573oPctp/uIM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387861AbfDDJPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:15:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:56202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732558AbfDDJPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:15:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDB762147C;
        Thu,  4 Apr 2019 09:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369316;
        bh=arQQroCuE3Tz40RLNSGqCBRyf0pJwzkFjGW8/PrcC0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rUKpxxJEKk9EGJacdN2hVPxDFqg29kroDf/MIrkc7+vQGRJXXaQCIjxTAQxKYgK/T
         P0GhLs56rKC7G5obwV1sLyjk9b773H16aZkMzbQ3I3NXz8R8jdSk8yQILyPOMyHDkK
         UsYXHfmIw+ymxXfJN9ScUEkmNMmIyYIeUy1WgEdU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Breno Leitao <leitao@debian.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 164/246] powerpc/ptrace: Mitigate potential Spectre v1
Date:   Thu,  4 Apr 2019 10:47:44 +0200
Message-Id: <20190404084624.915139062@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

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



