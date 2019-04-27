Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0494C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98552216C4
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329427;
	bh=GfVGltHsuRGwLDCG05ZdifajtPUEqqEoa4VQkaf0hNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Pwd6SIfm/BRbjmgoNxXjOImXgLnLvp3W5fEU2ovu6uY8uVyGTXD+YjEbzdh7Q6N7q
	 v4GEeUkrHDg+0XQNM7m4GCXnaJRMedqCG8kP8XQUftf0OXlEBjlYJvxMZAUa86aRfl
	 nQ7ciiDCeYyWW3O3XfttoVTz2bS6x57JGV8Q8BXw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbfD0Bnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:43:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:48004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728272AbfD0Bno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:43:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8F4A21707;
        Sat, 27 Apr 2019 01:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329424;
        bh=GfVGltHsuRGwLDCG05ZdifajtPUEqqEoa4VQkaf0hNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hwmvOI/FXY8ZFenwqCM61nrrBB1eGA12g1oaDJZzYVmLwPE5wP8VGm0ZXswTkHHif
         CUpaijjKJ2gU3AS1PuJwPA/nGKiI/McgyemCJwh2KHqrS04HCuGZJIP4Bs2IFqDXby
         Otr/aQxSvgPyQwcvLgvoAsqdkWZbhRoXdixvTs2w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Max Filippov <jcmvbkbc@gmail.com>, Sasha Levin <sashal@kernel.org>,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH AUTOSEL 4.9 10/16] xtensa: fix initialization of pt_regs::syscall in start_thread
Date:   Fri, 26 Apr 2019 21:43:18 -0400
Message-Id: <20190427014325.8704-10-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427014325.8704-1-sashal@kernel.org>
References: <20190427014325.8704-1-sashal@kernel.org>
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
index 521c1e789e6e..1fc015459755 100644
--- a/arch/xtensa/include/asm/processor.h
+++ b/arch/xtensa/include/asm/processor.h
@@ -180,15 +180,18 @@ struct thread_struct {
 
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

