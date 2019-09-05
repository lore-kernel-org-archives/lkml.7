Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74707C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 11:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45DBF2070C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 11:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kST9Skas"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388460AbfIELaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 07:30:13 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41174 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbfIELaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 07:30:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3Z6GGxQtw6kGZ90rRUAsKRrfp8SLjkfWxpfQA5HECNQ=; b=kST9SkasBfRkvNAy3jwGSEqAx
        L5hV5CM0qO23/QJaoYSxUxpqMwhdekI9KbVAvA3Q3J+LOMm6kjJf0t+4RQP0yxfp/J1v1Irv7p20L
        JU15zzpLAoEiiP/7USl6oOLXMdnYwFAz2UsKeP/b8pvcQOW8izmbSYkTbk4DXe3sel3WoDhE8R0Of
        9KXIolpsXvHQjfhOeCT9kvsEJEqaN8rMbZyADLjSJ2I2tlfzZ7qfgLEnGSG/HmzjHCs0aTguKxmOl
        dR7dQMuSw88uIJHMEOx2pLmtfHbKcN9xgJfpxa/gdCymyCSUGNtJkyr2sXlABmPKFWZghNOT5gcpp
        jIRvB213A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i5pxk-0006sr-BV; Thu, 05 Sep 2019 11:30:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 549A4305E47;
        Thu,  5 Sep 2019 13:29:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4B6E829CBE121; Thu,  5 Sep 2019 13:30:02 +0200 (CEST)
Date:   Thu, 5 Sep 2019 13:30:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Patrick Bellasi <patrick.bellasi@arm.com>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        steven.sistare@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net, parth@linux.ibm.com
Subject: Re: [RFC PATCH 1/9] sched,cgroup: Add interface for latency-nice
Message-ID: <20190905113002.GK2349@hirez.programming.kicks-ass.net>
References: <20190830174944.21741-1-subhra.mazumdar@oracle.com>
 <20190830174944.21741-2-subhra.mazumdar@oracle.com>
 <20190905083127.GA2332@hirez.programming.kicks-ass.net>
 <87r24v2i14.fsf@arm.com>
 <20190905104616.GD2332@hirez.programming.kicks-ass.net>
 <20190905111346.2w6kuqrdvaqvgilu@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905111346.2w6kuqrdvaqvgilu@e107158-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 12:13:47PM +0100, Qais Yousef wrote:
> On 09/05/19 12:46, Peter Zijlstra wrote:

> > This is important because we want to be able to bias towards less
> > importance to (tail) latency as well as more importantance to (tail)
> > latency.
> > 
> > Specifically, Oracle wants to sacrifice (some) latency for throughput.
> > Facebook OTOH seems to want to sacrifice (some) throughput for latency.
> 
> Another use case I'm considering is using latency-nice to prefer an idle CPU if
> latency-nice is set otherwise go for the most energy efficient CPU.
> 
> Ie: sacrifice (some) energy for latency.
> 
> The way I see interpreting latency-nice here as a binary switch. But
> maybe we can use the range to select what (some) energy to sacrifice
> mean here. Hmmm.

It cannot be binary, per definition is must be ternary, that is, <0, ==0
and >0 (or middle value if you're of that persuasion).

In your case, I'm thinking you mean >0, we want to lower the latency.

Anyway; there were a number of things mentioned at OSPM that we could
tie into this thing and finding sensible mappings is going to be a bit
of trial and error I suppose.

But as patrick said; we're very much exporting a BIAS knob, not a set of
behaviours.
