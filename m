Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19305C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 13:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D992921871
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 13:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DxLw/J2P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbfCNNLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 09:11:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44342 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbfCNNLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 09:11:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=51LsL6zBq2dD+dHWWzXV54l4My7JvojSdAsyn2uDHBY=; b=DxLw/J2P8MHZtRpLOvK7nkA/LZ
        +m2AkfnSEvxpkrAnVVI1fV0C6srxJbXMR6W7CNTu0Dn2FGI71P8rRMd/bbiravCpYyvevSDC6KMDO
        Ka51gquEjpLp9pdYFWtUezGFVJbV1dx+MphcPrdF/2JEWI7fhR5/gMkW307xAHDpEImCoWPhDrkzj
        Ip90U4eyYiHaW0aJZSPxcB1k1VLy8i6gZh3T3a25NAVLzbHmj0ZAKo7KbVPXLG44w4chl3BD0An/t
        L9c+1HMUPRPpUnt2zROwzSm75tnyxkZ+iY3puzkaSv18CZIjDj+QToHs00LTNizjzgT+FPCb9kY4l
        oiKwSmJw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h4Q8u-0006XO-UT; Thu, 14 Mar 2019 13:11:29 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4E634203C07C0; Thu, 14 Mar 2019 14:11:27 +0100 (CET)
Message-Id: <20190314130705.651247561@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 14 Mar 2019 14:01:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, eranian@google.com, jolsa@redhat.com
Cc:     linux-kernel@vger.kernel.org, tonyj@suse.com,
        nelson.dsouza@intel.com, peterz@infradead.org
Subject: [RFC][PATCH 3/8] perf/x86: Simplify x86_pmu.get_constraints() interface
References: <20190314130113.919278615@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a special case for validate_events() where we'll call
x86_pmu.get_constraints(.idx=-1). It's purpose, up until recent, seems
to be to avoid taking a previous constraint from
cpuc->event_constraint[] in intel_get_event_constraints().

(I could not find any other get_event_constraints() implementation
using @idx)

However, since that cpuc is freshly allocated, that array will in fact
be initialized with NULL pointers, achieving the very same effect.

Therefore remove this exception.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/events/core.c       |    2 +-
 arch/x86/events/intel/core.c |    8 +++-----
 2 files changed, 4 insertions(+), 6 deletions(-)

--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2031,7 +2031,7 @@ static int validate_event(struct perf_ev
 	if (IS_ERR(fake_cpuc))
 		return PTR_ERR(fake_cpuc);
 
-	c = x86_pmu.get_event_constraints(fake_cpuc, -1, event);
+	c = x86_pmu.get_event_constraints(fake_cpuc, 0, event);
 
 	if (!c || !c->weight)
 		ret = -EINVAL;
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2931,11 +2931,9 @@ static struct event_constraint *
 intel_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 			    struct perf_event *event)
 {
-	struct event_constraint *c1 = NULL;
-	struct event_constraint *c2;
+	struct event_constraint *c1, *c2;
 
-	if (idx >= 0) /* fake does < 0 */
-		c1 = cpuc->event_constraint[idx];
+	c1 = cpuc->event_constraint[idx];
 
 	/*
 	 * first time only
@@ -3410,7 +3408,7 @@ tfa_get_event_constraints(struct cpu_hw_
 	/*
 	 * Without TFA we must not use PMC3.
 	 */
-	if (!allow_tsx_force_abort && test_bit(3, c->idxmsk) && idx >= 0) {
+	if (!allow_tsx_force_abort && test_bit(3, c->idxmsk)) {
 		c = dyn_constraint(cpuc, c, idx);
 		c->idxmsk64 &= ~(1ULL << 3);
 		c->weight--;


