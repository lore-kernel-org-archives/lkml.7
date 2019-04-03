Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A070C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CAD7206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbfDCKlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 06:41:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42319 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfDCKlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 06:41:15 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x33AenBm1812191
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Apr 2019 03:40:49 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x33AemDJ1812187;
        Wed, 3 Apr 2019 03:40:48 -0700
Date:   Wed, 3 Apr 2019 03:40:48 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-d7262457e35dbe239659e62654e56f8ddb814bed@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        peterz@infradead.org, jolsa@redhat.com, nelson.dsouza@intel.com,
        acme@redhat.com, tglx@linutronix.de, eranian@google.com,
        vincent.weaver@maine.edu, hpa@zytor.com,
        torvalds@linux-foundation.org, mingo@kernel.org
Reply-To: nelson.dsouza@intel.com, jolsa@redhat.com,
          linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
          peterz@infradead.org, tglx@linutronix.de,
          vincent.weaver@maine.edu, eranian@google.com, hpa@zytor.com,
          mingo@kernel.org, torvalds@linux-foundation.org, acme@redhat.com
In-Reply-To: <20190321123849.GN6521@hirez.programming.kicks-ass.net>
References: <20190321123849.GN6521@hirez.programming.kicks-ass.net>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/x86/intel: Initialize TFA MSR
Git-Commit-ID: d7262457e35dbe239659e62654e56f8ddb814bed
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

Commit-ID:  d7262457e35dbe239659e62654e56f8ddb814bed
Gitweb:     https://git.kernel.org/tip/d7262457e35dbe239659e62654e56f8ddb814bed
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Thu, 21 Mar 2019 13:38:49 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 3 Apr 2019 11:40:32 +0200

perf/x86/intel: Initialize TFA MSR

Stephane reported that the TFA MSR is not initialized by the kernel,
but the TFA bit could set by firmware or as a leftover from a kexec,
which makes the state inconsistent.

Reported-by: Stephane Eranian <eranian@google.com>
Tested-by: Nelson DSouza <nelson.dsouza@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: tonyj@suse.com
Link: https://lkml.kernel.org/r/20190321123849.GN6521@hirez.programming.kicks-ass.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 1539647ea39d..f61dcbef20ff 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3575,6 +3575,12 @@ static void intel_pmu_cpu_starting(int cpu)
 
 	cpuc->lbr_sel = NULL;
 
+	if (x86_pmu.flags & PMU_FL_TFA) {
+		WARN_ON_ONCE(cpuc->tfa_shadow);
+		cpuc->tfa_shadow = ~0ULL;
+		intel_set_tfa(cpuc, false);
+	}
+
 	if (x86_pmu.version > 1)
 		flip_smm_bit(&x86_pmu.attr_freeze_on_smi);
 
