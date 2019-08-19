Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C536C3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 09:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C5E120989
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 09:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="QE+pXL/J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfHSJwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 05:52:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33705 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfHSJwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 05:52:46 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7J9qEMI4086349
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 19 Aug 2019 02:52:14 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7J9qEMI4086349
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1566208334;
        bh=QScMPmQDb5fdaplPHhg46Tx8EJJPEw8R47HPZblUhxI=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=QE+pXL/JWfhvA3koMQ/VGh+wuxdHB1rId5bxOB8mJz0peivkI2xaF1BDYX5gl/kg2
         i9iN3tHFumuUS5LvoLCofXbDC/CjjVgAC06VqAIsiYgz5LRPNZb+sF27UL492vxLh1
         Xh80Lnd2mSIfEWwm0WopkgaOq8JpqNozEpT0T/lrHi2ORGTizGiiYJhCLyXzQN2BSQ
         k5MmyKH3LU6rlqj9CkUP3bbRD/B2QDDaPYbqj8aUixxXW5qZE07g3X8ULKlpnMjrZd
         hTLruZk7Th7BZFeAUweHIFNxFYglCG5cv9TgsSUkgm0aa4tl0zdRCAixijfqWjWCdN
         rRMVoWmrM4uEg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7J9qD1m4086345;
        Mon, 19 Aug 2019 02:52:13 -0700
Date:   Mon, 19 Aug 2019 02:52:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-342061c53a049569fc7f56d237753c26b4b2166d@git.kernel.org>
Cc:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        tglx@linutronix.de, bp@suse.de, hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org,
          peterz@infradead.org, torvalds@linux-foundation.org, bp@suse.de,
          tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <20190819070140.23708-1-bp@alien8.de>
References: <20190819070140.23708-1-bp@alien8.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/msr-index: Move AMD MSRs where they belong
Git-Commit-ID: 342061c53a049569fc7f56d237753c26b4b2166d
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

Commit-ID:  342061c53a049569fc7f56d237753c26b4b2166d
Gitweb:     https://git.kernel.org/tip/342061c53a049569fc7f56d237753c26b4b2166d
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Mon, 19 Aug 2019 09:01:40 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 19 Aug 2019 10:55:44 +0200

x86/msr-index: Move AMD MSRs where they belong

... sort them in and fixup comment, while at it.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20190819070140.23708-1-bp@alien8.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/msr-index.h | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 6b4fc2788078..f9a01a04c708 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -375,13 +375,17 @@
 /* Alternative perfctr range with full access. */
 #define MSR_IA32_PMC0			0x000004c1
 
-/* AMD64 MSRs. Not complete. See the architecture manual for a more
-   complete list. */
-
+/*
+ * AMD64 MSRs. Not complete. See the architecture manual for a more
+ * complete list.
+ */
 #define MSR_AMD64_PATCH_LEVEL		0x0000008b
 #define MSR_AMD64_TSC_RATIO		0xc0000104
 #define MSR_AMD64_NB_CFG		0xc001001f
 #define MSR_AMD64_PATCH_LOADER		0xc0010020
+#define MSR_AMD_PERF_CTL		0xc0010062
+#define MSR_AMD_PERF_STATUS		0xc0010063
+#define MSR_AMD_PSTATE_DEF_BASE		0xc0010064
 #define MSR_AMD64_OSVW_ID_LENGTH	0xc0010140
 #define MSR_AMD64_OSVW_STATUS		0xc0010141
 #define MSR_AMD64_LS_CFG		0xc0011020
@@ -560,9 +564,6 @@
 #define MSR_IA32_PERF_STATUS		0x00000198
 #define MSR_IA32_PERF_CTL		0x00000199
 #define INTEL_PERF_CTL_MASK		0xffff
-#define MSR_AMD_PSTATE_DEF_BASE		0xc0010064
-#define MSR_AMD_PERF_STATUS		0xc0010063
-#define MSR_AMD_PERF_CTL		0xc0010062
 
 #define MSR_IA32_MPERF			0x000000e7
 #define MSR_IA32_APERF			0x000000e8
