Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3EAAC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C87BA20661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729849AbfCFJ4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 04:56:00 -0500
Received: from terminus.zytor.com ([198.137.202.136]:54223 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbfCFJz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 04:55:59 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x269tBDW1653895
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 6 Mar 2019 01:55:11 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x269t9gA1653891;
        Wed, 6 Mar 2019 01:55:09 -0800
Date:   Wed, 6 Mar 2019 01:55:09 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kees Cook <tipbot@zytor.com>
Message-ID: <tip-d309ba034fac1a149d00cac79318973e9ba81848@git.kernel.org>
Cc:     linux@dominikbrodowski.net, gregkh@linuxfoundation.org,
        jannh@google.com, hpa@zytor.com, tglx@linutronix.de,
        sean.j.christopherson@intel.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, keescook@chromium.org,
        kernel-hardening@lists.openwall.com, mingo@kernel.org,
        solar@openwall.com
Reply-To: gregkh@linuxfoundation.org, linux@dominikbrodowski.net,
          linux-kernel@vger.kernel.org, sean.j.christopherson@intel.com,
          hpa@zytor.com, tglx@linutronix.de, jannh@google.com,
          kernel-hardening@lists.openwall.com, keescook@chromium.org,
          peterz@infradead.org, solar@openwall.com, mingo@kernel.org
In-Reply-To: <20190227200132.24707-2-keescook@chromium.org>
References: <20190227200132.24707-2-keescook@chromium.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/asm] x86/asm: Pin sensitive CR0 bits
Git-Commit-ID: d309ba034fac1a149d00cac79318973e9ba81848
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

Commit-ID:  d309ba034fac1a149d00cac79318973e9ba81848
Gitweb:     https://git.kernel.org/tip/d309ba034fac1a149d00cac79318973e9ba81848
Author:     Kees Cook <keescook@chromium.org>
AuthorDate: Wed, 27 Feb 2019 12:01:30 -0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 6 Mar 2019 10:49:50 +0100

x86/asm: Pin sensitive CR0 bits

With sensitive CR4 bits pinned now, it's possible that the WP bit for CR0
might become a target as well. Following the same reasoning for the CR4
pinning, this pins CR0's WP bit (but this can be done with a static value).

As before, to convince the compiler to not optimize away the check for the
WP bit after the set, this marks "val" as an output from the asm() block.
This protects against just jumping into the function past where the masking
happens; we must check that the mask was applied after we do the set). Due
to how this function can be built by the compiler (especially due to the
removal of frame pointers), jumping into the middle of the function
frequently doesn't require stack manipulation to construct a stack frame
(there may only a retq without pops, which is sufficient for use with
exploits like timer overwrites).

Additionally, this avoids WARN()ing before resetting the bit, just to
minimize any race conditions with leaving the bit unset.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Solar Designer <solar@openwall.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Jann Horn <jannh@google.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>
Link: https://lkml.kernel.org/r/20190227200132.24707-2-keescook@chromium.org

---
 arch/x86/include/asm/special_insns.h | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index fabda1400137..1f01dc3f6c64 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -25,7 +25,28 @@ static inline unsigned long native_read_cr0(void)
 
 static inline void native_write_cr0(unsigned long val)
 {
-	asm volatile("mov %0,%%cr0": : "r" (val), "m" (__force_order));
+	bool warn = false;
+
+again:
+	val |= X86_CR0_WP;
+	/*
+	 * In order to have the compiler not optimize away the check
+	 * after the cr4 write, mark "val" as being also an output ("+r")
+	 * by this asm() block so it will perform an explicit check, as
+	 * if it were "volatile".
+	 */
+	asm volatile("mov %0,%%cr0" : "+r" (val) : "m" (__force_order) : );
+	/*
+	 * If the MOV above was used directly as a ROP gadget we can
+	 * notice the lack of pinned bits in "val" and start the function
+	 * from the beginning to gain the WP bit for sure. And do it
+	 * without first taking the exception for a WARN().
+	 */
+	if ((val & X86_CR0_WP) != X86_CR0_WP) {
+		warn = true;
+		goto again;
+	}
+	WARN_ONCE(warn, "Attempt to unpin X86_CR0_WP, cr0 bypass attack?!\n");
 }
 
 static inline unsigned long native_read_cr2(void)
