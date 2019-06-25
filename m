Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA52C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 844CE215EA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="YuzZKb2y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730013AbfFYIWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:22:52 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38101 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfFYIWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:22:52 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5P8LQJO3527436
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 25 Jun 2019 01:21:27 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5P8LQJO3527436
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561450887;
        bh=mpSsIZmZgptRzqmtSWuYMGtWCvhQ3YuueZtSPpXy07E=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=YuzZKb2yXIvQpoUPAvOLO8Rkekdhfm5KMSlgeD4GICqfSrawvteXGvcdWGETNF8QX
         0+6bQRrOVqdzlkv7bJl6HvtnQiqv1GYWpAvqxcKRLfgW7Gx2fQNyweWqidKu4i+sWn
         jXtiQ1uekUMdHfW5/A6OmLEzVLswooUzFCF+SZqlO+65wbXEY/skHsOLXrzU78Uk7Y
         ige/cBgaGdfWLRNXnHWZxDa0yAlEKyx4o3Vg/E2F4ssTipQjswdwYX6piK74Ds7pgw
         IVqsCcH+QR3GCbEinLyFaWgqcba3qA5Af7iYFju87T17dkXYNYnnCMJK3WkZNshrQd
         8gteFBZhr1/Yg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5P8LQ3i3527433;
        Tue, 25 Jun 2019 01:21:26 -0700
Date:   Tue, 25 Jun 2019 01:21:26 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-dce86ac75d772047e9bc606154704aa73bfd4c83@git.kernel.org>
Cc:     tglx@linutronix.de, alexander.shishkin@linux.intel.com,
        eranian@google.com, torvalds@linux-foundation.org, acme@redhat.com,
        linux-kernel@vger.kernel.org, kan.liang@linux.intel.com,
        mingo@kernel.org, vincent.weaver@maine.edu, jolsa@redhat.com,
        hpa@zytor.com, peterz@infradead.org
Reply-To: kan.liang@linux.intel.com, vincent.weaver@maine.edu,
          jolsa@redhat.com, mingo@kernel.org, tglx@linutronix.de,
          alexander.shishkin@linux.intel.com, eranian@google.com,
          peterz@infradead.org, linux-kernel@vger.kernel.org,
          acme@redhat.com, torvalds@linux-foundation.org, hpa@zytor.com
In-Reply-To: <1559081314-9714-3-git-send-email-kan.liang@linux.intel.com>
References: <1559081314-9714-3-git-send-email-kan.liang@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/x86: Clean up PEBS_XMM_REGS
Git-Commit-ID: dce86ac75d772047e9bc606154704aa73bfd4c83
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

Commit-ID:  dce86ac75d772047e9bc606154704aa73bfd4c83
Gitweb:     https://git.kernel.org/tip/dce86ac75d772047e9bc606154704aa73bfd4c83
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Tue, 28 May 2019 15:08:32 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 24 Jun 2019 19:19:24 +0200

perf/x86: Clean up PEBS_XMM_REGS

Use generic macro PERF_REG_EXTENDED_MASK to replace PEBS_XMM_REGS to
avoid duplication.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Link: https://lkml.kernel.org/r/1559081314-9714-3-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/core.c       |  4 ++--
 arch/x86/events/intel/ds.c   |  2 +-
 arch/x86/events/perf_event.h | 18 ------------------
 3 files changed, 3 insertions(+), 21 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index f315425d8468..7708a6fb5f4a 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -561,13 +561,13 @@ int x86_pmu_hw_config(struct perf_event *event)
 	}
 
 	/* sample_regs_user never support XMM registers */
-	if (unlikely(event->attr.sample_regs_user & PEBS_XMM_REGS))
+	if (unlikely(event->attr.sample_regs_user & PERF_REG_EXTENDED_MASK))
 		return -EINVAL;
 	/*
 	 * Besides the general purpose registers, XMM registers may
 	 * be collected in PEBS on some platforms, e.g. Icelake
 	 */
-	if (unlikely(event->attr.sample_regs_intr & PEBS_XMM_REGS)) {
+	if (unlikely(event->attr.sample_regs_intr & PERF_REG_EXTENDED_MASK)) {
 		if (x86_pmu.pebs_no_xmm_regs)
 			return -EINVAL;
 
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 6cb38ab02c8a..955b2c688f23 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -987,7 +987,7 @@ static u64 pebs_update_adaptive_cfg(struct perf_event *event)
 		pebs_data_cfg |= PEBS_DATACFG_GP;
 
 	if ((sample_type & PERF_SAMPLE_REGS_INTR) &&
-	    (attr->sample_regs_intr & PEBS_XMM_REGS))
+	    (attr->sample_regs_intr & PERF_REG_EXTENDED_MASK))
 		pebs_data_cfg |= PEBS_DATACFG_XMMS;
 
 	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index a6ac2f4f76fc..d3b6e90c80d3 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -121,24 +121,6 @@ struct amd_nb {
 	 (1ULL << PERF_REG_X86_R14)   | \
 	 (1ULL << PERF_REG_X86_R15))
 
-#define PEBS_XMM_REGS                   \
-	((1ULL << PERF_REG_X86_XMM0)  | \
-	 (1ULL << PERF_REG_X86_XMM1)  | \
-	 (1ULL << PERF_REG_X86_XMM2)  | \
-	 (1ULL << PERF_REG_X86_XMM3)  | \
-	 (1ULL << PERF_REG_X86_XMM4)  | \
-	 (1ULL << PERF_REG_X86_XMM5)  | \
-	 (1ULL << PERF_REG_X86_XMM6)  | \
-	 (1ULL << PERF_REG_X86_XMM7)  | \
-	 (1ULL << PERF_REG_X86_XMM8)  | \
-	 (1ULL << PERF_REG_X86_XMM9)  | \
-	 (1ULL << PERF_REG_X86_XMM10) | \
-	 (1ULL << PERF_REG_X86_XMM11) | \
-	 (1ULL << PERF_REG_X86_XMM12) | \
-	 (1ULL << PERF_REG_X86_XMM13) | \
-	 (1ULL << PERF_REG_X86_XMM14) | \
-	 (1ULL << PERF_REG_X86_XMM15))
-
 /*
  * Per register state.
  */
