Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6A3C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E5920661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729873AbfCFJ4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 04:56:19 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60321 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbfCFJ4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 04:56:18 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x269tnHb1653944
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 6 Mar 2019 01:55:49 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x269tmGJ1653941;
        Wed, 6 Mar 2019 01:55:48 -0800
Date:   Wed, 6 Mar 2019 01:55:48 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kees Cook <tipbot@zytor.com>
Message-ID: <tip-1201dc68361cdb83ba314bef565b89400a68f5a5@git.kernel.org>
Cc:     solar@openwall.com, jannh@google.com, mingo@kernel.org,
        kernel-hardening@lists.openwall.com, keescook@chromium.org,
        linux@dominikbrodowski.net, tglx@linutronix.de,
        peterz@infradead.org, gregkh@linuxfoundation.org,
        sean.j.christopherson@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Reply-To: peterz@infradead.org, linux-kernel@vger.kernel.org,
          sean.j.christopherson@intel.com, hpa@zytor.com,
          gregkh@linuxfoundation.org, mingo@kernel.org, jannh@google.com,
          solar@openwall.com, tglx@linutronix.de,
          linux@dominikbrodowski.net, keescook@chromium.org,
          kernel-hardening@lists.openwall.com
In-Reply-To: <20190227200132.24707-3-keescook@chromium.org>
References: <20190227200132.24707-3-keescook@chromium.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/asm] x86/asm: Avoid taking an exception before cr4 restore
Git-Commit-ID: 1201dc68361cdb83ba314bef565b89400a68f5a5
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

Commit-ID:  1201dc68361cdb83ba314bef565b89400a68f5a5
Gitweb:     https://git.kernel.org/tip/1201dc68361cdb83ba314bef565b89400a68f5a5
Author:     Kees Cook <keescook@chromium.org>
AuthorDate: Wed, 27 Feb 2019 12:01:31 -0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 6 Mar 2019 10:49:50 +0100

x86/asm: Avoid taking an exception before cr4 restore

Instead of taking a full WARN() exception before restoring a potentially
missed CR4 bit, this retains the missing bit for later reporting. This
matches the logic done for the CR0 pinning. Additionally updates the
comments to note the required use of "volatile".

Suggested-by: Solar Designer <solar@openwall.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Jann Horn <jannh@google.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>
Link: https://lkml.kernel.org/r/20190227200132.24707-3-keescook@chromium.org

---
 arch/x86/include/asm/special_insns.h | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 1f01dc3f6c64..6020cb1de66e 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -97,18 +97,24 @@ extern volatile unsigned long cr4_pin;
 
 static inline void native_write_cr4(unsigned long val)
 {
+	unsigned long warn = 0;
+
 again:
 	val |= cr4_pin;
 	asm volatile("mov %0,%%cr4": : "r" (val), "m" (__force_order));
 	/*
 	 * If the MOV above was used directly as a ROP gadget we can
 	 * notice the lack of pinned bits in "val" and start the function
-	 * from the beginning to gain the cr4_pin bits for sure.
+	 * from the beginning to gain the cr4_pin bits for sure. Note
+	 * that "val" must be volatile to keep the compiler from
+	 * optimizing away this check.
 	 */
-	if (WARN_ONCE((val & cr4_pin) != cr4_pin,
-		      "Attempt to unpin cr4 bits: %lx, cr4 bypass attack?!",
-		      ~val & cr4_pin))
+	if ((val & cr4_pin) != cr4_pin) {
+		warn = ~val & cr4_pin;
 		goto again;
+	}
+	WARN_ONCE(warn, "Attempt to unpin cr4 bits: %lx; bypass attack?!\n",
+		  warn);
 }
 
 #ifdef CONFIG_X86_64
