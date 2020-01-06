Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98356C2D0D1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 10:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A64320731
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 10:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N+nS18zn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgAFKYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 05:24:09 -0500
Received: from merlin.infradead.org ([205.233.59.134]:40382 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgAFKYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 05:24:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=g9YBz3F+B0vv6Z8r9xsyYIVGQYxQAbmF8Qb3K4NcA+A=; b=N+nS18znWKjmEYLgGbzrCg9tz
        IdcDn2h6JdIpBdWF0v5ZMOARbrN8br+d5EgzsfVfg1p3Ft9o4pW0UUvEssCtYXPegMTfUHF6oqq3P
        cMZdCUjLiWIvEzE/10F/tB8kG7TlFkQbJtyv7tgFJakLatFSio3Z6hKF01fSFf9ugR7I8TTXkONzE
        fWvApuW+voFa+eGzPLjzsyc9o7QDIhICoMTP3fsaOZ47XWrotAYMSvEplsimQEUUdHmZdR476wfgm
        y8YT7R95ZDt8OikrwOJzzZKgAnWrYzLxxQEJJ/rHZ+IL473lsq8eoLNpg+ZdW1F/dovgZSlm+Grmf
        FNbc592Yw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ioPY0-0000tu-Dv; Mon, 06 Jan 2020 10:23:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5E54B306CEE;
        Mon,  6 Jan 2020 11:22:09 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5D9DA2B627478; Mon,  6 Jan 2020 11:23:41 +0100 (CET)
Date:   Mon, 6 Jan 2020 11:23:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peng Liu <iwtbavbm@gmail.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, qais.yousef@arm.com, morten.rasmussen@arm.com,
        valentin.schneider@arm.com
Subject: Re: [PATCH v2] sched/fair: fix sgc->{min,max}_capacity miscalculate
Message-ID: <20200106102341.GM2810@hirez.programming.kicks-ass.net>
References: <20200104130828.GA7718@iZj6chx1xj0e0buvshuecpZ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200104130828.GA7718@iZj6chx1xj0e0buvshuecpZ>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 04, 2020 at 09:08:28PM +0800, Peng Liu wrote:
> commit bf475ce0a3dd ("sched/fair: Add per-CPU min capacity to
> sched_group_capacity") introduced per-cpu min_capacity.
> 
> commit e3d6d0cb66f2 ("sched/fair: Add sched_group per-CPU max capacity")
> introduced per-cpu max_capacity.
> 
> Here, capacity is the accumulated sum of (maybe) many CPUs' capacity.
> Compare with capacity to get {min,max}_capacity makes no sense. Instead,
> we should compare one by one in each iteration to get
> sgc->{min,max}_capacity of the group.
> 
> Also, the only CPU in rq->sd->groups should be rq's CPU. Thus,
> capacity_of(cpu_of(rq)) should be equal to rq->sd->groups->sgc->capacity.
> Code can be simplified by removing the if/else.
> 
> Signed-off-by: Peng Liu <iwtbavbm@gmail.com>
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
> v1: https://lkml.org/lkml/2019/12/30/502

Please (for future use); use the form:

  https://lkml.kernel.org/r/$msgid

