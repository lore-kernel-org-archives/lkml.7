Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF1DC10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29EF5218DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355680;
	bh=5A2ngiJuKAby31NI/J7YuAWid9Fb0v6+N9cF50tHabE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MqDmayxl9SxG/T2w2bFqGx6bcUBR06vEpFtqJRpWagQQ4EIGgCOM5oZnked7LdjXo
	 Pqnu4I7fK0XARJuzy3VdHNB5SKHN/k0FU2RudPxGaKvzJZUhqn5gFEjeU1z5j5TpQ2
	 an5vvZN49yWz6oYFKwzIIZyyNqJvyTXnKmYNvz5w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731798AbfDOTOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:14:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:52838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731780AbfDOTOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:14:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A98AA2073F;
        Mon, 15 Apr 2019 19:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355677;
        bh=5A2ngiJuKAby31NI/J7YuAWid9Fb0v6+N9cF50tHabE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=viCyx5VutUkVRhi6pd2M35FuzHDBSI6EfgGk+i0oOX8g+5RX/w/nW42TbJfZ5rJMb
         gGAs9znpNBcvmkeXAcpV4xrQIrdifQdYze+KMNF5hz8coiPxh/EL3KiKMbsLgmzFOI
         rYcxw0yL1PkjtG1PAC7OIMU8uSS3Li6aGBBzlHnQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anton Blanchard <anton@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.0 109/117] powerpc/64s/radix: Fix radix segment exception handling
Date:   Mon, 15 Apr 2019 21:01:19 +0200
Message-Id: <20190415183750.294661658@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Piggin <npiggin@gmail.com>

commit 7100e8704b61247649c50551b965e71d168df30b upstream.

Commit 48e7b76957 ("powerpc/64s/hash: Convert SLB miss handlers to C")
broke the radix-mode segment exception handler. In radix mode, this is
exception is not an SLB miss, rather it signals that the EA is outside
the range translated by any page table.

The commit lost the radix feature alternate code patch, which can
cause faults to some EAs to kernel BUG at arch/powerpc/mm/slb.c:639!

The original radix code would send faults to slb_miss_large_addr,
which would end up faulting due to slb_addr_limit being 0. This patch
sends radix directly to do_bad_slb_fault, which is a bit clearer.

Fixes: 48e7b7695745 ("powerpc/64s/hash: Convert SLB miss handlers to C")
Cc: stable@vger.kernel.org # v4.20+
Reported-by: Anton Blanchard <anton@samba.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/exceptions-64s.S |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -612,11 +612,17 @@ EXC_COMMON_BEGIN(data_access_slb_common)
 	ld	r4,PACA_EXSLB+EX_DAR(r13)
 	std	r4,_DAR(r1)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
+BEGIN_MMU_FTR_SECTION
+	/* HPT case, do SLB fault */
 	bl	do_slb_fault
 	cmpdi	r3,0
 	bne-	1f
 	b	fast_exception_return
 1:	/* Error case */
+MMU_FTR_SECTION_ELSE
+	/* Radix case, access is outside page table range */
+	li	r3,-EFAULT
+ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_TYPE_RADIX)
 	std	r3,RESULT(r1)
 	bl	save_nvgprs
 	RECONCILE_IRQ_STATE(r10, r11)
@@ -661,11 +667,17 @@ EXC_COMMON_BEGIN(instruction_access_slb_
 	EXCEPTION_PROLOG_COMMON(0x480, PACA_EXSLB)
 	ld	r4,_NIP(r1)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
+BEGIN_MMU_FTR_SECTION
+	/* HPT case, do SLB fault */
 	bl	do_slb_fault
 	cmpdi	r3,0
 	bne-	1f
 	b	fast_exception_return
 1:	/* Error case */
+MMU_FTR_SECTION_ELSE
+	/* Radix case, access is outside page table range */
+	li	r3,-EFAULT
+ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_TYPE_RADIX)
 	std	r3,RESULT(r1)
 	bl	save_nvgprs
 	RECONCILE_IRQ_STATE(r10, r11)


