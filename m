Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D28C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC63A2192D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256593;
	bh=O/Ewb3NjgTvEqvWEx8cTMJ63L8ci/XuWoTONZJyCCuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XIcni1vjQLtyTVyJO6Kwn9pXIFrO8ihd3V8cmffeG5DCXjUf3v5qi21m6pIcPMdCi
	 SjLMdpsRA5cakyTxGXNOgZJ/sN7GlJkanaO7zfoYF6s11Ne9TnpJVX1tWa/rlqQ3pz
	 D9l5NSikMEIwVM5zr5fUp3EglS/b7M6o2bdE4KLc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389396AbfCVMJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:09:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:48280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388950AbfCVMJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:09:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D3BD21929;
        Fri, 22 Mar 2019 12:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256587;
        bh=O/Ewb3NjgTvEqvWEx8cTMJ63L8ci/XuWoTONZJyCCuo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Roeyuo2I72WQx1XmXjlJgukGeB1W+l48WDrfF5Nw8bDD4fuFj1yFwOjieVY8jo1ZH
         HCt4PFZ/imEmV52+d2ZTJha2kBpaqfzLIALxBF6W9IzlW2qFN91bJB7HmEioguNjgB
         OE7T2z2ObpX8sbDqUOVXEM0yFWq8BpQXHAFrmGPk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Ingo Molnar <mingo@kernel.org>, stable@kernel.org
Subject: [PATCH 4.19 257/280] perf/x86/intel/uncore: Fix client IMC events return huge result
Date:   Fri, 22 Mar 2019 12:16:50 +0100
Message-Id: <20190322111343.254840591@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kan Liang <kan.liang@linux.intel.com>

commit 8041ffd36f42d8521d66dd1e236feb58cecd68bc upstream.

The client IMC bandwidth events currently return very large values:

  $ perf stat -e uncore_imc/data_reads/ -e uncore_imc/data_writes/ -I 10000 -a

  10.000117222 34,788.76 MiB uncore_imc/data_reads/
  10.000117222 8.26 MiB uncore_imc/data_writes/
  20.000374584 34,842.89 MiB uncore_imc/data_reads/
  20.000374584 10.45 MiB uncore_imc/data_writes/
  30.000633299 37,965.29 MiB uncore_imc/data_reads/
  30.000633299 323.62 MiB uncore_imc/data_writes/
  40.000891548 41,012.88 MiB uncore_imc/data_reads/
  40.000891548 6.98 MiB uncore_imc/data_writes/
  50.001142480 1,125,899,906,621,494.75 MiB uncore_imc/data_reads/
  50.001142480 6.97 MiB uncore_imc/data_writes/

The client IMC events are freerunning counters. They still use the
old event encoding format (0x1 for data_read and 0x2 for data write).
The counter bit width is calculated by common code, which assume that
the standard encoding format is used for the freerunning counters.
Error bit width information is calculated.

The patch intends to convert the old client IMC event encoding to the
standard encoding format.

Current common code uses event->attr.config which directly copy from
user space. We should not implicitly modify it for a converted event.
The event->hw.config is used to replace the event->attr.config in
common code.

For client IMC events, the event->attr.config is used to calculate a
converted event with standard encoding format in the custom
event_init(). The converted event is stored in event->hw.config.
For other events of freerunning counters, they already use the standard
encoding format. The same value as event->attr.config is assigned to
event->hw.config in common event_init().

Reported-by: Jin Yao <yao.jin@linux.intel.com>
Tested-by: Jin Yao <yao.jin@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: stable@kernel.org # v4.18+
Fixes: 9aae1780e7e8 ("perf/x86/intel/uncore: Clean up client IMC uncore")
Link: https://lkml.kernel.org/r/20190227165729.1861-1-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/events/intel/uncore.c     |    1 +
 arch/x86/events/intel/uncore.h     |   12 ++++++------
 arch/x86/events/intel/uncore_snb.c |    4 +++-
 3 files changed, 10 insertions(+), 7 deletions(-)

--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -740,6 +740,7 @@ static int uncore_pmu_event_init(struct
 		/* fixed counters have event field hardcoded to zero */
 		hwc->config = 0ULL;
 	} else if (is_freerunning_event(event)) {
+		hwc->config = event->attr.config;
 		if (!check_valid_freerunning_event(box, event))
 			return -EINVAL;
 		event->hw.idx = UNCORE_PMC_IDX_FREERUNNING;
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -285,8 +285,8 @@ static inline
 unsigned int uncore_freerunning_counter(struct intel_uncore_box *box,
 					struct perf_event *event)
 {
-	unsigned int type = uncore_freerunning_type(event->attr.config);
-	unsigned int idx = uncore_freerunning_idx(event->attr.config);
+	unsigned int type = uncore_freerunning_type(event->hw.config);
+	unsigned int idx = uncore_freerunning_idx(event->hw.config);
 	struct intel_uncore_pmu *pmu = box->pmu;
 
 	return pmu->type->freerunning[type].counter_base +
@@ -360,7 +360,7 @@ static inline
 unsigned int uncore_freerunning_bits(struct intel_uncore_box *box,
 				     struct perf_event *event)
 {
-	unsigned int type = uncore_freerunning_type(event->attr.config);
+	unsigned int type = uncore_freerunning_type(event->hw.config);
 
 	return box->pmu->type->freerunning[type].bits;
 }
@@ -368,7 +368,7 @@ unsigned int uncore_freerunning_bits(str
 static inline int uncore_num_freerunning(struct intel_uncore_box *box,
 					 struct perf_event *event)
 {
-	unsigned int type = uncore_freerunning_type(event->attr.config);
+	unsigned int type = uncore_freerunning_type(event->hw.config);
 
 	return box->pmu->type->freerunning[type].num_counters;
 }
@@ -382,8 +382,8 @@ static inline int uncore_num_freerunning
 static inline bool check_valid_freerunning_event(struct intel_uncore_box *box,
 						 struct perf_event *event)
 {
-	unsigned int type = uncore_freerunning_type(event->attr.config);
-	unsigned int idx = uncore_freerunning_idx(event->attr.config);
+	unsigned int type = uncore_freerunning_type(event->hw.config);
+	unsigned int idx = uncore_freerunning_idx(event->hw.config);
 
 	return (type < uncore_num_freerunning_types(box, event)) &&
 	       (idx < uncore_num_freerunning(box, event));
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -444,9 +444,11 @@ static int snb_uncore_imc_event_init(str
 
 	/* must be done before validate_group */
 	event->hw.event_base = base;
-	event->hw.config = cfg;
 	event->hw.idx = idx;
 
+	/* Convert to standard encoding format for freerunning counters */
+	event->hw.config = ((cfg - 1) << 8) | 0x10ff;
+
 	/* no group validation needed, we have free running counters */
 
 	return 0;


