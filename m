Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D63ECE59D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A9CA2168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FKLVhskw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388412AbfJPI27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 04:28:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47374 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729646AbfJPI25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 04:28:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=F6wdwkLS5YIBFm9uUOcdDvp68NOyscyLtLISp6pAdS8=; b=FKLVhskw8PSJ0s6I3yOcLvpA1
        59TfLaVzZkj60onD2dqGvFYN/41Y3KSoXTvXqbM2O7B9Ke5ijicM9e4L+ErBR4qdzN+qGsbmCi9LF
        c0WiMiQQQUq1ukM8+jpKTP3yJX3kwbBx15ePfGSAQkvqRhSWi1d2SY6suEYm3I37gFdBYH1fVlBk9
        qJ/n8K6AOFdD2EGXsV9FnyQMirM8jNNmLw8v2iLymllHeSWTW4tCFc9KYI9YLrQa4bGGX8kVOH77Z
        +E6oS2SFZ2eSskIuMDbD4Gs62cEAxXi7WUeNOyqxksgVfajD2arjYCdtCTWc9aB6KGyvBjV3ky2zb
        1y2M6SmWg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKefr-0001z9-8N; Wed, 16 Oct 2019 08:28:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7E945305E42;
        Wed, 16 Oct 2019 10:27:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 500B328B61623; Wed, 16 Oct 2019 10:28:49 +0200 (CEST)
Date:   Wed, 16 Oct 2019 10:28:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        vincent.guittot@linaro.org, juri.lelli@redhat.com,
        Dietmar.Eggemann@arm.com, morten.rasmussen@arm.com,
        seto.hidetoshi@jp.fujitsu.com, qperret@google.com
Subject: Re: [PATCH] sched/topology: Don't set SD_BALANCE_WAKE on cpuset
 domain relax
Message-ID: <20191016082849.GQ2328@hirez.programming.kicks-ass.net>
References: <20191014164408.32596-1-valentin.schneider@arm.com>
 <20191015113410.GG2311@hirez.programming.kicks-ass.net>
 <86fd060d-fc2f-b9e8-ec14-b4f4627f7c0c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86fd060d-fc2f-b9e8-ec14-b4f4627f7c0c@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 12:37:11PM +0100, Valentin Schneider wrote:
> On 15/10/2019 12:34, Peter Zijlstra wrote:
> > This 'relax' thing is on my list of regrets. It is a terrible thing that
> > should never have existed.
> > 
> > Are you actually using it or did you just stumble upon it while looking
> > around there?
> > 
> 
> Just staring around, I don't use cpuset stuff unless I really need to...

Fair enough. Applied it.
