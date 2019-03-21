Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCFAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93268218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="v5vZeLwa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbfCUSBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:01:43 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37836 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfCUSBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:01:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ke9qxFkY69QDxU8ffO9m9AJA7gLz6EqzY+9IUjLcd7Q=; b=v5vZeLwa6dKKS49o1eS1J4Lz2
        v0O/iCEP3qxWr/oVhvHZHExn9hAjnHx1opPOM6W/IkUd6sX7P5d+9FaekcLbdXBaWv/XcWhmu9vk0
        LL8jREDHLB0syEqhXmqWuyYzJtli5gAVdrJB1wMztU7c8FJUP4ehzeaS09q6GBRvs85goip3Xb2fc
        Ycoz9dHvaGQ9hcjKZCZ/BNDBvn/KrJ6/A2mXpwtFJ3EDBpUNqIqctb+9BXdIu0g27xHyJFbQJjvDd
        SQ1oPGCBYJm1rtT7l3slVzKVrxVi7cord0DkUEYx/iwwQIR/IXB72eG1ZCEro3VOpxC68ZGdaBv42
        QHpCqYFqQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h720Y-0001SX-OE; Thu, 21 Mar 2019 18:01:38 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 783A6203CBE1E; Thu, 21 Mar 2019 19:01:37 +0100 (CET)
Date:   Thu, 21 Mar 2019 19:01:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Phil Auld <pauld@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Ben Segall <bsegall@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Anton Blanchard <anton@ozlabs.org>
Subject: Re: [PATCH v2] sched/fair: Limit sched_cfs_period_timer loop to
 avoid hard lockup
Message-ID: <20190321180137.GQ6058@hirez.programming.kicks-ass.net>
References: <20190319130005.25492-1-pauld@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319130005.25492-1-pauld@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 09:00:05AM -0400, Phil Auld wrote:
> sched/fair: Limit sched_cfs_period_timer loop to avoid hard lockup
> 
> With extremely short cfs_period_us setting on a parent task group with a large
> number of children the for loop in sched_cfs_period_timer can run until the
> watchdog fires. There is no guarantee that the call to hrtimer_forward_now()
> will ever return 0.  The large number of children can make
> do_sched_cfs_period_timer() take longer than the period.

> 
> To prevent this we add protection to the loop that detects when the loop has run
> too many times and scales the period and quota up, proportionally, so that the timer
> can complete before then next period expires.  This preserves the relative runtime
> quota while preventing the hard lockup.
> 
> A warning is issued reporting this state and the new values.
> 
> v2: Math reworked/simplified by Peter Zijlstra.
> 
> Signed-off-by: Phil Auld <pauld@redhat.com>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Anton Blanchard <anton@ozlabs.org>

Thanks!
