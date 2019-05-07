Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443D6C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 07:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F20E21019
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 07:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfEGHgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 03:36:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:56868 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726449AbfEGHgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 03:36:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 83F24AD17;
        Tue,  7 May 2019 07:36:46 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     linux-riscv@lists.infradead.org
Subject: [PATCH] riscv: fix locking violation in page fault handler
CC:     linux-kernel@vger.kernel.org
X-Yow:  I'm rated PG-34!!
Date:   Tue, 07 May 2019 09:36:46 +0200
Message-ID: <mvm5zqmu35d.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a user mode process accesses an address in the vmalloc area
do_page_fault tries to unlock the mmap semaphore when it isn't locked.

Signed-off-by: Andreas Schwab <schwab@suse.de>
---
 arch/riscv/mm/fault.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 88401d5125bc..c51878e5a66a 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -181,6 +181,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 	up_read(&mm->mmap_sem);
 	/* User mode accesses just cause a SIGSEGV */
 	if (user_mode(regs)) {
+bad_area_do_trap:
 		do_trap(regs, SIGSEGV, code, addr, tsk);
 		return;
 	}
@@ -230,7 +231,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 		int index;
 
 		if (user_mode(regs))
-			goto bad_area;
+			goto bad_area_do_trap;
 
 		/*
 		 * Synchronize this task's top level page-table
-- 
2.21.0


-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
