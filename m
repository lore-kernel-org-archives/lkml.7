Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7043CC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 10:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 445D121743
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 10:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="SMLOGUG8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfGXKWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 06:22:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51451 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfGXKWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 06:22:45 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6OAMLAE490320
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 24 Jul 2019 03:22:21 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6OAMLAE490320
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1563963741;
        bh=Cb6E/AEJ31z78Bst6yAAp5yYD+unp+whSXcGVbkFmjM=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=SMLOGUG8Dx/WtB0K6FqYnkQE3FRgHrK+oURXYcyu8lnjRNPe9fctxkZ1NAdqPrpBV
         rXtJcG3ToUdRMFvT8LiA4eSBQgT+b1n5khe+M5/GttWmabuAzIfC05MD84zRsPcsiu
         7UnPc7ar7V4/MNBYOgPQc9zhq0hMZ03NNpkX2vGsqSaD5HYn1GTmeoNach+NwRmDtS
         ZyhjuMQYIxvlIsuHGZmYegwgasqm/LvH/YM8pNPv+OHeEzE/mTtWo3g92Am1TC0093
         /6G9Supfn4JOlo3lKU5M2ylbMUfpbvy/BqvEB7M695uNOrlFE2EIxZ4focf+ZRewQg
         OYqvNVpstrOAA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6OAMKlm490317;
        Wed, 24 Jul 2019 03:22:20 -0700
Date:   Wed, 24 Jul 2019 03:22:20 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Matt Mullins <tipbot@zytor.com>
Message-ID: <tip-b8f70953c1251d8b16276995816a95639f598e70@git.kernel.org>
Cc:     mmullins@fb.com, mingo@kernel.org, peterz@infradead.org,
        hpa@zytor.com, tglx@linutronix.de, linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, hpa@zytor.com, mmullins@fb.com,
          mingo@kernel.org, peterz@infradead.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190724042058.24506-1-mmullins@fb.com>
References: <20190724042058.24506-1-mmullins@fb.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/entry/32: Pass cr2 to do_async_page_fault()
Git-Commit-ID: b8f70953c1251d8b16276995816a95639f598e70
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  b8f70953c1251d8b16276995816a95639f598e70
Gitweb:     https://git.kernel.org/tip/b8f70953c1251d8b16276995816a95639f598e70
Author:     Matt Mullins <mmullins@fb.com>
AuthorDate: Tue, 23 Jul 2019 21:20:58 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 24 Jul 2019 12:17:39 +0200

x86/entry/32: Pass cr2 to do_async_page_fault()

Commit a0d14b8909de ("x86/mm, tracing: Fix CR2 corruption") added the
address parameter to do_async_page_fault(), but does not pass it from the
32-bit entry point.  To plumb it through, factor-out
common_exception_read_cr2 in the same fashion as common_exception, and uses
it from both page_fault and async_page_fault.

For a 32-bit KVM guest, this fixes:

  Run /sbin/init as init process
  Starting init: /sbin/init exists but couldn't execute it (error -14)

Fixes: a0d14b8909de ("x86/mm, tracing: Fix CR2 corruption")
Signed-off-by: Matt Mullins <mmullins@fb.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190724042058.24506-1-mmullins@fb.com

---
 arch/x86/entry/entry_32.S | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 2bb986f305ac..4f86928246e7 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1443,8 +1443,12 @@ BUILD_INTERRUPT3(hv_stimer0_callback_vector, HYPERV_STIMER0_VECTOR,
 
 ENTRY(page_fault)
 	ASM_CLAC
-	pushl	$0; /* %gs's slot on the stack */
+	pushl	$do_page_fault
+	jmp	common_exception_read_cr2
+END(page_fault)
 
+common_exception_read_cr2:
+	/* the function address is in %gs's slot on the stack */
 	SAVE_ALL switch_stacks=1 skip_gs=1
 
 	ENCODE_FRAME_POINTER
@@ -1452,6 +1456,7 @@ ENTRY(page_fault)
 
 	/* fixup %gs */
 	GS_TO_REG %ecx
+	movl	PT_GS(%esp), %edi
 	REG_TO_PTGS %ecx
 	SET_KERNEL_GS %ecx
 
@@ -1463,9 +1468,9 @@ ENTRY(page_fault)
 
 	TRACE_IRQS_OFF
 	movl	%esp, %eax			# pt_regs pointer
-	call	do_page_fault
+	CALL_NOSPEC %edi
 	jmp	ret_from_exception
-END(page_fault)
+END(common_exception_read_cr2)
 
 common_exception:
 	/* the function address is in %gs's slot on the stack */
@@ -1595,7 +1600,7 @@ END(general_protection)
 ENTRY(async_page_fault)
 	ASM_CLAC
 	pushl	$do_async_page_fault
-	jmp	common_exception
+	jmp	common_exception_read_cr2
 END(async_page_fault)
 #endif
 
