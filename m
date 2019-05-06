Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3901C46470
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 19:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93FE921019
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 19:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=babayev.com header.i=@babayev.com header.b="EFy2N1Df"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfEFTGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 15:06:13 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37809 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfEFTGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 15:06:12 -0400
Received: by mail-pf1-f195.google.com with SMTP id g3so7260404pfi.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 12:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=babayev.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=6hW4hrPH/2E41pgWfspNre3qd7EyYPweaCQi68+mpOg=;
        b=EFy2N1DfAPfdSzaxOnmE4xlZaCOPDxPymykKSCWVkEVmGNd2+RNaoATpsLs5aFY+og
         GFZet74F9iM2rDTwDLCBRmBUSKSDot8kB0NN23bsJRUHRYpBEeAoF8eC0DyrMZuHc5Yx
         iceUg1eYU1uTh5BYJi7WLKzkQ3t9IzPQVzzuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=6hW4hrPH/2E41pgWfspNre3qd7EyYPweaCQi68+mpOg=;
        b=LPZZhHDv7Qmp+pOjx3CiFyFakDVhO7/L0N59GhFKooz1LVHaVqHpjaYdGzRrqD+Sy6
         zdAa089EHfJyVxUYyAddIlsAebdThkvjt4Ed0/WBLmMjEFlnIXOvF4fxwtqMW1xJ/2sv
         s0ka5/CffldHyVvlnmYNOgIyYhHoiXJ2hUO488zhc3X1mC+X45tOoVibzNBMMyKmC7aC
         WatXcOnctFrapIoVYpQ4iznY/rFbJggcinvpZVGWC8wydCO0YZ6RMjbAqxahC/tVtvaq
         XYAD7GAl58hkHNNRnAeTE5hCVGOAGsLoERZLb77qdgN//VEVnN8BgqZm//qQcw4Bmhcd
         eIWw==
X-Gm-Message-State: APjAAAU0XDdqWRk7+Hnd9U3IamE7yKgAgpvwSfrUBH9YUWDRUdnb1+4W
        +R7JW3kncLzouP+OlHQvpDSGeg==
X-Google-Smtp-Source: APXvYqwubcG2zIxnszpN5JvEJ5/oUqyuv2KOC+f2f0mIfferTIpyl9TsDsaV1GIrIuWUTLWP2ve8HA==
X-Received: by 2002:a65:64da:: with SMTP id t26mr34448347pgv.322.1557169571795;
        Mon, 06 May 2019 12:06:11 -0700 (PDT)
Received: from localhost (50-46-216-15.evrt.wa.frontiernet.net. [50.46.216.15])
        by smtp.gmail.com with ESMTPSA id 13sm13922560pfi.172.2019.05.06.12.06.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 12:06:10 -0700 (PDT)
References: <20190505220524.37266-3-ruslan@babayev.com> <20190506125523.GA15291@lunn.ch>
User-agent: mu4e 1.0; emacs 26.1
From:   Ruslan Babayev <ruslan@babayev.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Ruslan Babayev <ruslan@babayev.com>, linux@armlinux.org.uk,
        f.fainelli@gmail.com, hkallweit1@gmail.com,
        mika.westerberg@linux.intel.com, wsa@the-dreams.de,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-acpi@vger.kernel.org, xe-linux-external@cisco.com
Subject: Re: [PATCH net-next 2/2] net: phy: sfp: enable i2c-bus detection on ACPI based systems
In-reply-to: <20190506125523.GA15291@lunn.ch>
Date:   Mon, 06 May 2019 12:06:09 -0700
Message-ID: <87zhnztnby.fsf@babayev.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Lunn writes:

> On Sun, May 05, 2019 at 03:05:23PM -0700, Ruslan Babayev wrote:
>> Lookup I2C adapter using the "i2c-bus" device property on ACPI based
>> systems similar to how it's done with DT.
>>
>> An example DSD describing an SFP on an ACPI based system:
>>
>> Device (SFP0)
>> {
>>     Name (_HID, "PRP0001")
>>     Name (_DSD, Package ()
>>     {
>>         ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>>         Package () {
>>             Package () { "compatible", "sff,sfp" },
>>             Package () { "i2c-bus", \_SB.PCI0.RP01.I2C.MUX.CH0 },
>>         },
>>     })
>> }
>
> Hi Ruslan
>
> So this gives you the I2C bus. But what about the 6 GPIOs? And the
> maximum power property? You are defining the ACPI interface which from
> now on everybody has to follow. So it would be good to make it
> complete. ACPI also seems to be poorly documented. There does not
> appear to be anything like Documentation/devicetree. So having one
> patch, with a good commit message, which implements everything makes
> it easier for those that follow.
>
Hi Andrew,

I had the GPIOs and the "maximum-power" property in my ACPI snippet initially,
but then decided to take it out thinking it was not relevant for the
current patch. I can add the missing pieces back in V2.
This is what it would like:

Device (SFP0)
{
    Name (_HID, "PRP0001")
    Name (_CRS, ResourceTemplate()
    {
        GpioIo(Exclusive, PullDefault, 0, 0, IoRestrictionNone,
               "\\_SB.PCI0.RP01.GPIO", 0, ResourceConsumer)
            { 0, 1, 2, 3, 4 }
    })
    Name (_DSD, Package ()
    {
        ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
        Package () {
            Package () { "compatible", "sff,sfp" },
            Package () { "i2c-bus", \_SB.PCI0.RP01.I2C.MUX.CH0 },
            Package () { "maximum-power-milliwatt", 1000 },
            Package () { "tx-disable-gpios", Package () { ^SFP0, 0, 0, 1} },
            Package () { "reset-gpio",       Package () { ^SFP0, 0, 1, 1} },
            Package () { "mod-def0-gpios",   Package () { ^SFP0, 0, 2, 1} },
            Package () { "tx-fault-gpios",   Package () { ^SFP0, 0, 3, 0} },
            Package () { "los-gpios",        Package () { ^SFP0, 0, 4, 1} },
        },
    })
}


> This appears to be enough to get a very minimal SFP instantiated. But
> then what?  How are you using it? How do you instantiate a Phylink
> instance for the MAC? How do you link the SFP to the Phylink?
>
> Before accepting this patch, i would like to know more about the
> complete solution.
>
> Thanks
> 	Andrew

I haven't gotten that far yet, but for the Phylink I was thinking something along the
lines of:

Device (PHY0)
{
    Name (_HID, "PRP0001")
    Name (_DSD, Package ()
    {
        ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
        Package () {
            Package () { "compatible", "ethernet-phy-ieee802.3-c45" },
            Package () { "sfp", \_SB.PCI0.RP01.SFP0 },
        },
    })
}

Phylink is already using the fwnode_property_get_reference_args(fwnode,
"sfp", ...), so it should work with ACPI.

I don't have a complete solution working yet. With these patches
I was hoping to get some early feedback.

Thanks,
Ruslan
