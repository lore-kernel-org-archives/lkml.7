Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BD9C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03238215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573214307;
	bh=CxjtkCJ5cvAF6I3EU4aSmKk9PXTOLpIbmiFxjIgh9/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Blipyqz/sVmCyRMRr3bH2lTwmD77aPMn6+KmHIl8LXOX948ll/eEQiW+iEc+Qfj/A
	 zsva5/v2P+vYsl0RTx7B/xPpCgIXKi5L4b8O4fuLU8NdUdm3sddtBd08l4xbe/qH6T
	 QUGu/V+LOSnVqVRI1MvE0GKDTYI/zo3nCMC5UsvE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391366AbfKHL60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:58:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:59800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390878AbfKHLor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:44:47 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6FF52245B;
        Fri,  8 Nov 2019 11:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213486;
        bh=CxjtkCJ5cvAF6I3EU4aSmKk9PXTOLpIbmiFxjIgh9/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pLpBe3jmYWKd7UZGlwQYsv3Sy55AykyicBhmtCsRY0Ms+RiqX0lxRktEkO+L+R9Ci
         3gp8zChrwYrZ+346/qpWGprqO9Go7F4geouDvf3eiS/vy9BWHBcNEU1pofsxT2CsC0
         HDdEOJt4Sa8d/32lmaZnjMZjJj7SaCJJgTGFfz5E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 066/103] signal: Properly deliver SIGSEGV from x86 uprobes
Date:   Fri,  8 Nov 2019 06:42:31 -0500
Message-Id: <20191108114310.14363-66-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108114310.14363-1-sashal@kernel.org>
References: <20191108114310.14363-1-sashal@kernel.org>
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
index 7a87ef1f5b5e6..73391c1bd2a9a 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -987,7 +987,7 @@ arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr, struct pt_regs
 		pr_err("uprobe: return address clobbered: pid=%d, %%sp=%#lx, "
 			"%%ip=%#lx\n", current->pid, regs->sp, regs->ip);
 
-		force_sig_info(SIGSEGV, SEND_SIG_FORCED, current);
+		force_sig(SIGSEGV, current);
 	}
 
 	return -1;
-- 
2.20.1

