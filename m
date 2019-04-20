Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB11EC282E3
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 07:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73BDE218AE
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 07:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555743859;
	bh=18TfnheCMC9vyu3YMVoWOG4cJ2kvLU27FXzNRhBZvZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=p6GwJnv+T+gAVjrgXIskaAZL6UyP+pRo05IPVhHHC1xsa6KO+5i7LrWzR+QKdDTU1
	 McFGq2g+3IBAFe7sz+P4I3CHMsGqYkzkuvNgtU6siFcZIAyHjeoD5DQrUnPsMc5CIB
	 1pkua+SABWVdEJx34TbALHtcliiBcoRlacCHSmyI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfDTHES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 03:04:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:55110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbfDTHES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 03:04:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97ABD21479;
        Sat, 20 Apr 2019 07:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555743857;
        bh=18TfnheCMC9vyu3YMVoWOG4cJ2kvLU27FXzNRhBZvZ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L71mJUGznJ+XcjYJt0zEU+rWvu3BRgkIImoXCSQC9n0YqB5Lh1jVdRdT9fjXnEMjX
         W01izGza1CHmrjuWWkkz47KdV2M8e59Q9h/ykZVewoCochrqevVoFZN2rfk0gKTJIv
         jZoPzhNPrCimuJKi/y2BfXzgRpEYhLAdZsgci81k=
Date:   Sat, 20 Apr 2019 09:04:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/50] 4.9.170-stable review
Message-ID: <20190420070414.GA24855@kroah.com>
References: <20190418160422.455656724@linuxfoundation.org>
 <20190419193926.GA10320@roeck-us.net>
 <20190419201637.GA5347@roeck-us.net>
 <20190420011245.GG17719@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190420011245.GG17719@sasha-vm>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 09:12:45PM -0400, Sasha Levin wrote:
> On Fri, Apr 19, 2019 at 01:16:37PM -0700, Guenter Roeck wrote:
> > On Fri, Apr 19, 2019 at 12:39:26PM -0700, Guenter Roeck wrote:
> > > On Thu, Apr 18, 2019 at 07:57:11PM +0200, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 4.9.170 release.
> > > > There are 50 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > >
> > > > Responses should be made by Sat Apr 20 16:03:22 UTC 2019.
> > > > Anything received after that time might be too late.
> > > >
> > > Build results:
> > > 	total: 172 pass: 170 fail: 2
> > > Failed builds:
> > > 	i386:tools/perf
> > > 	x86_64:tools/perf
> > 
> > Caused by "tools include: Adopt linux/bits.h". That isn't really
> > a bug fix, and since it is the last commit in the perf directory
> > it isn't needed either. Reverting it fixes the problem.
> 
> Indeed. I'll remove it from all branches since it doesn't look like a
> fix to begin with.

My fault with that one, sorry about that.

greg k-h
