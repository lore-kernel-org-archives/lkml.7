Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B9FC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 08:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CBD220862
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 08:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YiJEHtTV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbfEOIzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 04:55:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54208 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfEOIzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 04:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=L4+42qyCw9nGUS+VBeFtSAa3Wj46UL4vdg6bpVVkdHY=; b=YiJEHtTV/1LfTZXXeeBX19lDe
        DXX7vwtzMJRODcTnYdQw8z3ce4SeRRDRtw8lBKEg6H6+pk8NZluV+X15UOiOSRWtL0SqfryaK1Ho3
        PQZyIC0EumqNxK3nx/P8xDszfFDkzSGtO6MIJad2TCgHDo+AOpjNggc2oPVqg2HHb9AWy+0sgriG3
        ZA9/8vH3p/ryEx1h0ort5G73NDpVGF299DxZuXaIaD9BJthwMeTeiS6giftk/ouhKulmDp4/6qhWk
        eLfkBsEUQLaJSlZTKMPOY4gNmJXx9PKHVxCt+JCa07DT8+EgtOUWO7Ao6kY5FkVI92EcsYUh3eegk
        CLeSYcsNw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hQpha-0007Xf-2A; Wed, 15 May 2019 08:55:54 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2A83920297D49; Wed, 15 May 2019 10:55:51 +0200 (CEST)
Date:   Wed, 15 May 2019 10:55:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Len Brown <lenb@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/19] v6 multi-die/package topology support
Message-ID: <20190515085551.GB2623@hirez.programming.kicks-ass.net>
References: <20190513175903.8735-1-lenb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513175903.8735-1-lenb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 01:58:44PM -0400, Len Brown wrote:
> 
> This patch series does 4 things.
> 
> 1. Parse the new CPUID.1F leaf to discover multi-die/package topology
> 
> 2. Export multi-die topology inside the kernel
> 
> 3. Update 4 places (coretemp, pkgtemp, rapl, perf) that that need to know
>    the difference between die and package-scope MSR.
> 
> 4. Export multi-die topology to user-space via sysfs
> 
> These changes should have no impact on cache topology,
> NUMA topology, Linux scheduler, or system performance.
> 
> These topology changes primarily impact parts of the kernel
> and some applications that care about package MSR scope.
> Also, some software is licensed per package, and other tools,
> such as benchmark reporting software sometimes cares about packages.

I still think having a 'rapl package' be a 'die' is weird, but if that's
the way it is specified in the SDM then so be it.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
