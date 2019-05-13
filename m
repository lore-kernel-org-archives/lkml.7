Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6EAC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C6A52070D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A1fzvHen"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbfEMLf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 07:35:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51734 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbfEMLf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 07:35:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0jKHovWkj7cxIrQ0X5J93JzH+HcvbEjnDPDSVCLfbu0=; b=A1fzvHenWBFJTS5Js0S8GC2ip
        2ijSnUjcwuRiy+YDeghv0WkTfiiQ8yglpfr7Dxp94Oi9X2BFQ/lubsruO1ywjbdF8J2dtAJe51n6D
        BUHyEEtdJLb3/sGvv1RVC2zbtCtUzAspFX0dFZTzwaoHdUN9iBZ+mkBSSrs2RJCin2iKLLRcijHU8
        ox3NqupE6nOmjFsA+ztnAu3XpE5i/jPmfjifXA242Q6oyxllO/RvcZ2Vlb1vNVj3BdjtRj8GyJn1v
        hNyTOmxQfewaVH0yBWll7rOmiuZYjZm9wNXdo9cqx7Bl+w+m6HWv95Til0hJA99rEUsoZOq8uUPxC
        B9fC2BYeQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQ9En-0003v1-2u; Mon, 13 May 2019 11:35:21 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 410592029F87D; Mon, 13 May 2019 13:35:18 +0200 (CEST)
Date:   Mon, 13 May 2019 13:35:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     songliubraving@fb.com, Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, tkjos@google.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        quentin.perret@linaro.org, chris.redpath@arm.com,
        Dietmar.Eggemann@arm.com, linux-kernel@vger.kernel.org,
        steven.sistare@oracle.com
Subject: Re: [RFC V2 2/2] sched/fair: Fallback to sched-idle CPU if idle CPU
 isn't found
Message-ID: <20190513113518.GQ2623@hirez.programming.kicks-ass.net>
References: <cover.1556182964.git.viresh.kumar@linaro.org>
 <59b37c56b8fcb834f7d3234e776eaeff74ad117f.1556182965.git.viresh.kumar@linaro.org>
 <20190510072125.GG2623@hirez.programming.kicks-ass.net>
 <20190513093418.altqhlhu4zsu75t4@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513093418.altqhlhu4zsu75t4@vireshk-i7>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 03:04:18PM +0530, Viresh Kumar wrote:
> On 10-05-19, 09:21, Peter Zijlstra wrote:

> > I don't hate his per se; but the whole select_idle_sibling() thing is
> > something that needs looking at.
> > 
> > There was the task stealing thing from Steve that looked interesting and
> > that would render your apporach unfeasible.
> 
> I am surely missing something as I don't see how that patchset will
> make this patchset perform badly, than what it already does.

Nah; I just misremembered. I know Oracle has a patch set poking at
select_idle_siblings() _somewhere_ (as do I), and I just found the wrong
one.

Basically everybody is complaining select_idle_sibling() is too
expensive for checking the entire LLC domain, except for FB (and thus
likely some other workloads too) that depend on it to kill their tail
latency.

But I suppose we could still do this, even if we scan only a subset of
the LLC, just keep track of the last !idle CPU running only SCHED_IDLE
tasks and pick that if you do not (in your limited scan) find a better
candidate.


