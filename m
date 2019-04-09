Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95C7C10F13
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 03:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F18F21473
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 03:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=innovation.ch header.i=@innovation.ch header.b="VvPAADhp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbfDIDXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 23:23:32 -0400
Received: from chill.innovation.ch ([216.218.245.220]:39204 "EHLO
        chill.innovation.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfDIDXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 23:23:32 -0400
Date:   Mon, 8 Apr 2019 20:23:31 -0700
DKIM-Filter: OpenDKIM Filter v2.10.3 chill.innovation.ch 439C964013A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innovation.ch;
        s=default; t=1554780211;
        bh=6sq4QRoaUT162PxaRzedOhV5IPeOyGs+EtwLB1FzIv0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VvPAADhpzA8nI6B2Fsk3D8zRMe6OMzsIREesSfHtn0ady6Q0YB6JMbGcXs62mwUw0
         Io42qqv7oCBhvBLNOpov7jdt/scezh6JQcgjV46C/c43O07n0RlzebCWfpavz4tv1h
         5db6fWn//83IMA3eqsFr06M3KgeaksS2RRgCH3fs1/HEK+kmefxVPRTAo56y1V5de7
         x2fEQtUSyhHCw/aYLlY9WnE39rdPRnHQjfo0cgLGsyBrCheO04VkSd3jr5nxpndddL
         95vjHWkN65gKY5IeGakdYmHngQCXD/JvwvzmHRzx7s0PKfBJp3ZqKUtatL+lG92GCl
         BjvPhqo7CzY4w==
From:   "Life is hard, and then you die" <ronald@innovation.ch>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Federico Lorenzi <federico@travelground.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] Input: add Apple SPI keyboard and trackpad driver.
Message-ID: <20190409032331.GA478@innovation.ch>
References: <20190407050358.2976-1-ronald@innovation.ch>
 <20190407050358.2976-3-ronald@innovation.ch>
 <20190408123343.GO9224@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190408123343.GO9224@smile.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Apr 08, 2019 at 03:33:43PM +0300, Andy Shevchenko wrote:
> On Sat, Apr 06, 2019 at 10:03:58PM -0700, Ronald Tschalär wrote:
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
> Thank you for an update, my comments below.

Thank you again for your review.

[snip]
> > +	} else {
> > +		struct dentry *ret;
> > +
> > +		ret = debugfs_create_bool("enable_tp_dim", 0600,
> > +					  applespi->debugfs_root,
> > +					  &applespi->debug_tp_dim);
> > +		if (IS_ERR(ret))
> > +			dev_warn(&(applespi)->spi->dev,
> > +				 "Error creating debugfs entry enable_tp_dim (%ld)\n",
> > +				 PTR_ERR(ret));
> 
> Can ret be NULL?

No, it actually can't (I manually traced all code paths to be sure):
the documentation for these helper functions is wrong in this respect.
However, I note that a lot of existing kernel code also has this wrong
(i.e. it's checking for NULL). Digging a bit further and looking at
the history, it appears this was changed just recently (commit
ff9fb72b "debugfs: return error values, not NULL"), which would
explain the existing code and documentation. I'll submit a patch to
update the docs.

> dev_dbg() looks more appropriate.

Hmm, ok, I guess I find this a bit odd, though: true, this only
affects code used for debugging, but it's nevertheless an error that
shouldn't normally occur.


  Cheers,

  Ronald

