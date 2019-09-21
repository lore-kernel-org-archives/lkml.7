Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DFEC49ED7
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 12:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C88E02086A
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 12:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569069793;
	bh=QReZHc803vGaY9LQtLy584uM1Fw63wEHnkzuhudv0/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y5PZKRLIFijvPlyApSYtIYgQXMV9fE3V2Y9cHGMWj0DagCZNo3kQFPi5KoV9UwrIl
	 A4zJeDq8n/lwpwXxEQKAGrYwDCBlnEwMa627Q1NtfWTjeHqiBc18E5GmdJTdkuKajK
	 G9sQ6JO7G9VtGw4Cy/Xw6pjQmWn6jO/FUvCCcI2s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407692AbfIUMnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 08:43:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:39072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407679AbfIUMnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 08:43:07 -0400
Received: from quaco.ghostprotocols.net (user.186-235-137-39.acesso10.net.br [186.235.137.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71E6B217F5;
        Sat, 21 Sep 2019 12:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569069786;
        bh=QReZHc803vGaY9LQtLy584uM1Fw63wEHnkzuhudv0/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Aimq7e5WMVRiHj4ZWhuPOrkkNb4mt7LxwjpH7xNGVE3TyquGWNobKKwa2xolqk2fI
         AoaGbKaxEMGMtGhX6pB/m+uv5gsfwRY7AQOOM3MlZYkZMrvj2g5A+clO0RhXC9S7vD
         6MgCDrYsVEspjcJF9H6it4FOmW9Uj0dxtkU+VhPk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Hellstrom <thellstrom@vmware.com>
Subject: [PATCH 05/10] tools arch x86: Sync asm/cpufeatures.h with the kernel sources
Date:   Sat, 21 Sep 2019 09:42:35 -0300
Message-Id: <20190921124240.15741-6-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190921124240.15741-1-acme@kernel.org>
References: <20190921124240.15741-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
index 5171b9c7ca3e..0652d3eed9bd 100644
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
-- 
2.21.0

