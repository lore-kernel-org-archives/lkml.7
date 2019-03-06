Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD259C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FF4B20675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 09:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729764AbfCFJf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 04:35:28 -0500
Received: from foss.arm.com ([217.140.101.70]:57724 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729078AbfCFJf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 04:35:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9966A78;
        Wed,  6 Mar 2019 01:35:27 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 927913F71D;
        Wed,  6 Mar 2019 01:35:26 -0800 (PST)
Date:   Wed, 6 Mar 2019 09:35:21 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lucas Stach <l.stach@pengutronix.de>,
        Peng Hao <peng.hao2@zte.com.cn>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Smarter Kconfig help
Message-ID: <20190306093521.GA50994@lakrids.cambridge.arm.com>
References: <20190305173111.t3n6ycktht7kxuhq@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190305173111.t3n6ycktht7kxuhq@shell.armlinux.org.uk>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 05:31:12PM +0000, Russell King - ARM Linux admin wrote:
> Guys,

Hi Russell,

> We need to be smarter when writing Kconfig help.  I'm just going
> through updating my build trees with the results of 5.0 development,
> and a number of the help texts are next to useless.  For example,
> 
> PVPANIC - is this something that should be enabled for a host or
> guest kernel?  Answer: you have to read the driver code to find out.

When I looked at the help text:

    This driver provides support for the pvpanic device.  pvpanic is
    a paravirtualized device provided by QEMU; it lets a virtual machine
    (guest) communicate panic events to the host.

... it seemed clear to me that this was for a guest, given the text says
QEMU provides the device. I guess you read that as meaning QEMU asks the
host kernel to provide the device to the guest?

Do you have a suggestion for how to word that unambiguously?

> IMX_IRQSTEER - which i.MX SoCs does this apply to?  The help text
> just says:
> 
>   "Support for the i.MX IRQSTEER interrupt multiplexer/remapper."
> 
> which doesn't say which SoCs this should be enabled for - it turns
> out that grepping for the driver's DT compatible string, none of
> the 32-bit ARM cores have support for this, yet we still default
> it to enabled there.  It seems the help text should at the very
> least tell the user that this is not applicable to i.MX SoCs with
> 32-bit ARM cores.
> 
> I'm sure there's many other instances of this... I suspect that
> it's caused by review concentrating mostly on the technical aspects
> of the code and the Kconfig help text just gets forgotten about.

Just to be clear, in general what you want is for Kconfig help to be
clearer about *when* an option is relevant, right?

I'll try to bear that in mind when reviewing in future.

Thanks,
Mark.
