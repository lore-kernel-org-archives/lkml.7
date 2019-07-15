Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D95C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 10:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC2222064B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 10:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n6DIUMaE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729775AbfGOKsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 06:48:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54668 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729530AbfGOKsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 06:48:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZemKervWq2l2BB1otVFe5CqPcuYhkJ4NM1DzWiilUIY=; b=n6DIUMaEYEDbWWXegK8JoQGDP
        RvkPw8nYDBPdfmzwsFlvZqDoD+pcoQhCLpAQ4IexF53gMoLunr5mL0esa3zArK3Z0H39zCBrHhZLr
        P/conJ9pwu1I6guf5iy/9PHoZOKTRFmv5zY75B8D69S95KfFhf14OAiiJ/LyRhbPzV2e+ppUj8QdK
        yjKAiCwvVVa1dkQ6YxEu4HMvGsgDR0VsKHv3qv+qDz62yZEMame195cNyk9m7Ua78GMhxQIaB4u0c
        7KEstn0p//fsi2Tn6Hb/Yorus9KwWk76ZWpqcTlDYvpZJYehcQOM4RsPTwJudV80cCVZMUGZL6Xf1
        3EbpNmY+g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hmyX1-0001c8-1t; Mon, 15 Jul 2019 10:48:31 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A0F2A20144522; Mon, 15 Jul 2019 12:48:28 +0200 (CEST)
Date:   Mon, 15 Jul 2019 12:48:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, mgorman@suse.de,
        riel@surriel.com
Subject: Re: [PATCH 0/3] sched/fair: Init NUMA task_work in sched_fork()
Message-ID: <20190715104828.GD3419@hirez.programming.kicks-ass.net>
References: <20190715102508.32434-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715102508.32434-1-valentin.schneider@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 11:25:05AM +0100, Valentin Schneider wrote:
> A TODO has been sitting in task_tick_numa() regarding init'ing the
> task_numa_work() task_work in sched_fork() rather than in task_tick_numa(),
> so I figured I'd have a go at it.
> 
> Patches 1 & 2 do that, and patch 3 is a freebie cleanup.
> 
> Briefly tested on a 2 * (Xeon E5-2690) system, didn't see any obvious
> breakage.
> 
> Valentin Schneider (3):
>   sched/fair: Move init_numa_balancing() below task_numa_work()
>   sched/fair: Move task_numa_work() init to init_numa_balancing()
>   sched/fair: Change task_numa_work() storage to static
> 
>  kernel/sched/fair.c | 93 +++++++++++++++++++++++----------------------
>  1 file changed, 47 insertions(+), 46 deletions(-)

Thanks!
