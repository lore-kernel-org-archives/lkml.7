Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBD5C2BCA1
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC7B52084A
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560098691;
	bh=M7LJnhvvvtA9Zwb4nMxS0ANRE6HLPg0e+nHjz18Pyjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zMNuJ+CV2ZqDYkKLjUL4N/ZuUBhqwprBUJxR2VB13Lue1jcqmnCKLx7GaNN4/Qa6u
	 hrmV4LSkk14/CEFhPp0cKnQcYYHGad0lvX7+cn35MQnUX51Nh62R7pbQYBozhsom4z
	 awNobnr3j8ZLalxIoTShLaJhskY+U1ZMlfw9n/lw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbfFIQov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:44:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:42088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729457AbfFIQor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:44:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D63DC2084A;
        Sun,  9 Jun 2019 16:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560098686;
        bh=M7LJnhvvvtA9Zwb4nMxS0ANRE6HLPg0e+nHjz18Pyjw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NcrjyGruYyseEeGl8glnWqeFBbuFDNDlOksq3CHtgFZ7VuX1uzwnLzEyssTjOHpd3
         uIYuSSZM3hzKAwyTD6CqmWAt2btO44yuTySTiFhinXTxwuiRPmKV/rrjC/QiK9U66B
         KQcKXT1LHK9yeSl8sFxDH+YVkfsRQYBYfaXVUr+8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>
Subject: [PATCH 5.1 24/70] ARC: mm: SIGSEGV userspace trying to access kernel virtual memory
Date:   Sun,  9 Jun 2019 18:41:35 +0200
Message-Id: <20190609164129.046993468@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164127.541128197@linuxfoundation.org>
References: <20190609164127.541128197@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>

commit a8c715b4dd73c26a81a9cc8dc792aa715d8b4bb2 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arc/mm/fault.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

--- a/arch/arc/mm/fault.c
+++ b/arch/arc/mm/fault.c
@@ -66,7 +66,7 @@ void do_page_fault(unsigned long address
 	struct vm_area_struct *vma = NULL;
 	struct task_struct *tsk = current;
 	struct mm_struct *mm = tsk->mm;
-	int si_code = 0;
+	int si_code = SEGV_MAPERR;
 	int ret;
 	vm_fault_t fault;
 	int write = regs->ecr_cause & ECR_C_PROTV_STORE;  /* ST/EX */
@@ -81,16 +81,14 @@ void do_page_fault(unsigned long address
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


