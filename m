Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833F3C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5124A2173B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565802412;
	bh=kMnTO3RgwWOH+yLy+5j3sBYEHdgm1LH/sb0y+RPW8pQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qub8pvtOMETS3WJXGB8IQSfQsQ5gNPJvBUNHjP0xNeHezaK9bch6MXg1NlDe+5ntN
	 H2rCSJK5M3m/VKDysTfcaXLtGPb6mbT9TSkGhCCBRF26ajGwaKOoaCMJSQEqu5F2Ju
	 k0TaRTHbZjfb0Ka/QtEQfRxiZhjlJhvTVSIya+rI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbfHNRGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:06:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:55960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729136AbfHNRGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:06:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E4C621721;
        Wed, 14 Aug 2019 17:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565802404;
        bh=kMnTO3RgwWOH+yLy+5j3sBYEHdgm1LH/sb0y+RPW8pQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wE1wnwahl6IxlR+BQDvfVyd5W0wmt11FpnMDy3gIAyFnrrad0zj7g6pzKlz4Jdxmh
         KYtdQn7fBntZ3w7QuhmhzF3H71BZTDQcrd12Ms2DiEs3oh2i856XE9++TW0Ktu7p3Q
         9ZpVl9+znQH6ywcprni6DfQSwv71AA0yA/FWlZbg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 112/144] perf/x86/intel: Fix SLOTS PEBS event constraint
Date:   Wed, 14 Aug 2019 19:01:08 +0200
Message-Id: <20190814165804.595706787@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814165759.466811854@linuxfoundation.org>
References: <20190814165759.466811854@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 3d0c3953601d250175c7684ec0d9df612061dae5 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/events/intel/ds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 505c73dc6a730..6601b8759c92f 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -851,7 +851,7 @@ struct event_constraint intel_skl_pebs_event_constraints[] = {
 
 struct event_constraint intel_icl_pebs_event_constraints[] = {
 	INTEL_FLAGS_UEVENT_CONSTRAINT(0x1c0, 0x100000000ULL),	/* INST_RETIRED.PREC_DIST */
-	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0400, 0x400000000ULL),	/* SLOTS */
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0400, 0x800000000ULL),	/* SLOTS */
 
 	INTEL_PLD_CONSTRAINT(0x1cd, 0xff),			/* MEM_TRANS_RETIRED.LOAD_LATENCY */
 	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x1d0, 0xf),	/* MEM_INST_RETIRED.LOAD */
-- 
2.20.1



