Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A24DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 08:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 337F32075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 08:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552294333;
	bh=+FMv0EsI/MP06uQK4orjiWP9jc/z0XWlDVNG4ls3LkI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AhqRh8PrtclnquhuPFgOkhiZecToYIl0B4tvDwH6qiMUQEGj0gaoPCdsU56NhqKFp
	 pPFtPp2CvsfPn1bUbQmQPz6Yjq0WzqaUm8DVebSxJrjz5bkRNPuJwnu9dpaVOyw4Y6
	 V1pvbaZBoJhCImH6+3mEFngLDv7/h9gwnQ0v/n1c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfCKIwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 04:52:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:44042 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726590AbfCKIwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 04:52:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 467DAAF6E;
        Mon, 11 Mar 2019 08:52:09 +0000 (UTC)
Date:   Mon, 11 Mar 2019 09:52:08 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Stefan Agner <stefan@agner.ch>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kernel-owner@vger.kernel.org
Subject: Re: arch/arm/kernel/setup.c fails to compile for NOMMU
Message-ID: <20190311085208.GY5232@dhcp22.suse.cz>
References: <20170818112402.GB18499@dhcp22.suse.cz>
 <20170824161741.GX20805@n2100.armlinux.org.uk>
 <20170825064540.GB25498@dhcp22.suse.cz>
 <20180406095656.GJ8286@dhcp22.suse.cz>
 <be04f030b480d88aed666698dcd06c5e@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be04f030b480d88aed666698dcd06c5e@agner.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 05-03-19 23:08:45, Stefan Agner wrote:
> Hi Michal,
> 
> On 06.04.2018 11:56, Michal Hocko wrote:
> > On Fri 25-08-17 08:45:40, Michal Hocko wrote:
> >> On Thu 24-08-17 17:17:41, Russell King - ARM Linux wrote:
> >> > On Fri, Aug 18, 2017 at 01:24:02PM +0200, Michal Hocko wrote:
> >> > > Hi Russel,
> >> > > I have a battery of configs for compile testing and for some time I've
> >> > > been seeing the following compilation error with nommu config (attached)
> >> > >
> >> > > arch/arm/kernel/setup.c: In function 'reserve_crashkernel':
> >> > > arch/arm/kernel/setup.c:1005:25: error: 'SECTION_SIZE' undeclared (first
> >> > > use in this function)
> >> > >              crash_size, SECTION_SIZE);
> >> > >
> >> > > I didn't get to look what is going on here, maybe my config is just too
> >> > > artificial but the primary reason is that SECTION_SIZE is not defined in
> >> > > pgtable-nommu.h. To be honest I am not familiar with nommu very much and
> >> > > it smells like the whole reserve_crashkernel doesn't really make any
> >> > > sense on those configs. Could you have a look what is the best fix
> >> > > please?
> >> >
> >> > Hi,
> >> >
> >> > I suspect that mach-netx has never been tested in nommu configurations
> >> > (ditto for many of the older platforms, which pre-date merging nommu
> >> > support.)
> >> >
> >> > Maybe the best solution is to make these old platforms depend on MMU.
> >> >
> >> > However, I'm wondering whether kexec makes sense for !MMU - that's
> >> > probably something that hasn't been tested and doesn't actually work.
> >> > So maybe another approach would be to make kexec depend on MMU for
> >> > ARM - but I'm afraid I don't really know.
> >>
> >> Yeah, I've disabled KEXEC in my testing config. All I do care about is
> >> to test nommu specific code paths in MM code.
> >>
> >> > I only have very limited nommu experience.
> >>
> >> me too
> >>
> >> So what would you say about the following?
> > 
> > It's been some time and it seems this has fallen between cracks. Is this
> > worth puruing or I should just forget about it and drop it on the floor?
> 
> I actually came across this issue during some randconfig testing. Your
> change looks good to me:
> 
> Reviewed-by: Stefan Agner <stefan@agner.ch>
> 
> Fixes for the ARM core usually go through Russell's patch tracker, did
> you submit you patch there?
> 
> See also:
> https://www.arm.linux.org.uk/developer/patches/info.php

Thanks! I am quite busy though so please feel free to resubmit if you
feel this is worth it.

> --
> Stefan
> 
> >> ---
> >> From 2707f3bf00181bbc9dcf6a1f287eb7369141e955 Mon Sep 17 00:00:00 2001
> >> From: Michal Hocko <mhocko@suse.com>
> >> Date: Fri, 25 Aug 2017 08:40:09 +0200
> >> Subject: [PATCH] arm: make kexec depend on MMU
> >>
> >> arm nommu config with KEXEC enabled doesn't compile
> >> arch/arm/kernel/setup.c: In function 'reserve_crashkernel':
> >> arch/arm/kernel/setup.c:1005:25: error: 'SECTION_SIZE' undeclared (first
> >> use in this function)
> >>              crash_size, SECTION_SIZE);
> >>
> >> since 61603016e212 ("ARM: kexec: fix crashkernel= handling") which is
> >> over one year without anybody noticing. I have only noticed beause of
> >> my testing nommu config which somehow gained CONFIG_KEXEC without
> >> an intention. This suggests that nobody is actually using KEXEC
> >> on nommu ARM configs. It is even a question whether kexec works with
> >> nommu.
> >>
> >> Make KEXEC depend on MMU to make this clear. If somebody wants to enable
> >> there will be probably more things to take care.
> >>
> >> Signed-off-by: Michal Hocko <mhocko@suse.com>
> >> ---
> >>  arch/arm/Kconfig | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> >> index 3f4aa9179337..c8603195d7fc 100644
> >> --- a/arch/arm/Kconfig
> >> +++ b/arch/arm/Kconfig
> >> @@ -2003,6 +2003,7 @@ config KEXEC
> >>  	bool "Kexec system call (EXPERIMENTAL)"
> >>  	depends on (!SMP || PM_SLEEP_SMP)
> >>  	depends on !CPU_V7M
> >> +	depends on MMU
> >>  	select KEXEC_CORE
> >>  	help
> >>  	  kexec is a system call that implements the ability to shutdown your
> >> --
> >> 2.13.2
> >>
> >> --
> >> Michal Hocko
> >> SUSE Labs

-- 
Michal Hocko
SUSE Labs
