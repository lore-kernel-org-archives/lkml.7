Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58E7C04AA6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 08:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A113F21744
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 08:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OAe1zycT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfD3Ixp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 04:53:45 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45708 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfD3Ixp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 04:53:45 -0400
Received: by mail-oi1-f195.google.com with SMTP id t189so7589245oih.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 01:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A8/NEuA9marorl0ixlh/3shrh19pr40I3KqHuo9ZWlE=;
        b=OAe1zycT9lDlKZVighchQ6eYIy0XmGyjFcKMqUYoeryriWN1KoF3rGGIXMpOm1MOSW
         wgUx0cDHR3zb0tvqC9URlP1WM45RF6izTv/+uwYLDj99eI5wPP8y+aaAyVKzmFAjqAlC
         feJmhPrZF31W8VYorttnQ6+BZVtwXGTJempUyobcpGMhYT7H22ZWlravqZqnJYUbV5zc
         ktSOYP9QtbDUpUQn5egp/kHSOzXG5SISQnQgsDJ8VlWbvz3pltax2xuK7zNlJFAiI1NR
         SVJrMACuAzxXNHg+e6TGZ7trsDl8ZQ+C7oJzDbnHWL+BKCgvV+oYmcq8ZJEaqWV8fZ27
         IcdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A8/NEuA9marorl0ixlh/3shrh19pr40I3KqHuo9ZWlE=;
        b=RdGHKvkiONnjNb7jG5waiG0F0kU+1SLaTFYVLpZqgqahS1bdc5gxOJMqHBSjuQgxRw
         uxAV/AR11Z5Ew/wFbtfzFMu5s8cvPrsveeC+wBt0WijRoLA05wv+LDPNQWFAyV9kR9xr
         +KKYbLdPslS54HHxX7B3pSe1X2UpiJS+4GTkhBZOLhBfB0tOMGEwZ02xR3x54Vz++ZLK
         cGr+vkCYCecUW05F+wRKJslQQLRO0taV1h7RTyyvP3LQGX+h5MnRcp2b8zmlkzS9zWKE
         jPQnUbX82vIRGFXB8nrKfu80v72I92KdAu/9OvHRCt8h1ZZE3L3l3dVDMmeB2IMlxBm1
         EAfg==
X-Gm-Message-State: APjAAAXyF/1Aseu92CgC+ZXmnIwmCxagfd5Ci4ORVnmrwOt6Re2M+xX5
        OS9gGrpz3rlkdxvxxQ9vJz4KqAwoxC5hJ5uqv3h99Q==
X-Google-Smtp-Source: APXvYqwtAPgDAo5ewm/8SWWaA1+o4UOZZmMGy268pyU4RTnAt8OUNfnqJVpWboYxwh48ndcMExsT4WmicraSu+Dg5hg=
X-Received: by 2002:aca:ba0b:: with SMTP id k11mr2230922oif.57.1556614424087;
 Tue, 30 Apr 2019 01:53:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1555330115.git.baolin.wang@linaro.org> <d77dca51a14087873627d735a17adcfde5517398.1555330115.git.baolin.wang@linaro.org>
 <20190429115723.GK3845@vkoul-mobl.Dlink> <CAMz4kuLf4wgr4Js3xH1aQVc4c2XK1Oq2TnsUq=NSowQUq5ZN5g@mail.gmail.com>
 <20190429140537.GN3845@vkoul-mobl.Dlink> <CAMz4ku+ctQrcR+6t1ouakeG3dbgL3qR8fz-Hft4s9FnxtFL1ng@mail.gmail.com>
 <20190430082954.GQ3845@vkoul-mobl.Dlink> <CAMz4kuKV3J+aw9sic=QOhmcnr+H_pZ-pmq4pRbLX1R+XAR=phA@mail.gmail.com>
