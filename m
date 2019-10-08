Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE10C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 06:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0632520673
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 06:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729963AbfJHGDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 02:03:18 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44925 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbfJHGDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 02:03:17 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iHiaX-00038n-G6; Tue, 08 Oct 2019 08:03:13 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1iHiaV-0001dd-UC; Tue, 08 Oct 2019 08:03:11 +0200
Date:   Tue, 8 Oct 2019 08:03:11 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        ckeepax@opensource.cirrus.com, LKML <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Subject: Re: [PATCH 1/3] regulator: core: fix boot-on regulators use_count
 usage
Message-ID: <20191008060311.3ukim22vv7ywmlhs@pengutronix.de>
References: <20190923181431.GU2036@sirena.org.uk>
 <CAD=FV=WVGj8xzKFFxsjpeuqtVzSvv22cHmWBRJtTbH00eC=E9w@mail.gmail.com>
 <20190923184907.GY2036@sirena.org.uk>
 <CAD=FV=VkaXDn034EFnJWYvWwyLgvq7ajfgMRm9mbhQeRKmPDRQ@mail.gmail.com>
 <20190924182758.GC2036@sirena.org.uk>
 <CAD=FV=WZSy6nHjsY2pvjcoR4iy64b35OPGEb3EPSSc5vpeTTuA@mail.gmail.com>
 <20190927084710.mt42454vsrjm3yh3@pengutronix.de>
 <CAD=FV=XM0i=GsvttJjug6VPOJJGHRqFmsmCp-1XXNvmsYp9sJA@mail.gmail.com>
 <20191007093429.qekysnxufvkbirit@pengutronix.de>
 <20191007182907.GB5614@sirena.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007182907.GB5614@sirena.co.uk>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 07:54:41 up 143 days, 12:12, 94 users,  load average: 0.03, 0.03,
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

On 19-10-07 19:29, Mark Brown wrote:
> On Mon, Oct 07, 2019 at 11:34:29AM +0200, Marco Felsch wrote:
> 
> > Sorry that won't fix my problem. If I drop the regulator-boot-on state
> > the fixed-regulator will disable this regulator but disable/enable this
> > regulator is only valid during suspend/resume. I don't say that my fix
> > is correct but we should fix this.
> 
> I'm having a bit of trouble parsing this but it sounds like you want the
> regulator to be always on in which case you should use the property
> specifically for that.

Sorry my english wasn't the best.. Imagine this case: The bootloader
turned the display on to show an early bootlogo. Now if I miss the
regulator-boot-on property the display is turned off and on. The turn
off comes from the regulator probe, the turn on comes from the cosumer.
Is that assumption correct?

Regards,
  Marco

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
