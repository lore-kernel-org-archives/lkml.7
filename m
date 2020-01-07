Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD17C33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 12:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CB1C2072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 12:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Lu63eo78"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgAGMaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 07:30:00 -0500
Received: from merlin.infradead.org ([205.233.59.134]:50072 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgAGM37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 07:29:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IWIyXi1gVFEl0mksTr1DghHX8bjTId6K8sb/e1hCsoI=; b=Lu63eo78KESL7seVds7fAyKJU
        nlnGG6LCkIvdUqHTKiAhrR9RCnOqOvH+xAtR3788pxZOW2kPyIXRpRYYlfkLWJSQH1lUg3SW1qmiD
        SAsdb+SlfsvRg+8f9eYqw3PjBBn/BCGwIAA/NP3ub43a8YbyEuXXECkis77vD8lH10q92+5cXG5Zr
        piAN/YWa/i9y63EE74bS1wEtyt+4XCNJi7YJYJscf11lTUQUosDE9/s+RzNJxrdOwCDImAB34YTcW
        VKZRXYDKWF60DvfjKGiHDAfnWbm7Fv47W9YIMnbHSZppZySMgSVy575Em6c1gqEP+S8plC/D6UAK5
        tZ4EnShVw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ionzW-0006QS-EV; Tue, 07 Jan 2020 12:29:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0742A300693;
        Tue,  7 Jan 2020 13:28:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8FA8A2B48237D; Tue,  7 Jan 2020 13:29:43 +0100 (CET)
Date:   Tue, 7 Jan 2020 13:29:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        Parth Shah <parth@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched, fair: Allow a small degree of load imbalance
 between SD_NUMA domains v2
Message-ID: <20200107122943.GW2827@hirez.programming.kicks-ass.net>
References: <20191220084252.GL3178@techsingularity.net>
 <CAKfTPtDp624geHEnPmHki70L=ZrBuz6zJG3zW0VFy+_S064Etw@mail.gmail.com>
 <20200103143051.GA3027@techsingularity.net>
 <CAKfTPtCGm7-mq3duxi=ugy+mn=Yutw6w9c35+cSHK8aZn7rzNQ@mail.gmail.com>
 <20200106145225.GB3466@techsingularity.net>
 <CAKfTPtBa74nd4VP3+7V51Jv=-UpqNyEocyTzMYwjopCgfWPSXg@mail.gmail.com>
 <20200107095655.GF3466@techsingularity.net>
 <20200107112255.GV2827@hirez.programming.kicks-ass.net>
 <20200107114211.GH3466@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107114211.GH3466@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 11:42:11AM +0000, Mel Gorman wrote:
> On Tue, Jan 07, 2020 at 12:22:55PM +0100, Peter Zijlstra wrote:

> > > +		/* Consider allowing a small imbalance between NUMA groups */
> > > +		if (env->sd->flags & SD_NUMA) {
> > > +			struct sched_domain *child = env->sd->child;
> > 
> > This assumes sd-child exists, which should be true for NUMA domains I
> > suppose.
> > 
> 
> I would be stunned if it was not. What sort of NUMA domain would not have
> child domains? Does a memory-only NUMA node with no CPUs even generate
> a scheduler domain? If it does, then I guess the check is necessary.

I think it's fine, it was just my paranoia triggering. At the very least
we'll have the single CPU domain there.
