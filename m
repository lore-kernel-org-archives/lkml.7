Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3727C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 14:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F4522146F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 14:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="bxWpXWU/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730787AbfEMOmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 10:42:01 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:37628 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730772AbfEMOl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 10:41:57 -0400
Received: from mailhost.synopsys.com (dc8-mailhost2.synopsys.com [10.13.135.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 32332C0161;
        Mon, 13 May 2019 14:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1557758508; bh=Q4RwNBuD8FtLCQ9UQgg0ETBjXIo13TCHbTK17grz4lY=;
        h=From:To:Cc:Subject:Date:From;
        b=bxWpXWU/MCnS+mi6hZ8O3LDVNP667dIopzjPVf22P7/Otl8C1qtBdGdadJTe9Ur38
         eoT3IFkJA7d3WG6IBfB8OKHbQ84RzY4Y5YtrmLjhebvKEWEAJdlaWXsZBeZyTl2mrF
         KWOmN7SYBlqzZXBpjU8gLXO5X25c1U4k677uCw/jaoZm1MK0JijbxOE+V9bWUzv7qJ
         6mQ0mLvbjd2PUvvxZGHG5gv3j3kG8ic+hYnEjzfBcTXCetaT5ARV9221nxnvcQyOTE
         61c7NLlK6Ee3o/Xoh0oGGge7avtKuerJQWdZpei1N1giZkvju8/hwnv4jWwEuZ8skP
         fq+OZWHIWp2ZQ==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.8.106])
        by mailhost.synopsys.com (Postfix) with ESMTP id B5A52A005A;
        Mon, 13 May 2019 14:41:55 +0000 (UTC)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH] ARC: Send SIGSEGV if userspace process accesses kernel virtual memory
Date:   Mon, 13 May 2019 17:41:53 +0300
Message-Id: <20190513144153.6112-1-Eugeniy.Paltsev@synopsys.com>
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

Cc: <stable@vger.kernel.org> # 4.20+
Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/mm/fault.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
index 8df1638259f3..53fb4ba6cd08 100644
--- a/arch/arc/mm/fault.c
+++ b/arch/arc/mm/fault.c
@@ -66,7 +66,7 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 	struct vm_area_struct *vma = NULL;
 	struct task_struct *tsk = current;
 	struct mm_struct *mm = tsk->mm;
-	int si_code = 0;
+	int si_code = SEGV_ACCERR;
 	int ret;
 	vm_fault_t fault;
 	int write = regs->ecr_cause & ECR_C_PROTV_STORE;  /* ST/EX */
@@ -82,6 +82,10 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 	 * nothing more.
 	 */
 	if (address >= VMALLOC_START) {
+		/* Forbid userspace to access kernel-space virtual memory */
+		if (unlikely(user_mode(regs)))
+			goto bad_area_nosemaphore;
+
 		ret = handle_kernel_vaddr_fault(address);
 		if (unlikely(ret))
 			goto bad_area_nosemaphore;
-- 
2.14.5

