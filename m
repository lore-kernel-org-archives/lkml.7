Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD3DC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 12:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7921920652
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 12:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ev5uKQUS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730165AbfCFMuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 07:50:32 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:59620 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfCFMuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 07:50:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WR0S/PfcH9lLxoKWJu+GgLcUWJNBIIuWZc/DeVg1zag=; b=ev5uKQUSUImCZnLFxWslUIdvF
        KWcV7cGenVyMyathz8+BGrbknbuTs679sitr1j/+EQzbl8hAkli/k4CJ7G7MZTU78DnH6dro+0Ukh
        syZRwsECaGXM0NN1ukQWD7yiD/hQYHSNrLA19iWo7eia/ECIiO4G78UUq8Cn4dgfME4x7lNBRNpgG
        9SM4ppnuOExQwTkdH4MBMYPRLnnS34NeDqXsIysyY2wrAVOhEjEZ88Z4UAI6wnTq4QaMnKBTm/Afl
        Q2ujBq0eoqLEcssDKivDynq4o6rs7crB4MkeIRNNFLSIbGP1mKRTCAl1zfreo7xZgSaqAumOkxwn7
        JAMYg9rWQ==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:54980)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1h1W09-0007jK-Mf; Wed, 06 Mar 2019 12:50:25 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1h1W06-00044X-DV; Wed, 06 Mar 2019 12:50:22 +0000
Date:   Wed, 6 Mar 2019 12:50:22 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lucas Stach <l.stach@pengutronix.de>,
        Peng Hao <peng.hao2@zte.com.cn>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Smarter Kconfig help
Message-ID: <20190306125022.ikqy66lf25yifxwc@shell.armlinux.org.uk>
References: <20190305173111.t3n6ycktht7kxuhq@shell.armlinux.org.uk>
 <20190306093521.GA50994@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190306093521.GA50994@lakrids.cambridge.arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Wed, Mar 06, 2019 at 09:35:21AM +0000, Mark Rutland wrote:
> On Tue, Mar 05, 2019 at 05:31:12PM +0000, Russell King - ARM Linux admin wrote:
> > Guys,
> 
> Hi Russell,
> 
> > We need to be smarter when writing Kconfig help.  I'm just going
> > through updating my build trees with the results of 5.0 development,
> > and a number of the help texts are next to useless.  For example,
> > 
> > PVPANIC - is this something that should be enabled for a host or
> > guest kernel?  Answer: you have to read the driver code to find out.
> 
> When I looked at the help text:
> 
>     This driver provides support for the pvpanic device.  pvpanic is
>     a paravirtualized device provided by QEMU; it lets a virtual machine
>     (guest) communicate panic events to the host.
> 
> ... it seemed clear to me that this was for a guest, given the text says
> QEMU provides the device. I guess you read that as meaning QEMU asks the
> host kernel to provide the device to the guest?

Yes - that's exactly where the confusion was.  It could be something
like a tap network device to allow a guest access to a facility on the
host, or it could be something that the guest kernel uses to communicate
with its host environment.

> Do you have a suggestion for how to word that unambiguously?

It used to be normal to include a sugestion in the help text that
guided when an option should be enabled.  So, adding something like:

    "Say Y here if you are building a kernel for a virtual machine."

would make it clear.  This used to be standard throughout the kernel,
but it seems in recent years, this has been omitted.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
