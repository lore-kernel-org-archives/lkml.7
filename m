Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EABC3A5A7
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 12:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C282C23405
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 12:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbfH3Mxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 08:53:50 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:39195 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbfH3Mxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 08:53:49 -0400
Received: from localhost (aclermont-ferrand-651-1-259-53.w86-207.abo.wanadoo.fr [86.207.98.53])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id B4278200005;
        Fri, 30 Aug 2019 12:53:45 +0000 (UTC)
Date:   Fri, 30 Aug 2019 14:53:38 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH 1/2] rtc: max77686: convert to devm_i2c_new_dummy_device()
Message-ID: <20190830125338.GP21922@piout.net>
References: <20190820154239.8230-1-wsa+renesas@sang-engineering.com>
 <20190820154239.8230-2-wsa+renesas@sang-engineering.com>
 <20190829205752.GL21922@piout.net>
 <20190830124554.GB2870@ninjato>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830124554.GB2870@ninjato>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2019 14:45:54+0200, Wolfram Sang wrote:
> On Thu, Aug 29, 2019 at 10:57:52PM +0200, Alexandre Belloni wrote:
> > On 20/08/2019 17:42:37+0200, Wolfram Sang wrote:
> > > I was about to simplify the call to i2c_unregister_device() when I
> > > realized that converting to devm_i2c_new_dummy_device() will simplify
> > > the driver a lot. So I took this approach.
> > > 
> > > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > > ---
> > > Build tested only, buildbot is happy, too.
> > > 
> > > Please apply to your tree.
> > > 
> > 
> > I'm confused because I already applied:
> > https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git/commit/?h=rtc-next&id=7150710f3084de8d35ce3221eeae2caee8813f92
> 
> The above was a mass conversion to i2c_new_dummy_device() to make sure
> all in-kernel users use the API returning an ERRPTR. Mass conversion to
> the devm_ variant of the same function was too troublesome.
> 
> With another series, I wanted to remove superfluous error checking of
> i2c_unregister_device() because it is NULL-ptr safe, like here:
> 
> > > -	if (info->rtc)
> > > -		i2c_unregister_device(info->rtc);
> 
> But for these two RTC drivers, I figured moving to devm_* is way easier
> than fixing up the mass conversion result from coccinelle.
> 

Ok so should I drop the previous patches and apply those instead?


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
