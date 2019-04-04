Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1947FC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCB322186A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368860;
	bh=NFdyG0c28uum+R0yFwpuAZGgwWWE8lGHF5IbpBx6O9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=crZ1lFBtZP4ZOQkOs8NyTxQXEM7UMLc/KhI+qEAWrXB4csTOQnCqPryKktKn/7eTF
	 ayZgfzZ/illALS99rTMwQeEIgquu228O5aTCGskFzVy7EkTrxiZWelpvVSp9TYmXjQ
	 2PfoNUcf1uaj191rMmCfdx6U5UgL6+3bXxtMtj34=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732295AbfDDJHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:07:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:46402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731858AbfDDJHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:07:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88A8D214AF;
        Thu,  4 Apr 2019 09:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368856;
        bh=NFdyG0c28uum+R0yFwpuAZGgwWWE8lGHF5IbpBx6O9U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XZoHGif7nyR78HfJpxiwHMFZVIl+sRH7t8Hy4soPz1QRhMLe6Sw9HlPZYEqP9+V8p
         t/Wd3UznZ2TzEANveTxi3Y+mvm1dVWyUm2MKFV88jgPl8VwZ3mJiF1g8IcF28v5Nu/
         eJxqvH0kgHixm1xMXoqQ7kQOO9M/Oq5ttzzblOB4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrea Righi <righi.andrea@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yonghong Song <yhs@fb.com>, Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 187/187] kprobes/x86: Blacklist non-attachable interrupt functions
Date:   Thu,  4 Apr 2019 10:48:44 +0200
Message-Id: <20190404084611.921138608@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
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

[ Upstream commit a50480cb6d61d5c5fc13308479407b628b6bc1c5 ]

These interrupt functions are already non-attachable by kprobes.
Blacklist them explicitly so that they can show up in
/sys/kernel/debug/kprobes/blacklist and tools like BCC can use this
additional information.

Signed-off-by: Andrea Righi <righi.andrea@gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: David S. Miller <davem@davemloft.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Yonghong Song <yhs@fb.com>
Link: http://lkml.kernel.org/r/20181206095648.GA8249@Dell
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/entry/entry_64.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index f95dcb209fdf..617df50a11d9 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -627,6 +627,7 @@ ENTRY(interrupt_entry)
 
 	ret
 END(interrupt_entry)
+_ASM_NOKPROBE(interrupt_entry)
 
 
 /* Interrupt entry/exit. */
@@ -826,6 +827,7 @@ native_irq_return_ldt:
 	jmp	native_irq_return_iret
 #endif
 END(common_interrupt)
+_ASM_NOKPROBE(common_interrupt)
 
 /*
  * APIC interrupts.
@@ -840,6 +842,7 @@ ENTRY(\sym)
 	call	\do_sym	/* rdi points to pt_regs */
 	jmp	ret_from_intr
 END(\sym)
+_ASM_NOKPROBE(\sym)
 .endm
 
 /* Make sure APIC interrupt handlers end up in the irqentry section: */
@@ -984,6 +987,7 @@ ENTRY(\sym)
 
 	jmp	error_exit
 	.endif
+_ASM_NOKPROBE(\sym)
 END(\sym)
 .endm
 
-- 
2.19.1



