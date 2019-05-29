Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B070DC04AB3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 07:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8263B20B7C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 07:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nYSePjc+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfE2Heb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 03:34:31 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59684 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfE2Heb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 03:34:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8YcPDsoJ9AlZynQLMk7bsSZmc9cD1uQb+EscSFuY5C4=; b=nYSePjc+xQwCKKYF/1cPtwRgX
        +/iGXIbgUVQy0XjGUrOEGbMtXccO2EwbGJKQlBrqo+rKB2l8MliklGmAUZjBw4Kd9jg1o5V6U2/5U
        4s1C38uvP8EgSXa3rkuKk4WUxHsNrlyRDljfr/4mnLqXTJjy/b08ec01BX1+hiynpAUroEB+L3DCb
        Q4SYmVf2/+bQN/ulwfxgFqH5B6Zkj/MK17jhzgfjRrXdbMqNW7uUqNkQ5b0JY8asTuDXqvjvC5bPS
        GgGsDWiIoNuke0+fhxl2Cp31ecf3+WnYwvO5W6z3EV0xI/xwdxXhW/YDjwoGwLb71Ll684WOxNuX2
        M9Zp0ra5Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVt6N-00029i-OJ; Wed, 29 May 2019 07:34:23 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5ECF6201A7E41; Wed, 29 May 2019 09:34:21 +0200 (CEST)
Date:   Wed, 29 May 2019 09:34:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     acme@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com
Subject: Re: [PATCH 4/9] perf/x86/intel: Support hardware TopDown metrics
Message-ID: <20190529073421.GZ2623@hirez.programming.kicks-ass.net>
References: <20190521214055.31060-1-kan.liang@linux.intel.com>
 <20190521214055.31060-5-kan.liang@linux.intel.com>
 <20190528133022.GX2606@hirez.programming.kicks-ass.net>
 <a3722bae-9506-21f0-7e6e-a85217313bf8@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3722bae-9506-21f0-7e6e-a85217313bf8@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 02:24:14PM -0400, Liang, Kan wrote:

> > > +		if (!(txn_flags & PERF_PMU_TXN_REMOVE)) {
> > > +			/* Reset the metric value when reading
> > > +			 * The SLOTS register must be reset when PERF_METRICS reset,
> > > +			 * otherwise PERF_METRICS may has wrong output.
> > > +			 */
> > 
> > broken comment style.. (and grammer)
> 
> Missed a full stop.
> Should be "Reset the metric value for each read."

s/may has wrong/may have wrong/

> > > +			wrmsrl(MSR_PERF_METRICS, 0);
> > > +			wrmsrl(MSR_CORE_PERF_FIXED_CTR3, 0);
> > 
> > I don't get this, overflow happens on when we flip sign, so why is
> > programming 0 a sane thing to do?
> 
> Reset the counters (programming 0) don't trigger overflow.

Right, so why then do you allow creating this thing as
is_sampling_event() ?

> We have to reset both registers for each read to avoid the known
> PERF_METRICS issue.

'the known PERF_METRICS issue' is unknown to me and any other reader.

> > > +	metric = (cpuc->last_metric >> ((hwc->idx - INTEL_PMC_IDX_FIXED_METRIC_BASE)*8)) & 0xff;
> > > +	last = (((metric * 0xffff) >> 8) * cpuc->last_slots) >> 16;
> > 
> > How is that cpuc->last_* crap not broken for NMIs ?
> 
> There should be no NMI for slots or metric events at the moment, because the
> MSR_PERF_METRICS and MSR_CORE_PERF_FIXED_CTR3 are reset in first read.
> Other NMIs will not touch the codes here.

What happens if someone does: read(perf_fd) and then has the NMI hit?
