Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A82C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 23:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 534D82084B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 23:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=innovation.ch header.i=@innovation.ch header.b="D3iMRl6J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbfDOXJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 19:09:56 -0400
Received: from chill.innovation.ch ([216.218.245.220]:58114 "EHLO
        chill.innovation.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbfDOXJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 19:09:56 -0400
Date:   Mon, 15 Apr 2019 16:09:55 -0700
DKIM-Filter: OpenDKIM Filter v2.10.3 chill.innovation.ch C6DDE640133
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innovation.ch;
        s=default; t=1555369795;
        bh=MYeycwUDmoLZRR45PUgS2HDWNt0lTCMxisXhlhbXmXs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D3iMRl6JNlrX0yUGdSss9nCkNWf7l4DJS8pQMxUqAkNRWP/XNsotih9ZuZ2JGqL0D
         7CjH5FctpUsJzNmqTivGcxX8xD+518NM4IAtc20UYa7cZMGLpcNTgMJVWs4fn0mWnq
         7KMvuwnZaJpcWcHfv1HMujRZy8ip63zxlLnZPMa71dkfid2Lb/HqOMxwPD8Yofo40o
         WuQqWCDzMrHHfT30JK7ti7OnIGV3vC4JdGhxgQ0U3ZPnldWYy92sCaKHJ5UOdUWj4i
         DvWk6TYtaZuUY8LEHRPqkmwyj/00EdDn+XlDD+N63Osy+v+ZAtRbfkzS3zD7t/zUQY
         MHxq6xtDXOy0w==
From:   "Life is hard, and then you die" <ronald@innovation.ch>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Federico Lorenzi <federico@travelground.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-input@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] Input: add Apple SPI keyboard and trackpad driver.
Message-ID: <20190415230955.GA13033@innovation.ch>
References: <20190415081300.24831-1-ronald@innovation.ch>
 <20190415081300.24831-3-ronald@innovation.ch>
 <20190415090346.GL9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190415090346.GL9224@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


  Hi Andy,

On Mon, Apr 15, 2019 at 12:03:46PM +0300, Andy Shevchenko wrote:
> On Mon, Apr 15, 2019 at 01:13:00AM -0700, Ronald Tschalär wrote:
> > The keyboard and trackpad on recent MacBook's (since 8,1) and
> > MacBookPro's (13,* and 14,*) are attached to an SPI controller instead
> > of USB, as previously. The higher level protocol is not publicly
> > documented and hence has been reverse engineered. As a consequence there
> > are still a number of unknown fields and commands. However, the known
> > parts have been working well and received extensive testing and use.
> > 
> > In order for this driver to work, the proper SPI drivers need to be
> > loaded too; for MB8,1 these are spi_pxa2xx_platform and spi_pxa2xx_pci;
> > for all others they are spi_pxa2xx_platform and intel_lpss_pci. For this
> > reason enabling this driver in the config implies enabling the above
> > drivers.
> 
> Thank you for an update.
> I suddenly realized couple of places where something maybe optimized.
> 
> Nevertheless, FWIW,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Many thanks for all your reviews!

[snip]
> > +static void
> > +applespi_remap_fn_key(struct keyboard_protocol *keyboard_protocol)
> > +{
> > +	unsigned char tmp;
> 
> > +	u8 bit = BIT(fnremap - 1);
> 
> The above is UB and I'm sorry I didn't find this earlier.
> 
> So, something like this would work
> 
> 	u8 bit = BIT((fnremap - 1) & 0x07);

fnremap is already constrained by the following:

> > +
> > +	if (!fnremap || fnremap > ARRAY_SIZE(applespi_controlcodes) ||
> > +	    !applespi_controlcodes[fnremap - 1])
> > +		return;

and the array-size of applespi_controlcodes is constrained to the
number of bits in u8 according to this assertion

> > +	compiletime_assert(ARRAY_SIZE(applespi_controlcodes) ==
> > +			   sizeof_field(struct keyboard_protocol, modifiers) * 8,
> > +			   "applespi_controlcodes has wrong number of entries");

So I don't see that the masking buys anything new.

[snip]
> > +	/* check for rollover overflow, which is signalled by all keys == 1 */
> > +	for (i = 0; i < MAX_ROLLOVER; i++) {
> > +		if (keyboard_protocol->keys_pressed[i] != 1)
> > +			break;
> > +	}
> > +
> > +	if (i == MAX_ROLLOVER)	/* all keys were 1 */
> > +		return;
> 
> Since keys_pressed is an array of byte values, it may be replaced with
> memchr_inv().
> 
> > +
> > +	/* remap fn key if desired */
> > +	applespi_remap_fn_key(keyboard_protocol);
> > +
> > +	/* check released keys */
> > +	for (i = 0; i < MAX_ROLLOVER; i++) {
> > +		for (j = 0; j < MAX_ROLLOVER; j++) {
> > +			if (applespi->last_keys_pressed[i] ==
> > +			    keyboard_protocol->keys_pressed[j])
> > +				break;
> > +		}
> > +
> > +		if (j < MAX_ROLLOVER)	/* key is still pressed */
> > +			continue;
> 
> And memchr() here.

Ah, yes, excellent suggestion. Thanks.


  Cheers,

  Ronald

