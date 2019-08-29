Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E93C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 11:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F3023403
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 11:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567077496;
	bh=QV/q/2L6au2GnPDKNQgpWono0mUk3TBCJNzG+cy5n2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WNgG7Q6+olVZz3FFlg6lo63aYoi5sxtz8raj+nJcFNKvIyn1txh7RL1qjN6+j1WtR
	 tG35NNtMkDrjE6CfmqtPM/o0F9F0bIIxnIBKFbqd2QTmZ9cJUVqfmJfGulc5+xvDsh
	 Gke04VFGFACvA+ibLBhEuKHoHftPA8QZD0dI6e5w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbfH2LSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 07:18:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:50240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbfH2LSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 07:18:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDB0E2166E;
        Thu, 29 Aug 2019 11:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567077493;
        bh=QV/q/2L6au2GnPDKNQgpWono0mUk3TBCJNzG+cy5n2o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J9A26W5yINMhnUI6Bz5MFO+KPnvSBWWOOQwb/nviBZxiZk8dElJsnRbRcMlsNi1hW
         qZXpGblNCEmVC/b2PUCh7N0gAp2QNKrcvcdjz2CTUePFAlA5rgmjVtAN1MxNHu/NUb
         80CQIWkMKlcDetwaYwoFnhZ48094bZSz2MavMSVk=
Date:   Thu, 29 Aug 2019 13:18:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     devel@driverdev.osuosl.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to staging
Message-ID: <20190829111810.GA23393@kroah.com>
References: <20190828160817.6250-1-gregkh@linuxfoundation.org>
 <20190828170022.GA7873@kroah.com>
 <20190829062340.GB3047@infradead.org>
 <20190829063955.GA30193@kroah.com>
 <20190829094136.GA28643@infradead.org>
 <20190829095019.GA13557@kroah.com>
 <20190829103749.GA13661@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829103749.GA13661@infradead.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 03:37:49AM -0700, Christoph Hellwig wrote:
> On Thu, Aug 29, 2019 at 11:50:19AM +0200, Greg Kroah-Hartman wrote:
> > I did try just that, a few years ago, and gave up on it.  I don't think
> > it can be added to the existing vfat code base but I am willing to be
> > proven wrong.
> 
> And what exactly was the problem?

At the time, I just couldn't figure out how to do it as I had no spec,
and only a bad code-base to go off of.  I'm sure someone else might be
able to do to it :)

> > Now that we have the specs, it might be easier, and the vfat spec is a
> > subset of the exfat spec, but to get stuff working today, for users,
> > it's good to have it in staging.  We can do the normal, "keep it in
> > stable, get a clean-room implementation merged like usual, and then
> > delete the staging version" three step process like we have done a
> > number of times already as well.
> > 
> > I know the code is horrible, but I will gladly take horrible code into
> > staging.  If it bothers you, just please ignore it.  That's what staging
> > is there for :)
> 
> And then after a while you decide it's been long enough and force move
> it out of staging like the POS erofs code?

Hey, that's not nice, erofs isn't a POS.  It could always use more
review, which the developers asked for numerous times.

There's nothing different from a filesystem compared to a driver.  If
its stand-alone, and touches nothing else, all issues with it are
self-contained and do not bother anyone else in the kernel.  We merge
drivers all the time that need more work because our review cycles are
low.  And review cycles for vfs developers are even more scarce than
driver reviewers.

thanks,

greg k-h
