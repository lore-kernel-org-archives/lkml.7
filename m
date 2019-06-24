Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F71C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2519213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="X0g7jw8Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfFXBmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 21:42:52 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43987 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726416AbfFXBkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 21:40:52 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5O015RJ2861440
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 23 Jun 2019 17:01:05 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5O015RJ2861440
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561334466;
        bh=9Q0LBSpPTClmIQnLyXzhC9StoB4MrBqwop/ZevWzvp0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=X0g7jw8QdtBRZ0nYYkVigy4FqN9BNYj4mlKxLDG9vxvpPDrbASR7SUt4dfKsvZbjD
         0vtUrCC0HVDRWJ+YfE1lCThMAWIkgoC0p5XCiD8HwgvOGmzBAO82PMARVedpU4fe7M
         H0Xpp1pFCv9qEYK2uZQxdP5CqPFg+sKGm2FANpoPAVijYe+rAn9GB3lE2os1U36xzM
         gsQg9G7KB7ra05LQEkKRu+6Lorv4HdOiqKnFLMTx4FQBqt3UShip1sNVgDE/kzTPje
         RgGgdDHEJhXn94ViUI1sdZStKWrRWLLZhBY9BoPTtD5dGVNCyk2MpTazppvBgBfsiZ
         /oe1f1GJz/LBg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5O014ui2861436;
        Sun, 23 Jun 2019 17:01:04 -0700
Date:   Sun, 23 Jun 2019 17:01:04 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Fenghua Yu <tipbot@zytor.com>
Message-ID: <tip-6dbbf5ec9e1e9f607a4c51266d0f9a63ba754b63@git.kernel.org>
Cc:     hpa@zytor.com, tony.luck@intel.com, ashok.raj@intel.com,
        linux-kernel@vger.kernel.org, fenghua.yu@intel.com,
        tglx@linutronix.de, luto@kernel.org, mingo@kernel.org,
        peterz@infradead.org, ravi.v.shankar@intel.com, bp@alien8.de
Reply-To: peterz@infradead.org, mingo@kernel.org, fenghua.yu@intel.com,
          ashok.raj@intel.com, tony.luck@intel.com, hpa@zytor.com,
          bp@alien8.de, ravi.v.shankar@intel.com, luto@kernel.org,
          tglx@linutronix.de, linux-kernel@vger.kernel.org
In-Reply-To: <1560994438-235698-2-git-send-email-fenghua.yu@intel.com>
References: <1560994438-235698-2-git-send-email-fenghua.yu@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/cpufeatures: Enumerate user wait instructions
Git-Commit-ID: 6dbbf5ec9e1e9f607a4c51266d0f9a63ba754b63
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

Commit-ID:  6dbbf5ec9e1e9f607a4c51266d0f9a63ba754b63
Gitweb:     https://git.kernel.org/tip/6dbbf5ec9e1e9f607a4c51266d0f9a63ba754b63
Author:     Fenghua Yu <fenghua.yu@intel.com>
AuthorDate: Wed, 19 Jun 2019 18:33:54 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 24 Jun 2019 01:44:19 +0200

x86/cpufeatures: Enumerate user wait instructions

umonitor, umwait, and tpause are a set of user wait instructions.

umonitor arms address monitoring hardware using an address. The
address range is determined by using CPUID.0x5. A store to
an address within the specified address range triggers the
monitoring hardware to wake up the processor waiting in umwait.

umwait instructs the processor to enter an implementation-dependent
optimized state while monitoring a range of addresses. The optimized
state may be either a light-weight power/performance optimized state
(C0.1 state) or an improved power/performance optimized state
(C0.2 state).

tpause instructs the processor to enter an implementation-dependent
optimized state C0.1 or C0.2 state and wake up when time-stamp counter
reaches specified timeout.

The three instructions may be executed at any privilege level.

The instructions provide power saving method while waiting in
user space. Additionally, they can allow a sibling hyperthread to
make faster progress while this thread is waiting. One example of an
application usage of umwait is when waiting for input data from another
application, such as a user level multi-threaded packet processing
engine.

Availability of the user wait instructions is indicated by the presence
of the CPUID feature flag WAITPKG CPUID.0x07.0x0:ECX[5].

Detailed information on the instructions and CPUID feature WAITPKG flag
can be found in the latest Intel Architecture Instruction Set Extensions
and Future Features Programming Reference and Intel 64 and IA-32
Architectures Software Developer's Manual.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Cc: "Borislav Petkov" <bp@alien8.de>
Cc: "H Peter Anvin" <hpa@zytor.com>
Cc: "Peter Zijlstra" <peterz@infradead.org>
Cc: "Tony Luck" <tony.luck@intel.com>
Cc: "Ravi V Shankar" <ravi.v.shankar@intel.com>
Link: https://lkml.kernel.org/r/1560994438-235698-2-git-send-email-fenghua.yu@intel.com

---
 arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 8ecd9fac97c3..998c2cc08363 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -330,6 +330,7 @@
 #define X86_FEATURE_UMIP		(16*32+ 2) /* User Mode Instruction Protection */
 #define X86_FEATURE_PKU			(16*32+ 3) /* Protection Keys for Userspace */
 #define X86_FEATURE_OSPKE		(16*32+ 4) /* OS Protection Keys Enable */
+#define X86_FEATURE_WAITPKG		(16*32+ 5) /* UMONITOR/UMWAIT/TPAUSE Instructions */
 #define X86_FEATURE_AVX512_VBMI2	(16*32+ 6) /* Additional AVX512 Vector Bit Manipulation Instructions */
 #define X86_FEATURE_GFNI		(16*32+ 8) /* Galois Field New Instructions */
 #define X86_FEATURE_VAES		(16*32+ 9) /* Vector AES */
