Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0471FC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B2720C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ptp7kkvT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730471AbfHFNDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 09:03:42 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59766 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfHFNDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 09:03:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jwyUMBVjiYnUmvqz+giwj5r280EW828xGRYTzfWaN3w=; b=ptp7kkvTn803t1ObiCaymhOJp
        biPQk0rsgodiwdHrCK32q17oPe+aNX6zEYN7WKjNyHu2gRXRiMJ8QThBRkl3tvV6NE4UFWLeIBRDG
        u4MQw5puHNHMdPKcMiEw0/0xVqj6hl5tvx5tav12tOV0GGAmqfnfc9/0dQmDFV053jfZytr7uSfJb
        2If11HHO5wMhNo9Hx0+3qKov9WbDLTErhMw8izm3NttZdJbXgS3pH3ZkTPxFvLdJKnXIi1AkzTmw8
        7Gqa6pouUNitaQ/EcTNpFmu1btxio+8tdAjr+gIiXu5NTYovqt3g/BCt4sln5nSTHYMh3xBCSKDHl
        HyWaO925g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1huz7o-0002jB-Tv; Tue, 06 Aug 2019 13:03:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DE9FA3067E2;
        Tue,  6 Aug 2019 15:03:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 42FDA201B6A97; Tue,  6 Aug 2019 15:03:34 +0200 (CEST)
Date:   Tue, 6 Aug 2019 15:03:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Phil Auld <pauld@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched: use rq_lock/unlock in online_fair_sched_group
Message-ID: <20190806130334.GO2349@hirez.programming.kicks-ass.net>
References: <20190801133749.11033-1-pauld@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801133749.11033-1-pauld@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 09:37:49AM -0400, Phil Auld wrote:
> Enabling WARN_DOUBLE_CLOCK in /sys/kernel/debug/sched_features causes

ISTR there were more issues; but it sure is good to start picking them
off.

> warning to fire in update_rq_clock. This seems to be caused by onlining
> a new fair sched group not using the rq lock wrappers.
> 
> [472978.683085] rq->clock_update_flags & RQCF_UPDATED
> [472978.683100] WARNING: CPU: 5 PID: 54385 at kernel/sched/core.c:210 update_rq_clock+0xec/0x150

> Using the wrappers in online_fair_sched_group instead of the raw locking 
> removes this warning. 

Yeah, that seems sane. Thanks!
