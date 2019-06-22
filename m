Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D8FC43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 09:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1031320675
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 09:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="gKGYm22P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfFVJ7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 05:59:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50543 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfFVJ7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 05:59:15 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5M9wmMi2091397
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 22 Jun 2019 02:58:48 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5M9wmMi2091397
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561197528;
        bh=6e2G3wXX6PEzpiwRMhk4HymR/KsMtROAKKP5aBCi/XQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=gKGYm22PpmKj3TPX0NqP/McEbC7cgmG5fHeRH6tY6+ZkAxc7i8RyuU/FHApQnZzZZ
         gHan5BIB0WvUNz+r3/BxZGBqk4BSaInr9gXkmmHqnl1TtsWZzzxt7CPLQp2UikqorC
         Yp5QAcX+d0uVV6NFPz3VW0PKTNSi0U6kpm2Qq/Hqb1R8pBOVww9RlBR9zCPl5krYJh
         vloyzuTrA6YJY2t39086kchi3h7GH7TZsnPYfjUD1M5RBEh8KbxuvDxm+9NIyATEqs
         KbEoDS7fYKy84E3JfBI9kBKZagG/fS7z2Qo8HFgEhQe5KUwfvaPqFDkpZfn/3BGfzx
         pVahtZ9OPSCIg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5M9wlUm2091394;
        Sat, 22 Jun 2019 02:58:47 -0700
Date:   Sat, 22 Jun 2019 02:58:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kees Cook <tipbot@zytor.com>
Message-ID: <tip-8dbec27a242cd3e2816eeb98d3237b9f57cf6232@git.kernel.org>
Cc:     keescook@chromium.org, dave.hansen@intel.com, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
        peterz@infradead.org, torvalds@linux-foundation.org
Reply-To: hpa@zytor.com, peterz@infradead.org,
          torvalds@linux-foundation.org, mingo@kernel.org,
          keescook@chromium.org, dave.hansen@intel.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190618045503.39105-4-keescook@chromium.org>
References: <20190618045503.39105-4-keescook@chromium.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/asm] x86/asm: Pin sensitive CR0 bits
Git-Commit-ID: 8dbec27a242cd3e2816eeb98d3237b9f57cf6232
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

Commit-ID:  8dbec27a242cd3e2816eeb98d3237b9f57cf6232
Gitweb:     https://git.kernel.org/tip/8dbec27a242cd3e2816eeb98d3237b9f57cf6232
Author:     Kees Cook <keescook@chromium.org>
AuthorDate: Mon, 17 Jun 2019 21:55:03 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 22 Jun 2019 11:55:22 +0200

x86/asm: Pin sensitive CR0 bits

With sensitive CR4 bits pinned now, it's possible that the WP bit for
CR0 might become a target as well.

Following the same reasoning for the CR4 pinning, pin CR0's WP
bit. Contrary to the cpu feature dependend CR4 pinning this can be done
with a constant value.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: kernel-hardening@lists.openwall.com
Link: https://lkml.kernel.org/r/20190618045503.39105-4-keescook@chromium.org

---
 arch/x86/include/asm/special_insns.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index c8c8143ab27b..b2e84d113f2a 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -31,7 +31,20 @@ static inline unsigned long native_read_cr0(void)
 
 static inline void native_write_cr0(unsigned long val)
 {
-	asm volatile("mov %0,%%cr0": : "r" (val), "m" (__force_order));
+	unsigned long bits_missing = 0;
+
+set_register:
+	asm volatile("mov %0,%%cr0": "+r" (val), "+m" (__force_order));
+
+	if (static_branch_likely(&cr_pinning)) {
+		if (unlikely((val & X86_CR0_WP) != X86_CR0_WP)) {
+			bits_missing = X86_CR0_WP;
+			val |= bits_missing;
+			goto set_register;
+		}
+		/* Warn after we've set the missing bits. */
+		WARN_ONCE(bits_missing, "CR0 WP bit went missing!?\n");
+	}
 }
 
 static inline unsigned long native_read_cr2(void)
