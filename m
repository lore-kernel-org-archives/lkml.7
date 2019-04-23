Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9CBC282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8691E20674
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JzQhZaX9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfDWJFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:05:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51600 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfDWJFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 05:05:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6VqXzTqzV4erjPSVPtVl2zQZ4ymXP6yRhCiCP3xmNmw=; b=JzQhZaX9wCR1O+q7wBnsYM6n0U
        V+FN/qJvVRDX/PdLVZhm0qsNatmpcnHcFuJ0sI9VMTSmVZiTDfFnQ/IalvfBTnz7WzD3W0/B3tTsS
        QpXw6XhiPzEw+nCaurIJhIoBvm2yg4Yptl8hMg0tWToYZQOOKLZ7EkwMnq7ZVqIo8wt3XxN4Ajh4f
        NjWysATDqv1dQ6ZV6VfP7HRwy4cr3txcBpY2O08fb3MncEICV/9yvPwSa6BYci7Zil6Uaw/tvBexY
        obgQhKwzPrTCW5m6f6dB4BvPaGA//4enbwbat3m+hpZZbnEFFQWVuUFyqoVwSLZpBD/HUvi6EIy/R
        B8+U44fw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hIrMR-0006tp-7X; Tue, 23 Apr 2019 09:05:07 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 90E0329B47DCD; Tue, 23 Apr 2019 11:05:05 +0200 (CEST)
Date:   Tue, 23 Apr 2019 11:05:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     =?utf-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH 5/5] numa: numa balancer
Message-ID: <20190423090505.GG11158@hirez.programming.kicks-ass.net>
References: <209d247e-c1b2-3235-2722-dd7c1f896483@linux.alibaba.com>
 <85bcd381-ef27-ddda-6069-1f1d80cf296a@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85bcd381-ef27-ddda-6069-1f1d80cf296a@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 10:21:17AM +0800, 王贇 wrote:
> numa balancer is a module which will try to automatically adjust numa
> balancing stuff to gain numa bonus as much as possible.
> 
> For each memory cgroup, we process the work in two steps:
> 
> On stage 1 we check cgroup's exectime and memory topology to see
> if there could be a candidate for settled down, if we got one then
> move onto stage 2.
> 
> On stage 2 we try to settle down as much as possible by prefer the
> candidate node, if the node no longer suitable or locality keep
> downturn, we reset things and new round begin.
> 
> Decision made with find_candidate_nid(), should_prefer() and keep_prefer(),
> which try to pick a candidate node, see if allowed to prefer it and if
> keep doing the prefer.
> 
> Tested on the box with 96 cpus with sysbench-mysql-oltp_read_write
> testing, 4 mysqld instances created and attached to 4 cgroups, 4
> sysbench instances then created and attached to corresponding cgroup
> to test the mysql with oltp_read_write script, average eps show:
> 
> 				origin		balancer
> 4 instances each 12 threads	5241.08		5375.59		+2.50%
> 4 instances each 24 threads	7497.29		7820.73		+4.13%
> 4 instances each 36 threads	8985.44		9317.04		+3.55%
> 4 instances each 48 threads	9716.50		9982.60		+2.66%
> 
> Other benchmark liks dbench, pgbench, perf bench numa also tested, and
> with different parameters and number of instances/threads, most of
> the cases show bonus, some show acceptable regression, and some got no
> changes.
> 
> TODO:
>   * improve the logical to address the regression cases
>   * Find a way, maybe, to handle the page cache left on remote
>   * find more scenery which could gain benefit
> 
> Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
> ---
>  drivers/Makefile             |   1 +
>  drivers/numa/Makefile        |   1 +
>  drivers/numa/numa_balancer.c | 715 +++++++++++++++++++++++++++++++++++++++++++

So I really think this is the wrong direction. Why introduce yet another
balancer thingy and not extend the existing numa balancer with the
additional information you got from the previous patches?

Also, this really should not be a module and not in drivers/
