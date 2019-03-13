Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDA4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 08:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D96A42184C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 08:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GBZEQLDS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfCMIUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 04:20:20 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44254 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfCMIUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 04:20:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ENirkpHLaDHbwhuX8Tw5Q/hr/4fSZUenQgyhRnch7CE=; b=GBZEQLDSEzGSelcl5Njcsq1ui
        Zm82Jqjv+Ed1Ly6BUGXO2vXVpfJQnfaZHj7eIMlIcVdH0MlRNtCO+v25PHWIpBc4R2GxztvurVoYJ
        o2ORMJq3mvP1PjNOWBJsQyreZ2IvN8Wu/84zBSTc36QozkLsnU7RhvTJgr+5GL7AiO146M/bDe/+K
        gcIDg2BJn1Qnm37MoG2LaZZOeZpIIv0nhrjRu/ymHYHu96fqB8nqUqDptdgzjCXttDWYsfra3C3uC
        rFwSDASrdC/V5/nhYefyAgAWW7of9CV49RAqktC5IjE60xUI1DDlnwU9ik9fZx2TDPAy0pa/LAXsb
        k+sHMqfHA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h3z7K-0006uA-LP; Wed, 13 Mar 2019 08:20:02 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 390E42011D47D; Wed, 13 Mar 2019 09:19:58 +0100 (CET)
Date:   Wed, 13 Mar 2019 09:19:58 +0100
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
Message-ID: <20190313081958.GA5996@hirez.programming.kicks-ass.net>
References: <20190208100554.32196-1-patrick.bellasi@arm.com>
 <20190208100554.32196-2-patrick.bellasi@arm.com>
 <20190312152059.GA5922@hirez.programming.kicks-ass.net>
 <20190312155043.vj3fiutnsovjti2x@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312155043.vj3fiutnsovjti2x@e110439-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 03:50:43PM +0000, Patrick Bellasi wrote:
> On 12-Mar 16:20, Peter Zijlstra wrote:
> > On Fri, Feb 08, 2019 at 10:05:40AM +0000, Patrick Bellasi wrote:
> > > +/* Integer ceil-rounded range for each bucket */

          ^^^^^^^^^^^^^^^^^^^^^^^^^^^

> > > +#define UCLAMP_BUCKET_DELTA ((SCHED_CAPACITY_SCALE / UCLAMP_BUCKETS) + 1)

                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

simply do not match.

> > Uhm, should that not me ((x+y-1)/y), aka. DIV_ROUND_UP(x,y) ?
> 
> Well, there is certainly some rounding to be done...
> 
> > The above would give 4 for 9/3, which is clearly buggered.
> 
> .. still the math above should work fine within the boundaries we
> define for UCLAMP_BUCKET_DELTA (5..20 groups) and considering that
> SCHED_CAPACITY_SCALE will never be smaller then 1024.

That's a very poor reason to write utter nonsense :-)

> The above is designed to shrink the topmost bucket wrt all the others
> but it will never be smaller than ~30%.

30% sounds like a lot, esp. for this range.

> Here are the start values computed for each bucket using the math
> above and the computed shrinking percentage for the topmost bucket:

If you use a regular rounding, the error is _much_ smaller:

$ for ((x=5;x<21;x++)) ; do let d=(1024+x/2)/x; let s=(x-1)*d; let e=1024-s; let p=100*(d-e)/d; echo $x $d $s $e $p%; done
5 205 820 204 0%
6 171 855 169 1%
7 146 876 148 -1%
8 128 896 128 0%
9 114 912 112 1%
10 102 918 106 -3%
11 93 930 94 -1%
12 85 935 89 -4%
13 79 948 76 3%
14 73 949 75 -2%
15 68 952 72 -5%
16 64 960 64 0%
17 60 960 64 -6%
18 57 969 55 3%
19 54 972 52 3%
20 51 969 55 -7%

Funnily enough, we have a helper for that too: DIV_ROUND_CLOSEST().

Now, if we go further, the error will obviously increase because we run
out of precision, but even there, regular rounding will be better than
either floor or ceil.
