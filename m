Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55705C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 12:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D06520674
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 12:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="axvw1+jA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbfLDMVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 07:21:00 -0500
Received: from merlin.infradead.org ([205.233.59.134]:60594 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbfLDMVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 07:21:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bZ2G9RFQdId9t/nc+tXoI4reqv5e4idr67b+Avs/qmw=; b=axvw1+jAhxanwUfVKyrWx1Igk
        qQe5Ghn61g81aWFEk2ciRjd1gmAXk0VX425dG5yPcm1JyKxxxArepnKZ6TyXITucIg2UTv86+EBK3
        8q9/plCgutlwZtML9Ys877k1CQtCcIQBmxtu+NDP/lTAQ/N5hUT+jnIPZT9IV+3mpEWS7M1BiClI+
        SPbA0G13R2VfKD3ZgJh2/2lOW5bzJT675x+wDvOFdI7ISRwNWfbYSj1wWl9WsJ68iqjLqEV5+RXqI
        u7qizqxz7aaieA+xUgJUtbS5eb37i0lhYozQxnrr7rEvBR+ztjpudf2tF0wniN0Z0X0HqJy1mfi34
        zoRolu8ZA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1icTeL-0006GJ-Ae; Wed, 04 Dec 2019 12:20:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3F7673006E3;
        Wed,  4 Dec 2019 13:19:38 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 048842B25FE23; Wed,  4 Dec 2019 13:20:54 +0100 (CET)
Date:   Wed, 4 Dec 2019 13:20:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] sched: Spare IPI on single task renice
Message-ID: <20191204122054.GS2844@hirez.programming.kicks-ass.net>
References: <20191203160106.18806-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191203160106.18806-1-frederic@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 05:01:04PM +0100, Frederic Weisbecker wrote:
> A couple of patches to avoid disturbing nohz_full CPUs when a single
> fair task get its priority changed. I should probably check other sched
> policies as well...

Yeah, auditing all that sounds like a good idea.

> Frederic Weisbecker (2):
>   sched: Spare resched IPI when prio changes on a single fair task
>   sched: Use fair:prio_changed() instead of ad-hoc implementation

These look good though, thanks!
