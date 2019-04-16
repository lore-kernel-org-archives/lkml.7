Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F63DC282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA1F32073F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbfDPLcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:32:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58699 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfDPLco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:32:44 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3GBWNWE3427793
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 16 Apr 2019 04:32:23 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3GBWNE13427790;
        Tue, 16 Apr 2019 04:32:23 -0700
Date:   Tue, 16 Apr 2019 04:32:23 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-9d5dcc93a6ddfc78124f006ccd3637ce070ef2fc@git.kernel.org>
Cc:     eranian@google.com, alexander.shishkin@linux.intel.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, hpa@zytor.com, acme@redhat.com,
        peterz@infradead.org, stable@vger.kernel.org, jolsa@redhat.com,
        kan.liang@linux.intel.com, vincent.weaver@maine.edu,
        mingo@kernel.org
Reply-To: eranian@google.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
          vincent.weaver@maine.edu, mingo@kernel.org,
          kan.liang@linux.intel.com, acme@redhat.com, hpa@zytor.com,
          torvalds@linux-foundation.org, peterz@infradead.org,
          stable@vger.kernel.org, jolsa@redhat.com
In-Reply-To: <20190402194509.2832-2-kan.liang@linux.intel.com>
References: <20190402194509.2832-2-kan.liang@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86: Fix incorrect PEBS_REGS
Git-Commit-ID: 9d5dcc93a6ddfc78124f006ccd3637ce070ef2fc
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

Commit-ID:  9d5dcc93a6ddfc78124f006ccd3637ce070ef2fc
Gitweb:     https://git.kernel.org/tip/9d5dcc93a6ddfc78124f006ccd3637ce070ef2fc
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Tue, 2 Apr 2019 12:44:58 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 16 Apr 2019 12:13:58 +0200

perf/x86: Fix incorrect PEBS_REGS

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
---
 arch/x86/events/intel/core.c |  2 +-
 arch/x86/events/perf_event.h | 38 +++++++++++++++++++-------------------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index f61dcbef20ff..f9451566cd9b 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3131,7 +3131,7 @@ static unsigned long intel_pmu_large_pebs_flags(struct perf_event *event)
 		flags &= ~PERF_SAMPLE_TIME;
 	if (!event->attr.exclude_kernel)
 		flags &= ~PERF_SAMPLE_REGS_USER;
-	if (event->attr.sample_regs_user & ~PEBS_REGS)
+	if (event->attr.sample_regs_user & ~PEBS_GP_REGS)
 		flags &= ~(PERF_SAMPLE_REGS_USER | PERF_SAMPLE_REGS_INTR);
 	return flags;
 }
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index a75955741c50..1e98a42b560a 100644
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
