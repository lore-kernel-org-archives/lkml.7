Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50480C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2021720823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731219AbfB1IW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 03:22:56 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33444 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbfB1IWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 03:22:55 -0500
Received: by mail-lj1-f193.google.com with SMTP id z7so16136051lji.0;
        Thu, 28 Feb 2019 00:22:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K1rJqDbahCX132JDH00YZY2kcH4sksWbtnkn8pkBJOA=;
        b=HcBBGd81dUeEc671uUiFL0vzCiT9STkavTxeJU9KPw6G1wi0SlT/i9OwHEATaxc9IM
         feioD6f5A+a2up72xToZ2+DSBbTjc5Dwa2Hqbeahp+xraThlYioO1iidmsZqylt+sDHl
         P+otXFEA7gYJ3rwBlHYS7nAlr3I2dZaB+w0qiFv/tja8WbQt4flh2Xxhn2DKUGynQouQ
         pGqTEt+t6tRUaMX/ty0Ac3LYvO9q36/Hh4XxL/CMlEx+SFXLWq8czccPmeqoVNq/9ffz
         aIu4ADitp3vOzbtRRqLHH2a9qGi6UuVs4pJO8T1JczGt+jhS8/rm9crDV8rbhJU5CvUY
         m5ew==
X-Gm-Message-State: APjAAAVHlrpopeDJQBtgdJ5U03kXJC6wVYHpV0M7ytXjxDq/GFi/jcg7
        U9xTyQBtGN6i07YmCv+wTKg=
X-Google-Smtp-Source: AHgI3Ia+PNhCfpt2ZNk19Ax8heLBizs83VUlDkNEDtmOhvcCGQmZx6RkdVzBwO97F1eY+y4m/2Vbmg==
X-Received: by 2002:a2e:2c3:: with SMTP id y64mr3961833lje.131.1551342172483;
        Thu, 28 Feb 2019 00:22:52 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id l11sm3963595lja.38.2019.02.28.00.22.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 00:22:51 -0800 (PST)
Date:   Thu, 28 Feb 2019 10:22:48 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     mazziesaccount@gmail.com, Guenter Roeck <linux@roeck-us.net>,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com,
        robh+dt@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, lgirdwood@gmail.com, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, bogdan-petru.chircu-mare@nxp.com
Subject: Re: [PATCH v10 0/9] support ROHM BD70528 PMIC
Message-ID: <20190228082248.GC3773@localhost.localdomain>
References: <cover.1550148989.git.matti.vaittinen@fi.rohmeurope.com>
 <20190228070450.GB3773@localhost.localdomain>
 <20190228081055.GL4118@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228081055.GL4118@dell>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Lee, Mark,

On Thu, Feb 28, 2019 at 08:10:55AM +0000, Lee Jones wrote:
> On Thu, 28 Feb 2019, Matti Vaittinen wrote:
> 
> > Hello Lee and Mark,
> > 
> > On Thu, Feb 14, 2019 at 03:02:37PM +0200, Matti Vaittinen wrote:
> > > Patch series introducing support for ROHM BD70528 PMIC
> > > 
> > I was wondering if there is anything that could be done to allow the MFD
> > part of this series to end up in upstream without having to wait the
> > regmap-irq changes
> > (https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git/commit/?h=topic/irq)
> >  to be merged from Linus' tree to MFD tree? If I see it correctly, the
> > regmap-irq (main-irq-reg support) changes are not targeted to linux 5.1.
> > To me it looks like getting them to MFD via Linus' tree will take a while.
> > 
> > The MFD part depends on the regmap-irq changes and I think that most
> > other subsystems want to have the MFD changes in before taking rest of
> > the driver in their trees. So it will be a while untill all the changes
> > are in. It would really be nice to have the drive in-tree sooner - hence
> > I ask if theres a way. (I don't want to push, just ask if it is possible :])
> 
> It's possible, so long as there aren't any build-time dependencies
> between the subsystems.  Immediate acceptance however isn't possible
> due to the impending merge-window which opens in 3 days.

Thanks for reply Lee. So merge-window is opening - meaning the 5.1 is
being baked now(?) 

Anyays to make it clear - there is build time dependency between MFD and
regmap-irq changes. MFD part won't compile without the changes in regmap
tree. And theres no new Kconfig to depend on or other compile time
checks. So REGMAP changes are required for this MFD portion to compile.

So my question actually is if the MFD portion must wait untill REGMAP
goes to Linus tree (at 5.2(?))- and then get merged to MFD tree later -
or if the regmap-irq changes can go to MFD via some other route (sorry -
I don't really know how you guys do maintain the trees - I really lack
of the insight/skills on that area :])

Rest of the subsystems (regulator, clk, watchdog, gpio) do all depend on
MFD - but they should have 'depends on' KConfig to MFD meaning they
won't be built without MFD.

Br,
	Matti Vaittinen

-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
