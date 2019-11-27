Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB1CC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC3AF2154A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574889562;
	bh=uO8J9GrsInOqTtJumeYPqJ41rEgZjMm0EPfbFPPGY0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z4JTEGqstPaIMoPOrBuwDMdje3Ry11nURhmVy5//LsQhGNV01F3UGHkfp0asGFS/W
	 2WGs74rdw3pgdvAVdoMtbphCV16mShIw01EFL8OqAZf/j0en5uQS9morWCRmLKIpkb
	 nOxHNW4r8PK8qbN4xEvkCkbcPDMIGwUHP17PqdQA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733068AbfK0VKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:10:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:37882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733055AbfK0VKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:10:36 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B48BF2154A;
        Wed, 27 Nov 2019 21:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574889035;
        bh=uO8J9GrsInOqTtJumeYPqJ41rEgZjMm0EPfbFPPGY0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JD4z3ZGJdriTGJFaBnXHaL2jXDuAdQXyQTRP2fZYy0fI7neyQ73rKhZaS3n8T/w4b
         Bz83YuGFIOeaq1Xdho56DQrDEPKCqoZaG1Q3vrDtCqkn1viA4QDCderpQU0dMbMvfB
         XGIFcM0cLwvZQcCX1iMeTAUpyTgI8s5Au6ZWTSyk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@kernel.org
Subject: [PATCH 5.3 59/95] x86/entry/32: Move FIXUP_FRAME after pushing %fs in SAVE_ALL
Date:   Wed, 27 Nov 2019 21:32:16 +0100
Message-Id: <20191127202925.348245607@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127202845.651587549@linuxfoundation.org>
References: <20191127202845.651587549@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Lutomirski <luto@kernel.org>

commit 82cb8a0b1d8d07817b5d59f7fa1438e1fceafab2 upstream.

This will allow us to get percpu access working before FIXUP_FRAME,
which will allow us to unwind ESPFIX earlier.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/entry/entry_32.S |   66 ++++++++++++++++++++++++----------------------
 1 file changed, 35 insertions(+), 31 deletions(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -213,54 +213,58 @@
 	 *
 	 * Be careful: we may have nonzero SS base due to ESPFIX.
 	 */
-	andl	$0x0000ffff, 3*4(%esp)
+	andl	$0x0000ffff, 4*4(%esp)
 
 #ifdef CONFIG_VM86
-	testl	$X86_EFLAGS_VM, 4*4(%esp)
+	testl	$X86_EFLAGS_VM, 5*4(%esp)
 	jnz	.Lfrom_usermode_no_fixup_\@
 #endif
-	testl	$USER_SEGMENT_RPL_MASK, 3*4(%esp)
+	testl	$USER_SEGMENT_RPL_MASK, 4*4(%esp)
 	jnz	.Lfrom_usermode_no_fixup_\@
 
-	orl	$CS_FROM_KERNEL, 3*4(%esp)
+	orl	$CS_FROM_KERNEL, 4*4(%esp)
 
 	/*
 	 * When we're here from kernel mode; the (exception) stack looks like:
 	 *
-	 *  5*4(%esp) - <previous context>
-	 *  4*4(%esp) - flags
-	 *  3*4(%esp) - cs
-	 *  2*4(%esp) - ip
-	 *  1*4(%esp) - orig_eax
-	 *  0*4(%esp) - gs / function
+	 *  6*4(%esp) - <previous context>
+	 *  5*4(%esp) - flags
+	 *  4*4(%esp) - cs
+	 *  3*4(%esp) - ip
+	 *  2*4(%esp) - orig_eax
+	 *  1*4(%esp) - gs / function
+	 *  0*4(%esp) - fs
 	 *
 	 * Lets build a 5 entry IRET frame after that, such that struct pt_regs
 	 * is complete and in particular regs->sp is correct. This gives us
-	 * the original 5 enties as gap:
+	 * the original 6 enties as gap:
 	 *
-	 * 12*4(%esp) - <previous context>
-	 * 11*4(%esp) - gap / flags
-	 * 10*4(%esp) - gap / cs
-	 *  9*4(%esp) - gap / ip
-	 *  8*4(%esp) - gap / orig_eax
-	 *  7*4(%esp) - gap / gs / function
-	 *  6*4(%esp) - ss
-	 *  5*4(%esp) - sp
-	 *  4*4(%esp) - flags
-	 *  3*4(%esp) - cs
-	 *  2*4(%esp) - ip
-	 *  1*4(%esp) - orig_eax
-	 *  0*4(%esp) - gs / function
+	 * 14*4(%esp) - <previous context>
+	 * 13*4(%esp) - gap / flags
+	 * 12*4(%esp) - gap / cs
+	 * 11*4(%esp) - gap / ip
+	 * 10*4(%esp) - gap / orig_eax
+	 *  9*4(%esp) - gap / gs / function
+	 *  8*4(%esp) - gap / fs
+	 *  7*4(%esp) - ss
+	 *  6*4(%esp) - sp
+	 *  5*4(%esp) - flags
+	 *  4*4(%esp) - cs
+	 *  3*4(%esp) - ip
+	 *  2*4(%esp) - orig_eax
+	 *  1*4(%esp) - gs / function
+	 *  0*4(%esp) - fs
 	 */
 
 	pushl	%ss		# ss
 	pushl	%esp		# sp (points at ss)
-	addl	$6*4, (%esp)	# point sp back at the previous context
-	pushl	6*4(%esp)	# flags
-	pushl	6*4(%esp)	# cs
-	pushl	6*4(%esp)	# ip
-	pushl	6*4(%esp)	# orig_eax
-	pushl	6*4(%esp)	# gs / function
+	addl	$7*4, (%esp)	# point sp back at the previous context
+	pushl	7*4(%esp)	# flags
+	pushl	7*4(%esp)	# cs
+	pushl	7*4(%esp)	# ip
+	pushl	7*4(%esp)	# orig_eax
+	pushl	7*4(%esp)	# gs / function
+	pushl	7*4(%esp)	# fs
 .Lfrom_usermode_no_fixup_\@:
 .endm
 
@@ -308,8 +312,8 @@
 .if \skip_gs == 0
 	PUSH_GS
 .endif
-	FIXUP_FRAME
 	pushl	%fs
+	FIXUP_FRAME
 	pushl	%es
 	pushl	%ds
 	pushl	\pt_regs_ax


