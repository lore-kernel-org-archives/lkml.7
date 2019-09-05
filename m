Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26EDBC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 11:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF6BA22CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 11:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rnhMtwdD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733252AbfIELrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 07:47:22 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38212 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730780AbfIELrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 07:47:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wCf+8T9FwWLVElgSE2buhC9xG+AjGiAQMHH/+zCWqL4=; b=rnhMtwdD7GHMrK3Kzf0HiydsM
        M/IMsl5QMdPZJ5FAkwVpwZt6jf3xBitErWSZs7CK7lywSx1dxipp1An20/GWKZ6sSjrooEnDlr8dp
        eMRROklD0+x7lQu4PwSRnfxRsXSs00JNN/s0KyDLC18Siy53pYa2VJuUXwfx1BDefLTzsfdjzbj+a
        TVFzYb5zKEdqwIQ3Z4/YVYug4xUvjGhWV4zhkaWIol2mEXK0S1SnhBvFmvByedU313g6BZAAFugf0
        oohw9OBSZu0R5EoSz3+yTSJ9uF6LvjlEbvYo+bsG4xI01i88wX1yGL2aQ0iPDMtuL09PPbTj0/srB
        8wwgpfyqw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i5qEJ-0000nr-No; Thu, 05 Sep 2019 11:47:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E654F3011DF;
        Thu,  5 Sep 2019 13:46:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E608229CBE15F; Thu,  5 Sep 2019 13:47:09 +0200 (CEST)
Date:   Thu, 5 Sep 2019 13:47:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        steven.sistare@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net, parth@linux.ibm.com
Subject: Re: [RFC PATCH 1/9] sched,cgroup: Add interface for latency-nice
Message-ID: <20190905114709.GM2349@hirez.programming.kicks-ass.net>
References: <20190830174944.21741-1-subhra.mazumdar@oracle.com>
 <20190830174944.21741-2-subhra.mazumdar@oracle.com>
 <20190905083127.GA2332@hirez.programming.kicks-ass.net>
 <87r24v2i14.fsf@arm.com>
 <20190905104616.GD2332@hirez.programming.kicks-ass.net>
 <20190905111346.2w6kuqrdvaqvgilu@e107158-lin.cambridge.arm.com>
 <87h85r2d5f.fsf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h85r2d5f.fsf@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 12:30:52PM +0100, Patrick Bellasi wrote:

> I see this concept possibly evolving into something more then just a
> binary switch. Not yet convinced if it make sense and/or it's possible
> but, in principle, I was thinking about these possible usages for CFS
> tasks:
> 
>  - dynamically tune the policy of a task among SCHED_{OTHER,BATCH,IDLE}
>    depending on crossing certain pre-configured threshold of latency
>    niceness.

A big part of BATCH is wakeup preemption (batch doesn't preempt itself),
and wakeup preemption is a task-task propery and can thus be completely
relative.

>  - dynamically bias the vruntime updates we do in place_entity()
>    depending on the actual latency niceness of a task.

That is dangerous; theory says we should keep track of the 0-lag point
and place it back where we found it. BFQ does this correctly IIRC, but
for CFS I've never done that because 'expensive'.

But yes, we could (carefully) fumble a bit there.

>  - bias the decisions we take in check_preempt_tick() still depending
>    on a relative comparison of the current and wakeup task latency
>    niceness values.

Ack.

Placing relative and absolute behaviour on the same scale is going to be
'fun' :-)
