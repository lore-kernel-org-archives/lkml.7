Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85514C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CDD620843
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 08:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WJp4EToc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfDWIoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 04:44:54 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46408 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfDWIox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 04:44:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uAxn3VVyRKikiswAJvxQH1wVrtz0xNI5a8VqqF5heXY=; b=WJp4ETocMlz7U+l2fuVy1dHNLi
        Cghs8JjIVAP8D5vrS+XN00r39FmEx1x3GS1b2zvbTdQQmdrV5ud4qB/sYhZ6HatUcX4vkXjPGvEiV
        QpmVrX3hYNGl9Ju/XGiuCAsKNgcMpJWKrwmn1KZacXdT2NDopgd7sYr81DvoYOYr1alN9tRW7eeUP
        Yrpf6CCsW+jHicS+42VLlwE7jltSE30bPNSqa0fPDgwUQV+PWRgVWlUyAbcqurGzMIU5TLRUUId8S
        /p5IfpLm0hoW+3LQr700/cxtpJgLqhflkyXFUDnZQ2Tkh9d4IzuMIx7GLKVAykSMjDerCL5Ugfc4h
        oIvAsw7w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hIr2k-0001DH-2O; Tue, 23 Apr 2019 08:44:46 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CE85329B47DC7; Tue, 23 Apr 2019 10:44:44 +0200 (CEST)
Date:   Tue, 23 Apr 2019 10:44:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     =?utf-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH 1/5] numa: introduce per-cgroup numa balancing
 locality, statistic
Message-ID: <20190423084444.GB11158@hirez.programming.kicks-ass.net>
References: <209d247e-c1b2-3235-2722-dd7c1f896483@linux.alibaba.com>
 <c0ec8861-2387-e73b-e450-2d636557a3dd@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c0ec8861-2387-e73b-e450-2d636557a3dd@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 10:11:24AM +0800, 王贇 wrote:
> +#ifdef CONFIG_NUMA_BALANCING
> +
> +enum memcg_numa_locality_interval {
> +	PERCENT_0_9,
> +	PERCENT_10_19,
> +	PERCENT_20_29,
> +	PERCENT_30_39,
> +	PERCENT_40_49,
> +	PERCENT_50_59,
> +	PERCENT_60_69,
> +	PERCENT_70_79,
> +	PERCENT_80_89,
> +	PERCENT_90_100,
> +	NR_NL_INTERVAL,
> +};
> +
> +struct memcg_stat_numa {
> +	u64 locality[NR_NL_INTERVAL];
> +};

If you make that 8 it fits a single cacheline. Do you really need the
additional resolution? If so, then 16 would be the next logical amount
of buckets. 10 otoh makes no sense what so ever.
