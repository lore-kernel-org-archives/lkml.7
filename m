Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96457C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6246420856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554192220;
	bh=lXG61drHYKWkH6JkBOWzJQigVdmu7d5++K4qQ0nR6fY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IVCz75lrXjPmgFo3sfjNilb1zRoSWEvKq6NwWkB3b22gOwgCvWlx4BXBMdO8ITbgb
	 Lpfy9GIO9IwBGQ3ECh3zEhwbOhDyUvI9Qjmhc+4qCUibqfvDxdEJJT/VA9ZmzPoUtO
	 asCJ3oGgcmv9LXrGeVxO6+GdLZ3GoXMiuhECyKWM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbfDBIDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 04:03:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:41462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfDBIDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 04:03:39 -0400
Received: from localhost.localdomain (unknown [115.192.191.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 167F620830;
        Tue,  2 Apr 2019 08:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554192218;
        bh=lXG61drHYKWkH6JkBOWzJQigVdmu7d5++K4qQ0nR6fY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fVLzstJbIsNs/lJESTdus9nNjlp+OfV5VYENhKjX4AVWbE9YpNfZuZxVu3dN/1AO6
         jOsUpiWtHRiwfFMOALwW0wSIYn/aDIDtluGkd/cINLiHJlDDsAsnhSWZLuzEGQq5P4
         7mcPBIx97phlkSwKEKndqCtQfUfOrh6qkVCq2P2c=
From:   guoren@kernel.org
To:     arnd@arndb.de, palmer@sifive.com
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        ren_guo@c-sky.com, linux-riscv@lists.infradead.org
Subject: [PATCH 3/3] riscv/signal: Fixup additional syscall restarting
Date:   Tue,  2 Apr 2019 16:02:33 +0800
Message-Id: <1554192153-2587-3-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554192153-2587-1-git-send-email-guoren@kernel.org>
References: <1554192153-2587-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

The function of do_notify_resume called by entry.S could be entered
in loop when SIGPENDING was setted again before sret. So we must add
prevent code to make syscall restart (regs->sepc -= 0x4) or it may
re-execute unexpected instructions.

Just like in_syscall & forget_syscall used by arm.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/riscv/kernel/signal.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index 837e164..804d6ee 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -234,6 +234,9 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 
 	/* Are we from a system call? */
 	if (regs->scause == EXC_SYSCALL) {
+		/* Avoid additional syscall restarting via ret_from_exception */
+		regs->scause = -1UL;
+
 		/* If so, check system call restarting.. */
 		switch (regs->a0) {
 		case -ERESTART_RESTARTBLOCK:
@@ -272,6 +275,9 @@ static void do_signal(struct pt_regs *regs)
 
 	/* Did we come from a system call? */
 	if (regs->scause == EXC_SYSCALL) {
+		/* Avoid additional syscall restarting via ret_from_exception */
+		regs->scause = -1UL;
+
 		/* Restart the system call - no handlers present */
 		switch (regs->a0) {
 		case -ERESTARTNOHAND:
-- 
2.7.4

