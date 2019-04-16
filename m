Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05371C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 12:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB5E205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 12:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbfDPMzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 08:55:41 -0400
Received: from mga06.intel.com ([134.134.136.31]:4944 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727821AbfDPMzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 08:55:41 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Apr 2019 05:52:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,357,1549958400"; 
   d="scan'208";a="162363516"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga004.fm.intel.com with ESMTP; 16 Apr 2019 05:52:36 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hGNZi-00037H-Hs; Tue, 16 Apr 2019 15:52:34 +0300
Date:   Tue, 16 Apr 2019 15:52:34 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Life is hard, and then you die" <ronald@innovation.ch>
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
Message-ID: <20190416125234.GD9224@smile.fi.intel.com>
References: <20190415081300.24831-1-ronald@innovation.ch>
 <20190415081300.24831-3-ronald@innovation.ch>
 <20190415090346.GL9224@smile.fi.intel.com>
 <20190415230955.GA13033@innovation.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190415230955.GA13033@innovation.ch>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 04:09:55PM -0700, Life is hard, and then you die wrote:
> On Mon, Apr 15, 2019 at 12:03:46PM +0300, Andy Shevchenko wrote:
> > On Mon, Apr 15, 2019 at 01:13:00AM -0700, Ronald Tschalär wrote:

> > > +static void
> > > +applespi_remap_fn_key(struct keyboard_protocol *keyboard_protocol)
> > > +{
> > > +	unsigned char tmp;
> > 
> > > +	u8 bit = BIT(fnremap - 1);
> > 
> > The above is UB and I'm sorry I didn't find this earlier.
> > 
> > So, something like this would work
> > 
> > 	u8 bit = BIT((fnremap - 1) & 0x07);
> 
> fnremap is already constrained by the following:

"already" is a wrong word here. Compiler checks in the order of appearing, so,
for it it is UB and we need to limit bits to allowed range, up to 31 for
unsigned int.

> 
> > > +
> > > +	if (!fnremap || fnremap > ARRAY_SIZE(applespi_controlcodes) ||
> > > +	    !applespi_controlcodes[fnremap - 1])
> > > +		return;
> 
> and the array-size of applespi_controlcodes is constrained to the
> number of bits in u8 according to this assertion
> 
> > > +	compiletime_assert(ARRAY_SIZE(applespi_controlcodes) ==
> > > +			   sizeof_field(struct keyboard_protocol, modifiers) * 8,
> > > +			   "applespi_controlcodes has wrong number of entries");
> 
> So I don't see that the masking buys anything new.

It buys us the follow to the standard. But gcc is clever enough to strip number
to allowed one.

-- 
With Best Regards,
Andy Shevchenko


