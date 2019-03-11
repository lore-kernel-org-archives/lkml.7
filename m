Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2C6C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85D622087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552334201;
	bh=KCYbM44UkkzAZSDmre6qaYGbY/SVl1TcHwJtGrV0v+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c6YsFqeoUtc0Tuy+4llaLc4moPR4dqzj+0d3HLmYwe2MPRgOlH44CDZW3mW4qq8iv
	 BGWCJrJVfbKrk88mA3TfPMIN76LDrJkf5mpoL3jfmI7pdoEsf/hGUx/Mq2SM/fE14U
	 mwoSJhQXDJntAT3Z2Z06Xx5ytFIiUv+EAftw8zAU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbfCKT4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:56:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:33836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728749AbfCKT4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:56:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F7E121734;
        Mon, 11 Mar 2019 19:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552334192;
        bh=KCYbM44UkkzAZSDmre6qaYGbY/SVl1TcHwJtGrV0v+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fa3djMJpmJt4t/6qi7GZ76GuScwLcxd9+k8Pu94d0GW9n9RGM4fGm7VzSjSg2BDfx
         QZEngEhIcjjeMG2tol4O+xeLQ7JrNwU1ffjEc+M5t2VMxpnlViBg+FZ85+v3VoNm16
         Vs5dGE6BV1FKs3PwACaWN5ijckjNUDGggsAfsmTA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Guo Ren <ren_guo@c-sky.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 40/52] csky: Fixup wrong pt_regs size
Date:   Mon, 11 Mar 2019 15:55:04 -0400
Message-Id: <20190311195516.137772-40-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190311195516.137772-1-sashal@kernel.org>
References: <20190311195516.137772-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

[ Upstream commit 9216cd7231c12a8c391bb2c904d13695398d3453 ]

The bug is from commit 2054f4af1957 ("csky: bugfix gdb coredump error.")

We change the ELF_NGREG to ELF_NGREG - 2 to fit gdb&gcc define, but forgot
modify ptrace regset.
Now coredump use ELF_NRGEG to parse GPRs and ptrace use pt_regs_regset, so
there are two different reg_sets for userspace.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/csky/kernel/ptrace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/csky/kernel/ptrace.c b/arch/csky/kernel/ptrace.c
index 34b30257298f..b5e4a706c867 100644
--- a/arch/csky/kernel/ptrace.c
+++ b/arch/csky/kernel/ptrace.c
@@ -8,6 +8,7 @@
 #include <linux/ptrace.h>
 #include <linux/regset.h>
 #include <linux/sched.h>
+#include <linux/sched/task_stack.h>
 #include <linux/signal.h>
 #include <linux/smp.h>
 #include <linux/uaccess.h>
@@ -161,7 +162,7 @@ static int fpr_set(struct task_struct *target,
 static const struct user_regset csky_regsets[] = {
 	[REGSET_GPR] = {
 		.core_note_type = NT_PRSTATUS,
-		.n = ELF_NGREG,
+		.n = sizeof(struct pt_regs) / sizeof(u32),
 		.size = sizeof(u32),
 		.align = sizeof(u32),
 		.get = &gpr_get,
-- 
2.19.1

