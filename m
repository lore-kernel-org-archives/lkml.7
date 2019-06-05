Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF5DC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 18:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB5892083E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 18:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HL94Of1Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfFESAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 14:00:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53512 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbfFESAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 14:00:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Wn6hbzD6Cf/LprvMetYQYPui1bmuJTeex+C2j3IFqVU=; b=HL94Of1QKtkxZTpCwABGGooa2
        XVtrsEMGwalwBX4XvOYCkNFLP/qupgDioPE+hDpSpdN204B2YSqRktmqd72nW74hbAm5TnqQ6Tvly
        4DMFCm8MQ9/jxMLEFiQdbsZ9XDbnlZQ5lHvcdDgr90MzrpPpRK9vX4nyN2tALYuk6XH2l8aD9TrQZ
        yHes24OdR1TEGKiIjZpy8nqCk12U/IJdvKQkUGdQKqv5+1b0FI1ifdQfTED6SqVZGZKxaM8Qbf4bL
        jSy7yomC6xbFtFkoggx752leMhrLyGqlQgWR31onRoREpKtj87gwwqUucSQHTQCXuRDEQKEVD2w72
        WS3kzOndw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYaDG-0001Km-5b; Wed, 05 Jun 2019 18:00:38 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F242220757B40; Wed,  5 Jun 2019 20:00:35 +0200 (CEST)
Date:   Wed, 5 Jun 2019 20:00:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Matt Fleming <matt@codeblueprint.co.uk>
Cc:     linux-kernel@vger.kernel.org,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] sched/topology: Improve load balancing on AMD EPYC
Message-ID: <20190605180035.GA3402@hirez.programming.kicks-ass.net>
References: <20190605155922.17153-1-matt@codeblueprint.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605155922.17153-1-matt@codeblueprint.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2019 at 04:59:22PM +0100, Matt Fleming wrote:
> SD_BALANCE_{FORK,EXEC} and SD_WAKE_AFFINE are stripped in sd_init()
> for any sched domains with a NUMA distance greater than 2 hops
> (RECLAIM_DISTANCE). The idea being that it's expensive to balance
> across domains that far apart.
> 
> However, as is rather unfortunately explained in
> 
>   commit 32e45ff43eaf ("mm: increase RECLAIM_DISTANCE to 30")
> 
> the value for RECLAIM_DISTANCE is based on node distance tables from
> 2011-era hardware.
> 
> Current AMD EPYC machines have the following NUMA node distances:
> 
> node distances:
> node   0   1   2   3   4   5   6   7
>   0:  10  16  16  16  32  32  32  32
>   1:  16  10  16  16  32  32  32  32
>   2:  16  16  10  16  32  32  32  32
>   3:  16  16  16  10  32  32  32  32
>   4:  32  32  32  32  10  16  16  16
>   5:  32  32  32  32  16  10  16  16
>   6:  32  32  32  32  16  16  10  16
>   7:  32  32  32  32  16  16  16  10
> 
> where 2 hops is 32.
> 
> The result is that the scheduler fails to load balance properly across
> NUMA nodes on different sockets -- 2 hops apart.
> 

> Update the code in sd_init() to account for modern node distances, and
> maintaining backward-compatible behaviour by respecting
> RECLAIM_DISTANCE for distances more than 2 hops.

And then we had two magic values :/

Should we not 'fix' RECLAIM_DISTANCE for EPYC or something? Because
surely, if we want to load-balance agressively over 30, then so too
should we do node_reclaim() I'm thikning.
