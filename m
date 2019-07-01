Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A83C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 14:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE8442173E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 14:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WtVTo9Em"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbfGAOFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 10:05:13 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35486 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729294AbfGAOFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 10:05:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SotD5xDKU4tAQXDc312orTzyiKC6J1IO6NGGg0le4bM=; b=WtVTo9Em9Pu8gmifFDUAIT37b
        vcWRO1Kssa1aPIOcf/s/1IwKqmzznPjIajojzRLdV7Usylbqe6kxR3S6FZG4KxQdWxSxs7n+AK4lK
        1E1+KTlvd35g37f9qOh37+gtYxwOu79XifNjm7TRzoe9KptSYlo2A0X0vurGj5D85zn75ffm+lLlt
        enza0nWDc4d6eU61HQDPd5FrcVZdCAl53MUU6OV0libZZA51syAu8S21ixjyYSZcDjYMoug3qnKvE
        ICrIJSnP7quBALtKcZlt8zDeR/L2Hl+Bh4yMT37J7mMhqDaXa6QTzXFRrlQlJqW6uxzA5pJ8KZl7J
        Etk0Tv9xQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hhwv7-0008G4-L9; Mon, 01 Jul 2019 14:04:37 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 84A2A209C957E; Mon,  1 Jul 2019 16:04:34 +0200 (CEST)
Date:   Mon, 1 Jul 2019 16:04:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     subhra mazumdar <subhra.mazumdar@oracle.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        steven.sistare@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net, Paul Turner <pjt@google.com>,
        riel@surriel.com, morten.rasmussen@arm.com
Subject: Re: [RESEND PATCH v3 0/7] Improve scheduler scalability for fast path
Message-ID: <20190701140434.GW3402@hirez.programming.kicks-ass.net>
References: <20190627012919.4341-1-subhra.mazumdar@oracle.com>
 <20190701090204.GQ3402@hirez.programming.kicks-ass.net>
 <20190701135552.kb4os6bxxhh2lyw6@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701135552.kb4os6bxxhh2lyw6@e110439-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 02:55:52PM +0100, Patrick Bellasi wrote:
> On 01-Jul 11:02, Peter Zijlstra wrote:

> > Some of the things we could tie to this would be:
> > 
> >   - select_idle_siblings; -nice would scan more than +nice,
> 
> Just to be sure, you are not proposing to use the nice value we
> already have, i.e.
>   p->{static,normal}_prio
> but instead a new similar concept, right?

Correct; a new sched_attr::sched_latency_nice value, which is like
sched_nice, but controls a different dimmension of behaviour.
