Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810B9C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5224220883
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138984;
	bh=d5uLGfLMcYrPU9M9BwlcjXvhFOtsDZtrRdp3fN4ebfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=quCOKASDJ8XpS71gxKkfRoyEh3RaQmzed0HYXDXrBq+JmPDXHU26X6BkXzysYqL/W
	 ApHqf82+j6DtNWv2PN+EbltNZBaLUqywbk42Evg5fbVYASUp7xXPhYzVVq58IgLUqY
	 YdRk+o4f1GBGHa4YGjKjfv6ufFpc7QBgx+iY56HY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730454AbfDARQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:16:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:41352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730566AbfDARQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:16:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1C8A206C0;
        Mon,  1 Apr 2019 17:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138976;
        bh=d5uLGfLMcYrPU9M9BwlcjXvhFOtsDZtrRdp3fN4ebfI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dxVzybiRWEobmZ93dwvfb8mjo/4HMVXBs9+rDkpYkvcGgASwBZKPrP+PDQl7jkrYX
         pPAx3dAu99JAPF7thRTkM7As/+1ZQsoQrObJPZdl7LoxnpFyWt+2qhsY/O1Ilu9uCy
         qhiZM263EXXa0ddJHJ1Goqq5HCi1CCS1FEHWec7s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Diana Craciun <diana.craciun@nxp.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.19 038/134] powerpc/fsl: Flush the branch predictor at each kernel entry (32 bit)
Date:   Mon,  1 Apr 2019 19:01:14 +0200
Message-Id: <20190401170048.283082727@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Diana Craciun <diana.craciun@nxp.com>

commit 7fef436295bf6c05effe682c8797dfcb0deb112a upstream.

In order to protect against speculation attacks on
indirect branches, the branch predictor is flushed at
kernel entry to protect for the following situations:
- userspace process attacking another userspace process
- userspace process attacking the kernel
Basically when the privillege level change (i.e.the kernel
is entered), the branch predictor state is flushed.

Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/head_booke.h     |    6 ++++++
 arch/powerpc/kernel/head_fsl_booke.S |   15 +++++++++++++++
 2 files changed, 21 insertions(+)

--- a/arch/powerpc/kernel/head_booke.h
+++ b/arch/powerpc/kernel/head_booke.h
@@ -43,6 +43,9 @@
 	andi.	r11, r11, MSR_PR;	/* check whether user or kernel    */\
 	mr	r11, r1;						     \
 	beq	1f;							     \
+START_BTB_FLUSH_SECTION					\
+	BTB_FLUSH(r11)						\
+END_BTB_FLUSH_SECTION					\
 	/* if from user, start at top of this thread's kernel stack */       \
 	lwz	r11, THREAD_INFO-THREAD(r10);				     \
 	ALLOC_STACK_FRAME(r11, THREAD_SIZE);				     \
@@ -128,6 +131,9 @@
 	stw	r9,_CCR(r8);		/* save CR on stack		   */\
 	mfspr	r11,exc_level_srr1;	/* check whether user or kernel    */\
 	DO_KVM	BOOKE_INTERRUPT_##intno exc_level_srr1;		             \
+START_BTB_FLUSH_SECTION								\
+	BTB_FLUSH(r10)									\
+END_BTB_FLUSH_SECTION								\
 	andi.	r11,r11,MSR_PR;						     \
 	mfspr	r11,SPRN_SPRG_THREAD;	/* if from user, start at top of   */\
 	lwz	r11,THREAD_INFO-THREAD(r11); /* this thread's kernel stack */\
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -453,6 +453,13 @@ END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)
 	mfcr	r13
 	stw	r13, THREAD_NORMSAVE(3)(r10)
 	DO_KVM	BOOKE_INTERRUPT_DTLB_MISS SPRN_SRR1
+START_BTB_FLUSH_SECTION
+	mfspr r11, SPRN_SRR1
+	andi. r10,r11,MSR_PR
+	beq 1f
+	BTB_FLUSH(r10)
+1:
+END_BTB_FLUSH_SECTION
 	mfspr	r10, SPRN_DEAR		/* Get faulting address */
 
 	/* If we are faulting a kernel address, we have to use the
@@ -547,6 +554,14 @@ END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)
 	mfcr	r13
 	stw	r13, THREAD_NORMSAVE(3)(r10)
 	DO_KVM	BOOKE_INTERRUPT_ITLB_MISS SPRN_SRR1
+START_BTB_FLUSH_SECTION
+	mfspr r11, SPRN_SRR1
+	andi. r10,r11,MSR_PR
+	beq 1f
+	BTB_FLUSH(r10)
+1:
+END_BTB_FLUSH_SECTION
+
 	mfspr	r10, SPRN_SRR0		/* Get faulting address */
 
 	/* If we are faulting a kernel address, we have to use the


