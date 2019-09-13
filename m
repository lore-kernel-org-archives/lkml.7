Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F25CC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 033DC206BB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381413;
	bh=HkYZv90sZN7NQyNcuQLg+7POxv5e7uxidSp5VsrL/dI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gnzP+boPExYyTXOcWNKC0vPZCzl04FzUYqNCE4H/wxYblxKpOySY9TfW0vW/lzspj
	 b/N8qxhLRwELUb8+2fLXM1Y4Q1MVSg20BGhc4zpQGRa33DuUIg43ya70M3DqYnWl2L
	 91wU1SMv+SzXZpk8ImLchiXp0fWPq8yZ1Xm5400A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391673AbfIMNaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:30:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:44814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390071AbfIMNRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:17:32 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E38D820717;
        Fri, 13 Sep 2019 13:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568380652;
        bh=HkYZv90sZN7NQyNcuQLg+7POxv5e7uxidSp5VsrL/dI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FN9hfDnqxEpXt+kA1R6XGtErq/yiPZJNPrBpB8paSI9RvYSk6wJPBTa0P2TZzfUbH
         Oi0kdGch+DnwCro/neyaHIq5nlrz5+vV55I5xVJMHRe/5we6HJc3gv1ovftZJHBw0u
         OOpZiYpeaWObYp2f6UyPxRX62vcAKAl0OceRLazI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 134/190] ARC: mm: SIGSEGV userspace trying to access kernel virtual memory
Date:   Fri, 13 Sep 2019 14:06:29 +0100
Message-Id: <20190913130610.668515923@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913130559.669563815@linuxfoundation.org>
References: <20190913130559.669563815@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit a8c715b4dd73c26a81a9cc8dc792aa715d8b4bb2 ]

As of today if userspace process tries to access a kernel virtual addres
(0x7000_0000 to 0x7ffff_ffff) such that a legit kernel mapping already
exists, that process hangs instead of being killed with SIGSEGV

Fix that by ensuring that do_page_fault() handles kenrel vaddr only if
in kernel mode.

And given this, we can also simplify the code a bit. Now a vmalloc fault
implies kernel mode so its failure (for some reason) can reuse the
@no_context label and we can remove @bad_area_nosemaphore.

Reproduce user test for original problem:

------------------------>8-----------------
 #include <stdlib.h>
 #include <stdint.h>

 int main(int argc, char *argv[])
 {
 	volatile uint32_t temp;

 	temp = *(uint32_t *)(0x70000000);
 }
------------------------>8-----------------

Cc: <stable@vger.kernel.org>
Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arc/mm/fault.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
index 535cf18e8bf2c..4e8143de32e70 100644
--- a/arch/arc/mm/fault.c
+++ b/arch/arc/mm/fault.c
@@ -66,7 +66,7 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 	struct vm_area_struct *vma = NULL;
 	struct task_struct *tsk = current;
 	struct mm_struct *mm = tsk->mm;
-	int si_code = 0;
+	int si_code = SEGV_MAPERR;
 	int ret;
 	vm_fault_t fault;
 	int write = regs->ecr_cause & ECR_C_PROTV_STORE;  /* ST/EX */
@@ -81,16 +81,14 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 	 * only copy the information from the master page table,
 	 * nothing more.
 	 */
-	if (address >= VMALLOC_START) {
+	if (address >= VMALLOC_START && !user_mode(regs)) {
 		ret = handle_kernel_vaddr_fault(address);
 		if (unlikely(ret))
-			goto bad_area_nosemaphore;
+			goto no_context;
 		else
 			return;
 	}
 
-	si_code = SEGV_MAPERR;
-
 	/*
 	 * If we're in an interrupt or have no user
 	 * context, we must not take the fault..
@@ -198,7 +196,6 @@ good_area:
 bad_area:
 	up_read(&mm->mmap_sem);
 
-bad_area_nosemaphore:
 	/* User mode accesses just cause a SIGSEGV */
 	if (user_mode(regs)) {
 		tsk->thread.fault_address = address;
-- 
2.20.1



