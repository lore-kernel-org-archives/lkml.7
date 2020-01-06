Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBEBC32771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 08:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E728720848
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 08:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZUDeLbmS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgAFIKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 03:10:31 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57478 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgAFIKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 03:10:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4jQT2MzQnGVbRqu0zEK79SsXrd8bqafhR3CZKOJDJAI=; b=ZUDeLbmSrGs+4SbT7pm8/4nX8
        tDqFDyrJfAWLbNTFH8krQ/jD9CmZo00y/8QCaZP/ZD0ZF0J74oLl6njQxiLOSuXqbifp2mteZIGXj
        Kv48FYjP11u/tXXxudiu2rB3gBeZb24sS/qIjcM0/Hm6r+qSKpGnI+ABWjvnUJSoElxkky5fLM35H
        pQGJvDdOd6JNvrZhY/d9wRPC5LwSeEfREX3urIJGZlAVhpTzX2OTUqKnYwEZJ66FhsWaexuXiaK1a
        kTzHNM5qH4k0+kw6bvh+llV0aCM3NNITchFIeu4CsP76UfMNAxMRZC2Uexhda+koZZrKFhNq/l46d
        A4PJKUhpw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ioNSx-0008Gk-9a; Mon, 06 Jan 2020 08:10:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A8799304124;
        Mon,  6 Jan 2020 09:08:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5F1612B508237; Mon,  6 Jan 2020 09:10:20 +0100 (CET)
Date:   Mon, 6 Jan 2020 09:10:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH 0/7] sched: Streamline select_task_rq() &
 select_task_rq_fair()
Message-ID: <20200106081020.GL2844@hirez.programming.kicks-ass.net>
References: <20191211164401.5013-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211164401.5013-1-valentin.schneider@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 04:43:54PM +0000, Valentin Schneider wrote:
> Discussion points
> =================
> 
> The use of SD_LOAD_BALANCE forced me to do a few ugly things.
> 
> Patch 5 is only required because the domain walk in select_task_rq_fair()
> is ceiled by the presence of SD_LOAD_BALANCE. Thing is (I also ramble about
> this in the changelog of patch 7) AFAIK this flag is set unconditionally in
> sd_init() and the only way to clear it is via the sched_domain sysctl,
> which is a SCHED_DEBUG interface. I haven't found anything with cpusets
> that would clear it; AFAICT cpusets can end up attaching the NULL domain to
> some CPUs (with sched_load_balance=0) but that's as far as this goes:

I can't find it in a hurry, but cpusets should really be able to build
stuff without LOAD_BALANCe on, otherwise it is broken.

/me digs a little into the code and finds that. no, you're right. What
cpusets does is create non-overlapping domain trees for each parition.
Which avoids the need to clear that flag.

Hmmm.. if we double check all that, I don't suppose there is anything
against simply removing that flag. Less is more etc..
