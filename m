Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E995AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD0F206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411893;
	bh=1tdeYFIXL7uYmksV6OONGB8Q/eBH0Ifxu3NGtf7CBZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AeUz0mDXsBMsBNz2MTYKFEjmvkON0tOgvrQ/eMwAnqT672Zj++lPlEYXpsovOMqtF
	 SwckK4zi5yHsOqm355jM1CRdU1MFjbeG3inuJ4fqtRFDZAwvnTiQKL8LocMzRDUaz9
	 fPssCooYb++0PVpAVu+6D70VfCHkekipySEaPF5w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbfCLRbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:31:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:60252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729464AbfCLRRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:17:10 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFA6E217D8;
        Tue, 12 Mar 2019 17:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411029;
        bh=1tdeYFIXL7uYmksV6OONGB8Q/eBH0Ifxu3NGtf7CBZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CpqdtZdtF4ZtXe790sWUQOWAS6V2hT06dD5nClB/DLQiYlpSbZFRPvrhAHg4/2pM0
         /igobZIwICbX9FQH91c5/uEgF45yrPYayTHY0pZluAodtiIr5C6S3cvlb/30B0yLqT
         0yrAHJr9AAUEzapVr42tamKIh9VWBs/0U4tGsL28=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.14 133/135] perf/x86/intel: Generalize dynamic constraint creation
Date:   Tue, 12 Mar 2019 10:09:40 -0700
Message-Id: <20190312170353.414674067@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170341.127810985@linuxfoundation.org>
References: <20190312170341.127810985@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2640,6 +2640,35 @@ intel_stop_scheduling(struct cpu_hw_even
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
@@ -2669,27 +2698,7 @@ intel_get_excl_constraints(struct cpu_hw
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


