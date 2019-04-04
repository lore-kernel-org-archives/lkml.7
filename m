Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D926C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 514D420657
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369702;
	bh=ErT364dMBz4EQQgO/OgfvJK7SqGr0gbRtrXsmnbFn/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2QE0yhp+OR+0Z5jUnSrbv2ZE1qEbV38O8FU/lx66vkuWbux09LbU+F/XhHaOsXGrp
	 MqcsMg+Z5ZG9mlDA/3U8jWm9l395kPT2/b8G7gMY9zeVuw0IMoX7mMhoAcG3ylcXEr
	 voDhfdfbMsEixkJmUg5iaQdeFuj+UfGqoScseby0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388286AbfDDJVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:21:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:57920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387637AbfDDJQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:16:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF6E42075E;
        Thu,  4 Apr 2019 09:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369400;
        bh=ErT364dMBz4EQQgO/OgfvJK7SqGr0gbRtrXsmnbFn/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VGe/wDsXZD+RPRjjFRC9UpdU2ABzV3BtAtpP1F0Z/lgmg9Xfu5n982otMDyLtkGEO
         NJNpgCsILqomHkyEw0DfQWI3jP2mtZ/FxI2qquZZUQtqaxLSWaLFhSoehXIv3S7ZLc
         mhovBYUd6kt9vggxGU9i301O67oU5RRvoLNRwjqk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vladimir Murzin <vladimir.murzin@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 184/246] ARM: 8830/1: NOMMU: Toggle only bits in EXC_RETURN we are really care of
Date:   Thu,  4 Apr 2019 10:48:04 +0200
Message-Id: <20190404084625.625137724@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 72cd4064fccaae15ab84d40d4be23667402df4ed ]

ARMv8M introduces support for Security extension to M class, among
other things it affects exception handling, especially, encoding of
EXC_RETURN.

The new bits have been added:

Bit [6]	Secure or Non-secure stack
Bit [5]	Default callee register stacking
Bit [0]	Exception Secure

which conflicts with hard-coded value of EXC_RETURN:

In fact, we only care of few bits:

Bit [3]	 Mode (0 - Handler, 1 - Thread)
Bit [2]	 Stack pointer selection (0 - Main, 1 - Process)

We can toggle only those bits and left other bits as they were on
exception entry.

It is basically, what patch does - saves EXC_RETURN when we do
transition form Thread to Handler mode (it is first svc), so later
saved value is used instead of EXC_RET_THREADMODE_PROCESSSTACK.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/include/asm/v7m.h     | 2 +-
 arch/arm/kernel/entry-header.S | 3 ++-
 arch/arm/kernel/entry-v7m.S    | 4 ++++
 arch/arm/mm/proc-v7m.S         | 3 +++
 4 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/v7m.h b/arch/arm/include/asm/v7m.h
index 187ccf6496ad..2cb00d15831b 100644
--- a/arch/arm/include/asm/v7m.h
+++ b/arch/arm/include/asm/v7m.h
@@ -49,7 +49,7 @@
  * (0 -> msp; 1 -> psp). Bits [1:0] are fixed to 0b01.
  */
 #define EXC_RET_STACK_MASK			0x00000004
-#define EXC_RET_THREADMODE_PROCESSSTACK		0xfffffffd
+#define EXC_RET_THREADMODE_PROCESSSTACK		(3 << 2)
 
 /* Cache related definitions */
 
diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index 773424843d6e..62db1c9746cb 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -127,7 +127,8 @@
          */
 	.macro	v7m_exception_slow_exit ret_r0
 	cpsid	i
-	ldr	lr, =EXC_RET_THREADMODE_PROCESSSTACK
+	ldr	lr, =exc_ret
+	ldr	lr, [lr]
 
 	@ read original r12, sp, lr, pc and xPSR
 	add	r12, sp, #S_IP
diff --git a/arch/arm/kernel/entry-v7m.S b/arch/arm/kernel/entry-v7m.S
index abcf47848525..19d2dcd6530d 100644
--- a/arch/arm/kernel/entry-v7m.S
+++ b/arch/arm/kernel/entry-v7m.S
@@ -146,3 +146,7 @@ ENTRY(vector_table)
 	.rept	CONFIG_CPU_V7M_NUM_IRQ
 	.long	__irq_entry		@ External Interrupts
 	.endr
+	.align	2
+	.globl	exc_ret
+exc_ret:
+	.space	4
diff --git a/arch/arm/mm/proc-v7m.S b/arch/arm/mm/proc-v7m.S
index 47a5acc64433..92e84181933a 100644
--- a/arch/arm/mm/proc-v7m.S
+++ b/arch/arm/mm/proc-v7m.S
@@ -139,6 +139,9 @@ __v7m_setup_cont:
 	cpsie	i
 	svc	#0
 1:	cpsid	i
+	ldr	r0, =exc_ret
+	orr	lr, lr, #EXC_RET_THREADMODE_PROCESSSTACK
+	str	lr, [r0]
 	ldmia	sp, {r0-r3, r12}
 	str	r5, [r12, #11 * 4]	@ restore the original SVC vector entry
 	mov	lr, r6			@ restore LR
-- 
2.19.1



