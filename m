Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5475DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 13:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 269BA2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 13:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hkRusnoO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbfCNNMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 09:12:05 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59856 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727456AbfCNNLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 09:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CWClUfB4EkQ8R7fzpQHpQ2PkYzxt8Y3iRDBnue64lb4=; b=hkRusnoOh0ptbrXP4EKNwXXOst
        CJvGhM5gsxk8Piuw3s7IyyD8MB+Uln8tk7MSX+N5ALVC6XV4BB2OKnrly661HPaTkj9IxBlLL/juj
        PAz4sd4DZrlVeiesOWFEjt4UN3aaOGTYEpwI4m3Je6w2c1VNBhyZ78HGRlTRw+lOcGYyylNXwIqvm
        WZfzyujzOGv2Mg601VJe64BwLvABv/+nWI7+kzRh5YPow/uPP4SKYNuyy/Bes9IfpHb6HD5K/RYK8
        Y5RR3SNRkz8g4cERLMmTfdgSfBHDabPkYW7uYwC95Tgc574Zuua7i3MX2vGL8fF29z9AzqLlVLINZ
        NNuAZ3/A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h4Q8u-0005RJ-KP; Thu, 14 Mar 2019 13:11:28 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4501A2029E072; Thu, 14 Mar 2019 14:11:27 +0100 (CET)
Message-Id: <20190314130705.441549378@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 14 Mar 2019 14:01:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, eranian@google.com, jolsa@redhat.com
Cc:     linux-kernel@vger.kernel.org, tonyj@suse.com,
        nelson.dsouza@intel.com, peterz@infradead.org
Subject: [PATCH 1/8] perf/x86/intel: Fix memory corruption
References: <20190314130113.919278615@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Through:

  validate_event()
    x86_pmu.get_event_constraints(.idx=-1)
      tfa_get_event_constraints()
        dyn_constraint()

We use cpuc->constraint_list[-1], which is an obvious out-of-bound
access.

In this case, simply skip the TFA constraint code, there is no event
constraint with just PMC3, therefore the code will never result in the
empty set.

Reported-by: Tony Jones <tonyj@suse.com>
Reported-by: "DSouza, Nelson" <nelson.dsouza@intel.com>
Tested-by: Tony Jones <tonyj@suse.com>
Tested-by: "DSouza, Nelson" <nelson.dsouza@intel.com>
Cc: stable@kernel.org
Fixes: 400816f60c54 ("perf/x86/intel: Implement support for TSX Force Abort")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/events/intel/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3410,7 +3410,7 @@ tfa_get_event_constraints(struct cpu_hw_
 	/*
 	 * Without TFA we must not use PMC3.
 	 */
-	if (!allow_tsx_force_abort && test_bit(3, c->idxmsk)) {
+	if (!allow_tsx_force_abort && test_bit(3, c->idxmsk) && idx >= 0) {
 		c = dyn_constraint(cpuc, c, idx);
 		c->idxmsk64 &= ~(1ULL << 3);
 		c->weight--;


