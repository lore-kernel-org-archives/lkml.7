Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0B2C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 21:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64D52214C6
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 21:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfFHVCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 17:02:40 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38457 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727372AbfFHVCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 17:02:40 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 7551880257; Sat,  8 Jun 2019 23:02:27 +0200 (CEST)
Date:   Sat, 8 Jun 2019 23:02:26 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Doug Anderson <dianders@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Richard Purdie <rpurdie@rpsys.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Brian Norris <briannorris@google.com>,
        Guenter Roeck <groeck@google.com>,
        Lee Jones <lee.jones@linaro.org>,
        Alexandru Stan <amstan@google.com>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v3 3/4] backlight: pwm_bl: compute brightness of LED
 linearly to human eye.
Message-ID: <20190608210226.GB2359@xo-6d-61-c0.localdomain>
References: <20180208113032.27810-1-enric.balletbo@collabora.com>
 <20180208113032.27810-4-enric.balletbo@collabora.com>
 <20190607220947.GR40515@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607220947.GR40515@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > +	 * Note that this method is based on empirical testing on different
> > +	 * devices with PWM of 8 and 16 bits of resolution.
> > +	 */
> > +	n = period;
> > +	while (n) {
> > +		counter += n % 2;
> > +		n >>= 1;
> > +	}
> 
> I don't quite follow the heuristics above. Are you sure the number of
> PWM bits can be infered from the period? What if the period value (in
> ns) doesn't directly correspond to a register value? And even if it
> did, counting the number of set bits (the above loops is a
> re-implementation of ffs()) doesn't really result in the dividers
> mentioned in the comment. E.g. a period of 32768 ns (0x8000) results
> in a divider of 1, i.e. 32768 brighness levels.
> 
> On veyron minnie the period is 1000000 ns, which results in 142858
> levels (1000000 / 7)!
> 
> Not sure if there is a clean solution using heuristics, a DT property
> specifying the number of levels could be an alternative. This could
> also be useful to limit the number of (mostly) redundant levels, even
> the intended max of 4096 seems pretty high.
> 
> Another (not directly related) observation is that on minnie the
> actual brightness at a nominal 50% is close to 0 (duty cycle ~3%). I
> haven't tested with other devices, but I wonder if it would make
> sense to have an option to drop the bottom N% of levels, since the
> near 0 brightness in the lower 50% probably isn't very useful in most
> use cases, but maybe it looks different on other devices.

Eye percieves logarithm(duty cycle), mostly, and I find very low brightness
levels quite useful when trying to use machine in dark room.

But yes, specifying if brightness is linear or exponential would be quite
useful.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
