Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9897ACA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 10:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D44D217F9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 10:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572602814;
	bh=FW7BnYe1gaen2VhkkCO1cMAZFidZayPIMgSDmZ3HphA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pGeav3bsH8oiMnWxMdB/UNsVMNmAin2OSG8amusOZCRPs9SElt8rLPkOE5cDC+qf0
	 WuSRWf1aBK4hKHs5fANLflFaJ8VWVv/KWLPAqPnu49yWtbQQNV1BnBcR0zCIGRNjER
	 Y+3ogDxVHXiC1N3Apb3wam1dnRqiVJIHjuH6pNr0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbfKAKGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 06:06:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:54428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728048AbfKAKGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 06:06:52 -0400
Received: from localhost (unknown [84.241.195.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D80E2086D;
        Fri,  1 Nov 2019 10:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572602812;
        bh=FW7BnYe1gaen2VhkkCO1cMAZFidZayPIMgSDmZ3HphA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BvppdWtYN3o/hiqD4Hkcc332lNyyQlsTeNKgpqRF/M9Sj1nxOszMD8jajab1tvm18
         hy2nmMqKJ1oM/or6ppWuMDK9fvMiqRaH4o+eiqREzgMPiWzb7vTCapXf6ulJCJPnQM
         DjwBZFX3F+wU8e2rgHN5/Mhzpn7Pmz7HI/Tw8raU=
Date:   Fri, 1 Nov 2019 11:06:48 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Thunderbolt fixes for v5.4
Message-ID: <20191101100648.GA2812215@kroah.com>
References: <20191011101831.GC2819@lahna.fi.intel.com>
 <20191024074358.GM2819@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024074358.GM2819@lahna.fi.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 10:43:58AM +0300, Mika Westerberg wrote:
> Hi Greg,
> 
> On Fri, Oct 11, 2019 at 01:18:31PM +0300, Mika Westerberg wrote:
> > Hi Greg,
> > 
> > The following changes since commit da0c9ea146cbe92b832f1b0f694840ea8eb33cce:
> > 
> >   Linux 5.4-rc2 (2019-10-06 14:27:30 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt.git tags/thunderbolt-fixes-for-v5.4-1
> > 
> > for you to fetch changes up to 747125db6dcd8bcc21f13d013f6e6a2acade21ee:
> > 
> >   thunderbolt: Drop unnecessary read when writing LC command in Ice Lake (2019-10-08 12:08:21 +0300)
> > 
> > ----------------------------------------------------------------
> > thunderbolt: Fixes for v5.4
> > 
> > This includes three fixes for various issues people have reported:
> > 
> >   - Fix DP tunneling on some Light Ridge controllers
> >   - Fix for lockdep circular locking dependency warning
> >   - Drop unnecessary read on ICL
> > 
> > ----------------------------------------------------------------
> > Mika Westerberg (3):
> >       thunderbolt: Read DP IN adapter first two dwords in one go
> >       thunderbolt: Fix lockdep circular locking depedency warning
> >       thunderbolt: Drop unnecessary read when writing LC command in Ice Lake
> 
> Just checking whether this fell through the cracks or you require some
> changes?

Sorry, travel cracks here, will get to it this weekend, my fault...

greg k-h
