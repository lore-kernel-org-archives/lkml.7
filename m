Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5B1C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A71206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbfCFJqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 04:46:01 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36153 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729695AbfCFJqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 04:46:01 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1h1T7b-0006X3-3u; Wed, 06 Mar 2019 10:45:55 +0100
Message-ID: <1551865552.9298.24.camel@pengutronix.de>
Subject: Re: Smarter Kconfig help
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Peng Hao <peng.hao2@zte.com.cn>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Wed, 06 Mar 2019 10:45:52 +0100
In-Reply-To: <20190305173111.t3n6ycktht7kxuhq@shell.armlinux.org.uk>
References: <20190305173111.t3n6ycktht7kxuhq@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

Am Dienstag, den 05.03.2019, 17:31 +0000 schrieb Russell King - ARM Linux admin:
> Guys,
> 
> We need to be smarter when writing Kconfig help.  I'm just going
> through updating my build trees with the results of 5.0 development,
> and a number of the help texts are next to useless.  For example,
> 
> PVPANIC - is this something that should be enabled for a host or
> guest kernel?  Answer: you have to read the driver code to find out.
> 
> IMX_IRQSTEER - which i.MX SoCs does this apply to?  The help text
> just says:
> 
>   "Support for the i.MX IRQSTEER interrupt multiplexer/remapper."
> 
> which doesn't say which SoCs this should be enabled for - it turns
> out that grepping for the driver's DT compatible string, none of
> the 32-bit ARM cores have support for this, yet we still default
> it to enabled there.  It seems the help text should at the very
> least tell the user that this is not applicable to i.MX SoCs with
> 32-bit ARM cores.
> 
> I'm sure there's many other instances of this... I suspect that
> it's caused by review concentrating mostly on the technical aspects
> of the code and the Kconfig help text just gets forgotten about.
> 
> Can we at least improve these two options please?

While I totally agree that the irqsteer driver should only default Y on
64bit i.MX SoCs, I'm not really sure what to do about the Kconfig help
text.

Enumerating SoCs in the Kconfig of a IP block driver is always prone to
get outdated. Just as the first example I've been able to come up with,
the MMC_SDHCI_ESDHC_IMX help text says: "This selects the Freescale
eSDHC/uSDHC controller support found on i.MX25, i.MX35 i.MX5x and
i.MX6x.", while the same IP block is to be found on i.MX7 and various
i.MX8.

For the Kconfig user, who needs to decide if an option is relevant,
outdated SoC information is probably just as bad as no information at
all.

Regards,
Lucas
