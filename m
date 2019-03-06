Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3E1C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BBAA20675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="rvFC0zs/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbfCFLev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 06:34:51 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:58706 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfCFLeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 06:34:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=D4bF8+CAmptDpA70NbBNCQNqvLKWS6Y2idy2T9oICuI=; b=rvFC0zs/HOsCPT5IUjX7iEOCv
        V2cvmpU5aADX9ZD7J7JLqJIwlK41Ru5Suqge+Qd4VoFhmkOH7OMsDIit67mCny7n3r69yOEjqFPF8
        13Sv2gWA/CTqiQSnhlu42GeR65qAWQhkxrCLvCzpWgc+E1jQxR/El0h4tkbzWiGdqvHYcHXoBKqhz
        E+E5MmPbo6ZqNcHRsoZ8lfS8JQNj9X64hCSAORn1gb6yVGpOk9VBgxXVu7vNRUCvNnRifhbCaU88k
        xKCDmJwFD6qdrK9xoLKA7JI7kfQEsLUJyxM0l5ehCoEEplc5YVBautyO2TtACKbSxfQ71CNMME1sM
        qoGSKue+Q==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:37278)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1h1Uor-0007OK-Vp; Wed, 06 Mar 2019 11:34:42 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1h1Uom-00041L-EO; Wed, 06 Mar 2019 11:34:36 +0000
Date:   Wed, 6 Mar 2019 11:34:36 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peng Hao <peng.hao2@zte.com.cn>
Subject: Re: Smarter Kconfig help
Message-ID: <20190306113436.5ucdjppibwl6pahz@shell.armlinux.org.uk>
References: <20190305173111.t3n6ycktht7kxuhq@shell.armlinux.org.uk>
 <1551865552.9298.24.camel@pengutronix.de>
 <20190306095147.xyf3d62bywx4v6ji@shell.armlinux.org.uk>
 <CAHp75Vc_Nfm7tAwGtLuYgrPGPFQzx3a4ppx0+mXhF=q_X8jT7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vc_Nfm7tAwGtLuYgrPGPFQzx3a4ppx0+mXhF=q_X8jT7w@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 12:49:40PM +0200, Andy Shevchenko wrote:
> On Wed, Mar 6, 2019 at 11:52 AM Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> > On Wed, Mar 06, 2019 at 10:45:52AM +0100, Lucas Stach wrote:
> > > Am Dienstag, den 05.03.2019, 17:31 +0000 schrieb Russell King - ARM Linux admin:
> 
> > > While I totally agree that the irqsteer driver should only default Y on
> > > 64bit i.MX SoCs, I'm not really sure what to do about the Kconfig help
> > > text.
> > >
> > > Enumerating SoCs in the Kconfig of a IP block driver is always prone to
> > > get outdated. Just as the first example I've been able to come up with,
> > > the MMC_SDHCI_ESDHC_IMX help text says: "This selects the Freescale
> > > eSDHC/uSDHC controller support found on i.MX25, i.MX35 i.MX5x and
> > > i.MX6x.", while the same IP block is to be found on i.MX7 and various
> > > i.MX8.
> > >
> > > For the Kconfig user, who needs to decide if an option is relevant,
> > > outdated SoC information is probably just as bad as no information at
> > > all.
> >
> > How about "This option does not apply to AArch32 based SoCs" or
> 
> Negative is usually error prone.
> 
> > "This option should be enabled for i.MX7 and later SoCs" ?
> 
> Why it should be? It can / could be I guess.

I've no idea.  I'm just making suggestions - if you have anything
better, let's hear it.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
