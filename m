Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031F8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 03:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8EB621873
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 03:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RHrkuORF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfCODWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 23:22:23 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41210 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfCODWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 23:22:22 -0400
Received: by mail-qk1-f193.google.com with SMTP id o129so4698180qke.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 20:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D//235HFkNRLwill9zqq/U/iBoMHwlkuX82hhdgpT/I=;
        b=RHrkuORFlhEEdiA4KVogw849asICy/i3zdF4gHBbXXCcq6JehCB7fy40RIUajhihGD
         MfprgCk/tPtZ27JwZRPnp12CySepMewjHnrahYDCc3fHtkCp0zFkV6ORavHGZQduHPoH
         nS9bir2xlssZoD1/+/hHB12bULPDeaSvmQghQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D//235HFkNRLwill9zqq/U/iBoMHwlkuX82hhdgpT/I=;
        b=pmh8Xyf+s1BZ0YKSV/2U5CGldhpmbp4fHBg2GkViJvPbUa0gLWD3g6HB0Ahc3chsbP
         XdxTe38M/nRmOZJPCG6SpF8h98Nmu+bbBMbW9OX2RmJX3kKEN/2xZOMRUq2yLtmNt+Pd
         j6bm0pVCkYqRkRuCD+/IEnfsjslr1twsMyeAX8KVi3gEtNXTMkfI+/1Nn9CvzouQoZas
         wxisqysQQIGms3HF9KO+MLDJhD2QS/AnfvJvHzGyZfvPlqYNmMBGsUtZ6MzIJg1cYK0N
         UNd07Qo5171CeTa4SBNK6skoZpi7jY9kBtv/7Yoqia+4wUhKI/v6kiKas4Gh/cKydf+R
         ZJtg==
X-Gm-Message-State: APjAAAXuyzBDM2HVnL/7ofbX6WieEomd1O5vIWyMGgSXspPtFMvrQHjI
        8WWwKqUoAHtG6Ou3DOMxpBeYuVqTdrR2GbqQ3zfqvQ==
X-Google-Smtp-Source: APXvYqzATtfpS/Hpo4SmPuzZSIj3VVO2Gr1UM/EbQG6CuLv9xGwq6NjoAo5Gp135+PWWzm/iEqWmrnYY4P0r54v4t50=
X-Received: by 2002:a05:620a:1428:: with SMTP id k8mr1125672qkj.185.1552620141315;
 Thu, 14 Mar 2019 20:22:21 -0700 (PDT)
MIME-Version: 1.0
References: <1545638931-24938-1-git-send-email-yongqiang.niu@mediatek.com>
 <1545638931-24938-4-git-send-email-yongqiang.niu@mediatek.com>
 <CANMq1KBTN61hmWy2K+rrx3NL0eR7AXhFQBkCpcHu5nhUw_6xjw@mail.gmail.com> <1552615576.31200.19.camel@mhfsdcap03>
In-Reply-To: <1552615576.31200.19.camel@mhfsdcap03>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri, 15 Mar 2019 11:22:10 +0800
Message-ID: <CANMq1KBSw=Xsw_QX7=ci3dCWqHXVhceHv6H+v_C_uSvVeraDeQ@mail.gmail.com>
Subject: Re: [PATCH 03/18] drm/mediatek: redefine mtk_ddp_sout_sel
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 10:06 AM Yongqiang Niu
<yongqiang.niu@mediatek.com> wrote:
>
> On Tue, 2018-12-25 at 11:57 +0800, Nicolas Boichat wrote:
> > On Mon, Dec 24, 2018 at 6:52 PM Yongqiang Niu
> > <yongqiang.niu@mediatek.com> wrote:
> > >
> > > This patch redefine mtk_ddp_sout_sel
> >
> > Can you describe a bit more why you are making this change?
>
> the format of "mtk_ddp_sout_sel"was not flexible, after we add more
> mediatek SOC support, that will be redundant
>
> set this function format like mtk_ddp_mout_en and mtk_ddp_sel_in

This needs to be 2 patches:
 1. Make the change to "cur == DDP_COMPONENT_BLS && next ==
DDP_COMPONENT_DPI0", along with an explanation of why this is
reasonable.
 2. Change the format to look like mtk_ddp_mout_en and mtk_ddp_sel_in

