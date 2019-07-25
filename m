Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DC7C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D299A2238C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 16:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="WuOxSp1Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389901AbfGYQFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 12:05:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52095 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388481AbfGYQFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 12:05:49 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6PG5cvK1073122
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 25 Jul 2019 09:05:38 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6PG5cvK1073122
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564070738;
        bh=2OCx0nm4I8EQKaMDKKB4PSLMZgBj8rM39+vo43Bw2QQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=WuOxSp1QQO2a+lDBUFw9GEhOkUN6NvhmEjhVDzjhSn/7xqdCGTL+aV1YfLQnysFjX
         b2N4jDl4oSV0YnQ7SIxF0cjrFuIyjjNZm0ofZmq/xC7Ce0qYEKUcS8ZZl77hxi3pD5
         gNgG9r+Pj/uUZW49TxPxHWjLBbDALENoQhp1LcxMKwsLhvXQP+LQnlQ+HVrQ19HfB/
         eyG3kQbMkgYwGbtqHBCXbCCtRuG7yYTWL9181zx1hnGrR+EiPafY8XeLJzolUMycOF
         ZuMSNeP4q4zrCVexVHfM094I1lR2ox2re32s+LgPpTaW5gaMjqYuWsqnGDM9NuIiCr
         sNqqvq/XpiWZg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6PG5bTO1073118;
        Thu, 25 Jul 2019 09:05:37 -0700
Date:   Thu, 25 Jul 2019 09:05:37 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-3d0c3953601d250175c7684ec0d9df612061dae5@git.kernel.org>
Cc:     ak@linux.intel.com, torvalds@linux-foundation.org,
        kan.liang@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: kan.liang@linux.intel.com, hpa@zytor.com, mingo@kernel.org,
          peterz@infradead.org, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, torvalds@linux-foundation.org,
          ak@linux.intel.com
In-Reply-To: <20190723200429.8180-1-kan.liang@linux.intel.com>
References: <20190723200429.8180-1-kan.liang@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/x86/intel: Fix SLOTS PEBS event constraint
Git-Commit-ID: 3d0c3953601d250175c7684ec0d9df612061dae5
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

Commit-ID:  3d0c3953601d250175c7684ec0d9df612061dae5
Gitweb:     https://git.kernel.org/tip/3d0c3953601d250175c7684ec0d9df612061dae5
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Tue, 23 Jul 2019 13:04:29 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 25 Jul 2019 15:41:29 +0200

perf/x86/intel: Fix SLOTS PEBS event constraint

Sampling SLOTS event and ref-cycles event in a group on Icelake gives
EINVAL.

SLOTS event is the event stands for the fixed counter 3, not fixed
counter 2. Wrong mask was set to SLOTS event in
intel_icl_pebs_event_constraints[].

Reported-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 6017608936c1 ("perf/x86/intel: Add Icelake support")
Link: https://lkml.kernel.org/r/20190723200429.8180-1-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/ds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 2c8db2c19328..f1269e804e9b 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -851,7 +851,7 @@ struct event_constraint intel_skl_pebs_event_constraints[] = {
 
 struct event_constraint intel_icl_pebs_event_constraints[] = {
 	INTEL_FLAGS_UEVENT_CONSTRAINT(0x1c0, 0x100000000ULL),	/* INST_RETIRED.PREC_DIST */
-	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0400, 0x400000000ULL),	/* SLOTS */
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0400, 0x800000000ULL),	/* SLOTS */
 
 	INTEL_PLD_CONSTRAINT(0x1cd, 0xff),			/* MEM_TRANS_RETIRED.LOAD_LATENCY */
 	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x1d0, 0xf),	/* MEM_INST_RETIRED.LOAD */
