Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187D2C46460
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 10:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBC152054F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 10:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mPaCfQeH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfEGKkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 06:40:43 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:35608 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfEGKkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 06:40:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JcsFUl7CHtmmwrs51FmIWdyRtiT3Wl9CxTGXiiAUYec=; b=mPaCfQeHR6JOJpSd6Hq+AJ5ub
        3BLhIrQEjNLDuLkxG5+L8XTsPrJlxLrYCYfQUk3mlQ4iAQiG2+SvPVFD5veUHwFdE0FJ7Sbr221Gg
        fARQLR2jtCIGMed5NPNDNWqlo0vRQjlRs+nLZKHpow92zqlOtz0X0bV9TUmJI3+gkUHyE2S3jsLg/
        D7bL3ty0LHo0jp1ScAcdPN8SmSrWwj2/L+OyLmIHelffdbkIQmzvSRQj5tQQEkBtFZcU8JDE4PrGJ
        vt3gPMAzwgpsFVEMoE0A3g4LRgTIfL0zQFZrBw57ohrp9kCuKxS8LMyog1/NvExVDsT89qs7E3Zru
        23kPfarOw==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:55712)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hNxWT-0002o7-SO; Tue, 07 May 2019 11:40:34 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hNxWO-0001kd-Ou; Tue, 07 May 2019 11:40:28 +0100
Date:   Tue, 7 May 2019 11:40:28 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Ruslan Babayev <ruslan@babayev.com>, andrew@lunn.ch,
        f.fainelli@gmail.com, hkallweit1@gmail.com, wsa@the-dreams.de,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-acpi@vger.kernel.org, xe-linux-external@cisco.com
Subject: Re: [PATCH net-next 2/2] net: phy: sfp: enable i2c-bus detection on
 ACPI based systems
Message-ID: <20190507104028.zf34wxr7hgwdwa64@shell.armlinux.org.uk>
References: <20190505220524.37266-3-ruslan@babayev.com>
 <20190506045951.GB2895@lahna.fi.intel.com>
 <871s1bv4aw.fsf@babayev.com>
 <20190507092946.GS2895@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507092946.GS2895@lahna.fi.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 12:29:46PM +0300, Mika Westerberg wrote:
> On Mon, May 06, 2019 at 11:14:15AM -0700, Ruslan Babayev wrote:
> > 
> > Mika Westerberg writes:
> > 
> > > On Sun, May 05, 2019 at 03:05:23PM -0700, Ruslan Babayev wrote:
> > >> Lookup I2C adapter using the "i2c-bus" device property on ACPI based
> > >> systems similar to how it's done with DT.
> > >> 
> > >> An example DSD describing an SFP on an ACPI based system:
> > >> 
> > >> Device (SFP0)
> > >> {
> > >>     Name (_HID, "PRP0001")
> > >>     Name (_DSD, Package ()
> > >>     {
> > >>         ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> > >>         Package () {
> > >>             Package () { "compatible", "sff,sfp" },
> > >>             Package () { "i2c-bus", \_SB.PCI0.RP01.I2C.MUX.CH0 },
> > >
> > > Hmm, ACPI has I2cSerialBusV2() resource for this purpose. Why you are not
> > > using that?
> > 
> > I am not an ACPI expert, but my understanding is I2cSerialBusV2() is
> > used for slave connections. I am trying to reference an I2C controller
> > here.
> 
> Ah, the device itself is not sitting on an I2C bus? In that case I
> agree, I2CSerialBusV2() is not correct here.

There are several possibilities:

- Identifying information in EEPROM-like device at 0x50.
- Optional diagnostics information and measurements at 0x51.
- Optional network PHY at some other address.

Hence, we need access to the bus to be able to parse the EEPROM without
interfering with the AT24 driver that would otherwise bind to it, to
be able to read the diagnostics, and to probe for the network PHY
without needing to have a big table of module vendors/descriptions to
PHY information (and therefore limiting our SFP support to only
"approved" known modules (which, common with big-name switches, pisses
users off and is widely seen as a vendor lock-in measure.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
