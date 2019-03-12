Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5CBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A883E2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552414327;
	bh=EMErSks4R37cSLNF5FkmVqD66qJQTyH5+uruK+xZsVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vlndmJ/Zbn+jClOGv08FjjJHjd4MDjahZ8tQbRqTY5WAcYkOdW++vuyKfq+KZg41L
	 i25S3b5QI1tQLnTFNVe//N1bg0buVtyEp+oi9gze6AUEjxCdpsHT8XlxpW4SVSmC8a
	 GXMGLztW1JhkPqfCx1AP29sGf1Yw7QRv/HcDfvAc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbfCLSMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:12:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:45120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727024AbfCLRLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:11:37 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFABD21773;
        Tue, 12 Mar 2019 17:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410696;
        bh=EMErSks4R37cSLNF5FkmVqD66qJQTyH5+uruK+xZsVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zkJy3asiiue6miduUOmiRWbzLDjtSPPwEFSwCGvk6/NS0mBeONCL94YVkzkwjlD2m
         1cV3xuo1NHIUXRriTW5NRjBneb4qLxmhazWnA6xPbberviZCg7zJNjgAalIoEQ9Qxm
         TwdEcNRPo2yzbPpqMubryaRgj0Zri/OvjvOkdjEY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 5.0 23/25] perf/x86/intel: Generalize dynamic constraint creation
Date:   Tue, 12 Mar 2019 10:09:01 -0700
Message-Id: <20190312170405.416500916@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170403.643852550@linuxfoundation.org>
References: <20190312170403.643852550@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Peter Zijlstra (Intel)" <peterz@infradead.org>

Such that we can re-use it.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/events/intel/core.c |   51 +++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 21 deletions(-)

--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2769,6 +2769,35 @@ intel_stop_scheduling(struct cpu_hw_even
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
@@ -2798,27 +2827,7 @@ intel_get_excl_constraints(struct cpu_hw
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


