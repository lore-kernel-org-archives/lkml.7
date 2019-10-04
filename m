Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36240C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0319B222C0
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570201181;
	bh=4Lgjg4tuESUADzeIWw9QpZbJpoFP2sxi0cuGF0usbuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AE3EZsxP4eC3Ii0im0aqxGSL1v4UrZJr8ZCV78Dg3Umv353xo80Z1StFIpF6vjJx2
	 XRK9ugNUSaOOc9KzFRmN5gnSokc7ySN3Dc7d5L7GoQ+6Lgm0ZmOdMHJtwREcoW/GHn
	 V8lWNpEQ6K6lZ5RqcJcC2MfbpWsQHo3S0UCYFizg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389619AbfJDO7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 10:59:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:48246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389473AbfJDO7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 10:59:39 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BDFB2133F;
        Fri,  4 Oct 2019 14:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570201178;
        bh=4Lgjg4tuESUADzeIWw9QpZbJpoFP2sxi0cuGF0usbuU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IsYRIWmAWyl08ISb8Mph0fvcqH7MyvrWuIHGxz1gG3pOCxCprlyuzMJZ1HZY+51Om
         RIVr1JJ46d4lZnCbuy9kZd8+0Mf9/pxyeWPY68q1Pi6Px4MC1qo50ip1hwsw6zuSl7
         KCwQ03ySSg735BFFC+HnkIKkdI7k5OuIK6+YpbH0=
Date:   Fri, 4 Oct 2019 15:59:33 +0100
From:   Will Deacon <will@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     John Garry <john.garry@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        mark.rutland@arm.com, zhangshaokun@hisilicon.com
Subject: Re: [PATCH 0/4] HiSilicon hip08 uncore PMU events additions
Message-ID: <20191004145932.3ipoaqsmzmlr2b45@willie-the-truck>
References: <1567612484-195727-1-git-send-email-john.garry@huawei.com>
 <27e693fd-124e-1aa8-3b8a-62301a5a1d10@huawei.com>
 <20191004143658.GA17687@kernel.org>
 <20191004143835.GB17687@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004143835.GB17687@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 11:38:35AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Oct 04, 2019 at 11:36:58AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Fri, Oct 04, 2019 at 03:30:07PM +0100, John Garry escreveu:
> > > On 04/09/2019 16:54, John Garry wrote:
> > > > This patchset adds some missing uncore PMU events for the hip08 arm64
> > > > platform.
> > > > 
> > > > The missing events were originally mentioned in
> > > > https://lkml.org/lkml/2019/6/14/645, when upstreaming the JSONs initially.
> > > > 
> > > > It also includes a fix for a DDRC eventname.
> > > 
> > > Hi guys,
> > > 
> > > Could I get these JSON updates picked up please? Maybe they were missed
> > > earlier. Let me know if I should re-post.
> > 
> > Looking at them now.
> 
> It would be really good if somehow we managed to have someone from the
> ARM community to check and provide a Reviewed-by for those, i.e. someone
> else than the poster to look at it and check that its ok, would that be
> possible?

The patches look fine to me, but the IP being supported here is designed
by Hisilicon so my Arm knowledge isn't very helpful as it's outside the
scope of the architecture.

Will
