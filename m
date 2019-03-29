Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE77BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E075217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553866716;
	bh=3wHOUOKI0Y5sv3OkeWlaNLhsux3cGL8FveQ/nQqZElY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zmnoFPfFGnKvWHb3wEx28CP0MAZl0f/0La2mbleDLAm1wET0dgllIAXyb8PbUf6cL
	 7ajxjUbIiVX23sXGXmYXEbkUhxqtcJTpw6b1KqfOS8CJJ+BNjwUjwsO14EdRbF+8oK
	 5szkNDxJUqVONsiQLiDhT+qt6ybAkTB6gsVemEDY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729810AbfC2Nif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 09:38:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:33830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729636AbfC2Nic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 09:38:32 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FE3321850;
        Fri, 29 Mar 2019 13:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553866711;
        bh=3wHOUOKI0Y5sv3OkeWlaNLhsux3cGL8FveQ/nQqZElY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GK7ZsFrtCa6lSCB5QwKWrR5AIF71BAZwJgRFhr5XNZ12LESHMy89Glp6SU0skEuEE
         KsLtQ9U157/zGo4Nxndwpe8d1Yx1HlA5CNFCjPbV+e3NYKYhm1i1OfDsCXGZ4rAtG3
         qhHld/GJEmUYtz58Th7WsdVD0LYnquEwAvPa/dCw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 06/13] tools arch x86: Sync asm/cpufeatures.h with the kernel sources
Date:   Fri, 29 Mar 2019 10:37:54 -0300
Message-Id: <20190329133801.21004-7-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190329133801.21004-1-acme@kernel.org>
References: <20190329133801.21004-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To get the changes from:

  52f64909409c ("x86: Add TSX Force Abort CPUID/MSR")

That don't cause any changes in the generated perf binaries.

And silence this perf build warning:

  Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h'
  diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/n/tip-zv8kw8vnb1zppflncpwfsv2w@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 6d6122524711..981ff9479648 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -344,6 +344,7 @@
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EDX), word 18 */
 #define X86_FEATURE_AVX512_4VNNIW	(18*32+ 2) /* AVX-512 Neural Network Instructions */
 #define X86_FEATURE_AVX512_4FMAPS	(18*32+ 3) /* AVX-512 Multiply Accumulation Single precision */
+#define X86_FEATURE_TSX_FORCE_ABORT	(18*32+13) /* "" TSX_FORCE_ABORT */
 #define X86_FEATURE_PCONFIG		(18*32+18) /* Intel PCONFIG */
 #define X86_FEATURE_SPEC_CTRL		(18*32+26) /* "" Speculation Control (IBRS + IBPB) */
 #define X86_FEATURE_INTEL_STIBP		(18*32+27) /* "" Single Thread Indirect Branch Predictors */
-- 
2.20.1

