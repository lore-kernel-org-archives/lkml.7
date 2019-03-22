Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383E6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 086432082C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254864;
	bh=lFmSGhlZQTaOw3fM4AANBxMQOtobeXywLCg7OdJox0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z2e7dMuAObIHn6BBKE7a6nOewxp2EPW2p9xv6tN4XmehGAv+UByx6qRer1G8y3dMv
	 i4KwJCnEJkdC910FpLHm9uTSDDGLEMthhjIS8BVCU9VpM7ik0QU56CU3bzvLRmY1/z
	 7icihKAXdths72HdVyQGYIwofnWmEMjoCixQmIQc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731175AbfCVLlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:41:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:43020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731342AbfCVLlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:41:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0F8A218B0;
        Fri, 22 Mar 2019 11:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254859;
        bh=lFmSGhlZQTaOw3fM4AANBxMQOtobeXywLCg7OdJox0s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tPdnaD0m50AnzgfDLZsTy6bPEcke16KFtmFTaqaCjjMswuyGS/fz2+Uqa04P1rp0G
         HiQNODr1Zz2FtZrf6Jw4JRlJCok7AxbVc3UDyfzi6yZJfApE75oSImA+s7kliZG7Bt
         VKVFhrwEjXH5bFQ/Y0lme7bRWHiYO5KbfSHA7BZ8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 033/118] ARCv2: lib: memcpy: fix doing prefetchw outside of buffer
Date:   Fri, 22 Mar 2019 12:15:05 +0100
Message-Id: <20190322111218.512422098@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111215.873964544@linuxfoundation.org>
References: <20190322111215.873964544@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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



