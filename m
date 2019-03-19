Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE22CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A632A20811
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 15:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rJSogGjM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfCSP1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 11:27:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40234 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfCSP1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 11:27:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dLubaoSw4lfGEbGrrW/VSL2bV9gX8/eBqRxi7iCafs8=; b=rJSogGjMAyaUjolsRNIbOoCSo
        C+aXFB53VY7rA2ttTnkXBet4Ld7wk7JejwwAbhrxnWSUr4va2CQIRK/C6n1sZzQNNgDNHOk+F8RkW
        NRIe2ty5qi5lggc2aAcRfzdKyZ8Fp6BHU0jl6Q8YbqcQ01oCZM/pWa887xCR9jygjnMLCdi39/sK2
        ziRgzFqmBcbW3se5weXOcMp7Hfhyg2APscKAGovzno9ltTmxCrUSRAJTD99GDFuCZR1QhdMKPUV8B
        TFAqijxgRXWH8jdw3dxJBda3HuwrNgvZIoarOZQPe6NRCEOCH6cM+Gkdma6KRJlT+CxHzUlZQnaGW
        yAnUsnB7g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h6Ge2-0004D5-LU; Tue, 19 Mar 2019 15:27:14 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E3C4C28295A3E; Tue, 19 Mar 2019 16:27:12 +0100 (CET)
Date:   Tue, 19 Mar 2019 16:27:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH 05/22] perf/x86: Support constraint ranges
Message-ID: <20190319152712.GI6521@hirez.programming.kicks-ass.net>
References: <20190318214144.4639-1-kan.liang@linux.intel.com>
 <20190318214144.4639-6-kan.liang@linux.intel.com>
 <20190319145309.GI5996@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319145309.GI5996@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 03:53:09PM +0100, Peter Zijlstra wrote:
> On Mon, Mar 18, 2019 at 02:41:27PM -0700, kan.liang@linux.intel.com wrote:

> > The changes costs ~2k text size according to 0day report.
> 
> Where?! there isn't much code here.

