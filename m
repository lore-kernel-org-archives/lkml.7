Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9456C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 07:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB58E206C2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 07:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730367AbfJHHfV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 03:35:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47100 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730171AbfJHHfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 03:35:20 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iHk1N-00040x-05; Tue, 08 Oct 2019 09:35:01 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6ED381C0325;
        Tue,  8 Oct 2019 09:35:00 +0200 (CEST)
Date:   Tue, 08 Oct 2019 07:35:00 -0000
From:   "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpufeatures: Add feature bit RDPRU on AMD
Cc:     Babu Moger <babu.moger@amd.com>, Borislav Petkov <bp@suse.de>,
        Aaron Lewis <aaronlewis@google.com>, ak@linux.intel.com,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        robert.hu@linux.intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        "x86-ml" <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20191007204839.5727.10803.stgit@localhost.localdomain>
References: <20191007204839.5727.10803.stgit@localhost.localdomain>
MIME-Version: 1.0
Message-ID: <157052010022.9978.18216780749038351513.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     9d40b85bb46a99bc95dad3a07787da93b0a018e9
Gitweb:        https://git.kernel.org/tip/9d40b85bb46a99bc95dad3a07787da93b0a018e9
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Mon, 07 Oct 2019 15:48:39 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 08 Oct 2019 09:28:37 +02:00

x86/cpufeatures: Add feature bit RDPRU on AMD

AMD Zen 2 introduces a new RDPRU instruction which is used to give
access to some processor registers that are typically only accessible
when the privilege level is zero.

ECX is used as the implicit register to specify which register to read.
RDPRU places the specified register’s value into EDX:EAX.

For example, the RDPRU instruction can be used to read MPERF and APERF
at CPL > 0.

Add the feature bit so it is visible in /proc/cpuinfo.

Details are available in the AMD64 Architecture Programmer’s Manual:
https://www.amd.com/system/files/TechDocs/24594.pdf

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Aaron Lewis <aaronlewis@google.com>
Cc: ak@linux.intel.com
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: robert.hu@linux.intel.com
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Hellstrom <thellstrom@vmware.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20191007204839.5727.10803.stgit@localhost.localdomain
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 0652d3e..1db10a1 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -292,6 +292,7 @@
 #define X86_FEATURE_CLZERO		(13*32+ 0) /* CLZERO instruction */
 #define X86_FEATURE_IRPERF		(13*32+ 1) /* Instructions Retired Count */
 #define X86_FEATURE_XSAVEERPTR		(13*32+ 2) /* Always save/restore FP error pointers */
+#define X86_FEATURE_RDPRU		(13*32+ 4) /* Read processor register at user level */
 #define X86_FEATURE_WBNOINVD		(13*32+ 9) /* WBNOINVD instruction */
 #define X86_FEATURE_AMD_IBPB		(13*32+12) /* "" Indirect Branch Prediction Barrier */
 #define X86_FEATURE_AMD_IBRS		(13*32+14) /* "" Indirect Branch Restricted Speculation */
