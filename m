Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13677C282E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 00:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E30CC21874
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 00:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfEYAFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 20:05:37 -0400
Received: from mga01.intel.com ([192.55.52.88]:36240 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbfEYAFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 20:05:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 May 2019 17:05:15 -0700
X-ExtLoop1: 1
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga005.jf.intel.com with ESMTP; 24 May 2019 17:05:15 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H Peter Anvin" <hpa@zytor.com>,
        "Andy Lutomirski" <luto@amacapital.net>,
        "Andrew Cooper" <andrew.cooper3@citrix.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v3 1/5] x86/cpufeatures: Enumerate user wait instructions
Date:   Fri, 24 May 2019 16:55:58 -0700
Message-Id: <1558742162-73402-2-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1558742162-73402-1-git-send-email-fenghua.yu@intel.com>
References: <1558742162-73402-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 75f27ee2c263..b8bd428ae5bc 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -322,6 +322,7 @@
 #define X86_FEATURE_UMIP		(16*32+ 2) /* User Mode Instruction Protection */
 #define X86_FEATURE_PKU			(16*32+ 3) /* Protection Keys for Userspace */
 #define X86_FEATURE_OSPKE		(16*32+ 4) /* OS Protection Keys Enable */
+#define X86_FEATURE_WAITPKG		(16*32+ 5) /* UMONITOR/UMWAIT/TPAUSE Instructions */
 #define X86_FEATURE_AVX512_VBMI2	(16*32+ 6) /* Additional AVX512 Vector Bit Manipulation Instructions */
 #define X86_FEATURE_GFNI		(16*32+ 8) /* Galois Field New Instructions */
 #define X86_FEATURE_VAES		(16*32+ 9) /* Vector AES */
-- 
2.19.1

