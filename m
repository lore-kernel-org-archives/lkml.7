Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BE2C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 08:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF8D220640
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 08:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730014AbfIRISO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 04:18:14 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53963 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbfIRISN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 04:18:13 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iAVA9-0005wX-KR; Wed, 18 Sep 2019 10:18:09 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1iAVA7-0006x5-PO; Wed, 18 Sep 2019 10:18:07 +0200
Date:   Wed, 18 Sep 2019 10:18:07 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     zhang.chunyan@linaro.org, Doug Anderson <dianders@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, ckeepax@opensource.cirrus.com,
        lkml <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Subject: Re: [PATCH 3/3] regulator: core: make regulator_register()
 EPROBE_DEFER aware
Message-ID: <20190918081807.yl4lkjgosq5bhow3@pengutronix.de>
References: <20190917154021.14693-1-m.felsch@pengutronix.de>
 <20190917154021.14693-4-m.felsch@pengutronix.de>
 <CAKdAkRSi+d0AXwXaxc4wx+p2kAf=+_P8HZnq-sJAKmbwuuKH4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKdAkRSi+d0AXwXaxc4wx+p2kAf=+_P8HZnq-sJAKmbwuuKH4Q@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 10:11:24 up 123 days, 14:29, 70 users,  load average: 0.15, 0.11,
 0.06
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-09-17 17:57, Dmitry Torokhov wrote:
> On Tue, Sep 17, 2019 at 4:42 PM Marco Felsch <m.felsch@pengutronix.de> wrote:
> >
> > Sometimes it can happen that the regulator_of_get_init_data() can't
> > retrieve the config due to a not probed device the regulator depends on.
> > Fix that by checking the return value of of_parse_cb() and return
> > EPROBE_DEFER in such cases.
> 
> Treating EPROBE_DEFER in a special way is usually wrong.
> regulator_of_get_init_data() may fail for multiple reasons (no memory,
> invalid DT, etc, etc). All of them should abort instantiating
> regulator.

Those errors are handled but the behaviour of this funciton is to return
NULL in such errors which is fine for the caller of this function. I
only want to handle EPROBE_DEFER special..

Regards,
  Marco


> Thanks.
> 
> -- 
> Dmitry
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
