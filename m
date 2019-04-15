Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB231C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F48020880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355590;
	bh=2d021XjXqrApmCc0tAWeYZHebctEUMdgkcjJfV2+07I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kr+2cqUf2v0ynXLKJ+5r5230FBszjMWpLPaE5Hjc3vkyBiBDUsy0AsivnvQ2vuosN
	 JulEsNU8xEglBQNtCXW9KXMeGhTYsvk+ydDPh7PCef/fayK+ay10FaTLJGRT7LNrtS
	 dm6gGfKumVFVpm4doaDkBXkRG75mOYX5PBF5gd8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731506AbfDOTNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:13:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:50718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731141AbfDOTNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:13:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10AE320880;
        Mon, 15 Apr 2019 19:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355586;
        bh=2d021XjXqrApmCc0tAWeYZHebctEUMdgkcjJfV2+07I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eg1QbtwOL8Kzk0mvEx63q6Sp9K8nxJ1bZwTX8zJmKikh7jTYDXmqQurJLzaxdpgj/
         VlV8+5y5ZA29x2QokOjsbVno81fiL6j+iw4/4Y4687Cx3koYW9iZSuseXAsivBdSK5
         DFQjOrHsezLKxmfJJYMxxYSrc5IE6bn5riegsn0g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, stable@kernel.org,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 5.0 091/117] arm64: futex: Fix FUTEX_WAKE_OP atomic ops with non-zero result value
Date:   Mon, 15 Apr 2019 21:01:01 +0200
Message-Id: <20190415183749.494366460@linuxfoundation.org>
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

From: Will Deacon <will.deacon@arm.com>

commit 045afc24124d80c6998d9c770844c67912083506 upstream.

Rather embarrassingly, our futex() FUTEX_WAKE_OP implementation doesn't
explicitly set the return value on the non-faulting path and instead
leaves it holding the result of the underlying atomic operation. This
means that any FUTEX_WAKE_OP atomic operation which computes a non-zero
value will be reported as having failed. Regrettably, I wrote the buggy
code back in 2011 and it was upstreamed as part of the initial arm64
support in 2012.

The reasons we appear to get away with this are:

  1. FUTEX_WAKE_OP is rarely used and therefore doesn't appear to get
     exercised by futex() test applications

  2. If the result of the atomic operation is zero, the system call
     behaves correctly

  3. Prior to version 2.25, the only operation used by GLIBC set the
     futex to zero, and therefore worked as expected. From 2.25 onwards,
     FUTEX_WAKE_OP is not used by GLIBC at all.

Fix the implementation by ensuring that the return value is either 0
to indicate that the atomic operation completed successfully, or -EFAULT
if we encountered a fault when accessing the user mapping.

Cc: <stable@kernel.org>
Fixes: 6170a97460db ("arm64: Atomic operations")
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/include/asm/futex.h |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/arch/arm64/include/asm/futex.h
+++ b/arch/arm64/include/asm/futex.h
@@ -30,8 +30,8 @@ do {									\
 "	prfm	pstl1strm, %2\n"					\
 "1:	ldxr	%w1, %2\n"						\
 	insn "\n"							\
-"2:	stlxr	%w3, %w0, %2\n"						\
-"	cbnz	%w3, 1b\n"						\
+"2:	stlxr	%w0, %w3, %2\n"						\
+"	cbnz	%w0, 1b\n"						\
 "	dmb	ish\n"							\
 "3:\n"									\
 "	.pushsection .fixup,\"ax\"\n"					\
@@ -50,30 +50,30 @@ do {									\
 static inline int
 arch_futex_atomic_op_inuser(int op, int oparg, int *oval, u32 __user *_uaddr)
 {
-	int oldval = 0, ret, tmp;
+	int oldval, ret, tmp;
 	u32 __user *uaddr = __uaccess_mask_ptr(_uaddr);
 
 	pagefault_disable();
 
 	switch (op) {
 	case FUTEX_OP_SET:
-		__futex_atomic_op("mov	%w0, %w4",
+		__futex_atomic_op("mov	%w3, %w4",
 				  ret, oldval, uaddr, tmp, oparg);
 		break;
 	case FUTEX_OP_ADD:
-		__futex_atomic_op("add	%w0, %w1, %w4",
+		__futex_atomic_op("add	%w3, %w1, %w4",
 				  ret, oldval, uaddr, tmp, oparg);
 		break;
 	case FUTEX_OP_OR:
-		__futex_atomic_op("orr	%w0, %w1, %w4",
+		__futex_atomic_op("orr	%w3, %w1, %w4",
 				  ret, oldval, uaddr, tmp, oparg);
 		break;
 	case FUTEX_OP_ANDN:
-		__futex_atomic_op("and	%w0, %w1, %w4",
+		__futex_atomic_op("and	%w3, %w1, %w4",
 				  ret, oldval, uaddr, tmp, ~oparg);
 		break;
 	case FUTEX_OP_XOR:
-		__futex_atomic_op("eor	%w0, %w1, %w4",
+		__futex_atomic_op("eor	%w3, %w1, %w4",
 				  ret, oldval, uaddr, tmp, oparg);
 		break;
 	default:


