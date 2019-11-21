Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534E2C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 06:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C1FD2088F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 06:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574319507;
	bh=YGyhRwlY72JDTjzaZmlNQykwtpBveLAAsHXNDUiazXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UzU3d80IHsNeIpq/IiD1axXgaa/FABFOfdEyzKHVzciZpcdcFJzcboPm56twcL8LM
	 KmpMBX/nlbm71CPcnv7DZOubKb0TzWRl+V+4SzJOX0qjUryYUt233pWy+Ha/G0XxIA
	 yLSNrCe82sKCml99BrQoZQaimfkZ7qYv7YqBrMBU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfKUG60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 01:58:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:53378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbfKUG6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 01:58:25 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 424742088F;
        Thu, 21 Nov 2019 06:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574319503;
        bh=YGyhRwlY72JDTjzaZmlNQykwtpBveLAAsHXNDUiazXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TIgkhTvTAfGBCUZBORyLkBvRPlBvdZ77YbyP3Rpe5LBritT8i6KMlETO4M5FxmpwW
         EYrq/jaBc54+644LF7yEXNIKwnnnYk8XDLWECJd4mtz+rAj8+4mWq82G7bNjK+WduV
         A4BT4yzvPPhRwysFcyEtDNPo9wMBSBULCYv3oY3A=
Date:   Thu, 21 Nov 2019 07:58:21 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Sasha Levin <sashal@kernel.org>,
        "kernelci.org bot" <bot@kernelci.org>, tomeu.vizoso@collabora.com,
        guillaume.tucker@collabora.com,
        Niklas Cassel <niklas.cassel@linaro.org>, broonie@kernel.org,
        khilman@baylibre.com, mgalka@collabora.com,
        enric.balletbo@collabora.com, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@codeaurora.org>,
        linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Viresh Kumar <vireshk@kernel.org>
Subject: Re: stable/linux-4.14.y bisection: boot on odroid-x2
Message-ID: <20191121065821.GA344102@kroah.com>
References: <5dd5fbf5.1c69fb81.0938.8061@mx.google.com>
 <20191121060811.mvzzh4zlfzlubzlv@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121060811.mvzzh4zlfzlubzlv@vireshk-i7>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 11:38:11AM +0530, Viresh Kumar wrote:
> On 20-11-19, 18:52, kernelci.org bot wrote:
> > commit 714ab224a8db6e8255c61a42613de9349ceb0bba
> > Author: Viresh Kumar <viresh.kumar@linaro.org>
> > Date:   Fri Aug 3 07:05:21 2018 +0530
> > 
> >     OPP: Protect dev_list with opp_table lock
> >     
> >     [ Upstream commit 3d2556992a878a2210d3be498416aee39e0c32aa ]
> >     
> >     The dev_list needs to be protected with a lock, else we may have
> >     simultaneous access (addition/removal) to it and that would be racy.
> >     Extend scope of the opp_table lock to protect dev_list as well.
> >     
> >     Tested-by: Niklas Cassel <niklas.cassel@linaro.org>
> >     Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> >     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> @Sasha: Please drop this patch for now.

Drop it from 4.14 and 4.19?

thanks,

greg k-h
