Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7009BC10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A582087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412264;
	bh=M0RrdXYbO4q1LUHknZr40zxJjr+1CL+DbU6LhGmrhlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mc3+E2OYATdt2KfrTQz6rpwdSeWoSl6SI4uWLl0roxUVP47bPmuqNXCIaRQyEmICy
	 JzGBsIp70yNWeHxqBRomHeBy6GJUfXcYjUaw4kpW5AYXVa1odhKXjBOyYBABDlIbGO
	 0pCxyjMN4whVzYg5L3UXhazdvgAxm3Ae6q8AVvR8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbfCLRQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:16:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:56156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728757AbfCLRPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:15:32 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C95CE218A1;
        Tue, 12 Mar 2019 17:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410931;
        bh=M0RrdXYbO4q1LUHknZr40zxJjr+1CL+DbU6LhGmrhlo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cdtqhDNUwcHpSjg8VFpBy2Kda1HP3VxYn6WOj8NlyXS9iYpakDuxOB3cPUSv4/p7P
         yxQJor1FLGCCNt1ZUidoR3q/Cmxshvs1jIf7cOttJakCA9OyzJoWf5Qqp9Q8KkZ9lz
         P2Zk1GweUGeLj+mbv5zxojtulIo3DRw8WUKrE0eA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.19 147/149] perf/x86/intel: Generalize dynamic constraint creation
Date:   Tue, 12 Mar 2019 10:09:25 -0700
Message-Id: <20190312170401.661877302@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170349.421581206@linuxfoundation.org>
References: <20190312170349.421581206@linuxfoundation.org>
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
@@ -2653,6 +2653,35 @@ intel_stop_scheduling(struct cpu_hw_even
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
@@ -2682,27 +2711,7 @@ intel_get_excl_constraints(struct cpu_hw
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


