Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C671CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96DA9214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411932;
	bh=o6Hgtsd3OwCu/r0KXxvVzwW/ts4hho1Nd9WYIevSUh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IXCBCKAGodUfDsJq1WvAXbf2zyZDoTGm6e751cImfFQY+Drem+Hd6wr47sxV6ha6v
	 ofdZZfvJAWrVZEVui4CWh9HpMW3trpo1ie7ySbuLssUi/AcQbvpMy/irFPktjrzqS/
	 OYetmImBdjdY7MGX1dCWtUr+YrymL2g1Iq+0YJtc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729622AbfCLRcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:32:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:60392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729431AbfCLRRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:17:07 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E9CD21741;
        Tue, 12 Mar 2019 17:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411026;
        bh=o6Hgtsd3OwCu/r0KXxvVzwW/ts4hho1Nd9WYIevSUh4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CYAuuelA0fxf884v+L0AvnfkR2eHoiti/qu8iCTNSbzRhDNFZ/oQbKX7A6nnEoulf
         WvAb7cWcb1pnl7RCRCBCloCFVBtczPuHuVfHzwAJI24hCLOOWir3njGGS21HluxRre
         LtGgH4jtEYlQ+bR60MntIwHIK/a7NKXpTP54/g6w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 128/135] ARM: 8781/1: Fix Thumb-2 syscall return for binutils 2.29+
Date:   Tue, 12 Mar 2019 10:09:35 -0700
Message-Id: <20190312170352.939916201@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170341.127810985@linuxfoundation.org>
References: <20190312170341.127810985@linuxfoundation.org>
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

[ Upstream commit afc9f65e01cd114cb2cedf544d22239116ce0cc6 ]

When building the kernel as Thumb-2 with binutils 2.29 or newer, if the
assembler has seen the .type directive (via ENDPROC()) for a symbol, it
automatically handles the setting of the lowest bit when the symbol is
used with ADR.  The badr macro on the other hand handles this lowest bit
manually.  This leads to a jump to a wrong address in the wrong state
in the syscall return path:

 Internal error: Oops - undefined instruction: 0 [#2] SMP THUMB2
 Modules linked in:
 CPU: 0 PID: 652 Comm: modprobe Tainted: G      D           4.18.0-rc3+ #8
 PC is at ret_fast_syscall+0x4/0x62
 LR is at sys_brk+0x109/0x128
 pc : [<80101004>]    lr : [<801c8a35>]    psr: 60000013
 Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
 Control: 50c5387d  Table: 9e82006a  DAC: 00000051
 Process modprobe (pid: 652, stack limit = 0x(ptrval))

 80101000 <ret_fast_syscall>:
 80101000:       b672            cpsid   i
 80101002:       f8d9 2008       ldr.w   r2, [r9, #8]
 80101006:       f1b2 4ffe       cmp.w   r2, #2130706432 ; 0x7f000000

 80101184 <local_restart>:
 80101184:       f8d9 a000       ldr.w   sl, [r9]
 80101188:       e92d 0030       stmdb   sp!, {r4, r5}
 8010118c:       f01a 0ff0       tst.w   sl, #240        ; 0xf0
 80101190:       d117            bne.n   801011c2 <__sys_trace>
 80101192:       46ba            mov     sl, r7
 80101194:       f5ba 7fc8       cmp.w   sl, #400        ; 0x190
 80101198:       bf28            it      cs
 8010119a:       f04f 0a00       movcs.w sl, #0
 8010119e:       f3af 8014       nop.w   {20}
 801011a2:       f2af 1ea2       subw    lr, pc, #418    ; 0x1a2

To fix this, add a new symbol name which doesn't have ENDPROC used on it
and use that with badr.  We can't remove the badr usage since that would
would cause breakage with older binutils.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/kernel/entry-common.S |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -46,6 +46,7 @@ saved_pc	.req	lr
  * features make this path too inefficient.
  */
 ret_fast_syscall:
+__ret_fast_syscall:
  UNWIND(.fnstart	)
  UNWIND(.cantunwind	)
 	disable_irq_notrace			@ disable interrupts
@@ -75,6 +76,7 @@ fast_work_pending:
  * r0 first to avoid needing to save registers around each C function call.
  */
 ret_fast_syscall:
+__ret_fast_syscall:
  UNWIND(.fnstart	)
  UNWIND(.cantunwind	)
 	str	r0, [sp, #S_R0 + S_OFF]!	@ save returned r0
@@ -241,7 +243,7 @@ local_restart:
 	tst	r10, #_TIF_SYSCALL_WORK		@ are we tracing syscalls?
 	bne	__sys_trace
 
-	invoke_syscall tbl, scno, r10, ret_fast_syscall
+	invoke_syscall tbl, scno, r10, __ret_fast_syscall
 
 	add	r1, sp, #S_OFF
 2:	cmp	scno, #(__ARM_NR_BASE - __NR_SYSCALL_BASE)


