Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FE0C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 12:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A3C24679
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 12:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kGleREul"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfLTMUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 07:20:06 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48508 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727209AbfLTMUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 07:20:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=R5Zw3DDJm4ULPliPYUAssjzZ7w7pMoy4+U0VF7anJkg=; b=kGleREul1+TOIzHsXgqHZ4Cbq
        4MeHJK5OCxVpyeUhcrn4CWbXjCzzGTXNYQmilD7zoJVZs2mlZ+++cSHPzBI73i9aDHhRjONctFEsT
        /VW6qnZo1P8/l5b+cU+nB+zxwjnAWy6svrA3N/QHZQotSX3ahFyfe3RQbJhB4uotDaqG7FWxgQdwK
        BZIN/8nCFvnv1iqS5ZcLLw66PHJNQlh53yIqPDCv800XrVXKZH3ehTze5Xt2dFWEJTSUudSYHPHRH
        LBV2u4nm8Qco5AwB9aVQrWj3p+g/ZFQ/9fj4LSQJNheTcNBqGe1yQVMU4XdjpMeHSfe1oAhe8OwfF
        I+egC4T4g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iiHG1-0005GX-Fr; Fri, 20 Dec 2019 12:19:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 82D67300DB7;
        Fri, 20 Dec 2019 13:18:23 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6D4702B270F5D; Fri, 20 Dec 2019 13:19:47 +0100 (CET)
Date:   Fri, 20 Dec 2019 13:19:47 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Kirill Tkhai <tkhai@yandex.ru>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC][PATCH 1/4] sched: Force the address order of each sched
 class descriptor
Message-ID: <20191220121947.GH2844@hirez.programming.kicks-ass.net>
References: <20191219214451.340746474@goodmis.org>
 <20191219214558.510271353@goodmis.org>
 <0a957e8d-7af8-613c-11ae-f51b9b241eb7@rasmusvillemoes.dk>
 <20191220100033.GE2844@hirez.programming.kicks-ass.net>
 <1ac359e8-fa7f-7ded-e2f2-9f7d0b23a4e1@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ac359e8-fa7f-7ded-e2f2-9f7d0b23a4e1@rasmusvillemoes.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 11:12:37AM +0100, Rasmus Villemoes wrote:
> On 20/12/2019 11.00, Peter Zijlstra wrote:

> >>> +/*
> >>> + * The order of the sched class addresses are important, as they are
> >>> + * used to determine the order of the priority of each sched class in
> >>> + * relation to each other.
> >>> + */
> >>> +#define SCHED_DATA				\
> >>> +	*(__idle_sched_class)			\
> >>> +	*(__fair_sched_class)			\
> >>> +	*(__rt_sched_class)			\
> >>> +	*(__dl_sched_class)			\
> >>> +	STOP_SCHED_CLASS
> > 
> > I'm confused, why does that STOP_SCHED_CLASS need magic here at all?
> > Doesn't the linker deal with empty sections already by making them 0
> > sized?
> 
> Yes, but dropping the STOP_SCHED_CLASS define doesn't prevent one from
> needing some ifdeffery to define highest_sched_class if they are laid
> out in (higher sched class <-> higher address) order.

Would not something like:

	__begin_sched_classes = .;
	*(__idle_sched_class)
	*(__fair_sched_class)
	*(__rt_sched_class)
	*(__dl_sched_class)
	*(__stop_sched_class)
	__end_sched_classes = .;

combined with something like:

extern struct sched_class *__begin_sched_classes;
extern struct sched_class *__end_sched_classes;

#define sched_class_highest (__end_sched_classes - 1)
#define sched_class_lowest  (__begin_sched_classes - 1)

#define for_class_range(class, _from, _to) \
	for (class = (_from); class != (_to), class--)

#define for_each_class(class) \
	for_class_range(class, sched_class_highest, sched_class_lowest)

just work?

When no __stop_sched_class is present, that section is 0 sized, and
__end_sched_classes points to one past __dl_sched_class, no?
