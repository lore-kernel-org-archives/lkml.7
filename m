Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1364C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 20:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B63F72184C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 20:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfKKUAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 15:00:09 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37965 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbfKKUAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 15:00:09 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iUFr3-00045n-V5; Mon, 11 Nov 2019 21:00:05 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iUFr3-0000Rx-DL; Mon, 11 Nov 2019 21:00:05 +0100
Date:   Mon, 11 Nov 2019 21:00:05 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, Neil Brown <neilb@suse.de>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, kernel@pengutronix.de,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 1/4] pwm: omap-dmtimer: remove pwmchip in .remove before
 making it unfunctional
Message-ID: <20191111200005.c37mecp44idxskjq@pengutronix.de>
References: <20191111071952.6pbswbboqreen6im@pengutronix.de>
 <20191111090357.13903-1-u.kleine-koenig@pengutronix.de>
 <dd3fe743-ee4a-153a-c044-40587568a494@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd3fe743-ee4a-153a-c044-40587568a494@web.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Markus,

On Mon, Nov 11, 2019 at 02:30:42PM +0100, Markus Elfring wrote:
> > In the old code (e.g.) mutex_destroy() was called before
> > pwmchip_remove(). Between these two calls it is possible that a pwm
> > callback is used which tries to grab the mutex.
> 
> How do you think about to add a more “imperative mood” for your
> change description?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=31f4f5b495a62c9a8b15b1c3581acd5efeb9af8c#n151

I described the old behaviour and like my wording.

> > +++ b/drivers/pwm/pwm-omap-dmtimer.c
> > @@ -351,6 +351,11 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
> >  static int pwm_omap_dmtimer_remove(struct platform_device *pdev)
> >  {
> >  	struct pwm_omap_dmtimer_chip *omap = platform_get_drvdata(pdev);
> > +	int ret;
> > +
> > +	ret = pwmchip_remove(&omap->chip);
> > +	if (ret)
> > +		return ret;
> >
> >  	if (pm_runtime_active(&omap->dm_timer_pdev->dev))
> >  		omap->pdata->stop(omap->dm_timer);
> 
> How do you think about to use the following statement variant?
> 
> +	int ret = pwmchip_remove(&omap->chip);

I think that between the declarations and code should be an empty line
and between the assignment to ret and the respective check there
shouldn't be one.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
