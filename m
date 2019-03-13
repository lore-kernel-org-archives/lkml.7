Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1710C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 993282171F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QlznlU3D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfCMTss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:48:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40898 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbfCMTss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:48:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=V6lzSncR4c6/O8KiDJNk5Af5QmZYSSOITe6zHzShbrQ=; b=QlznlU3DHxAKi03ReeJvSzNRm
        MJDAtP4DEBL0AAkP3gWjpjyNoiHsmEcbw37COEAheAYGThD0KAsiNER2YrF8tNOaDen7Ktitdd3Lf
        fEBAoMpGi9TrTFWBh02LqR+T1sn8QUOk22EEm/UyQXxJx54KGHS3iKPVcLGC91HgLlD3XUl5ziOHd
        OL9/xPWcGvNLtOLUD3Z8k6hGPbOhVffd3YZhYTlVNmlm5H5GMrHb3dEJXrLxLNayGsosPW/weA5ON
        q6+bx7S18yQEqKiJ5q3zXYB01dgNL1x6HtU2pDeJ2cGUPOkW2YyN26NwiifKWXhoD/ApdnmehG6hP
        yb0D1RFjw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h49rm-0002N0-06; Wed, 13 Mar 2019 19:48:42 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id EF2569826C0; Wed, 13 Mar 2019 20:48:38 +0100 (CET)
Date:   Wed, 13 Mar 2019 20:48:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v7 01/15] sched/core: uclamp: Add CPU's clamp buckets
 refcounting
Message-ID: <20190313194838.GS2482@worktop.programming.kicks-ass.net>
References: <20190208100554.32196-1-patrick.bellasi@arm.com>
 <20190208100554.32196-2-patrick.bellasi@arm.com>
 <20190313134022.GB5922@hirez.programming.kicks-ass.net>
 <20190313161229.pkib2tmjass5chtb@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313161229.pkib2tmjass5chtb@e110439-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 04:12:29PM +0000, Patrick Bellasi wrote:
> On 13-Mar 14:40, Peter Zijlstra wrote:
> > On Fri, Feb 08, 2019 at 10:05:40AM +0000, Patrick Bellasi wrote:
> > > +static inline unsigned int uclamp_bucket_id(unsigned int clamp_value)
> > > +{
> > > +	return clamp_value / UCLAMP_BUCKET_DELTA;
> > > +}
> > > +
> > > +static inline unsigned int uclamp_bucket_value(unsigned int clamp_value)
> > > +{
> > > +	return UCLAMP_BUCKET_DELTA * uclamp_bucket_id(clamp_value);
> > 
> > 	return clamp_value - (clamp_value % UCLAMP_BUCKET_DELTA);
> > 
> > might generate better code; just a single division, instead of a div and
> > mult.
> 
> Wondering if compilers cannot do these optimizations... but yes, looks
> cool and will do it in v8, thanks.

I'd be most impressed if they pull this off. Check the generated code
and see I suppose :-)