> >
> > > Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> > > ---
> > >  drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 32 ++++++++++++++++++++------------
> > >  1 file changed, 20 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > > index adb37e4..592f852 100644
> > > --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > > +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > > @@ -405,21 +405,27 @@ static unsigned int mtk_ddp_sel_in(enum mtk_ddp_comp_id cur,
> > >         return value;
> > >  }
> > >
> > > -static void mtk_ddp_sout_sel(void __iomem *config_regs,
> > > -                            enum mtk_ddp_comp_id cur,
> > > -                            enum mtk_ddp_comp_id next)
> > > +static unsigned int mtk_ddp_sout_sel(void __iomem *config_regs,
> >
> > You don't use config_regs anymore, drop it.
>
> ok, will drop it in next version
>
> >
> > > +                                    enum mtk_ddp_comp_id cur,
> > > +                                    enum mtk_ddp_comp_id next,
> > > +                                    unsigned int *addr)
> > >  {
> > > +       unsigned int value;
> > > +
> > >         if (cur == DDP_COMPONENT_BLS && next == DDP_COMPONENT_DSI0) {
> > > -               writel_relaxed(BLS_TO_DSI_RDMA1_TO_DPI1,
> > > -                              config_regs + DISP_REG_CONFIG_OUT_SEL);
> > > +               *addr = DISP_REG_CONFIG_OUT_SEL;
> > > +               value = BLS_TO_DSI_RDMA1_TO_DPI1;
> >
> > You can directly return BLS_TO_DSI_RDMA1_TO_DPI1.
>
> just format this like mtk_ddp_mout_en and mtk_ddp_sel_in

Since there is precedent, sounds ok.

> >
> > >         } else if (cur == DDP_COMPONENT_BLS && next == DDP_COMPONENT_DPI0) {
> > > -               writel_relaxed(BLS_TO_DPI_RDMA1_TO_DSI,
> > > -                              config_regs + DISP_REG_CONFIG_OUT_SEL);
> > > -               writel_relaxed(DSI_SEL_IN_RDMA,
> > > -                              config_regs + DISP_REG_CONFIG_DSI_SEL);
> > > -               writel_relaxed(DPI_SEL_IN_BLS,
> > > -                              config_regs + DISP_REG_CONFIG_DPI_SEL);
> > > +               *addr = DISP_REG_CONFIG_OUT_SEL;
> > > +               value = BLS_TO_DPI_RDMA1_TO_DSI;
> >
> > I (kind of) understand the change above, as you still end up writing
> > BLS_TO_DSI_RDMA1_TO_DPI1 in DISP_REG_CONFIG_OUT_SEL.
> >
> > This changes the behaviour, as now you only write
> > BLS_TO_DPI_RDMA1_TO_DSI to DISP_REG_CONFIG_OUT_SEL, but the previous
> > revision of the code would also write to DISP_REG_CONFIG_DSI_SEL and
> > DISP_REG_CONFIG_DPI_SEL. Why?
> >
>
> DISP_REG_CONFIG_DSI_SEL set in the next lines.

Ok, but where is mtk_ddp_sout_sel(DDP_COMPONENT_RDMA1,
DDP_COMPONENT_DSI0) called from?

Before this change, we just needed to call:
mtk_ddp_sout_sel(DDP_COMPONENT_BLS, DDP_COMPONENT_DSI0)
and the following 3 registers would be modified:
BLS_TO_DPI_RDMA1_TO_DSI, DSI_SEL_IN_RDMA, DPI_SEL_IN_BLS.

Now, to get similar behaviour, we need to call:
mtk_ddp_sout_sel(DDP_COMPONENT_BLS, DDP_COMPONENT_DSI0)
mtk_ddp_sout_sel(DDP_COMPONENT_RDMA1, DDP_COMPONENT_DSI0)

Maybe that's ok, but you really need to explain the reason for this
change in the commit message.

> DPI_SEL_IN_BLS is 0 for DISP_REG_CONFIG_DPI_SEL set, and hardware
> default setting is also 0, so this one is no need anymore

That's somewhat reasonable, but this needs to be at the very least
described in the commit message.

> > > +       } else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DSI0) {
> > > +               *addr = DISP_REG_CONFIG_DSI_SEL;
> > > +               value = DSI_SEL_IN_RDMA;
> > > +       } else {
> > > +               value = 0;
> > >         }
> > > +
> > > +       return value;
> > >  }
> > >
> > >  void mtk_ddp_add_comp_to_path(void __iomem *config_regs,
> > > @@ -434,7 +440,9 @@ void mtk_ddp_add_comp_to_path(void __iomem *config_regs,
> > >                 writel_relaxed(reg, config_regs + addr);
> > >         }
> > >
> > > -       mtk_ddp_sout_sel(config_regs, cur, next);
> > > +       value = mtk_ddp_sout_sel(cur, next, &addr);
> > > +       if (value)
> > > +               writel_relaxed(value, config_regs + addr);
> >
> > Why this change? I don't see mtk_ddp_sout_sel being used later in the
> > series, so I'm not sure why we don't directly write the value into the
> > register.
> >
> in the patch "[PATCH 04/18] drm/mediatek: move rdma sout from
> mtk_ddp_mout_en into mtk_ddp_sout_sel", i moved all rdma out to here,
> rdma only have single out, no multi out.
> if keep this format, there will many writel_relaxed in mtk_ddp_sout_sel.
> and modify this format like mtk_ddp_mout_en and mtk_ddp_sel_in looks
> better.
>
> >
> >
> > >         value = mtk_ddp_sel_in(cur, next, &addr);
> > >         if (value) {
> > > --
> > > 1.8.1.1.dirty
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
>
