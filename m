Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1329FC6196
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EF9B22459
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573213284;
	bh=PqZZ0bxqXQ0wT7uuBrDv+Tbx5Fn5EsJo8lr5iAdkK4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1VNXJ1pBTPz9/Q2YJzD0wbc65cWActvcTGqN/1rhZ9QpB32ZNNEDs4Zjwo1kVMgNh
	 OpBES/EzlsXe/Vlk/NhI7DnQuii3AB3+w+0gFZCjSpU6Ya+HGidYpnBgOUfc8wVU5M
	 isCxzWRS95iElkhMVXYvSnuytTkLbNQjo3iumXrs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389415AbfKHLlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:41:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:54416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389215AbfKHLlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:41:12 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC041222C2;
        Fri,  8 Nov 2019 11:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213271;
        bh=PqZZ0bxqXQ0wT7uuBrDv+Tbx5Fn5EsJo8lr5iAdkK4U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lZfvzCv6QyGSxjpUjSSkFJevqo4AaZzlC8UtyU8yrUsrYg7m2WZ45Cr14trGjiran
         /rfBtQ84LVFuXgcZWxOebcnUHOykxicCXVDC3qf3aFtDsbpSCG/ESMv7MC66Y4k8CI
         p4f3fpyUy9ddvCw2sy6Yi2jlQVmhJPIHtyqu5w2A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 133/205] signal: Properly deliver SIGSEGV from x86 uprobes
Date:   Fri,  8 Nov 2019 06:36:40 -0500
Message-Id: <20191108113752.12502-133-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108113752.12502-1-sashal@kernel.org>
References: <20191108113752.12502-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Eric W. Biederman" <ebiederm@xmission.com>

[ Upstream commit 4a63c1ffd384ebdce40aac9c997dab68379137be ]

For userspace to tell the difference between an random signal
and an exception, the exception must include siginfo information.

Using SEND_SIG_FORCED for SIGSEGV is thus wrong, and it will result in
userspace seeing si_code == SI_USER (like a random signal) instead of
si_code == SI_KERNEL or a more specific si_code as all exceptions
deliver.

Therefore replace force_sig_info(SIGSEGV, SEND_SIG_FORCE, current)
with force_sig(SIG_SEGV, current) which gets this right and is shorter
and easier to type.

Fixes: 791eca10107f ("uretprobes/x86: Hijack return address")
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 9119859ba7871..420aa7d3a2e6b 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -1089,7 +1089,7 @@ arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr, struct pt_regs
 		pr_err("return address clobbered: pid=%d, %%sp=%#lx, %%ip=%#lx\n",
 		       current->pid, regs->sp, regs->ip);
 
-		force_sig_info(SIGSEGV, SEND_SIG_FORCED, current);
+		force_sig(SIGSEGV, current);
 	}
 
 	return -1;
-- 
2.20.1

