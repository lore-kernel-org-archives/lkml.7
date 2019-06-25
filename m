Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AF7C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A02B221655
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="D8SKRwM7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbfFYIWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:22:43 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43883 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbfFYIWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:22:42 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5P8M92L3527525
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 25 Jun 2019 01:22:09 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5P8M92L3527525
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561450930;
        bh=0k6y0OXHppZsqTj4LnR8kUQ0tI7hwKSknVM/xL9SSkE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=D8SKRwM72Fm1t68/fU5FY061zBwi1F9xKTrmO7W6xo5kEvRZIk+I5qpxT+9CMhpqF
         i5MH4awOsHwqJtVJ4yZWwmbnXUKLzzb5A9RQzHSXebbrI7A4/mcToFVCwhhkzGjZPB
         ei7LGFrPHkGgZVfEqhS2Hx41MGu6mUgA2U8W8n3VsNe1qpGsOo1lMMpX2QbtgiEhOC
         8XCml+coTchHBiWZvv0UmQFOf4rj0llumyiI5BaXESqvs6TKcXXnxq86tI/MafdoCH
         o0bxUtNyTXxVzimZQpiO9Fpzbk1miGkPw4aOn1wnV0N42OXJjHxjkSJnBMAJ0d7jgP
         nfSLBbh3ogQ+A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5P8M8Eu3527518;
        Tue, 25 Jun 2019 01:22:08 -0700
Date:   Tue, 25 Jun 2019 01:22:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-cd6b984f6d8cd615755b5404a51b7efe45215f28@git.kernel.org>
Cc:     tglx@linutronix.de, jolsa@redhat.com,
        torvalds@linux-foundation.org, vincent.weaver@maine.edu,
        kan.liang@linux.intel.com, acme@redhat.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        peterz@infradead.org, eranian@google.com
Reply-To: torvalds@linux-foundation.org, vincent.weaver@maine.edu,
          kan.liang@linux.intel.com, acme@redhat.com,
          alexander.shishkin@linux.intel.com, peterz@infradead.org,
          tglx@linutronix.de, jolsa@redhat.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
          eranian@google.com
In-Reply-To: <1559081314-9714-4-git-send-email-kan.liang@linux.intel.com>
References: <1559081314-9714-4-git-send-email-kan.liang@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/x86: Remove pmu->pebs_no_xmm_regs
Git-Commit-ID: cd6b984f6d8cd615755b5404a51b7efe45215f28
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

Commit-ID:  cd6b984f6d8cd615755b5404a51b7efe45215f28
Gitweb:     https://git.kernel.org/tip/cd6b984f6d8cd615755b5404a51b7efe45215f28
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Tue, 28 May 2019 15:08:33 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 24 Jun 2019 19:19:25 +0200

perf/x86: Remove pmu->pebs_no_xmm_regs

We don't need pmu->pebs_no_xmm_regs anymore, the capabilities
PERF_PMU_CAP_EXTENDED_REGS can be used to check if XMM registers
collection is supported.

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
Link: https://lkml.kernel.org/r/1559081314-9714-4-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/core.c       | 2 +-
 arch/x86/events/intel/ds.c   | 6 ++----
 arch/x86/events/perf_event.h | 3 +--
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 7708a6fb5f4a..52a97463cb24 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -568,7 +568,7 @@ int x86_pmu_hw_config(struct perf_event *event)
 	 * be collected in PEBS on some platforms, e.g. Icelake
 	 */
 	if (unlikely(event->attr.sample_regs_intr & PERF_REG_EXTENDED_MASK)) {
-		if (x86_pmu.pebs_no_xmm_regs)
+		if (!(event->pmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS))
 			return -EINVAL;
 
 		if (!event->attr.precise_ip)
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 955b2c688f23..505c73dc6a73 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1964,10 +1964,9 @@ void __init intel_ds_init(void)
 	x86_pmu.bts  = boot_cpu_has(X86_FEATURE_BTS);
 	x86_pmu.pebs = boot_cpu_has(X86_FEATURE_PEBS);
 	x86_pmu.pebs_buffer_size = PEBS_BUFFER_SIZE;
-	if (x86_pmu.version <= 4) {
+	if (x86_pmu.version <= 4)
 		x86_pmu.pebs_no_isolation = 1;
-		x86_pmu.pebs_no_xmm_regs = 1;
-	}
+
 	if (x86_pmu.pebs) {
 		char pebs_type = x86_pmu.intel_cap.pebs_trap ?  '+' : '-';
 		char *pebs_qual = "";
@@ -2023,7 +2022,6 @@ void __init intel_ds_init(void)
 				x86_get_pmu()->capabilities |= PERF_PMU_CAP_EXTENDED_REGS;
 			} else {
 				/* Only basic record supported */
-				x86_pmu.pebs_no_xmm_regs = 1;
 				x86_pmu.large_pebs_flags &=
 					~(PERF_SAMPLE_ADDR |
 					  PERF_SAMPLE_TIME |
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index d3b6e90c80d3..4e346856ee19 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -650,8 +650,7 @@ struct x86_pmu {
 			pebs_broken		:1,
 			pebs_prec_dist		:1,
 			pebs_no_tlb		:1,
-			pebs_no_isolation	:1,
-			pebs_no_xmm_regs	:1;
+			pebs_no_isolation	:1;
 	int		pebs_record_size;
 	int		pebs_buffer_size;
 	int		max_pebs_events;
