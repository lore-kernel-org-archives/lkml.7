Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764D9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 13:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C132184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 13:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Kvmziy7z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbfCNNLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 09:11:51 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59866 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbfCNNLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 09:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UYG49NhyVu7cNtNRCL20P1Z39GZ6lT/pWSkNg1mi8D4=; b=Kvmziy7zhGNL8F91u4nj8sobuf
        kf5QEQvma4Pb8+umK5xp/TY3iVqo3MtDY7xXv3UQ0USSMjIcEYvomvSW67zrgosSuU75/0TQeVu7e
        ONiV10iqmQVUlKLRxTxV4qnSYkucSWjuPLqF8C8i8iFI1eUY2WWIRPQB6+l8lT6AeYOeBYJM9Gjbn
        jYPIvBOMOoA7w8nF77hMdf/Zv0VNxNaZhWbxwGvlYuGSIKtAS0wNIEi+sAhGWhkciNQ4BR+wdazGQ
        PDPN7Ts2fmGbN1sran/sNtvXXCIA1wRyQWw1Hlzx2ZZ2HB+75YIHDtPxAg5NOneVXfboklBb5PcUE
        qjqGPdSA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h4Q8w-0005RX-6R; Thu, 14 Mar 2019 13:11:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5A57D203C774E; Thu, 14 Mar 2019 14:11:27 +0100 (CET)
Message-Id: <20190314130705.852659665@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 14 Mar 2019 14:01:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, eranian@google.com, jolsa@redhat.com
Cc:     linux-kernel@vger.kernel.org, tonyj@suse.com,
        nelson.dsouza@intel.com, peterz@infradead.org
Subject: [RFC][PATCH 5/8] perf/x86/intel: Optimize intel_get_excl_constraints()
References: <20190314130113.919278615@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid the POPCNT by noting we can decrement the weight for each
cleared bit.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/events/intel/core.c |   22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2838,7 +2838,7 @@ intel_get_excl_constraints(struct cpu_hw
 	struct intel_excl_cntrs *excl_cntrs = cpuc->excl_cntrs;
 	struct intel_excl_states *xlo;
 	int tid = cpuc->excl_thread_id;
-	int is_excl, i;
+	int is_excl, i, w;
 
 	/*
 	 * validating a group does not require
@@ -2894,36 +2894,40 @@ intel_get_excl_constraints(struct cpu_hw
 	 * SHARED   : sibling counter measuring non-exclusive event
 	 * UNUSED   : sibling counter unused
 	 */
+	w = c->weight;
 	for_each_set_bit(i, c->idxmsk, X86_PMC_IDX_MAX) {
 		/*
 		 * exclusive event in sibling counter
 		 * our corresponding counter cannot be used
 		 * regardless of our event
 		 */
-		if (xlo->state[i] == INTEL_EXCL_EXCLUSIVE)
+		if (xlo->state[i] == INTEL_EXCL_EXCLUSIVE) {
 			__clear_bit(i, c->idxmsk);
+			w--;
+			continue;
+		}
 		/*
 		 * if measuring an exclusive event, sibling
 		 * measuring non-exclusive, then counter cannot
 		 * be used
 		 */
-		if (is_excl && xlo->state[i] == INTEL_EXCL_SHARED)
+		if (is_excl && xlo->state[i] == INTEL_EXCL_SHARED) {
 			__clear_bit(i, c->idxmsk);
+			w--;
+			continue;
+		}
 	}
 
 	/*
-	 * recompute actual bit weight for scheduling algorithm
-	 */
-	c->weight = hweight64(c->idxmsk64);
-
-	/*
 	 * if we return an empty mask, then switch
 	 * back to static empty constraint to avoid
 	 * the cost of freeing later on
 	 */
-	if (c->weight == 0)
+	if (!w)
 		c = &emptyconstraint;
 
+	c->weight = w;
+
 	return c;
 }
 


