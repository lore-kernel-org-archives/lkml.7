Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60AB3C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 09:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 371DB214E0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 09:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="0gkGcUth"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfKLJPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 04:15:22 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36348 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfKLJPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 04:15:21 -0500
Received: by mail-wr1-f66.google.com with SMTP id r10so17637759wrx.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 01:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5zriEFojyVbt7ELQVanoYbgxzAFKHxi+UtmPwx0zmeQ=;
        b=0gkGcUth8FLOYxIwdZiDgR1Ug9t1VBkV/3FwqbV7Q0OlC+Vnjq19TT2qyCHUVKF/vP
         xdyiQ1QMLC15zHuNxZa0g4PJoKcO0gxfNPTSTdKFqWIDgBQucl+tKWv/Wgu96XF+l4EC
         GePrmS8gHuU5b34yWy4N1ZDP0a6Dm87jhF8JmDu8AL2s6dcQEiXZIW2FjIwPVEScBxcn
         6ul3OgpUkJcW9ZPpYN4sggNPfJ156PbxG9iFTX8eybTpwN1zHmR3LDOnCTShPahCKN60
         TNKZDin0L9emwY/sf5PJwSW1f4dE9rV1pSJ2wZuEBC63PHpBBtA2eWcyjUea0wS/FxP9
         Qr9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5zriEFojyVbt7ELQVanoYbgxzAFKHxi+UtmPwx0zmeQ=;
        b=efBYC8v0KRxkB2Kq0lxm06LPnNh2Svd0/97/ShNjBJu+a6079vgiU+ACDG365m3nMw
         nuaIDa9z1IOv29owDi1LcCG7cXOR3qZAL9HhtIhFQ8vq4uHqHok3kKFusoPG+XZlQULD
         thxEZxtyHOtX8oaSQ15hEoq8cHK1VvloGhbFW6eBLOxytFc61BWb+lxI6EKBITAJZB0O
         9tI7QU+q7XSF6WL2TgToW19ujzJZTCLI9r2GLYNDhCPcO+Q89FHQ9gC80ZGF9sfaqCve
         JYZEoliYF2Vcdmcpgu/l7RenYF328kElbRRJ20XKFp4PbpNVSehINVMeXdaJWxQPz7an
         l+qA==
X-Gm-Message-State: APjAAAWY0u2Nw92vCHvkwehHdr/VjH1IcSwEPN17617pAQumPpBx4cUO
        w4WBDJKSisj0srslFklmuOrRSA==
X-Google-Smtp-Source: APXvYqx+VbXRh53fdGzs8aktmfDb/8p3+34H0pWGuEbXJ4Iu26iSzSwF5u9NWkTtoQhxRr47dqsTZw==
X-Received: by 2002:adf:f388:: with SMTP id m8mr8138227wro.18.1573550117445;
        Tue, 12 Nov 2019 01:15:17 -0800 (PST)
Received: from netronome.com ([2001:982:756:703:d63d:7eff:fe99:ac9d])
        by smtp.gmail.com with ESMTPSA id h15sm16794949wrb.44.2019.11.12.01.15.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Nov 2019 01:15:16 -0800 (PST)
Date:   Tue, 12 Nov 2019 10:15:16 +0100
From:   Simon Horman <simon.horman@netronome.com>
To:     Andy Duan <fugang.duan@nxp.com>
Cc:     Chuhong Yuan <hslester96@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] [PATCH] net: fec: add a check for CONFIG_PM to avoid clock
 count mis-match
Message-ID: <20191112091515.glw4jzlqluecg4m2@netronome.com>
References: <20191106080128.23284-1-hslester96@gmail.com>
 <VI1PR0402MB3600F14956A82EF8D7B53CC4FF790@VI1PR0402MB3600.eurprd04.prod.outlook.com>
 <CANhBUQ1wZU92K=XTRCNU5HhOzZ761+S83zyjqOdZKpyQVuXrCw@mail.gmail.com>
 <VI1PR0402MB36000BE1C169ECA035BE3610FF790@VI1PR0402MB3600.eurprd04.prod.outlook.com>
 <CANhBUQ2qN+vLYiHdUFGH22LnTa3nuKMYncq3JHDJp=vM=ZvCPA@mail.gmail.com>
 <VI1PR0402MB3600111063607DDAC4DFFE26FF780@VI1PR0402MB3600.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR0402MB3600111063607DDAC4DFFE26FF780@VI1PR0402MB3600.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 01:44:11AM +0000, Andy Duan wrote:
