Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C238FC3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 10:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2A7220830
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 10:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbfIVKYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 06:24:31 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:36212 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728125AbfIVKY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 06:24:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 13B61FB02;
        Sun, 22 Sep 2019 12:24:26 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CC0af0zyy5wC; Sun, 22 Sep 2019 12:24:24 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 3BAFF486A8; Sat, 21 Sep 2019 14:15:25 -0700 (PDT)
Date:   Sat, 21 Sep 2019 14:15:25 -0700
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] leds: lm3692x: Don't overwrite return value in
 error path
Message-ID: <20190921211525.GA8263@bogon.m.sigxcpu.org>
References: <cover.1568957104.git.agx@sigxcpu.org>
 <e3ee36845c1555bd722807f85329341d5ec9728e.1568957104.git.agx@sigxcpu.org>
 <2bde2870-08a3-38b9-9cd7-fee0e2107743@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2bde2870-08a3-38b9-9cd7-fee0e2107743@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,
On Fri, Sep 20, 2019 at 06:48:59AM -0500, Dan Murphy wrote:
> Guido
> 
> On 9/20/19 12:27 AM, Guido Günther wrote:
> > The driver currently reports successful initialization on every failure
> > as long as it's able to power off the regulator. Don't check the return
> > value of regulator_disable to avoid that.
> > 
> > Signed-off-by: Guido Günther <agx@sigxcpu.org>
> > ---
> >   drivers/leds/leds-lm3692x.c | 7 ++++---
> >   1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/leds/leds-lm3692x.c b/drivers/leds/leds-lm3692x.c
> > index 487228c2bed2..31115655f97b 100644
> > --- a/drivers/leds/leds-lm3692x.c
> > +++ b/drivers/leds/leds-lm3692x.c
> > @@ -198,7 +198,7 @@ static int lm3692x_brightness_set(struct led_classdev *led_cdev,
> >   static int lm3692x_init(struct lm3692x_led *led)
> >   {
> >   	int enable_state;
> > -	int ret;
> > +	int ret, ret2;
> >   	if (led->regulator) {
> >   		ret = regulator_enable(led->regulator);
> > @@ -313,14 +313,15 @@ static int lm3692x_init(struct lm3692x_led *led)
> >   		gpiod_direction_output(led->enable_gpio, 0);
> >   	if (led->regulator) {
> > -		ret = regulator_disable(led->regulator);
> > -		if (ret)
> > +		ret2 = regulator_disable(led->regulator);
> > +		if (ret2)
> >   			dev_err(&led->client->dev,
> >   				"Failed to disable regulator\n");
> 
> s/ret2/reg_ret
> 
> Like you did in patch 1 log the error code as well.
> 
> If regulator_disabled failed you might want to send that error code but
> either error returned is fine.

Changed in v3 - i opted to return the original error code since this is
likely what upper layers care about and only printk the regulator
failure one.
Thanks for the review,
 -- Guido

> 
> Dan
> 
> 
> >   	}
> >   	return ret;
> >   }
> > +
> >   static int lm3692x_probe_dt(struct lm3692x_led *led)
> >   {
> >   	struct fwnode_handle *child = NULL;
> 
