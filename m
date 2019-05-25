Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F133C282E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 01:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5963E20879
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 01:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NT3VV33a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfEYBFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 21:05:00 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:57564 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbfEYBE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 21:04:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=/leK6BrYDpRbnBbfmgnP0FFU1Et8b8QTAuc98yARIyk=; b=NT3VV33a2rMFOcZQZMsHb19cFA
        znq0wrszYxlCKa1v7J/h5hnX8syLQlW9zskdtp2ehW/yxFLtT9yXtRJuhirKTI4AB1+wacebppBnY
        NvXBiIWIsDUNIjP8PIcv56m6CbarlsemgzvO6Z4WfqsVqEUiAj4dgBNP7Iet2kI+lUgU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hUL79-00064G-PH; Sat, 25 May 2019 03:04:47 +0200
Date:   Sat, 25 May 2019 03:04:47 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Ruslan Babayev <ruslan@babayev.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        xe-linux-external@cisco.com,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: phy: sfp: enable i2c-bus detection
 on ACPI based systems
Message-ID: <20190525010447.GQ2979@lunn.ch>
References: <20190505193435.3248-1-ruslan@babayev.com>
 <20190525005302.27164-2-ruslan@babayev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190525005302.27164-2-ruslan@babayev.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2019 at 05:53:02PM -0700, Ruslan Babayev wrote:
> Lookup I2C adapter using the "i2c-bus" device property on ACPI based
> systems similar to how it's done with DT.
> 
> An example DSD describing an SFP on an ACPI based system:
> 
> Device (SFP0)
> {
>     Name (_HID, "PRP0001")
>     Name (_CRS, ResourceTemplate()
>     {
>         GpioIo(Exclusive, PullDefault, 0, 0, IoRestrictionNone,
>                "\\_SB.PCI0.RP01.GPIO", 0, ResourceConsumer)
>             { 0, 1, 2, 3, 4 }
>     })
>     Name (_DSD, Package ()
>     {
>         ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>         Package () {
>             Package () { "compatible", "sff,sfp" },
>             Package () { "i2c-bus", \_SB.PCI0.RP01.I2C.MUX.CH0 },
>             Package () { "maximum-power-milliwatt", 1000 },
>             Package () { "tx-disable-gpios", Package () { ^SFP0, 0, 0, 1} },
>             Package () { "reset-gpio",       Package () { ^SFP0, 0, 1, 1} },
>             Package () { "mod-def0-gpios",   Package () { ^SFP0, 0, 2, 1} },
>             Package () { "tx-fault-gpios",   Package () { ^SFP0, 0, 3, 0} },
>             Package () { "los-gpios",        Package () { ^SFP0, 0, 4, 1} },
>         },
>     })
> }
> 
> Device (PHY0)
> {
>     Name (_HID, "PRP0001")
>     Name (_DSD, Package ()
>     {
>         ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>         Package () {
>             Package () { "compatible", "ethernet-phy-ieee802.3-c45" },
>             Package () { "sfp", \_SB.PCI0.RP01.SFP0 },
>             Package () { "managed", "in-band-status" },
>             Package () { "phy-mode", "sgmii" },
>         },
>     })
> }
> 
> Signed-off-by: Ruslan Babayev <ruslan@babayev.com>
> Cc: xe-linux-external@cisco.com

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