> > @@ -71,6 +72,12 @@ struct event_constraint {
> >  #define PERF_X86_EVENT_AUTO_RELOAD	0x0400 /* use PEBS auto-reload */
> >  #define PERF_X86_EVENT_LARGE_PEBS	0x0800 /* use large PEBS */
> >  
> > +static inline bool constraint_match(struct event_constraint *c, u64 ecode)
> > +{
> > +	ecode &= c->cmask;
> > +	return ecode == c->code ||
> > +		(c->range_end && ecode >= c->code && ecode <= c->range_end);
> > +}
> >  
> >  struct amd_nb {
> >  	int nb_id;  /* NorthBridge id */
> 
> That's all the code, how does that add up to 2k ?

By my counting it adds all of 108 bytes of text. What it does do is add
5784 bytes of data. But that too appears not to be required.

The below patch does the same, it adds 37 bytes of text and no
additional data.

It mostly works because of how Intel event codes are 'small'. We can
easily compress the constraint to allow a u64 size, but I don't think
that is needed. If we need to cover AMD64_EVENTSEL_EVENT the range
compare needs to get fixed anyway.


---
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2688,7 +2688,7 @@ x86_get_event_constraints(struct cpu_hw_
 
 	if (x86_pmu.event_constraints) {
 		for_each_event_constraint(c, x86_pmu.event_constraints) {
-			if ((event->hw.config & c->cmask) == c->code) {
+			if (constraint_match(c, event->hw.config)) {
 				event->hw.flags |= c->flags;
 				return c;
 			}
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -858,7 +858,7 @@ struct event_constraint *intel_pebs_cons
 
 	if (x86_pmu.pebs_constraints) {
 		for_each_event_constraint(c, x86_pmu.pebs_constraints) {
-			if ((event->hw.config & c->cmask) == c->code) {
+			if (constraint_match(c, event->hw.config)) {
 				event->hw.flags |= c->flags;
 				return c;
 			}
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -54,6 +54,7 @@ struct event_constraint {
 	int	weight;
 	int	overlap;
 	int	flags;
+	unsigned int	size;
 };
 /*
  * struct hw_perf_event.flags flags
@@ -71,6 +72,10 @@ struct event_constraint {
 #define PERF_X86_EVENT_AUTO_RELOAD	0x0400 /* use PEBS auto-reload */
 #define PERF_X86_EVENT_LARGE_PEBS	0x0800 /* use large PEBS */
 
+static inline bool constraint_match(struct event_constraint *c, u64 ecode)
+{
+	return ((ecode & c->cmask) - c->code) <= (u64)c->size;
+}
 
 struct amd_nb {
 	int nb_id;  /* NorthBridge id */
@@ -257,18 +262,25 @@ struct cpu_hw_events {
 	void				*kfree_on_online[X86_PERF_KFREE_MAX];
 };
 
-#define __EVENT_CONSTRAINT(c, n, m, w, o, f) {\
+#define __EVENT_CONSTRAINT_RANGE(c, e, n, m, w, o, f) {	\
 	{ .idxmsk64 = (n) },		\
 	.code = (c),			\
+	.size = (e) - (c),		\
 	.cmask = (m),			\
 	.weight = (w),			\
 	.overlap = (o),			\
 	.flags = f,			\
 }
 
+#define __EVENT_CONSTRAINT(c, n, m, w, o, f) \
+	__EVENT_CONSTRAINT_RANGE(c, c, n, m, w, o, f)
+
 #define EVENT_CONSTRAINT(c, n, m)	\
 	__EVENT_CONSTRAINT(c, n, m, HWEIGHT(n), 0, 0)
 
+#define EVENT_CONSTRAINT_RANGE(c, e, n, m) \
+	__EVENT_CONSTRAINT_RANGE(c, e, n, m, HWEIGHT(n), 0, 0)
+
 #define INTEL_EXCLEVT_CONSTRAINT(c, n)	\
 	__EVENT_CONSTRAINT(c, n, ARCH_PERFMON_EVENTSEL_EVENT, HWEIGHT(n),\
 			   0, PERF_X86_EVENT_EXCL)
@@ -304,6 +316,12 @@ struct cpu_hw_events {
 	EVENT_CONSTRAINT(c, n, ARCH_PERFMON_EVENTSEL_EVENT)
 
 /*
+ * Constraint on a range of Event codes
+ */
+#define INTEL_EVENT_CONSTRAINT_RANGE(c, e, n)			\
+	EVENT_CONSTRAINT_RANGE(c, e, n, ARCH_PERFMON_EVENTSEL_EVENT)
+
+/*
  * Constraint on the Event code + UMask + fixed-mask
  *
  * filter mask to validate fixed counter events.
@@ -350,6 +368,9 @@ struct cpu_hw_events {
 #define INTEL_FLAGS_EVENT_CONSTRAINT(c, n) \
 	EVENT_CONSTRAINT(c, n, INTEL_ARCH_EVENT_MASK|X86_ALL_EVENT_FLAGS)
 
+#define INTEL_FLAGS_EVENT_CONSTRAINT_RANGE(c, e, n)			\
+	EVENT_CONSTRAINT_RANGE(c, e, n, INTEL_ARCH_EVENT_MASK|X86_ALL_EVENT_FLAGS)
+
 /* Check only flags, but allow all event/umask */
 #define INTEL_ALL_EVENT_CONSTRAINT(code, n)	\
 	EVENT_CONSTRAINT(code, n, X86_ALL_EVENT_FLAGS)
@@ -366,6 +387,11 @@ struct cpu_hw_events {
 			  ARCH_PERFMON_EVENTSEL_EVENT|X86_ALL_EVENT_FLAGS, \
 			  HWEIGHT(n), 0, PERF_X86_EVENT_PEBS_LD_HSW)
 
+#define INTEL_FLAGS_EVENT_CONSTRAINT_DATALA_LD_RANGE(code, end, n) \
+	__EVENT_CONSTRAINT_RANGE(code, end, n,				\
+			  ARCH_PERFMON_EVENTSEL_EVENT|X86_ALL_EVENT_FLAGS, \
+			  HWEIGHT(n), 0, PERF_X86_EVENT_PEBS_LD_HSW)
+
 #define INTEL_FLAGS_EVENT_CONSTRAINT_DATALA_XLD(code, n) \
 	__EVENT_CONSTRAINT(code, n,			\
 			  ARCH_PERFMON_EVENTSEL_EVENT|X86_ALL_EVENT_FLAGS, \
