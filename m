Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7470EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E432087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553710772;
	bh=16uQoA0Scihj4rZlxX+TNM8rpUSGTKESFabjU9JKVCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GNQGu8+mA7wQ2eU/qw1PvaY9v5+8IxwWIsEMlrdAoGNWRKt5WbXulU3/MO/hkmR2p
	 U1C9FKA4sNlLqanU3KyXQZWrZzrWrEE5UFQJgr+dgyZp465qXMeqI0rigviHQZX9Sb
	 SFOtATiCCxwmsFsRtvqm+zPL73TyMZYOIUp0JzWE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390456AbfC0STb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:19:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:36806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389947AbfC0ST1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:19:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C09E92063F;
        Wed, 27 Mar 2019 18:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710766;
        bh=16uQoA0Scihj4rZlxX+TNM8rpUSGTKESFabjU9JKVCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YjxjYTEggVi9p9V2hlbGDVhgEwdrdf+V2UXPsIDRCis4m7mrHdgW9BKF9j4O2W2jk
         fjA4lPYba9IXn3vM38ewYipUpz1XD5vyJtBVAL/W2uMtDCc/N8eaDfwSXLyl/u56CG
         a/rRSwgZg3VyKQ3c7FyQB/502Z2RhF+r5Lz2Sztk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vladimir Murzin <vladimir.murzin@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 092/123] ARM: 8830/1: NOMMU: Toggle only bits in EXC_RETURN we are really care of
Date:   Wed, 27 Mar 2019 14:15:56 -0400
Message-Id: <20190327181628.15899-92-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181628.15899-1-sashal@kernel.org>
References: <20190327181628.15899-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Murzin <vladimir.murzin@arm.com>

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
index e6d9e29fcae4..6416fd3a3894 100644
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

