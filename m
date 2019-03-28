Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2454C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 00:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D6A020700
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 00:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=innovation.ch header.i=@innovation.ch header.b="RWp2NPdL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfC1AYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 20:24:39 -0400
Received: from chill.innovation.ch ([216.218.245.220]:46406 "EHLO
        chill.innovation.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfC1AYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 20:24:38 -0400
Date:   Wed, 27 Mar 2019 17:24:38 -0700
DKIM-Filter: OpenDKIM Filter v2.10.3 chill.innovation.ch 27D2764012F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innovation.ch;
        s=default; t=1553732678;
        bh=fB4qUozCYKeRMf2R/DBnaoHZH4gpE5gIcFrbM+jLr/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RWp2NPdL0pKkCMv1/g1WKZqTJCaKx9TC4fpeYC9C1BQeeesSjBkjJV8rgQ7WP51QY
         JLW/zh0EF6DTOQBKM7QCtUcQyRpNsFoVOp0PSreDMexGtDCU0CtmXIS7ZdvNq2UBxV
         GpYacNfDH7WQOXAM1sGulQu6o+ukRw3+aWZtTNsamTHxmVEz2p2KYygbgGyDKDmLnS
         h8x5QJfm2HMGbmQ6N5N+ijuR0PRiuFT8LEOEywxZ7uOkvzJdFreiUuP8eysVvRoPE+
         Mcu0Pi4PBZSz9fB3wFjnpHQPAaO8qSXGCBDGvJmFAVz3ymyRGEq16NNLY6f/ZJak77
         seUFPzG/NJulg==
From:   "Life is hard, and then you die" <ronald@innovation.ch>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Federico Lorenzi <federico@travelground.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] Input: add Apple SPI keyboard and trackpad driver.
Message-ID: <20190328002438.GE24753@innovation.ch>
References: <20190327014807.7472-1-ronald@innovation.ch>
 <20190327014807.7472-5-ronald@innovation.ch>
 <20190327093530.GH9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190327093530.GH9224@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Mar 27, 2019 at 11:35:30AM +0200, Andy Shevchenko wrote:
> On Tue, Mar 26, 2019 at 06:48:07PM -0700, Ronald Tschalär wrote:
> > The keyboard and trackpad on recent MacBook's (since 8,1) and
> > MacBookPro's (13,* and 14,*) are attached to an SPI controller instead
> > of USB, as previously. The higher level protocol is not publicly
> > documented and hence has been reverse engineered. As a consequence there
> > are still a number of unknown fields and commands. However, the known
> > parts have been working well and received extensive testing and use.
[snip]
> > +#include <asm/barrier.h>
> 
> > +#include <asm-generic/unaligned.h>
> 
> generic?!
> 
> #include <asm/unaligned.h>
> should work.

Yes, you're right. I brought myself up-to-speed now on the difference
between the two.

> > +static const char *applespi_debug_facility(unsigned int log_mask)
> > +{
> > +	switch (log_mask) {
> > +	case DBG_CMD_TP_INI:
> > +		return "Touchpad Initialization";
> > +	case DBG_CMD_BL:
> > +		return "Backlight Command";
> > +	case DBG_CMD_CL:
> > +		return "Caps-Lock Command";
> > +	case DBG_RD_KEYB:
> > +		return "Keyboard Event";
> > +	case DBG_RD_TPAD:
> > +		return "Touchpad Event";
> > +	case DBG_RD_UNKN:
> > +		return "Unknown Event";
> > +	case DBG_RD_IRQ:
> > +		return "Interrupt Request";
> > +	case DBG_RD_CRC:
> > +		return "Corrupted packet";
> > +	case DBG_TP_DIM:
> > +		return "Touchpad Dimensions";
> > +	default:
> 
> > +		return "-Unrecognized log mask-";
> 
> I don't think '-' surroundings are needed, but this is rather minor. Up to you.

I've used that to distinguish an error value from normal values; but
that's not an idiom used in the kernel AFAICT, so I'll remove them.

Thanks.


  Cheers,

  Ronald

