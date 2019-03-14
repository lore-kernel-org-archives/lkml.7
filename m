Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44932C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 13:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 164792184E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 13:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EElsZ0kA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfCNNLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 09:11:43 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59844 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbfCNNLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 09:11:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=919R7la1O1dfzHoLS8GO3HC91HAhkmvRsq3u8qSNbFk=; b=EElsZ0kAb7RdRWjqDtSnwXPJUR
        va+mYNxevk7YwlVLxhsstcw4WUVOkLUSimaozjVidKZtG0N1Xlm6373N0PzHF9U68wEDFqwitU8eY
        bHRg71rKociuwc/ZalzXSvr14kTR86L6H+nBZ4I5UT2rOsrD6i3YiJkv8EaURs0f+uOmkS0RGOZza
        xMpigpXBUu6Zhy2xXtXxKQ9nqX98TG9G5v2b0uKWgfgpc5jKK+wmMT6lMoAKGK9Uoy2dehnJ7+/p8
        +9HhxmJpcp6SceWH7SOPrLcevsgb/y48OV5DsTkOlayc5gaoZeH+XtoZdqkfH7QYzy7uc5Co3/ide
        +nfqHBWg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h4Q8w-0005RY-7Q; Thu, 14 Mar 2019 13:11:30 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5FC2D203DCFA4; Thu, 14 Mar 2019 14:11:27 +0100 (CET)
Message-Id: <20190314130705.956098225@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 14 Mar 2019 14:01:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, eranian@google.com, jolsa@redhat.com
Cc:     linux-kernel@vger.kernel.org, tonyj@suse.com,
        nelson.dsouza@intel.com, peterz@infradead.org
Subject: [RFC][PATCH 6/8] perf/x86: Clear ->event_constraint[] on put
References: <20190314130113.919278615@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current code unconditionally clears cpuc->event_constraint[i]
before calling get_event_constraints(.idx=i). The only site that cares
is intel_get_event_constraints() where the c1 load will always be
NULL.

However, always calling get_event_constraints() on all events is
wastefull, most times it will return the exact same result. Therefore
retain the logic in intel_get_event_constraints() and change the
generic code to only clear the constraint on put.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/events/core.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -858,7 +858,6 @@ int x86_schedule_events(struct cpu_hw_ev
 		x86_pmu.start_scheduling(cpuc);
 
 	for (i = 0, wmin = X86_PMC_IDX_MAX, wmax = 0; i < n; i++) {
-		cpuc->event_constraint[i] = NULL;
 		c = x86_pmu.get_event_constraints(cpuc, i, cpuc->event_list[i]);
 		cpuc->event_constraint[i] = c;
 
@@ -941,6 +940,8 @@ int x86_schedule_events(struct cpu_hw_ev
 			 */
 			if (x86_pmu.put_event_constraints)
 				x86_pmu.put_event_constraints(cpuc, e);
+
+			cpuc->event_constraint[i] = NULL;
 		}
 	}
 
@@ -1404,6 +1405,7 @@ static void x86_pmu_del(struct perf_even
 		cpuc->event_list[i-1] = cpuc->event_list[i];
 		cpuc->event_constraint[i-1] = cpuc->event_constraint[i];
 	}
+	cpuc->event_constraint[i-1] = NULL;
 	--cpuc->n_events;
 
 	perf_event_update_userpage(event);


