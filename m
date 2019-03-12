Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACBCC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A4DD2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pKKMZQpf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbfCLPVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:21:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47960 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfCLPVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:21:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VlGlLbq002PLe9VGoVpSt/3Rfzzq8YHm6Q4m8f9UOpI=; b=pKKMZQpf78MoIuoIcsybUosma
        aZcj/H0MnQIsSvQUx/Oeoj6RE1EGkov0ZSoaySu4mHVOYnlDTCu9stFJ0s7Zq1T1003Sbqrg0PmpY
        SnfERfdI+B46tKsEYeyVuYZTLtRUmDB7xKNzOKaOnpc6P+eGXlsZrmhp9ay0FiFKXym1kjSRrUkTl
        oNe2ygZtdPorSJQaGGna4pVtuZHEu3FfNqUjenEXn1P7yQwiV40rDpcVwE5UjugTkkCaphqZn+ZqT
        Z6UzsDg5ezkwetZQJX3/9JV9epoGbzWncV/qHXmAScRd5AToDu2pCxcX+YxlqN9ttmbti8WRdLEUT
        fpnnBfGRg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h3jDC-0001V3-Av; Tue, 12 Mar 2019 15:21:02 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 071A2202631D4; Tue, 12 Mar 2019 16:21:00 +0100 (CET)
Date:   Tue, 12 Mar 2019 16:20:59 +0100
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
Message-ID: <20190312152059.GA5922@hirez.programming.kicks-ass.net>
References: <20190208100554.32196-1-patrick.bellasi@arm.com>
 <20190208100554.32196-2-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208100554.32196-2-patrick.bellasi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 10:05:40AM +0000, Patrick Bellasi wrote:
> +/* Integer ceil-rounded range for each bucket */
> +#define UCLAMP_BUCKET_DELTA ((SCHED_CAPACITY_SCALE / UCLAMP_BUCKETS) + 1)

Uhm, should that not me ((x+y-1)/y), aka. DIV_ROUND_UP(x,y) ?

The above would give 4 for 9/3, which is clearly buggered.
