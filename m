Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6B8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD7812192B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255655;
	bh=Oz8PE7WAz/8IECeHortTes2PffMBRz9shNA2Kit+wK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jl1Ij660q3Yg0J6Q7NgsjO7kRhMw18oCSn1v+YLRLt/im+6M53C+32kCKi+pHV6nf
	 EYwqytGJArE01yba2uiAeMgkkh5zjPDBwKJv+mHbRp3qN4xCzcABCKG5zDctRBQq4f
	 1DoY7qjIHmUkTF6KRSeWL6AtWWr5dGoDnO3TeTSs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733149AbfCVLyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:54:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:58570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733137AbfCVLyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:54:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED54620643;
        Fri, 22 Mar 2019 11:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255650;
        bh=Oz8PE7WAz/8IECeHortTes2PffMBRz9shNA2Kit+wK4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WeumlmFuGDVWJh4uQfKDrK7giIl/bKYFFu1gcA1SrWego2HU3SZh8LWcx4HNZ0zz6
         AfCAoGg4f+oFPwG4xkMaUODE8myseH7eOnVZvmEE1n3QfrxV7qP6It1kdK/NFLSu+n
         7apsnJNCWkezV1qQk5YJU3ehXOPOJqn+Iv1Kfs/w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 138/183] powerpc/32: Clear on-stack exception marker upon exception return
Date:   Fri, 22 Mar 2019 12:16:06 +0100
Message-Id: <20190322111251.756730044@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe Leroy <christophe.leroy@c-s.fr>

commit 9580b71b5a7863c24a9bd18bcd2ad759b86b1eff upstream.

Clear the on-stack STACK_FRAME_REGS_MARKER on exception exit in order
to avoid confusing stacktrace like the one below.

  Call Trace:
  [c0e9dca0] [c01c42a0] print_address_description+0x64/0x2bc (unreliable)
  [c0e9dcd0] [c01c4684] kasan_report+0xfc/0x180
  [c0e9dd10] [c0895130] memchr+0x24/0x74
  [c0e9dd30] [c00a9e38] msg_print_text+0x124/0x574
  [c0e9dde0] [c00ab710] console_unlock+0x114/0x4f8
  [c0e9de40] [c00adc60] vprintk_emit+0x188/0x1c4
  --- interrupt: c0e9df00 at 0x400f330
      LR = init_stack+0x1f00/0x2000
  [c0e9de80] [c00ae3c4] printk+0xa8/0xcc (unreliable)
  [c0e9df20] [c0c27e44] early_irq_init+0x38/0x108
  [c0e9df50] [c0c15434] start_kernel+0x310/0x488
  [c0e9dff0] [00003484] 0x3484

With this patch the trace becomes:

  Call Trace:
  [c0e9dca0] [c01c42c0] print_address_description+0x64/0x2bc (unreliable)
  [c0e9dcd0] [c01c46a4] kasan_report+0xfc/0x180
  [c0e9dd10] [c0895150] memchr+0x24/0x74
  [c0e9dd30] [c00a9e58] msg_print_text+0x124/0x574
  [c0e9dde0] [c00ab730] console_unlock+0x114/0x4f8
  [c0e9de40] [c00adc80] vprintk_emit+0x188/0x1c4
  [c0e9de80] [c00ae3e4] printk+0xa8/0xcc
  [c0e9df20] [c0c27e44] early_irq_init+0x38/0x108
  [c0e9df50] [c0c15434] start_kernel+0x310/0x488
  [c0e9dff0] [00003484] 0x3484

Cc: stable@vger.kernel.org
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/entry_32.S |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -726,6 +726,9 @@ fast_exception_return:
 	mtcr	r10
 	lwz	r10,_LINK(r11)
 	mtlr	r10
+	/* Clear the exception_marker on the stack to avoid confusing stacktrace */
+	li	r10, 0
+	stw	r10, 8(r11)
 	REST_GPR(10, r11)
 #ifdef CONFIG_PPC_8xx_PERF_EVENT
 	mtspr	SPRN_NRI, r0
@@ -963,6 +966,9 @@ END_FTR_SECTION_IFSET(CPU_FTR_NEED_PAIRE
 	mtcrf	0xFF,r10
 	mtlr	r11
 
+	/* Clear the exception_marker on the stack to avoid confusing stacktrace */
+	li	r10, 0
+	stw	r10, 8(r1)
 	/*
 	 * Once we put values in SRR0 and SRR1, we are in a state
 	 * where exceptions are not recoverable, since taking an
@@ -1002,6 +1008,9 @@ exc_exit_restart_end:
 	mtlr	r11
 	lwz	r10,_CCR(r1)
 	mtcrf	0xff,r10
+	/* Clear the exception_marker on the stack to avoid confusing stacktrace */
+	li	r10, 0
+	stw	r10, 8(r1)
 	REST_2GPRS(9, r1)
 	.globl exc_exit_restart
 exc_exit_restart:


