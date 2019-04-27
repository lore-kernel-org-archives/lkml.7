Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F91C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD1AA208CB
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329484;
	bh=mp+6I4pjRm2AYmoLAup1iyp+O3VM/J2JrXVtgrHNfL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B2+Lyq2M+8hSWn8pMvzPfvOqt49h7KDTPvfWuwSLOMkgGD0TbVYVEsTGsJIAmOqUS
	 pGFnOKQ0mMT9zmr76ZusAfpmiLhqcsCAdwx1rXEd8R/i1T3+nK9ou0Y5r50g6a2R59
	 ccj1qSSIFmA+DhqIk8iJvR5ntQGKLcwtz3uC8V9o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbfD0Bon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:44:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:48712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727501AbfD0BoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:44:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE6D7215EA;
        Sat, 27 Apr 2019 01:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329460;
        bh=mp+6I4pjRm2AYmoLAup1iyp+O3VM/J2JrXVtgrHNfL8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gJq/ngW/256zOiIzmxamChxYXmZKl6H26gP1/xQIqbs2Bx9hMIp47WmxRydlWnoN/
         Zwmzn7qwz7bE9r4FjEZhHixfoJnir2F2tCMEmD4XPWY0Gu30KSTZER5YnuR1lzMRoW
         jHjKGumGpGaxcUH33dTPtAjHbVfIR1w4LS0ahOTM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Max Filippov <jcmvbkbc@gmail.com>, Sasha Levin <sashal@kernel.org>,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH AUTOSEL 3.18 5/8] xtensa: fix initialization of pt_regs::syscall in start_thread
Date:   Fri, 26 Apr 2019 21:44:08 -0400
Message-Id: <20190427014412.9091-5-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427014412.9091-1-sashal@kernel.org>
References: <20190427014412.9091-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Filippov <jcmvbkbc@gmail.com>

[ Upstream commit 2663147dc7465cb29040a05cc4286fdd839978b5 ]

New pt_regs should indicate that there's no syscall, not that there's
syscall #0. While at it wrap macro body in do/while and parenthesize
macro arguments.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/xtensa/include/asm/processor.h | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/xtensa/include/asm/processor.h b/arch/xtensa/include/asm/processor.h
index b61bdf0eea25..79b2d1a6b4ff 100644
--- a/arch/xtensa/include/asm/processor.h
+++ b/arch/xtensa/include/asm/processor.h
@@ -152,15 +152,18 @@ struct thread_struct {
 
 /* Clearing a0 terminates the backtrace. */
 #define start_thread(regs, new_pc, new_sp) \
-	memset(regs, 0, sizeof(*regs)); \
-	regs->pc = new_pc; \
-	regs->ps = USER_PS_VALUE; \
-	regs->areg[1] = new_sp; \
-	regs->areg[0] = 0; \
-	regs->wmask = 1; \
-	regs->depc = 0; \
-	regs->windowbase = 0; \
-	regs->windowstart = 1;
+	do { \
+		memset((regs), 0, sizeof(*(regs))); \
+		(regs)->pc = (new_pc); \
+		(regs)->ps = USER_PS_VALUE; \
+		(regs)->areg[1] = (new_sp); \
+		(regs)->areg[0] = 0; \
+		(regs)->wmask = 1; \
+		(regs)->depc = 0; \
+		(regs)->windowbase = 0; \
+		(regs)->windowstart = 1; \
+		(regs)->syscall = NO_SYSCALL; \
+	} while (0)
 
 /* Forward declaration */
 struct task_struct;
-- 
2.19.1

