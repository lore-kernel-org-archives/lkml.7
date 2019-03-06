Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95B9C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 20:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9331C206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 20:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="xaUnYiOU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730482AbfCFUWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 15:22:38 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:36840 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfCFUWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 15:22:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=y5ZURR5r/3LLx6aWN+bszh3KYmschxGAEvSeXhlTRzs=; b=xaUnYiOUXr98+jAF+wCQ2UQ03
        W/nBn1C9oLDm0V/ziHRHpOug/LC2bYOZtA3oreola8hBtc7WnuBHPf4/uoaBUl4DPrRyJhMRgvKFg
        vI48mThBzaEvWfwxO+WamgfDqgh05XV9GPkLtXtUtbAKK9ugn+q0gq5OqSXhavtr2VcDXS6r52BSV
        eBDr2YtkfcHprcVS4nzRY3q26rhD2zKJBA/LnaaHgHj7jAU/Jz7C3aKAsFIIjVB3gJWE1Ynn3vEO0
        gg5rdts0TI6VUfJexn0q2tTwNE6HuuLhrcIuu5h7/xLfwUnaD7GtIeYqMVmJCWOqKX6gPozN5pqfA
        Qtm/U36GQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51636)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1h1d3c-0001QL-22; Wed, 06 Mar 2019 20:22:28 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1h1d3V-0004Ka-6r; Wed, 06 Mar 2019 20:22:21 +0000
Date:   Wed, 6 Mar 2019 20:22:21 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peng Hao <peng.hao2@zte.com.cn>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: Re: Smarter Kconfig help
Message-ID: <20190306202221.n654yxedjtdang5n@shell.armlinux.org.uk>
References: <20190305173111.t3n6ycktht7kxuhq@shell.armlinux.org.uk>
 <1551865552.9298.24.camel@pengutronix.de>
 <20190306095147.xyf3d62bywx4v6ji@shell.armlinux.org.uk>
 <CAHp75Vc_Nfm7tAwGtLuYgrPGPFQzx3a4ppx0+mXhF=q_X8jT7w@mail.gmail.com>
 <20190306113436.5ucdjppibwl6pahz@shell.armlinux.org.uk>
 <20190306124221.bf6qj6zx6jbdcsey@shell.armlinux.org.uk>
 <80d7c75a-f537-ee10-a139-d342c6b0f2b4@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80d7c75a-f537-ee10-a139-d342c6b0f2b4@metux.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 09:16:02PM +0100, Enrico Weigelt, metux IT consult wrote:
> On 06.03.19 13:42, Russell King - ARM Linux admin wrote:
> 
> > In case it isn't clear, this is the *exact* point here - I don't know> whether this option should be enabled for iMX6 or not, and the only>
> way I found out was to grep the dts files in arch/arm/boot/dts for> the
> driver's compatible string.  What that reveals is that *no* 32-bit> dts
> files contain the compatible string, and so I summise that *no*> 32-bit
> iMX SoC should have this driver enabled.
> The problem is a bit more generic. I often have to spend lots of time
> to find out which configs to enable on a specific board, to get certain
> features (eg. network, sata, display, gpu, ...). Even worse: many
> options require other stuff enabled before even showing up. And when
> disabling unneeded stuff, it leaves lots of other things enabled.
> (we don't have some `apt autoremove` kconfig counterpart :().
> 
> I've decided to cope w/ that on a higher level and written a little
> config generator tool for that - here you can enable high level
> features (eg. 'network' or 'display', etc) and it will generate the
> actual .config:
> 
> 	https://github.com/metux/kmct
> 
> > The excuse that "we can't list the explicit SoCs" to me seems to be> a very lame excuse
> 
> Maybe this actually means "nobody here volounteered to actually maintain
> these help texts" ?
> 
> > The best that I can come up with right now, given what little I know> from grepping the 32-bit DTS files, is that the help text should at>
> least indicate that it *isn't* applicable to 32-bit SoCs, or if you>
> prefer, *is* applicable to 64-bit SoCs.  Beyond that, I have no>
> information to formulate a better suggestion.
> Perhaps just fix the text based on your knowledge and send a patch to
> the maintainers. They'll propably tell you if it's incorrect.

Frankly, no.  I don't want to be going round endlessly writing help
texts.

We need the effort to be properly distributed - we need those who
_know_ the feature they're developing to write a proper help text.
One way to achieve that is to make a proper informative help text
a pre-requisit of accepting the code.

The quality of the help text is just as important as the quality of
the code, and we really should be paying the same amount of attention
to both.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
