Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663C3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 13:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 261BA2085A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 13:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fPiqwMEJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfCNNcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 09:32:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53686 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfCNNcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 09:32:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=me9XAScX3Sm48pBYcWYgWkzLnZV4XsP5v0fkWo6mMwA=; b=fPiqwMEJuesXB6h7Ld2c+MXUL
        XJYM/3Vx6T/rNMdg5T6CKAA4LeI+HBmbR/aFW5Uw18awzeh/KNh7Hl/BwoLhjdHQhiVGp88tGcsOL
        UFj/+8t9/X0njxp+oIKelFaonoDceD1e8Y1F0SwhKpyqo+90aTKW2we2ku2EAtDSnNQcJf1o39gOe
        UN6IdEDPVHEFa5s9efAN2oIWVE/ltGNmVJ5ZqMh1AJf9x4wlC9Db5RHxiPQYxCVj34cV46QORM+5L
        1c0j+AS+OcSY44Q5rJ66nDCUXsV6pHzbWovoEdIfd4K5MZBn6HHbjpliwRbdKODnl3RxyOg4fEjGk
        W78HAqShA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h4QSy-00065s-TR; Thu, 14 Mar 2019 13:32:13 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 68FAD203E5149; Thu, 14 Mar 2019 14:32:11 +0100 (CET)
Date:   Thu, 14 Mar 2019 14:32:11 +0100
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
Message-ID: <20190314133211.GJ5996@hirez.programming.kicks-ass.net>
References: <20190208100554.32196-1-patrick.bellasi@arm.com>
 <20190208100554.32196-2-patrick.bellasi@arm.com>
 <20190313134022.GB5922@hirez.programming.kicks-ass.net>
 <20190313161229.pkib2tmjass5chtb@e110439-lin>
 <20190313194838.GS2482@worktop.programming.kicks-ass.net>
 <20190314121315.juqpsqu5cwouuqpp@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190314121315.juqpsqu5cwouuqpp@e110439-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 12:13:15PM +0000, Patrick Bellasi wrote:
> > I'd be most impressed if they pull this off. Check the generated code
> > and see I suppose :-)
> 
> On x86 the code generated looks exactly the same:
> 
>    https://godbolt.org/z/PjmA7k

Argh, they do mult by inverse to avoid the division, and can do this
because its a constant.

And then yes, your arm version looks worse.

It does what I expected with -Os, but as Rutland said the other day,
that stands for Optimize for Sadness.
