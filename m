Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F98AC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 22:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FB50204EC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 22:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="glNf1Gom"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfCEWIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 17:08:50 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:56876 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfCEWIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 17:08:49 -0500
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id EBD525C0816;
        Tue,  5 Mar 2019 23:08:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1551823726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+QkaNjiYlpG0A1tWiuj1oUtWf14BsbsS4Ofyh8yo478=;
        b=glNf1GomYWS3guyqu3yCa6ljb/npcfEzzOFMQwyGZh3+XG+p0NJBhKwcDro2ah0TTIUf5G
        XtjfJzHT43uskrzN+su0DTjOWXxOsKxA1M7g55pkUUUnZo7lGWNHfm6k9317B5VLHKyd/8
        9XnZnonLf7Kj6ya3GCnHgm6TNu7Z4Fo=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Tue, 05 Mar 2019 23:08:45 +0100
From:   Stefan Agner <stefan@agner.ch>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kernel-owner@vger.kernel.org
Subject: Re: arch/arm/kernel/setup.c fails to compile for NOMMU
In-Reply-To: <20180406095656.GJ8286@dhcp22.suse.cz>
References: <20170818112402.GB18499@dhcp22.suse.cz>
 <20170824161741.GX20805@n2100.armlinux.org.uk>
 <20170825064540.GB25498@dhcp22.suse.cz>
 <20180406095656.GJ8286@dhcp22.suse.cz>
Message-ID: <be04f030b480d88aed666698dcd06c5e@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On 06.04.2018 11:56, Michal Hocko wrote:
> On Fri 25-08-17 08:45:40, Michal Hocko wrote:
>> On Thu 24-08-17 17:17:41, Russell King - ARM Linux wrote:
>> > On Fri, Aug 18, 2017 at 01:24:02PM +0200, Michal Hocko wrote:
>> > > Hi Russel,
>> > > I have a battery of configs for compile testing and for some time I've
>> > > been seeing the following compilation error with nommu config (attached)
>> > >
>> > > arch/arm/kernel/setup.c: In function 'reserve_crashkernel':
>> > > arch/arm/kernel/setup.c:1005:25: error: 'SECTION_SIZE' undeclared (first
>> > > use in this function)
>> > >              crash_size, SECTION_SIZE);
>> > >
>> > > I didn't get to look what is going on here, maybe my config is just too
>> > > artificial but the primary reason is that SECTION_SIZE is not defined in
>> > > pgtable-nommu.h. To be honest I am not familiar with nommu very much and
>> > > it smells like the whole reserve_crashkernel doesn't really make any
>> > > sense on those configs. Could you have a look what is the best fix
>> > > please?
>> >
>> > Hi,
>> >
>> > I suspect that mach-netx has never been tested in nommu configurations
>> > (ditto for many of the older platforms, which pre-date merging nommu
>> > support.)
>> >
>> > Maybe the best solution is to make these old platforms depend on MMU.
>> >
>> > However, I'm wondering whether kexec makes sense for !MMU - that's
>> > probably something that hasn't been tested and doesn't actually work.
>> > So maybe another approach would be to make kexec depend on MMU for
>> > ARM - but I'm afraid I don't really know.
>>
>> Yeah, I've disabled KEXEC in my testing config. All I do care about is
>> to test nommu specific code paths in MM code.
>>
>> > I only have very limited nommu experience.
>>
>> me too
>>
>> So what would you say about the following?
> 
> It's been some time and it seems this has fallen between cracks. Is this
> worth puruing or I should just forget about it and drop it on the floor?

I actually came across this issue during some randconfig testing. Your
change looks good to me:

Reviewed-by: Stefan Agner <stefan@agner.ch>

Fixes for the ARM core usually go through Russell's patch tracker, did
you submit you patch there?

See also:
https://www.arm.linux.org.uk/developer/patches/info.php

--
Stefan

>> ---
>> From 2707f3bf00181bbc9dcf6a1f287eb7369141e955 Mon Sep 17 00:00:00 2001
>> From: Michal Hocko <mhocko@suse.com>
>> Date: Fri, 25 Aug 2017 08:40:09 +0200
>> Subject: [PATCH] arm: make kexec depend on MMU
>>
>> arm nommu config with KEXEC enabled doesn't compile
>> arch/arm/kernel/setup.c: In function 'reserve_crashkernel':
>> arch/arm/kernel/setup.c:1005:25: error: 'SECTION_SIZE' undeclared (first
>> use in this function)
>>              crash_size, SECTION_SIZE);
>>
>> since 61603016e212 ("ARM: kexec: fix crashkernel= handling") which is
>> over one year without anybody noticing. I have only noticed beause of
>> my testing nommu config which somehow gained CONFIG_KEXEC without
>> an intention. This suggests that nobody is actually using KEXEC
>> on nommu ARM configs. It is even a question whether kexec works with
>> nommu.
>>
>> Make KEXEC depend on MMU to make this clear. If somebody wants to enable
>> there will be probably more things to take care.
>>
>> Signed-off-by: Michal Hocko <mhocko@suse.com>
>> ---
>>  arch/arm/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 3f4aa9179337..c8603195d7fc 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -2003,6 +2003,7 @@ config KEXEC
>>  	bool "Kexec system call (EXPERIMENTAL)"
>>  	depends on (!SMP || PM_SLEEP_SMP)
>>  	depends on !CPU_V7M
>> +	depends on MMU
>>  	select KEXEC_CORE
>>  	help
>>  	  kexec is a system call that implements the ability to shutdown your
>> --
>> 2.13.2
>>
>> --
>> Michal Hocko
>> SUSE Labs
