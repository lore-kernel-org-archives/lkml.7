Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D589AC10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A652D20830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554299520;
	bh=1ZRresJgJEzsVEBoj/S/AYbwc7Vmx6/76WgBUf4AB1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=e7mZpALnpF9ofh3683dRIq/v7HT0bUvwyUJc23dAMeSfjUrmpMLsX2PqFJqqwI/q9
	 zDpRxIXe+8x4jh+vITjPJChChh2xpXr1d1KPQKVZrHCIREdPv2+RDBZtuB/i1fuhZn
	 f7G1JVbkOiajaRtXMwk2JoOkGTfuMds3jDjtYcSc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfDCNv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:51:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:54352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfDCNv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 09:51:59 -0400
Received: from localhost (217-101-180-136.cable.dynamic.v4.ziggo.nl [217.101.180.136])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1499420700;
        Wed,  3 Apr 2019 13:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554299518;
        bh=1ZRresJgJEzsVEBoj/S/AYbwc7Vmx6/76WgBUf4AB1U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sfx4Sv9E5vvjif3hht4ndpY+8ZyJWD8jXnep/tLrC21vq4L+tBGozQIBKsIanuWcU
         FMLN2foPwzFszoFqUcpa8ZCIQXlUvJcwmgtDq8CQwt5zi7K40Cx3aJ/hokx+bVG1/v
         nlOozo9HDnMP9+C8ZJX3umNkXc9ZXYtbb66198P0=
Date:   Wed, 3 Apr 2019 15:40:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, James Morse <james.morse@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.4 078/131] PM / Hibernate: Call flush_icache_range() on
 pages restored in-place
Message-ID: <20190403134008.GA6963@kroah.com>
References: <20190401170051.645954551@linuxfoundation.org>
 <20190401170058.681712612@linuxfoundation.org>
 <20190401203918.GA26671@amd>
 <20190403110051.GB34351@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403110051.GB34351@arrakis.emea.arm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 12:00:51PM +0100, Catalin Marinas wrote:
> On Mon, Apr 01, 2019 at 10:39:18PM +0200, Pavel Machek wrote:
> > On Mon 2019-04-01 19:02:28, Greg Kroah-Hartman wrote:
> > > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > > 
> > > ------------------
> > > 
> > > [ Upstream commit f6cf0545ec697ddc278b7457b7d0c0d86a2ea88e ]
> > > 
> > > Some architectures require code written to memory as if it were data to be
> > > 'cleaned' from any data caches before the processor can fetch them as new
> > > instructions.
> > > 
> > > During resume from hibernate, the snapshot code copies some pages directly,
> > > meaning these architectures do not get a chance to perform their cache
> > > maintenance. Modify the read and decompress code to call
> > > flush_icache_range() on all pages that are restored, so that the restored
> > > in-place pages are guaranteed to be executable on these architectures.
> > > 
> > > Signed-off-by: James Morse <james.morse@arm.com>
> > > Acked-by: Pavel Machek <pavel@ucw.cz>
> > > Acked-by: Rafael J. Wysocki <rjw@rjwysocki.net>
> > > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > > [will: make clean_pages_on_* static and remove initialisers]
> > > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > 
> > I don't think this is suitable for stable.
> > 
> > Catalin: Are there platforms that a) need this and b) support
> > hibernation in 4.4.X?
> 
> Good point. This commit was required for the arm64 hibernate support
> that went in the 4.7 kernel.
> 
> Greg, why was this patch selected for stable? It's harmless anyway.

It came in through Sasha's "magic patch selection AI" tools :)

If it's harmless, might as well leave it in now, and not revert it.

thanks,

greg k-h