In-Reply-To: <CAMz4kuKV3J+aw9sic=QOhmcnr+H_pZ-pmq4pRbLX1R+XAR=phA@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 30 Apr 2019 16:53:32 +0800
Message-ID: <CAMz4kuLFyckFdzVgL9FH0xW8036OoAbyjHqfOAVhibPyNssPDA@mail.gmail.com>
Subject: Re: [PATCH 4/7] dmaengine: sprd: Add device validation to support
 multiple controllers
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>, eric.long@unisoc.com,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Mark Brown <broonie@kernel.org>, dmaengine@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On Tue, 30 Apr 2019 at 16:34, Baolin Wang <baolin.wang@linaro.org> wrote:
>
> On Tue, 30 Apr 2019 at 16:30, Vinod Koul <vkoul@kernel.org> wrote:
> >
> > On 30-04-19, 13:30, Baolin Wang wrote:
> > > On Mon, 29 Apr 2019 at 22:05, Vinod Koul <vkoul@kernel.org> wrote:
> > > >
> > > > On 29-04-19, 20:20, Baolin Wang wrote:
> > > > > On Mon, 29 Apr 2019 at 19:57, Vinod Koul <vkoul@kernel.org> wrote:
> > > > > >
> > > > > > On 15-04-19, 20:14, Baolin Wang wrote:
> > > > > > > From: Eric Long <eric.long@unisoc.com>
> > > > > > >
> > > > > > > Since we can support multiple DMA engine controllers, we should add
> > > > > > > device validation in filter function to check if the correct controller
> > > > > > > to be requested.
> > > > > > >
> > > > > > > Signed-off-by: Eric Long <eric.long@unisoc.com>
> > > > > > > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > > > > > > ---
> > > > > > >  drivers/dma/sprd-dma.c |    5 +++++
> > > > > > >  1 file changed, 5 insertions(+)
> > > > > > >
> > > > > > > diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
> > > > > > > index 0f92e60..9f99d4b 100644
> > > > > > > --- a/drivers/dma/sprd-dma.c
> > > > > > > +++ b/drivers/dma/sprd-dma.c
> > > > > > > @@ -1020,8 +1020,13 @@ static void sprd_dma_free_desc(struct virt_dma_desc *vd)
> > > > > > >  static bool sprd_dma_filter_fn(struct dma_chan *chan, void *param)
> > > > > > >  {
> > > > > > >       struct sprd_dma_chn *schan = to_sprd_dma_chan(chan);
> > > > > > > +     struct of_phandle_args *dma_spec =
> > > > > > > +             container_of(param, struct of_phandle_args, args[0]);
> > > > > > >       u32 slave_id = *(u32 *)param;
> > > > > > >
> > > > > > > +     if (chan->device->dev->of_node != dma_spec->np)
> > > > > >
> > > > > > Are you not using of_dma_find_controller() that does this, so this would
> > > > > > be useless!
> > > > >
> > > > > Yes, we can use of_dma_find_controller(), but that will be a little
> > > > > complicated than current solution. Since we need introduce one
> > > > > structure to save the node to validate in the filter function like
> > > > > below, which seems make things complicated. But if you still like to
> > > > > use of_dma_find_controller(), I can change to use it in next version.
> > > >
> > > > Sorry I should have clarified more..
> > > >
> > > > of_dma_find_controller() is called by xlate, so you already run this
> > > > check, so why use this :)
> > >
> > > The of_dma_find_controller() can save the requested device node into
> > > dma_spec, and in the of_dma_simple_xlate() function, it will call
> > > dma_request_channel() to request one channel, but it did not validate
> > > the device node to find the corresponding dma device in
> > > dma_request_channel(). So we should in our filter function to validate
> > > the device node with the device node specified by the dma_spec. Hope I
> > > make things clear.
> >
> > But dma_request_channel() calls of_dma_request_slave_channel() which
> > invokes of_dma_find_controller() why is it broken for you if that is the
> > case..
>
> No,the calling process should be:
> dma_request_slave_channel()
> --->dma_request_chan()--->of_dma_request_slave_channel()---->of_dma_simple_xlate()
> ----> dma_request_channel().
>

You can check other drivers, they also will save the device node to
validate in their filter function.
For example the imx-sdma driver:
https://elixir.bootlin.com/linux/v5.1-rc6/source/drivers/dma/imx-sdma.c#L1931

-- 
Baolin Wang
Best Regards
