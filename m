Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B8DC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D392190A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127136;
	bh=hU8E97WY00+yW1sebap0EM7wOPGfaemsjvNCvPOP+Uo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mBxEiH2f2a3s3g3JWLcgMesYo+LDHUhiuiHowjQZKeJc8++izaBHE7KBSg3EEZa3i
	 V5d0P/WAmPlAiQ+zePhmp6jKRBllt7NMYuJdF8LBM8gcOS/1JkvSRfEd9gKQJp4Inr
	 vQEGOMxbN6AkwAZavKGBslMfAqXzVAZM7DjJVFg0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391308AbfDXRcP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:32:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:58808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403852AbfDXRcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:32:13 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C5B421904;
        Wed, 24 Apr 2019 17:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127132;
        bh=hU8E97WY00+yW1sebap0EM7wOPGfaemsjvNCvPOP+Uo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qXuV6jAPVxg7G9UgDFUeEm8mRhKsl7U84OQi24Xnp4N5uPr3VdD3FIN+q4ldFQUFw
         5FxmfOkZXL9SNuJMuRmLqZtccte4RSL+IBnhH1ZpxOWFuK+yqOWg+kRrBRXRAZ2vlJ
         UOWnAe1F64M+2xspH1VNnCTh8fUL4oBlo12Jfe00=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>, acme@kernel.org,
        jolsa@kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.19 74/96] perf/x86: Fix incorrect PEBS_REGS
Date:   Wed, 24 Apr 2019 19:10:19 +0200
Message-Id: <20190424170924.743805028@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170919.829037226@linuxfoundation.org>
References: <20190424170919.829037226@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

commit 9d5dcc93a6ddfc78124f006ccd3637ce070ef2fc upstream.

PEBS_REGS used as mask for the supported registers for large PEBS.
However, the mask cannot filter the sample_regs_user/sample_regs_intr
correctly.

(1ULL << PERF_REG_X86_*) should be used to replace PERF_REG_X86_*, which
is only the index.

Rename PEBS_REGS to PEBS_GP_REGS, because the mask is only for general
purpose registers.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: <stable@vger.kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: acme@kernel.org
Cc: jolsa@kernel.org
Fixes: 2fe1bc1f501d ("perf/x86: Enable free running PEBS for REGS_USER/INTR")
Link: https://lkml.kernel.org/r/20190402194509.2832-2-kan.liang@linux.intel.com
[ Renamed it to PEBS_GP_REGS - as 'GPRS' is used elsewhere ;-) ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/events/intel/core.c |    2 +-
 arch/x86/events/perf_event.h |   38 +++++++++++++++++++-------------------
 2 files changed, 20 insertions(+), 20 deletions(-)

--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3014,7 +3014,7 @@ static unsigned long intel_pmu_large_peb
 		flags &= ~PERF_SAMPLE_TIME;
 	if (!event->attr.exclude_kernel)
 		flags &= ~PERF_SAMPLE_REGS_USER;
-	if (event->attr.sample_regs_user & ~PEBS_REGS)
+	if (event->attr.sample_regs_user & ~PEBS_GP_REGS)
 		flags &= ~(PERF_SAMPLE_REGS_USER | PERF_SAMPLE_REGS_INTR);
 	return flags;
 }
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -96,25 +96,25 @@ struct amd_nb {
 	PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER | \
 	PERF_SAMPLE_PERIOD)
 
-#define PEBS_REGS \
-	(PERF_REG_X86_AX | \
-	 PERF_REG_X86_BX | \
-	 PERF_REG_X86_CX | \
-	 PERF_REG_X86_DX | \
-	 PERF_REG_X86_DI | \
-	 PERF_REG_X86_SI | \
-	 PERF_REG_X86_SP | \
-	 PERF_REG_X86_BP | \
-	 PERF_REG_X86_IP | \
-	 PERF_REG_X86_FLAGS | \
-	 PERF_REG_X86_R8 | \
-	 PERF_REG_X86_R9 | \
-	 PERF_REG_X86_R10 | \
-	 PERF_REG_X86_R11 | \
-	 PERF_REG_X86_R12 | \
-	 PERF_REG_X86_R13 | \
-	 PERF_REG_X86_R14 | \
-	 PERF_REG_X86_R15)
+#define PEBS_GP_REGS			\
+	((1ULL << PERF_REG_X86_AX)    | \
+	 (1ULL << PERF_REG_X86_BX)    | \
+	 (1ULL << PERF_REG_X86_CX)    | \
+	 (1ULL << PERF_REG_X86_DX)    | \
+	 (1ULL << PERF_REG_X86_DI)    | \
+	 (1ULL << PERF_REG_X86_SI)    | \
+	 (1ULL << PERF_REG_X86_SP)    | \
+	 (1ULL << PERF_REG_X86_BP)    | \
+	 (1ULL << PERF_REG_X86_IP)    | \
+	 (1ULL << PERF_REG_X86_FLAGS) | \
+	 (1ULL << PERF_REG_X86_R8)    | \
+	 (1ULL << PERF_REG_X86_R9)    | \
+	 (1ULL << PERF_REG_X86_R10)   | \
+	 (1ULL << PERF_REG_X86_R11)   | \
+	 (1ULL << PERF_REG_X86_R12)   | \
+	 (1ULL << PERF_REG_X86_R13)   | \
+	 (1ULL << PERF_REG_X86_R14)   | \
+	 (1ULL << PERF_REG_X86_R15))
 
 /*
  * Per register state.


