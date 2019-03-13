Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A46FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 17:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDE5121019
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 17:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="djGLuI+a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfCMRWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 13:22:43 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50686 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfCMRWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 13:22:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zCMgs6brq8AkwCpETt9ZurpyQhRdFytZGG2OsW51ZwQ=; b=djGLuI+ay+BbtOrxkiTAyJEvY
        wbtPvkv8Tu48RhJb0JUr5eIHtPP80B9ZXgAsocgxFhZRvPKUWNZbfekesYjeNVJaHEZid+Xzf43ne
        iU2KfcNc7bMW1BOuZnjPYMFWKGteG5FF2cVXlQmJZJhVeaRY2mKsiQrZYz0/x7qAIBUZ4lRFfjS0C
        cIaOEaBYkUT8eeWkIzzdCTYfcHUDRAD+9RbYX4cGjHIw11sU1kor4+W++cgfJQqkGjAodY3GzwZpZ
        w2UVYv6yEmltYpg0ZBsykuQ1HFVr1/4B57T7P4w7rvC2K9rARJP7aX1WlwFYn+YmaQtATvbXZ9jDX
        TjPZnzphw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h47aG-0005PI-P4; Wed, 13 Mar 2019 17:22:29 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BF4CB20298BBF; Wed, 13 Mar 2019 18:22:25 +0100 (CET)
Date:   Wed, 13 Mar 2019 18:22:25 +0100
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
Message-ID: <20190313172225.GG5996@hirez.programming.kicks-ass.net>
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
> Yes, the for looks better, but perhaps like that:
> 
> 	unsigned int bucket_id = UCLAMP_BUCKETS;
> 
>  	/*
>  	 * Both min and max clamps are MAX aggregated, thus the topmost
>  	 * bucket with some tasks defines the rq's clamp value.
>  	 */
> 	for (; bucket_id >= 0; --bucket_id) {

GCC will be clever and figure that unsigned will never be smaller than 0
and turn the above into an infinite loop or something daft.

That is; use 'int', not 'unsigned int' for bucket_id.
