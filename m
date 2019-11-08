Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E402C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E21EA222CF
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573213253;
	bh=RoJ98/3J4bGpFbXoIaQYhTZs4qSivjw8NPTnwltpGGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qAQtTEKVd7ZShNc6fc0Ocn0vAydqGlB+lbWfref0J+7ktL3L27gF5Z3fnilWWHxMP
	 UxWaF2LykyZBeW/gNjx5LzIt9EOLLcJ21FZDtI1jATVxgSpJ02+zgI7/ZCihh+u0pH
	 Y4sM8lGo0upZJnC/weDK27A61CIVBF0wTqQncH1c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389014AbfKHLkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:40:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:53712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388974AbfKHLkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:40:46 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75469222C4;
        Fri,  8 Nov 2019 11:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213245;
        bh=RoJ98/3J4bGpFbXoIaQYhTZs4qSivjw8NPTnwltpGGc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QoLYf2fqb/kF+6vYnEYmWWgUaavB4uwycXjRaurabMpwm3wgPeGHGkiinAtiQuciI
         v6bSIBc8Gor2WNkvktGfKO6GSTAezlCx0xmuk/lRP+IPFt/XjXssZQ5xB5Vrq/Dncg
         iVFE3/64zQ3TDruEnSdPQV126WufVVtkuaVeRXYI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Philipp Klocke <philipp97kl@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        clang-built-linux@googlegroups.com
Subject: [PATCH AUTOSEL 4.19 114/205] sched/debug: Explicitly cast sched_feat() to bool
Date:   Fri,  8 Nov 2019 06:36:21 -0500
Message-Id: <20191108113752.12502-114-sashal@kernel.org>
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

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 7e6f4c5d600c1c8e2a1d900e65cab319d9b6782e ]

LLVM has a warning that tags expressions like:

	if (foo && non-bool-const)

This pattern triggers for CONFIG_SCHED_DEBUG=n where sched_feat() ends
up being whatever bit we select. Avoid the warning with an explicit
cast to bool.

Reported-by: Philipp Klocke <philipp97kl@gmail.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9a7c3d08b39f8..c32322c73e22a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1393,7 +1393,7 @@ static const_debug __maybe_unused unsigned int sysctl_sched_features =
 	0;
 #undef SCHED_FEAT
 
-#define sched_feat(x) (sysctl_sched_features & (1UL << __SCHED_FEAT_##x))
+#define sched_feat(x) !!(sysctl_sched_features & (1UL << __SCHED_FEAT_##x))
 
 #endif /* SCHED_DEBUG && CONFIG_JUMP_LABEL */
 
-- 
2.20.1

