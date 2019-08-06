Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10880C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E302A21743
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731834AbfHFHoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 03:44:17 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46019 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfHFHoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 03:44:17 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1huu8j-0003rN-Qc; Tue, 06 Aug 2019 09:44:13 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1huu8h-0006yx-7s; Tue, 06 Aug 2019 09:44:11 +0200
Date:   Tue, 6 Aug 2019 09:44:11 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Schrempf Frieder <frieder.schrempf@kontron.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 4/4] serial: 8250: Don't check for mctrl_gpio_init()
 returning -ENOSYS
Message-ID: <20190806074411.coizcyqs54ylgq3e@pengutronix.de>
References: <20190802100349.8659-1-frieder.schrempf@kontron.de>
 <20190802100349.8659-4-frieder.schrempf@kontron.de>
 <20190802121555.dl6rpjphgaxdvcke@pengutronix.de>
 <20190802122623.GA25281@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190802122623.GA25281@kroah.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Greg

On Fri, Aug 02, 2019 at 02:26:23PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Aug 02, 2019 at 02:15:55PM +0200, Uwe Kleine-König wrote:
> > On Fri, Aug 02, 2019 at 10:04:11AM +0000, Schrempf Frieder wrote:
> > > From: Frieder Schrempf <frieder.schrempf@kontron.de>
> > > 
> > > Now that the mctrl_gpio code returns NULL instead of ERR_PTR(-ENOSYS)
> > > if CONFIG_GPIOLIB is disabled, we can safely remove this check.
> > > 
> > > Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> > 
> > Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > 
> > @greg: This patch doesn't depend on patch 2; ditto for patch 3. So only
> > taking patches 1, 3 and 4 should be fine. This way Frieder's v4 only
> > have to care for patch 2. (Assuming noone objects to 1, 3 and 4 of
> > course.)
> 
> Sounds good, I'll do that, thanks.

again you somehow managed to mangle my name :-|

$ git log -3 8f0df898b27926e443d13770adfd828cc0f50148 | grep Uwe
    Acked-by: Uwe Kleine-Knig <u.kleine-koenig@pengutronix.de>
    Acked-by: Uwe Kleine-Knig <u.kleine-koenig@pengutronix.de>
    Reviewed-by: Uwe Kleine-Knig <u.kleine-koenig@pengutronix.de>

in all three instances the ö is missing.

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
