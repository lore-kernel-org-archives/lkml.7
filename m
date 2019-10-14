Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894E8ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F35C2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 14:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XOJDbg6A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733078AbfJNOwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 10:52:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45174 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731121AbfJNOwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 10:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MkoYcTXKhce4x1iFMop5m8fG1D+SqlCqItdS8ky9PfU=; b=XOJDbg6ABJJK8Rso4KprxAQ62
        ZXt2l38/lFEEGW1rNFPUtiWKlZAEu8gaEgmDl2pvdb6zmxq16Qv3Heaqtxx4Ekfcs8eHdm6HVP149
        B2GMIjA0S5AZIzAUXd6mNsyaY2VUp1sxl1470Gdn5OfN0hcm1viqMr9npxFis9lT5V2igaOjjx/jC
        +eZGI3EkoKwFt4Gk5t9ovq396v07nnMEQCbM8RLp/JcCLZwvTpQN+C1D5GZMHboBQlaUCSKlFhmo0
        vuKcmQOJudZ3he8R7/dkLmYss0NNBc2OpMbXHeqVCauqBafM/wBGfptkl4By4koT48hwZM2TgK2jq
        ww6N6Zj0w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iK1hs-00023C-9J; Mon, 14 Oct 2019 14:52:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 44222305FCE;
        Mon, 14 Oct 2019 16:51:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5454D2023039A; Mon, 14 Oct 2019 16:52:18 +0200 (CEST)
Date:   Mon, 14 Oct 2019 16:52:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Douglas Raillard <douglas.raillard@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH] sched/fair: util_est: fast ramp-up EWMA on utilization
 increases
Message-ID: <20191014145218.GI2328@hirez.programming.kicks-ass.net>
References: <20190620150555.15717-1-patrick.bellasi@arm.com>
 <CAKfTPtDTfyBvfwE6_gtjxJoPNS6YGQ7rrLcjg_M-jr=YSc+FNA@mail.gmail.com>
 <20190628100751.lpcwsouacsi2swkm@e110439-lin>
 <20190628123800.GS3419@hirez.programming.kicks-ass.net>
 <20190628140057.7aujh2wsk7wtqib3@e110439-lin>
 <20190802094725.ploqfarz7fj7vrtp@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802094725.ploqfarz7fj7vrtp@e110439-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The energy aware schedutil patches remimded me this was still pending.

On Fri, Aug 02, 2019 at 10:47:25AM +0100, Patrick Bellasi wrote:
> Hi Peter, Vincent,
> is there anything different I can do on this?

I think both Vincent and me are basically fine with the patch, it was
the Changelog/explanation for it that sat uneasy.

Specifically I think the 'confusion' around the PELT invariance stuff
doesn't help.

I think that if you present it simply as making util_est directly follow
upward motion and only decay on downward -- and the rationale for it --
then it should be fine.


