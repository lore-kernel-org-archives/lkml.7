Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88935C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 19:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A97C20652
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 19:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lJV8jtHp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbfCETEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 14:04:20 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39692 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbfCETEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 14:04:20 -0500
Received: by mail-lf1-f68.google.com with SMTP id r123so6995218lff.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 11:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uluI8MIsJOeLu5eYIawXB0+49Ik0tPZfROdOhX5Bi1s=;
        b=lJV8jtHpED/XEnivaCDEhMF3qemjcbzDdRHCfYZ5zLRFH+nc9GSAOsmd1Ez8roODDn
         VeJ6jwHx7mDIj3ljM7s0+5eEABvH72b37MhDl/61RR0YY2yM+ZQG8Br9Dk2L+5iDv+fy
         cyhaW6Gt+LwurgcPDlsODUxypbCR1PezGa+Yo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uluI8MIsJOeLu5eYIawXB0+49Ik0tPZfROdOhX5Bi1s=;
        b=Wa3i5fbMHmFX0UlzZ0jUMpvFMAico9QIrMAV2TZ+I3MF3kEcZLwdUrsm8VeRPT9elz
         ls7rlDORETRrYfoDWuTEvQA1rYjt+BJHyaDg/RhQ69QyKBWLkK/3MCIfhRojNlEid/9Y
         dsvT0lIMatO9Oi2oCRcIJ/WGGIDJ94yOwyACpNltnxwlA8lO1bXk7wJo8o/CPAmeY0tP
         Qr/aLiOh2p4jhdGOyb9GeuOwAEw34H6QZPPXQ9qSXtPE57PhWrkINXfidTzpt98rWDKX
         L8g0FoZ64kxY/hQ+w9jSFugn+jQvkHFeTo+q1Sdl2lRg+jAmKXAAU1VymCv62D8cMdJh
         PLJw==
X-Gm-Message-State: APjAAAVywC682T9xDQpLt+ZxU94KehgZ9dE+gXvOp9u3EWwbTW/iBPu2
        RfU13AdQ0I3AzgsRbWsPzRTNJ1nETuA=
X-Google-Smtp-Source: APXvYqx2lsxfEYB6WmrR4nBZm20u4MUXN+WfnsT6HFnMM5eOuDWI6wAUnuczUxzfvtYuI3h7PqLL5Q==
X-Received: by 2002:ac2:55b2:: with SMTP id y18mr1638225lfg.72.1551812657825;
        Tue, 05 Mar 2019 11:04:17 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id v1sm2305285lfg.13.2019.03.05.11.04.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 11:04:17 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id z7so8583467lji.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 11:04:17 -0800 (PST)
X-Received: by 2002:a2e:93cf:: with SMTP id p15mr96879ljh.184.1551812656932;
 Tue, 05 Mar 2019 11:04:16 -0800 (PST)
MIME-Version: 1.0
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
 <1546318276-18993-12-git-send-email-yong.wu@mediatek.com> <CAE=gft4Z_C0NRmP0A_rnDzvB3txt3cGV=rvZhJOQZk_1qahiQQ@mail.gmail.com>
 <1551278012.17917.51.camel@mhfsdcap03>
In-Reply-To: <1551278012.17917.51.camel@mhfsdcap03>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 5 Mar 2019 11:03:40 -0800
X-Gmail-Original-Message-ID: <CAE=gft7ZQ36mKozYBmSJ9j9k4gcQyHMuEZsH0Kems2T6+=GtSg@mail.gmail.com>
Message-ID: <CAE=gft7ZQ36mKozYBmSJ9j9k4gcQyHMuEZsH0Kems2T6+=GtSg@mail.gmail.com>
Subject: Re: [PATCH 11/13] iommu/mediatek: Use builtin_platform_driver
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     youlin.pei@mediatek.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, srv_heupstream@mediatek.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will.deacon@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        yingjoe.chen@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 6:33 AM Yong Wu <yong.wu@mediatek.com> wrote:
>
> On Mon, 2019-02-25 at 15:56 -0800, Evan Green wrote:
> > On Mon, Dec 31, 2018 at 8:53 PM Yong Wu <yong.wu@mediatek.com> wrote:
> > >
> > > MediaTek IOMMU should wait for smi larb which need wait for the
> > > power domain(mtk-scpsys.c) and the multimedia ccf who both are
> > > module init. Thus, subsys_initcall for MediaTek IOMMU is not helpful.
> > > Switch to builtin_platform_driver.
> > >
> > > Meanwhile, the ".remove" can be removed. Move its content to
> > > ".shutdown".
> > >
> > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > ---
> > >  drivers/iommu/mtk_iommu.c    | 23 ++---------------------
> > >  drivers/iommu/mtk_iommu_v1.c | 16 ++--------------
> > >  2 files changed, 4 insertions(+), 35 deletions(-)
> > >
> > > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > > index 735ae8d..2798b12 100644
> > > --- a/drivers/iommu/mtk_iommu.c
> > > +++ b/drivers/iommu/mtk_iommu.c
> > > @@ -690,7 +690,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
> > >         return component_master_add_with_match(dev, &mtk_iommu_com_ops, match);
> > >  }
> > >
> > > -static int mtk_iommu_remove(struct platform_device *pdev)
> > > +static void mtk_iommu_shutdown(struct platform_device *pdev)
> > >  {
> > >         struct mtk_iommu_data *data = platform_get_drvdata(pdev);
> > >
> > > @@ -703,12 +703,6 @@ static int mtk_iommu_remove(struct platform_device *pdev)
> > >         clk_disable_unprepare(data->bclk);
> > >         devm_free_irq(&pdev->dev, data->irq, data);
> > >         component_master_del(&pdev->dev, &mtk_iommu_com_ops);
> > > -       return 0;
> > > -}
> > > -
> > > -static void mtk_iommu_shutdown(struct platform_device *pdev)
> > > -{
> > > -       mtk_iommu_remove(pdev);
> >
> > Is there a reason all these things are happening in shutdown()? Don't
> > we normally just not clean things up and let the machine turn off?
> > Normally I'm a big advocate of proper symmetric teardown, so it hurts
> > a little to ask.
>
> In this patch I change the driver to builtin driver. I guess the
> "_remove" is not helpful now. thus I remove it.
>
> About the shutdown, I don't have a special reason for it. I only want to
> mute the m4u log when something go wrong in the shutdown flow.
>

Wouldn't you want to see the logs when something goes wrong in
shutdown? Or is there a lot of noise that gets generated if you don't
do this during a graceful shutdown? I guess if there's some real
reason you're doing all this stuff in shutdown then it's fine, but if
it was just a default shuttling of code from remove to shutdown
because remove was going away then it could be deleted.
-Evan