> From: Chuhong Yuan <hslester96@gmail.com> Sent: Thursday, November 7, 2019 9:19 AM
> > On Wed, Nov 6, 2019 at 6:17 PM Andy Duan <fugang.duan@nxp.com> wrote:
> > >
> > > From: Chuhong Yuan <hslester96@gmail.com> Sent: Wednesday, November
> > 6,
> > > 2019 4:29 PM
> > > > On Wed, Nov 6, 2019 at 4:13 PM Andy Duan <fugang.duan@nxp.com>
> > wrote:
> > > > >
> > > > > From: Chuhong Yuan <hslester96@gmail.com> Sent: Wednesday,
> > > > > November
> > > > 6,
> > > > > 2019 4:01 PM
> > > > > > If CONFIG_PM is enabled, runtime pm will work and call
> > > > > > runtime_suspend automatically to disable clks.
> > > > > > Therefore, remove only needs to disable clks when CONFIG_PM is
> > > > disabled.
> > > > > > Add this check to avoid clock count mis-match caused by
> > double-disable.
> > > > > >
> > > > > > This patch depends on patch
> > > > > > ("net: fec: add missed clk_disable_unprepare in remove").
> > > > > >
> > > > > Please add Fixes tag here.
> > > > >
> > > >
> > > > The previous patch has not been merged to linux, so I do not know
> > > > which commit ID should be used.
> > >
> > > It should be merged into net-next tree.
> > >
> > 
> > I have searched in net-next but did not find it.

Commit ids are stable, so if there is an id in Linus's tree
it will be same in net-next (when the patch appears there).

So you want:

Fixes: c43eab3eddb4 ("net: fec: add missed clk_disable_unprepare in remove")

Also, it is unclear from the patch subject if this patch is targeted at
'net' or 'net-next'. But as c43eab3eddb4 is in Linus's tree I think
it should be for 'net'. So the correct patch subject would be:

[PATCH net] net: fec: add a check for CONFIG_PM to avoid clock

> David, please give the comment. Thanks.
> 
> Regards,
> Andy
> > 
> > > Andy
> > > >
> > > > > Andy
> > > > > > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> > > > > > ---
> > > > > >  drivers/net/ethernet/freescale/fec_main.c | 2 ++
> > > > > >  1 file changed, 2 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/net/ethernet/freescale/fec_main.c
> > > > > > b/drivers/net/ethernet/freescale/fec_main.c
> > > > > > index a9c386b63581..696550f4972f 100644
> > > > > > --- a/drivers/net/ethernet/freescale/fec_main.c
> > > > > > +++ b/drivers/net/ethernet/freescale/fec_main.c
> > > > > > @@ -3645,8 +3645,10 @@ fec_drv_remove(struct platform_device
> > > > *pdev)
> > > > > >                 regulator_disable(fep->reg_phy);
> > > > > >         pm_runtime_put(&pdev->dev);
> > > > > >         pm_runtime_disable(&pdev->dev);
> > > > > > +#ifndef CONFIG_PM
> > > > > >         clk_disable_unprepare(fep->clk_ahb);
> > > > > >         clk_disable_unprepare(fep->clk_ipg);
> > > > > > +#endif

FWIIW, I am surprised this is the cleanest way to resolve this problem,
though I confess that I have no specific alternative in mind.

> > > > > >         if (of_phy_is_fixed_link(np))
> > > > > >                 of_phy_deregister_fixed_link(np);
> > > > > >         of_node_put(fep->phy_node);
> > > > > > --
> > > > > > 2.23.0
> > > > >
