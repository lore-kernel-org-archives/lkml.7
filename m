Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E418AC10F00
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 906DB20661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="I1nigGHr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730044AbfCFJwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 04:52:01 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:57312 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729862AbfCFJv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 04:51:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=R04WONfcNjZyfefgQZ+56O4ERxZmYBCtYwY0/aXW1rU=; b=I1nigGHrh5KIuVRutokf3M484
        vuZgTMDpnvDMojX5GehXUfyzVCvZP4hOwMroq6q3btSLB7H78Azw1N6qH6zOMwboLQEb3Vw4vvlmA
        VBFZ7tgUZx0vI71h6e9od/CDL9aZjRMlDWaDDkk2ZzZiplXcXOJjo169JZN/Ow80L1BZLRjHA1Otz
        6jw/FrIXvlerhdvNpBBQP4wTSgd55mCEJ8xHXF/B+HGUiqTXyIljh1ELq37Y/4CcM/fgyVqHzmaak
        2Gu/BoJO1p04GHR22lbAdvEperUnnymYQEUVCrPThFmgWvCBwiO4z/Mn8JGgheiNFqwGWaQif/WUx
        d3FjLEvTA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51620)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1h1TDN-0006u2-RG; Wed, 06 Mar 2019 09:51:53 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1h1TDH-0003yJ-Qg; Wed, 06 Mar 2019 09:51:47 +0000
Date:   Wed, 6 Mar 2019 09:51:47 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Peng Hao <peng.hao2@zte.com.cn>
Subject: Re: Smarter Kconfig help
Message-ID: <20190306095147.xyf3d62bywx4v6ji@shell.armlinux.org.uk>
References: <20190305173111.t3n6ycktht7kxuhq@shell.armlinux.org.uk>
 <1551865552.9298.24.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1551865552.9298.24.camel@pengutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 10:45:52AM +0100, Lucas Stach wrote:
> Hi Russell,
> 
> Am Dienstag, den 05.03.2019, 17:31 +0000 schrieb Russell King - ARM Linux admin:
> > Guys,
> > 
> > We need to be smarter when writing Kconfig help.  I'm just going
> > through updating my build trees with the results of 5.0 development,
> > and a number of the help texts are next to useless.  For example,
> > 
> > PVPANIC - is this something that should be enabled for a host or
> > guest kernel?  Answer: you have to read the driver code to find out.
> > 
> > IMX_IRQSTEER - which i.MX SoCs does this apply to?  The help text
> > just says:
> > 
> >   "Support for the i.MX IRQSTEER interrupt multiplexer/remapper."
> > 
> > which doesn't say which SoCs this should be enabled for - it turns
> > out that grepping for the driver's DT compatible string, none of
> > the 32-bit ARM cores have support for this, yet we still default
> > it to enabled there.  It seems the help text should at the very
> > least tell the user that this is not applicable to i.MX SoCs with
> > 32-bit ARM cores.
> > 
> > I'm sure there's many other instances of this... I suspect that
> > it's caused by review concentrating mostly on the technical aspects
> > of the code and the Kconfig help text just gets forgotten about.
> > 
> > Can we at least improve these two options please?
> 
> While I totally agree that the irqsteer driver should only default Y on
> 64bit i.MX SoCs, I'm not really sure what to do about the Kconfig help
> text.
> 
> Enumerating SoCs in the Kconfig of a IP block driver is always prone to
> get outdated. Just as the first example I've been able to come up with,
> the MMC_SDHCI_ESDHC_IMX help text says: "This selects the Freescale
> eSDHC/uSDHC controller support found on i.MX25, i.MX35 i.MX5x and
> i.MX6x.", while the same IP block is to be found on i.MX7 and various
> i.MX8.
> 
> For the Kconfig user, who needs to decide if an option is relevant,
> outdated SoC information is probably just as bad as no information at
> all.

How about "This option does not apply to AArch32 based SoCs" or
"This option should be enabled for i.MX7 and later SoCs" ?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
