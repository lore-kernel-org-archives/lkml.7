Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C39C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04875206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411291;
	bh=ZQxoONCrx9PQjsLJDKccm0qVLa4u7+B22MyHgniTOwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MIfwfeeZyfj1om0UgVlI2D10VTIV1MvP0KukEHlHIgDsyuh+UH6xXobI1tQhAc2fC
	 yDss8gVxaMBUUYfnK46V5AEINcJwX1eb0/65PBcDaDBYFDaxyWKJBDlPN3l/H5dYWc
	 AFY43U1D/5CuH7a2JdsmXWj6QtYoytQiTZnJVObE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729607AbfCLRV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:21:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:35644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728567AbfCLRSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:18:14 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3227E217D4;
        Tue, 12 Mar 2019 17:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411094;
        bh=ZQxoONCrx9PQjsLJDKccm0qVLa4u7+B22MyHgniTOwg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R+irYuJ6jgnuYuZWuLBQ/k2NBQG91JAEQCb/XY00eYtE1BAiB/oKxy8EpGKOOHX+/
         rdG4NH1IVMA/zugnaYHPo4/Uworpq51y/+6RQrNO0gCTGZXxvctPCiSnq01mHeokv7
         6q6jg6G/Zq5YVNVCdZgO1TTnh0Q29fkdxRZTqh/8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.9 95/96] perf/x86/intel: Generalize dynamic constraint creation
Date:   Tue, 12 Mar 2019 10:10:53 -0700
Message-Id: <20190312171041.616887803@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312171034.530434962@linuxfoundation.org>
References: <20190312171034.530434962@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Peter Zijlstra (Intel)" <peterz@infradead.org>

commit 11f8b2d65ca9029591c8df26bb6bd063c312b7fe upstream

Such that we can re-use it.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/events/intel/core.c |   51 +++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 21 deletions(-)

--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2493,6 +2493,35 @@ intel_stop_scheduling(struct cpu_hw_even
 }
 
 static struct event_constraint *
+dyn_constraint(struct cpu_hw_events *cpuc, struct event_constraint *c, int idx)
+{
+	WARN_ON_ONCE(!cpuc->constraint_list);
+
+	if (!(c->flags & PERF_X86_EVENT_DYNAMIC)) {
+		struct event_constraint *cx;
+
+		/*
+		 * grab pre-allocated constraint entry
+		 */
+		cx = &cpuc->constraint_list[idx];
+
+		/*
+		 * initialize dynamic constraint
+		 * with static constraint
+		 */
+		*cx = *c;
+
+		/*
+		 * mark constraint as dynamic
+		 */
+		cx->flags |= PERF_X86_EVENT_DYNAMIC;
+		c = cx;
+	}
+
+	return c;
+}
+
+static struct event_constraint *
 intel_get_excl_constraints(struct cpu_hw_events *cpuc, struct perf_event *event,
 			   int idx, struct event_constraint *c)
 {
@@ -2522,27 +2551,7 @@ intel_get_excl_constraints(struct cpu_hw
 	 * only needed when constraint has not yet
 	 * been cloned (marked dynamic)
 	 */
-	if (!(c->flags & PERF_X86_EVENT_DYNAMIC)) {
-		struct event_constraint *cx;
-
-		/*
-		 * grab pre-allocated constraint entry
-		 */
-		cx = &cpuc->constraint_list[idx];
-
-		/*
-		 * initialize dynamic constraint
-		 * with static constraint
-		 */
-		*cx = *c;
-
-		/*
-		 * mark constraint as dynamic, so we
-		 * can free it later on
-		 */
-		cx->flags |= PERF_X86_EVENT_DYNAMIC;
-		c = cx;
-	}
+	c = dyn_constraint(cpuc, c, idx);
 
 	/*
 	 * From here on, the constraint is dynamic.


