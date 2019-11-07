Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE42FA372C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 01:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87B2A217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 01:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WybOMlcE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732801AbfKGBTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 20:19:39 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43221 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728041AbfKGBTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 20:19:38 -0500
Received: by mail-ed1-f66.google.com with SMTP id w6so448887edx.10;
        Wed, 06 Nov 2019 17:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=01gH6mza7gRt0mSaASLNbF4mMLN3fqC1wtVcO2OI7XE=;
        b=WybOMlcEDhjLxs8fS5g1kAQ/8E6LxAjtuHZEHlCiws/lueLEoT76M918YPp+mdY7vI
         7JhttppNJECSlZtaxuie0Z7pBH1zve8TqkucbUrpGwo8afa7FoO8p62je4JBUF2hvFjs
         nNMU8EJ+owWTbUJuiG8YoYWMxbyJbd6j9IlyyBni5LPrxScV91s4HNEyRMTECxdJLjFn
         drPeOpyhY/XbBCD60gCl2EYUbWz2R5m7LBreYs90OD8sTcjpNelpnB3pzWDqJ1UdxAL2
         DG/4kMkuix+/uE2QUtI7DCGKDPgqSt+pPQIMFCuJeZ7uK5FmeAKTFRC+dMZx9uX0hOxI
         e89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=01gH6mza7gRt0mSaASLNbF4mMLN3fqC1wtVcO2OI7XE=;
        b=Z7koPdq/Oxxfo506PVgudbQi24fd1i0njTWhmh27OCRgSGpGdp/8lzdfmfx+3Rk9PW
         ocCqWxe10gnYA5mh4B/GJ2+OD+uhmF6a7um5woLMZWhAZLxZ1o+Q9pUCs9NSr/drgpRT
         dX/wbgRZKfJoIELjV9PwHc1znF+7KMETsvsB3C3UVjGMHCptz0S39UmgojcH81mZDnIm
         eLVxwBbhzvEwxxjtV/tghBC6JAerYjcVud3xlf+HHzC75BzIoKDPrdDWyz+AuxNC7gIr
         rDnKQbzvcXUMIuyXXrxa+M4DXsYtRs3KqzEY7X+ZEodaifeLiAmiEh92FvEEjyzSyXwH
         XI7Q==
X-Gm-Message-State: APjAAAV8ZNVSRaPppA9bYJ4eNMtDK/rQ0dipC6wJ+CfQXMJGjqszs6al
        PwDhVQ9+i4SSlx9qEGGts6JJxComYn8xiRw71jfuij6O9eY=
X-Google-Smtp-Source: APXvYqwHpVx8zvfSTE96Rk7YcnyeKYzI/XT8zuroIijOODHGp7fF2QMdRi/BThgivPTFjisNMlrjwmUcvm5NxDeAnPQ=
X-Received: by 2002:aa7:d4d8:: with SMTP id t24mr883728edr.40.1573089577113;
 Wed, 06 Nov 2019 17:19:37 -0800 (PST)
MIME-Version: 1.0
References: <20191106080128.23284-1-hslester96@gmail.com> <VI1PR0402MB3600F14956A82EF8D7B53CC4FF790@VI1PR0402MB3600.eurprd04.prod.outlook.com>
 <CANhBUQ1wZU92K=XTRCNU5HhOzZ761+S83zyjqOdZKpyQVuXrCw@mail.gmail.com> <VI1PR0402MB36000BE1C169ECA035BE3610FF790@VI1PR0402MB3600.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR0402MB36000BE1C169ECA035BE3610FF790@VI1PR0402MB3600.eurprd04.prod.outlook.com>
From:   Chuhong Yuan <hslester96@gmail.com>
Date:   Thu, 7 Nov 2019 09:19:25 +0800
Message-ID: <CANhBUQ2qN+vLYiHdUFGH22LnTa3nuKMYncq3JHDJp=vM=ZvCPA@mail.gmail.com>
Subject: Re: [EXT] [PATCH] net: fec: add a check for CONFIG_PM to avoid clock
 count mis-match
To:     Andy Duan <fugang.duan@nxp.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 6, 2019 at 6:17 PM Andy Duan <fugang.duan@nxp.com> wrote:
>
> From: Chuhong Yuan <hslester96@gmail.com> Sent: Wednesday, November 6, 2019 4:29 PM
> > On Wed, Nov 6, 2019 at 4:13 PM Andy Duan <fugang.duan@nxp.com> wrote:
> > >
> > > From: Chuhong Yuan <hslester96@gmail.com> Sent: Wednesday, November
> > 6,
> > > 2019 4:01 PM
> > > > If CONFIG_PM is enabled, runtime pm will work and call
> > > > runtime_suspend automatically to disable clks.
> > > > Therefore, remove only needs to disable clks when CONFIG_PM is
> > disabled.
> > > > Add this check to avoid clock count mis-match caused by double-disable.
> > > >
> > > > This patch depends on patch
> > > > ("net: fec: add missed clk_disable_unprepare in remove").
> > > >
> > > Please add Fixes tag here.
> > >
> >
> > The previous patch has not been merged to linux, so I do not know which
> > commit ID should be used.
>
> It should be merged into net-next tree.
>

I have searched in net-next but did not find it.

> Andy
> >
> > > Andy
> > > > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> > > > ---
> > > >  drivers/net/ethernet/freescale/fec_main.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/drivers/net/ethernet/freescale/fec_main.c
> > > > b/drivers/net/ethernet/freescale/fec_main.c
> > > > index a9c386b63581..696550f4972f 100644
> > > > --- a/drivers/net/ethernet/freescale/fec_main.c
> > > > +++ b/drivers/net/ethernet/freescale/fec_main.c
> > > > @@ -3645,8 +3645,10 @@ fec_drv_remove(struct platform_device
> > *pdev)
> > > >                 regulator_disable(fep->reg_phy);
> > > >         pm_runtime_put(&pdev->dev);
> > > >         pm_runtime_disable(&pdev->dev);
> > > > +#ifndef CONFIG_PM
> > > >         clk_disable_unprepare(fep->clk_ahb);
> > > >         clk_disable_unprepare(fep->clk_ipg);
> > > > +#endif
> > > >         if (of_phy_is_fixed_link(np))
> > > >                 of_phy_deregister_fixed_link(np);
> > > >         of_node_put(fep->phy_node);
> > > > --
> > > > 2.23.0
> > >
