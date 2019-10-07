Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460ABC4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 09:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22AA821655
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 09:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbfJGJef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 05:34:35 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49005 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727272AbfJGJef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 05:34:35 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iHPPT-0003pH-HS; Mon, 07 Oct 2019 11:34:31 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1iHPPR-0007UZ-41; Mon, 07 Oct 2019 11:34:29 +0200
Date:   Mon, 7 Oct 2019 11:34:29 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        ckeepax@opensource.cirrus.com, LKML <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Subject: Re: [PATCH 1/3] regulator: core: fix boot-on regulators use_count
 usage
Message-ID: <20191007093429.qekysnxufvkbirit@pengutronix.de>
References: <20190917154021.14693-2-m.felsch@pengutronix.de>
 <CAD=FV=W7M8mwQqnPyU9vsK5VAdqqJdQdyxcoe9FRRGTY8zjnFw@mail.gmail.com>
 <20190923181431.GU2036@sirena.org.uk>
 <CAD=FV=WVGj8xzKFFxsjpeuqtVzSvv22cHmWBRJtTbH00eC=E9w@mail.gmail.com>
 <20190923184907.GY2036@sirena.org.uk>
 <CAD=FV=VkaXDn034EFnJWYvWwyLgvq7ajfgMRm9mbhQeRKmPDRQ@mail.gmail.com>
 <20190924182758.GC2036@sirena.org.uk>
 <CAD=FV=WZSy6nHjsY2pvjcoR4iy64b35OPGEb3EPSSc5vpeTTuA@mail.gmail.com>
 <20190927084710.mt42454vsrjm3yh3@pengutronix.de>
 <CAD=FV=XM0i=GsvttJjug6VPOJJGHRqFmsmCp-1XXNvmsYp9sJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=XM0i=GsvttJjug6VPOJJGHRqFmsmCp-1XXNvmsYp9sJA@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:28:21 up 142 days, 15:46, 94 users,  load average: 0.00, 0.02,
 0.00
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug, Mark,

On 19-10-01 12:57, Doug Anderson wrote:
> Hi,
> 
> On Fri, Sep 27, 2019 at 1:47 AM Marco Felsch <m.felsch@pengutronix.de> wrote:
> > > > > > It should be possible to do a regulator_disable() though I'm not
> > > > > > sure anyone actually uses that.  The pattern for a regular
> > > > > > consumer should be the normal enable/disable pair to handle
> > > > > > shared usage, only an exclusive consumer should be able to use
> > > > > > just a straight disable.
> >
> > In my case it is a regulator-fixed which uses the enable/disable pair.
> > But as my descriptions says this will not work currently because boot-on
> > marked regulators can't be disabled right now (using the same logic as
> > always-on regulators).
> >
> > > > > Ah, I see, I wasn't aware of the "exclusive" special case!  Marco: is
> > > > > this working for you?  I wonder if we need to match
> > > > > "regulator->enable_count" to "rdev->use_count" at the end of
> > > > > _regulator_get() in the exclusive case...
> >
> > So my fix isn't correct to fix this in general?
> 
> I don't think your fix is correct.  It sounds as if the intention of
> "regulator-boot-on" is to have the OS turn the regulator on at bootup
> and it keep an implicit reference until someone explicitly tells the
> OS to drop the reference.
> 
> 
> > > > Yes, I think that case has been missed when adding the enable
> > > > counts - I've never actually had a system myself that made any
> > > > use of this stuff.  It probably needs an audit of the users to
> > > > make sure nobody's relying on the current behaviour though I
> > > > can't think how they would.
> > >
> > > Marco: I'm going to assume you'll tackle this since I don't actually
> > > have any use cases that need this.
> >
> > My use case is a simple regulator-fixed which is turned on by the
> > bootloader or to be more precise by the pmic-rom. To map that correctly
> > I marked this regulator as boot-on. Unfortunately as I pointed out above
> > this is handeld the same way as always-on.
> 
> It's a fixed regulator controlled by a GPIO?  Presumably the GPIO can
> be read.  That would mean it ideally shouldn't be using
> "regulator-boot-on" since this is _not_ a regulator whose software
> state can't be read.  Just remove the property.

Sorry that won't fix my problem. If I drop the regulator-boot-on state
the fixed-regulator will disable this regulator but disable/enable this
regulator is only valid during suspend/resume. I don't say that my fix
is correct but we should fix this.

Regards,
  Marco

> -Doug
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
