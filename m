Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F54C4740C
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 10:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE5892070C
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 10:52:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbfIVKwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 06:52:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55565 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728370AbfIVKwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 06:52:38 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iBzTd-0000v8-Bv; Sun, 22 Sep 2019 12:52:25 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E63311C0E22;
        Sun, 22 Sep 2019 12:52:24 +0200 (CEST)
Date:   Sun, 22 Sep 2019 10:52:24 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] tools arch x86: Sync asm/cpufeatures.h with the
 kernel sources
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-pq63abgknsaeov23p80d8gjv@git.kernel.org>
References: <tip-pq63abgknsaeov23p80d8gjv@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156914954486.24167.16035963049459550059.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     40f1c039c7c6de913ee04eac585102e2fce7f6f7
Gitweb:        https://git.kernel.org/tip/40f1c039c7c6de913ee04eac585102e2fce7f6f7
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Fri, 20 Sep 2019 15:00:49 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 20 Sep 2019 15:00:49 -03:00

tools arch x86: Sync asm/cpufeatures.h with the kernel sources

To pick up the changes from:

  b4dd4f6e3648 ("x86/vmware: Add a header file for hypercall definitions")
  f36cf386e3fe ("x86/speculation/swapgs: Exclude ATOMs from speculation through SWAPGS")
  be261ffce6f1 ("x86: Remove X86_FEATURE_MFENCE_RDTSC")
  018ebca8bd70 ("x86/cpufeatures: Enable a new AVX512 CPU feature")

These don't cause any changes in tooling, just silences this perf build
warning:

  Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h'
  diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h

To clarify, updating those files cause these bits of tools/perf to rebuild:

  CC       /tmp/build/perf/bench/mem-memcpy-x86-64-asm.o
  CC       /tmp/build/perf/bench/mem-memset-x86-64-asm.o
  INSTALL  GTK UI
  LD       /tmp/build/perf/bench/perf-in.o

Those use just:

  $ grep FEATURE tools/arch/x86/lib/mem*.S
  tools/arch/x86/lib/memcpy_64.S:	ALTERNATIVE_2 "jmp memcpy_orig", "", X86_FEATURE_REP_GOOD, \
  tools/arch/x86/lib/memcpy_64.S:		      "jmp memcpy_erms", X86_FEATURE_ERMS
  tools/arch/x86/lib/memset_64.S:	ALTERNATIVE_2 "jmp memset_orig", "", X86_FEATURE_REP_GOOD, \
  tools/arch/x86/lib/memset_64.S:		      "jmp memset_erms", X86_FEATURE_ERMS
  $

I.e. none of the feature defines added/removed by the patches above.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Gayatri Kammela <gayatri.kammela@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Hellstrom <thellstrom@vmware.com>
Link: https://lkml.kernel.org/n/tip-pq63abgknsaeov23p80d8gjv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/cpufeatures.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 5171b9c..0652d3e 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -231,6 +231,8 @@
 #define X86_FEATURE_VMMCALL		( 8*32+15) /* Prefer VMMCALL to VMCALL */
 #define X86_FEATURE_XENPV		( 8*32+16) /* "" Xen paravirtual guest */
 #define X86_FEATURE_EPT_AD		( 8*32+17) /* Intel Extended Page Table access-dirty bit */
+#define X86_FEATURE_VMCALL		( 8*32+18) /* "" Hypervisor supports the VMCALL instruction */
+#define X86_FEATURE_VMW_VMMCALL		( 8*32+19) /* "" VMware prefers VMMCALL hypercall instruction */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EBX), word 9 */
 #define X86_FEATURE_FSGSBASE		( 9*32+ 0) /* RDFSBASE, WRFSBASE, RDGSBASE, WRGSBASE instructions*/
@@ -354,6 +356,7 @@
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EDX), word 18 */
 #define X86_FEATURE_AVX512_4VNNIW	(18*32+ 2) /* AVX-512 Neural Network Instructions */
 #define X86_FEATURE_AVX512_4FMAPS	(18*32+ 3) /* AVX-512 Multiply Accumulation Single precision */
+#define X86_FEATURE_AVX512_VP2INTERSECT (18*32+ 8) /* AVX-512 Intersect for D/Q */
 #define X86_FEATURE_MD_CLEAR		(18*32+10) /* VERW clears CPU buffers */
 #define X86_FEATURE_TSX_FORCE_ABORT	(18*32+13) /* "" TSX_FORCE_ABORT */
 #define X86_FEATURE_PCONFIG		(18*32+18) /* Intel PCONFIG */
