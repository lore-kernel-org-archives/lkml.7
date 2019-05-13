Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC223C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B820C2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 17:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="mH1hrvej"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731747AbfEMR2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 13:28:07 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:45364 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731719AbfEMR2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 13:28:04 -0400
Received: from mailhost.synopsys.com (dc8-mailhost2.synopsys.com [10.13.135.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id ECBD6C01BE;
        Mon, 13 May 2019 17:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1557768475; bh=xuOs4qwSdffNeE4cSBsvtl4Yi23BFWFZxAfSB82nI1M=;
        h=From:To:Cc:Subject:Date:From;
        b=mH1hrvejYv/qBh+ZvZnGVo/Y2EgAw4cQN5pr+nC2j8vqY/JBjREeO4YRrcU0uQ/yE
         qFmr9QeibhNm6XhcC0sb2OonJOey1p+mdpqH7W0s5ZFGw5bcDs5PQ+GXlF0m19Pv+i
         eZxkGG4q44wqzaJEZVhafKDERsKIicbCCU2Aekm7w9aMUnF+Bm45pghzJ8/AMn8yfU
         mS5qOHbx+IhA5yo3LUeYMGYUiAjvtUHZj9ynCVXr0b6aUMgEk8KaDdSaZ+q52iTj1A
         uhnlpXxG4Fm/JJ1U0R8A4QLvy+0VAOw4AMsGZV+zcOA8bNwnd5r/4v5qG6Otgi1Q70
         046cx5c0/a9lA==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.8.106])
        by mailhost.synopsys.com (Postfix) with ESMTP id 66F75A005A;
        Mon, 13 May 2019 17:28:02 +0000 (UTC)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH v2] ARC: Send SIGSEGV if userspace process accesses kernel virtual memory
Date:   Mon, 13 May 2019 20:28:00 +0300
Message-Id: <20190513172800.27940-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of today if userspace process tries to access address which belongs
to kernel virtual memory area and kernel have mapping for this address
that process hangs instead of receiving SIGSEGV and being killed.

Steps to reproduce:
Create userspace application which reads from the beginning of
kernel-space virtual memory area (I.E. read from 0x7000_0000 on most
of existing platforms):
------------------------>8-----------------
 #include <stdlib.h>
 #include <stdint.h>

 int main(int argc, char *argv[])
 {
 	volatile uint32_t temp;

 	temp = *(uint32_t *)(0x70000000);
 }
------------------------>8-----------------
That application hangs after such memory access.

Fix that by checking which access (user or kernel) caused the exception
before handling kernel virtual address fault.

Fix that by checking that VMALLOC_FAULT was caused in kernel mode
before trying to handle it.
Thus we can use @no_context label, removing the need for
@bad_area_nosemaphore and untangling the code mess a bit.

Cc: <stable@vger.kernel.org> # 4.20+
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/mm/fault.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
index 8df1638259f3..6836095251ed 100644
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
@@ -198,7 +196,6 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 bad_area:
 	up_read(&mm->mmap_sem);
 
-bad_area_nosemaphore:
 	/* User mode accesses just cause a SIGSEGV */
 	if (user_mode(regs)) {
 		tsk->thread.fault_address = address;
-- 
2.14.5

