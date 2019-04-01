Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7057C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7292B2133F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qMKDBZ8G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfDAK34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 06:29:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51622 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfDAK3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 06:29:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=41F3UiH0MOsWq4gcbosqJBDESmjeiE7na5W2YEy5ivc=; b=qMKDBZ8G+aai/ngZPKoph7Uax
        pdwk43DBCPmADEgDDnxWasJaR+ppoN5cJqiCcdbVIi27fi7K8uO+KNUW7Mny/N0q4g+aobzz9WfGq
        0Rcaa6zWdrYd5cwovBArovMe5A1aSQPvTeG/q20s0d/yhbYwnR0C7F8MBm5ngxq6SDRireOEZ5uLt
        y6jAtWNmoK5HM9pxCIo+BIDRIphFni/+uvA5EmVj2rbupLZpPeYQEtLhfI9fmujuQUr5I8opk0Wzz
        TvkvTRshta0MdMeSWXZHIvuvAJaJWhPrDFlTysWwdGeCHLewMqKLdzrreQRENt4z/vTxs66cD9Am0
        6M59Nf+rw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hAuCM-0002Ts-Ph; Mon, 01 Apr 2019 10:29:50 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4D05E2026BE97; Mon,  1 Apr 2019 12:29:48 +0200 (CEST)
Date:   Mon, 1 Apr 2019 12:29:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Quentin Perret <quentin.perret@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: Re: [Update][PATCH v3 3/4] cpufreq: schedutil: Simplify iowait
 boosting
Message-ID: <20190401102948.GI11158@hirez.programming.kicks-ass.net>
References: <11953735.uMqeHy63Iu@aspire.rjw.lan>
 <2864116.v8IU97Resm@aspire.rjw.lan>
 <3714586.Xfz7sSM4fi@aspire.rjw.lan>
 <388546350.6JbkPPd9ra@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <388546350.6JbkPPd9ra@aspire.rjw.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 11:27:25AM +0200, Rafael J. Wysocki wrote:
> On Thursday, March 28, 2019 11:33:21 AM CEST Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > There is not reason for the minimum iowait boost value in the
> > schedutil cpufreq governor to depend on the available range of CPU
> > frequencies.  In fact, that dependency is generally confusing,
> > because it causes the iowait boost to behave somewhat differently
> > on CPUs with the same maximum frequency and different minimum
> > frequencies, for example.
> > 
> > For this reason, replace the min field in struct sugov_cpu
> > with a constant and choose its values to be 1/8 of
> > SCHED_CAPACITY_SCALE (for consistency with the intel_pstate
> > driver's internal governor).
> > 
> > [Note that policy->cpuinfo.max_freq will not be a constant any more
> >  after a subsequent change, so this change is depended on by it.]
> > 
> > Link: https://lore.kernel.org/lkml/20190305083202.GU32494@hirez.programming.kicks-ass.net/T/#ee20bdc98b7d89f6110c0d00e5c3ee8c2ced93c3d
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> Any more comments on this patch?

I obviously like it :-)

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> If not, I'll queue it up along with the rest of the series.

Thanks!
