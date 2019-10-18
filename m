Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D47CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8864E205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571437545;
	bh=d/6zc+tZJQ0l59lFjH5IKUXNkBz2OQ9GKqznhzOEnoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E1ULWzFISRovjiRW3OVDB4HfPRyJ0C9jFJvi0TdlPRCmjNyUn5q6t5HvFrRD/2s9H
	 +0Qm/T374Scltq9fDf0VeC2n5CgnfUiUeci2sy1o3SDxAxLbfh2UIwGVyFaVjU6/nm
	 xujYwCf9VUrDA7NxLQOH9PPKim0b6Ec6cFgoiXPE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405857AbfJRWZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:25:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:36258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728314AbfJRWEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 18:04:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F3A6222CC;
        Fri, 18 Oct 2019 22:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571436273;
        bh=d/6zc+tZJQ0l59lFjH5IKUXNkBz2OQ9GKqznhzOEnoA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XV6zvPvZKq2mDapBa8Eg5nDYTtjfwT3evZnCkwNwOxRlgKsjY4XDWpyGPeCjIkcRG
         /uyTqfhvej73GzkelNEFeX0NNyW2WcPUGGL+ipr17BmtX/aX1MVdQBtXf4TsnFgxpf
         9lkK3zIHpqBEl5nkGlyGlWNIOzhO1i7Pj9qR2V+E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vincent Chen <vincent.chen@sifive.com>,
        Christoph Hellwig <hch@lst.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.3 52/89] riscv: avoid kernel hangs when trapped in BUG()
Date:   Fri, 18 Oct 2019 18:02:47 -0400
Message-Id: <20191018220324.8165-52-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018220324.8165-1-sashal@kernel.org>
References: <20191018220324.8165-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Chen <vincent.chen@sifive.com>

[ Upstream commit 8b04825ed205da38754f86f4c07ea8600d8c2a65 ]

When the CONFIG_GENERIC_BUG is disabled by disabling CONFIG_BUG, if a
kernel thread is trapped by BUG(), the whole system will be in the
loop that infinitely handles the ebreak exception instead of entering the
die function. To fix this problem, the do_trap_break() will always call
the die() to deal with the break exception as the type of break is
BUG_TRAP_TYPE_BUG.

Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/kernel/traps.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 424eb72d56b10..055a937aca70a 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -124,23 +124,23 @@ static inline unsigned long get_break_insn_length(unsigned long pc)
 
 asmlinkage void do_trap_break(struct pt_regs *regs)
 {
-#ifdef CONFIG_GENERIC_BUG
 	if (!user_mode(regs)) {
 		enum bug_trap_type type;
 
 		type = report_bug(regs->sepc, regs);
 		switch (type) {
+#ifdef CONFIG_GENERIC_BUG
 		case BUG_TRAP_TYPE_NONE:
 			break;
 		case BUG_TRAP_TYPE_WARN:
 			regs->sepc += get_break_insn_length(regs->sepc);
 			break;
 		case BUG_TRAP_TYPE_BUG:
+#endif /* CONFIG_GENERIC_BUG */
+		default:
 			die(regs, "Kernel BUG");
 		}
 	}
-#endif /* CONFIG_GENERIC_BUG */
-
 	force_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)(regs->sepc));
 }
 
-- 
2.20.1

