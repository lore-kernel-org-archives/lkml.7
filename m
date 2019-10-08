Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2291C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 20:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B01A821721
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 20:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730806AbfJHUQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 16:16:28 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52181 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbfJHUQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 16:16:28 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iHvuB-0000Y3-ML; Tue, 08 Oct 2019 22:16:23 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1iHvuA-00059u-9F; Tue, 08 Oct 2019 22:16:22 +0200
Date:   Tue, 8 Oct 2019 22:16:22 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        ckeepax@opensource.cirrus.com, LKML <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Subject: Re: [PATCH 1/3] regulator: core: fix boot-on regulators use_count
 usage
Message-ID: <20191008201622.b7ev4nfyhqapspon@pengutronix.de>
References: <20190927084710.mt42454vsrjm3yh3@pengutronix.de>
 <CAD=FV=XM0i=GsvttJjug6VPOJJGHRqFmsmCp-1XXNvmsYp9sJA@mail.gmail.com>
 <20191007093429.qekysnxufvkbirit@pengutronix.de>
 <20191007182907.GB5614@sirena.co.uk>
 <20191008060311.3ukim22vv7ywmlhs@pengutronix.de>
 <20191008125140.GK4382@sirena.co.uk>
 <20191008145605.5yf4hura7qu4fuyg@pengutronix.de>
 <20191008154213.GL4382@sirena.co.uk>
 <20191008161640.2fzqhrbc4ox6gjal@pengutronix.de>
 <20191008162333.GP4382@sirena.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008162333.GP4382@sirena.co.uk>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 22:04:44 up 144 days,  2:22, 98 users,  load average: 0.07, 0.11,
 0.04
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-10-08 17:23, Mark Brown wrote:
> On Tue, Oct 08, 2019 at 06:16:40PM +0200, Marco Felsch wrote:
> > On 19-10-08 16:42, Mark Brown wrote:
> 
> > > If this is a GPIO regulator then the Linux APIs mean you can't read the
> > > status back so it's one of the regulators for which this property was
> > > invented.  This is a real limitation of the Linux APIs, with most
> > > hardware you can actually read the status back so we shouldn't need
> > > this.
> 
> > I know and I followed the discussion between you and Doug. But it
> > is a valid use-case to have a external gpio-enabled regualtor connected
> > to a panel. If I don't mark the regulator as 'regualtor-boot-on' and use
> > the fixed.c driver (IMHO this is correct), the regulator gets disabled
> > during probe. So I will have a panel off/ panel on sequence during boot.
> 
> Right, this is why I am saying that this is one of the regulators for
> which this property was defined and where you should be using it.
> 
> > To avoid this I set the 'regualtor-boot-on' property but then I can't
> > disable the panel during suspend..
> 
> As you'll have seen from the discussion that's a bug, nothing should be
> taking a reference to the regulator outside of explicit enable calls.

Okay now we are on the right way :) Is the solution proposed by Doug:
".. we need to match "regulator->enable_count" to "rdev->use_count" at
the end of _regulator_get() in the exclusive case..." the correct fix?

Another question. Please can you have a look on the "DA9062 PMIC fixes
and features" series as well?

Regards,
  Marco

