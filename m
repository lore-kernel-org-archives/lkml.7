Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90827C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55FB5214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411399;
	bh=A11wx1lZwFNCs24hY/mpPhBVBVHdrRfo1KWQth4Uw+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W4Yld6vwYjhLS5zrEO1qvzffvsyweyxZ50Msy3bXOj+1WM9fMVWxUhRsiHOLn5+aY
	 y/HP5wVWcKj3rcxfPLECe6ASzR09q36nb8So4shKET0cEswWf8M/dYgw5QzEe9Q87R
	 C3A4z2jdXKg3ZhjKRUIa1MPePwGTmKNeq6iaJDcY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbfCLRSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:18:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:60568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729475AbfCLRRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:17:11 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A11CC217F5;
        Tue, 12 Mar 2019 17:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411030;
        bh=A11wx1lZwFNCs24hY/mpPhBVBVHdrRfo1KWQth4Uw+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QGF3aBgliPUORIkOI35ehKeev4gn/yRPCQ3VP7KSEwMbgzUEcu0qDZCcjbc8yYlIv
         2YhE7vGqaPG3uo+9HRGy+nURgyjE9vmxRJJHP6JqJhy9KZOrIjjPwUmJCRBzdyzy4z
         RCzxMFWWzV7kwl1AQLdOEoT8kZUvM5L1ni90XRew=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.14 134/135] x86: Add TSX Force Abort CPUID/MSR
Date:   Tue, 12 Mar 2019 10:09:41 -0700
Message-Id: <20190312170353.516068574@linuxfoundation.org>
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

From: "Peter Zijlstra (Intel)" <peterz@infradead.org>

commit 52f64909409c17adf54fcf5f9751e0544ca3a6b4 upstream

Skylake systems will receive a microcode update to address a TSX
errata. This microcode will (by default) clobber PMC3 when TSX
instructions are (speculatively or not) executed.

It also provides an MSR to cause all TSX transaction to abort and
preserve PMC3.

Add the CPUID enumeration and MSR definition.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/cpufeatures.h |    1 +
 arch/x86/include/asm/msr-index.h   |    6 ++++++
 2 files changed, 7 insertions(+)

--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -339,6 +339,7 @@
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EDX), word 18 */
 #define X86_FEATURE_AVX512_4VNNIW	(18*32+ 2) /* AVX-512 Neural Network Instructions */
 #define X86_FEATURE_AVX512_4FMAPS	(18*32+ 3) /* AVX-512 Multiply Accumulation Single precision */
+#define X86_FEATURE_TSX_FORCE_ABORT	(18*32+13) /* "" TSX_FORCE_ABORT */
 #define X86_FEATURE_PCONFIG		(18*32+18) /* Intel PCONFIG */
 #define X86_FEATURE_SPEC_CTRL		(18*32+26) /* "" Speculation Control (IBRS + IBPB) */
 #define X86_FEATURE_INTEL_STIBP		(18*32+27) /* "" Single Thread Indirect Branch Predictors */
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -610,6 +610,12 @@
 
 #define MSR_IA32_TSC_DEADLINE		0x000006E0
 
+
+#define MSR_TSX_FORCE_ABORT		0x0000010F
+
+#define MSR_TFA_RTM_FORCE_ABORT_BIT	0
+#define MSR_TFA_RTM_FORCE_ABORT		BIT_ULL(MSR_TFA_RTM_FORCE_ABORT_BIT)
+
 /* P4/Xeon+ specific */
 #define MSR_IA32_MCG_EAX		0x00000180
 #define MSR_IA32_MCG_EBX		0x00000181


