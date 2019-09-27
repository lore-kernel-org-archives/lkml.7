Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8262C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D82217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbfI0IrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 04:47:18 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50613 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfI0IrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 04:47:17 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iDluC-000704-Fy; Fri, 27 Sep 2019 10:47:12 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1iDluB-0007Up-0M; Fri, 27 Sep 2019 10:47:11 +0200
Date:   Fri, 27 Sep 2019 10:47:10 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        ckeepax@opensource.cirrus.com, LKML <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Subject: Re: [PATCH 1/3] regulator: core: fix boot-on regulators use_count
 usage
Message-ID: <20190927084710.mt42454vsrjm3yh3@pengutronix.de>
References: <20190917154021.14693-1-m.felsch@pengutronix.de>
 <20190917154021.14693-2-m.felsch@pengutronix.de>
 <CAD=FV=W7M8mwQqnPyU9vsK5VAdqqJdQdyxcoe9FRRGTY8zjnFw@mail.gmail.com>
 <20190923181431.GU2036@sirena.org.uk>
 <CAD=FV=WVGj8xzKFFxsjpeuqtVzSvv22cHmWBRJtTbH00eC=E9w@mail.gmail.com>
 <20190923184907.GY2036@sirena.org.uk>
 <CAD=FV=VkaXDn034EFnJWYvWwyLgvq7ajfgMRm9mbhQeRKmPDRQ@mail.gmail.com>
 <20190924182758.GC2036@sirena.org.uk>
 <CAD=FV=WZSy6nHjsY2pvjcoR4iy64b35OPGEb3EPSSc5vpeTTuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=WZSy6nHjsY2pvjcoR4iy64b35OPGEb3EPSSc5vpeTTuA@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 10:33:10 up 132 days, 14:51, 84 users,  load average: 0.00, 0.10,
 0.12
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

sorry for the delay..

On 19-09-26 12:44, Doug Anderson wrote:
> Hi,
> 
> On Tue, Sep 24, 2019 at 11:28 AM Mark Brown <broonie@kernel.org> wrote:
> > On Mon, Sep 23, 2019 at 03:40:09PM -0700, Doug Anderson wrote:
> > > On Mon, Sep 23, 2019 at 11:49 AM Mark Brown <broonie@kernel.org> wrote:
> > > > On Mon, Sep 23, 2019 at 11:36:11AM -0700, Doug Anderson wrote:
> >
> > > > > 1. Would it be valid to say that it's always incorrect to set this
> > > > > property if there is a way to read the status back from the regulator?
> >
> > > > As originally intended, yes.  I'm now not 100% sure that it won't
> > > > break any existing systems though :/
> >
> > > Should I change the bindings doc to say that?
> >
> > Sure.
> 
> Sent ("regulator: Document "regulator-boot-on" binding more thoroughly").
> 
> https://lore.kernel.org/r/20190926124115.1.Ice34ad5970a375c3c03cb15c3859b3ee501561bf@changeid

Yes, I saw it and thanks for it =)

> > > > It should be possible to do a regulator_disable() though I'm not
> > > > sure anyone actually uses that.  The pattern for a regular
> > > > consumer should be the normal enable/disable pair to handle
> > > > shared usage, only an exclusive consumer should be able to use
> > > > just a straight disable.

In my case it is a regulator-fixed which uses the enable/disable pair.
But as my descriptions says this will not work currently because boot-on
marked regulators can't be disabled right now (using the same logic as
always-on regulators).

> > > Ah, I see, I wasn't aware of the "exclusive" special case!  Marco: is
> > > this working for you?  I wonder if we need to match
> > > "regulator->enable_count" to "rdev->use_count" at the end of
> > > _regulator_get() in the exclusive case...

So my fix isn't correct to fix this in general?

> > Yes, I think that case has been missed when adding the enable
> > counts - I've never actually had a system myself that made any
> > use of this stuff.  It probably needs an audit of the users to
> > make sure nobody's relying on the current behaviour though I
> > can't think how they would.
> 
> Marco: I'm going to assume you'll tackle this since I don't actually
> have any use cases that need this.

My use case is a simple regulator-fixed which is turned on by the
bootloader or to be more precise by the pmic-rom. To map that correctly
I marked this regulator as boot-on. Unfortunately as I pointed out above
this is handeld the same way as always-on.

Regards,
  Marco

> -Doug
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
