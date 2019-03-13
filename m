Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647D3C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3876B2171F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552504582;
	bh=5SU8m6cmIFETHlwpr/gFjKRfq8Bk4QlAJ/7ABaYRufo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vOZwpWxr1WO07KPE5IIznxaz0meOa0PuOkyJNJP/4AR7oLeuNR1Ot9DbR9nECtZxK
	 q6Z5zjgOOLLvunZt3whZToRHgjGWSdufp6gL7F6NDwWJxOmR9awPE/3u/O3kQ/CFKe
	 ORZpSiuRBsFsy6AKUYGmlOBW5WG93V0JQJm24wak=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbfCMTQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:16:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:46648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728659AbfCMTQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:16:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B210F213A2;
        Wed, 13 Mar 2019 19:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504576;
        bh=5SU8m6cmIFETHlwpr/gFjKRfq8Bk4QlAJ/7ABaYRufo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aP8fXl8l0+QNoMgpZCij04zbNm1N6Wz5wzWo3lKIxuns/t5w6DczrR7E7O/w+h7FA
         Sd/vEdMbGJsa0L2TsdUTWNdcekqLN2MYluzANVjsmKCwU+taDhJVE9CWNx8YLr7y7A
         HRz0Q/9h/FBBq80OemBB0ckqxn/Ji/c0JLGtkc/4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-snps-arc@lists.infradead.org
Subject: [PATCH AUTOSEL 4.14 24/33] ARCv2: lib: memcpy: fix doing prefetchw outside of buffer
Date:   Wed, 13 Mar 2019 15:14:57 -0400
Message-Id: <20190313191506.159677-24-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191506.159677-1-sashal@kernel.org>
References: <20190313191506.159677-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>

[ Upstream commit f8a15f97664178f27dfbf86a38f780a532cb6df0 ]

ARCv2 optimized memcpy uses PREFETCHW instruction for prefetching the
next cache line but doesn't ensure that the line is not past the end of
the buffer. PRETECHW changes the line ownership and marks it dirty,
which can cause data corruption if this area is used for DMA IO.

Fix the issue by avoiding the PREFETCHW. This leads to performance
degradation but it is OK as we'll introduce new memcpy implementation
optimized for unaligned memory access using.

We also cut off all PREFETCH instructions at they are quite useless
here:
 * we call PREFETCH right before LOAD instruction call.
 * we copy 16 or 32 bytes of data (depending on CONFIG_ARC_HAS_LL64)
   in a main logical loop. so we call PREFETCH 4 times (or 2 times)
   for each L1 cache line (in case of 64B L1 cache Line which is
   default case). Obviously this is not optimal.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arc/lib/memcpy-archs.S | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/arc/lib/memcpy-archs.S b/arch/arc/lib/memcpy-archs.S
index d61044dd8b58..ea14b0bf3116 100644
--- a/arch/arc/lib/memcpy-archs.S
+++ b/arch/arc/lib/memcpy-archs.S
@@ -25,15 +25,11 @@
 #endif
 
 #ifdef CONFIG_ARC_HAS_LL64
-# define PREFETCH_READ(RX)	prefetch    [RX, 56]
-# define PREFETCH_WRITE(RX)	prefetchw   [RX, 64]
 # define LOADX(DST,RX)		ldd.ab	DST, [RX, 8]
 # define STOREX(SRC,RX)		std.ab	SRC, [RX, 8]
 # define ZOLSHFT		5
 # define ZOLAND			0x1F
 #else
-# define PREFETCH_READ(RX)	prefetch    [RX, 28]
-# define PREFETCH_WRITE(RX)	prefetchw   [RX, 32]
 # define LOADX(DST,RX)		ld.ab	DST, [RX, 4]
 # define STOREX(SRC,RX)		st.ab	SRC, [RX, 4]
 # define ZOLSHFT		4
@@ -41,8 +37,6 @@
 #endif
 
 ENTRY_CFI(memcpy)
-	prefetch [r1]		; Prefetch the read location
-	prefetchw [r0]		; Prefetch the write location
 	mov.f	0, r2
 ;;; if size is zero
 	jz.d	[blink]
@@ -72,8 +66,6 @@ ENTRY_CFI(memcpy)
 	lpnz	@.Lcopy32_64bytes
 	;; LOOP START
 	LOADX (r6, r1)
-	PREFETCH_READ (r1)
-	PREFETCH_WRITE (r3)
 	LOADX (r8, r1)
 	LOADX (r10, r1)
 	LOADX (r4, r1)
@@ -117,9 +109,7 @@ ENTRY_CFI(memcpy)
 	lpnz	@.Lcopy8bytes_1
 	;; LOOP START
 	ld.ab	r6, [r1, 4]
-	prefetch [r1, 28]	;Prefetch the next read location
 	ld.ab	r8, [r1,4]
-	prefetchw [r3, 32]	;Prefetch the next write location
 
 	SHIFT_1	(r7, r6, 24)
 	or	r7, r7, r5
@@ -162,9 +152,7 @@ ENTRY_CFI(memcpy)
 	lpnz	@.Lcopy8bytes_2
 	;; LOOP START
 	ld.ab	r6, [r1, 4]
-	prefetch [r1, 28]	;Prefetch the next read location
 	ld.ab	r8, [r1,4]
-	prefetchw [r3, 32]	;Prefetch the next write location
 
 	SHIFT_1	(r7, r6, 16)
 	or	r7, r7, r5
@@ -204,9 +192,7 @@ ENTRY_CFI(memcpy)
 	lpnz	@.Lcopy8bytes_3
 	;; LOOP START
 	ld.ab	r6, [r1, 4]
-	prefetch [r1, 28]	;Prefetch the next read location
 	ld.ab	r8, [r1,4]
-	prefetchw [r3, 32]	;Prefetch the next write location
 
 	SHIFT_1	(r7, r6, 8)
 	or	r7, r7, r5
-- 
2.19.1

