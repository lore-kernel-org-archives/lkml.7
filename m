Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564C0C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 03:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1815D206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 03:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TpULE9OX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfLSDmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 22:42:31 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46553 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbfLSDma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 22:42:30 -0500
Received: by mail-qk1-f193.google.com with SMTP id r14so3484612qke.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 19:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O6LOFVunh/OJDC7JvnA4isOAWmQTXpcdKGgNnEbH64k=;
        b=TpULE9OXsOToVRsqIEUUz/0B5xzbX3OOmWBLyc4F5l6u3dO1p8OyzXbWfPNaWQy/Q9
         oFe99o0qfiy2B83AF2rbUCC0TwM4oTtWJhe97usSuT8iNv4jUH11GbTHJn0uNooIQdAt
         vJqLFDMdnIOQsjKsyCNjK5+w0TSJK6ToFOiNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O6LOFVunh/OJDC7JvnA4isOAWmQTXpcdKGgNnEbH64k=;
        b=g6t56k9wpuK6y5+r2KLIxY1ClTGxAbB7VgvBlBOa4FAnETvzkWtdhYxc4bwxyT8JDO
         Dhx6BzoRpDRw2aq8kopFdEshc2ixE+uisRgr+GizGJZuqisQHaKA4y29sFu6FwhpQhDt
         5XsGUl4enCpyKlfFvKEm+9eMzsG4YTXBAM2/4DkNssCipBo6f4iZMxJu0qiOaeAC8SnI
         k09wXxvGPznrQR8gHWWmEOQnN/47K8/w9MrB+0GBvXlN24ghjwNh8IShUw1BOvuaASFm
         CbuTrab1yJwfZnCZ92Qkf6BsD3q5K/R0XyHjqtrTUlbdOpvIu9OHiy4DBjr4nJFJGF81
         GNpA==
X-Gm-Message-State: APjAAAVhpHu3+F1rxyRQsGgFGIdFgH+hz4dLzBvZCoKGMZtijdoFR4LX
        H4BJ9KZijBD+x6LwJHHPeX46/syzHompZwmubUELoA==
X-Google-Smtp-Source: APXvYqyLgkLmeEnazbCRrjSZ2SBiwnCH2DOGyt2BMNtf/xUV1tD8U3wu7lA97+V5Un2IAowvdm70tIGk8nRKyyJ08zM=
X-Received: by 2002:a37:6551:: with SMTP id z78mr6443627qkb.144.1576726949364;
 Wed, 18 Dec 2019 19:42:29 -0800 (PST)
MIME-Version: 1.0
References: <1575960413-6900-1-git-send-email-weiyi.lu@mediatek.com>
 <1575960413-6900-5-git-send-email-weiyi.lu@mediatek.com> <CANMq1KA4KL=ZpU=cQtw3LV79DKRdG3Eb16og6vU1SdsnnL=0CA@mail.gmail.com>
 <1576551056.14035.19.camel@mtksdaap41> <CANMq1KAn3vwCm5=LJPjE=STw9=XLSwdQ7_LZA2_okkA-V8R_3A@mail.gmail.com>
 <1576635932.13343.8.camel@mtksdaap41>
In-Reply-To: <1576635932.13343.8.camel@mtksdaap41>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Thu, 19 Dec 2019 11:42:18 +0800
Message-ID: <CANMq1KDeoRK8KcSqX9nA0d2iHAeq4oLnzgO16yCM5jK5uNJsSQ@mail.gmail.com>
Subject: Re: [PATCH v9 4/9] soc: mediatek: Add multiple step bus protection control
To:     Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>,
        James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 10:25 AM Weiyi Lu <weiyi.lu@mediatek.com> wrote:
>
> On Tue, 2019-12-17 at 13:33 +0800, Nicolas Boichat wrote:
> > On Tue, Dec 17, 2019 at 10:51 AM Weiyi Lu <weiyi.lu@mediatek.com> wrote:
> > >
> > > On Mon, 2019-12-16 at 15:21 +0800, Nicolas Boichat wrote:
> > > > On Tue, Dec 10, 2019 at 2:47 PM Weiyi Lu <weiyi.lu@mediatek.com> wrote:
> > > > >
> > > > > Both MT8183 & MT6765 have more control steps of bus protection
> > > > > than previous project. And there add more bus protection registers
> > > > > reside at infracfg & smi-common. Also add new APIs for multiple
> > > > > step bus protection control with more customized arguments.
> > > > >
> > > > > Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> > > > > ---
> > > > >  drivers/soc/mediatek/Makefile           |  2 +-
> > > > >  drivers/soc/mediatek/mtk-scpsys-ext.c   | 99 +++++++++++++++++++++++++++++++++
> > > > >  drivers/soc/mediatek/mtk-scpsys.c       | 39 +++++++++----
> > > > >  include/linux/soc/mediatek/scpsys-ext.h | 39 +++++++++++++
> > > > >  4 files changed, 168 insertions(+), 11 deletions(-)
> > > > >  create mode 100644 drivers/soc/mediatek/mtk-scpsys-ext.c
> > > > >  create mode 100644 include/linux/soc/mediatek/scpsys-ext.h
> > > > >
> > > > > diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
> > > > > index b017330..b442be9 100644
> > > > > --- a/drivers/soc/mediatek/Makefile
> > > > > +++ b/drivers/soc/mediatek/Makefile
> > > > > @@ -1,5 +1,5 @@
> > > > >  # SPDX-License-Identifier: GPL-2.0-only
> > > > >  obj-$(CONFIG_MTK_CMDQ) += mtk-cmdq-helper.o
> > > > > -obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o
> > > > > +obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o mtk-scpsys-ext.o
> > > > >  obj-$(CONFIG_MTK_PMIC_WRAP) += mtk-pmic-wrap.o
> > > > >  obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys.o
> > > > > diff --git a/drivers/soc/mediatek/mtk-scpsys-ext.c b/drivers/soc/mediatek/mtk-scpsys-ext.c
> > > > > new file mode 100644
> > > > > index 0000000..4f1adda
> > > > > --- /dev/null
> > > > > +++ b/drivers/soc/mediatek/mtk-scpsys-ext.c
> > > > > @@ -0,0 +1,99 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > +/*
> > > > > + * Copyright (c) 2018 MediaTek Inc.
> > > > > + * Author: Owen Chen <Owen.Chen@mediatek.com>
> > > > > + */
> > > > > +#include <linux/ktime.h>
> > > > > +#include <linux/mfd/syscon.h>
> > > > > +#include <linux/of_device.h>
> > > > > +#include <linux/regmap.h>
> > > > > +#include <linux/soc/mediatek/scpsys-ext.h>
> > > > > +
> > > > > +#define MTK_POLL_DELAY_US   10
> > > > > +#define MTK_POLL_TIMEOUT    USEC_PER_SEC
> > > > > +
> > > > > +static int set_bus_protection(struct regmap *map, u32 mask, u32 ack_mask,
> > > > > +               u32 reg_set, u32 reg_sta, u32 reg_en)
> > > > > +{
> > > > > +       u32 val;
> > > > > +
> > > > > +       if (reg_set)
> > > > > +               regmap_write(map, reg_set, mask);
> > > > > +       else
> > > > > +               regmap_update_bits(map, reg_en, mask, mask);
> > > >
> > > > At least for 8183, we never seen to use the reg_set case, can we
> > > > simplify this function?
> > > >
> > >
> > > Actually 6765 will use it and all the other MediaTek chips at least in
> > > near future.
> > > https://patchwork.kernel.org/patch/11042003/
> >
> > Ok, that's fine then.
> >
> > > > > +
> > > > > +       return regmap_read_poll_timeout(map, reg_sta,
> > > > > +                       val, (val & ack_mask) == ack_mask,
> > > > > +                       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> > > >
> > > > From 8183, I see that you have either:
> > > >  1. mask == ack_mask
> > > >  2. ack_mask == 0 (essentially this skips this test)
> > > >
> > > > Would it be simpler to just skip this test if reg_sta == 0, and always
> > > > assume mask == ack_mask otherwise?
> > > >
> > > > e.g.
> > > > if (reg_sta == 0)
> > > >    return 0;
> > > >
> > > > return regmap_read_poll_timeout(map, reg_sta,
> > > >                        val, (val & mask) == mask,
> > > >                        MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> > > >
> > >
> > > I'm not sure if you mean ack_mask == 0?
> > > reg_sta would be possible to be 0 because it's a register address
> > > offset.
> >
> > Right, so maybe "0" is not a good invalid value, or maybe you can have a
> > #define REG_STA_INVALID U32_MAX
> >
> > And then test for:
> > if (reg_sta == REG_STA_INVALID)
> >    return 0;
> >
> > My point here is that mask and ack_mask are always the same (unless
> > you don't care about reading back the status), so maybe you only need
> > to specify mask?
> >
> > (but if you need different mask and ack_mask for future chips, feel
> > free to ignore)
> >
>
> I do need different mask and ack_mask.
> For the special case of 8183 here, we still have to check the ack status
> when setting bus protection but only ignore the ack status when clearing
> bus protection.
>
> case A.
> SET: reg_set, reg_sta, mask == ack mask
> CLEAR: reg_clr, reg_sta, mask == clear ack mask
>
> case B. (the special case we discussed)
> SET: reg_set, reg_sta, mask == ack mask
> CLEAR: reg_clr, reg_sta, mask != clear ack mask(which is 0 now)
>
> If I use the REG_STA_INVALID to replace the clear ack mask way.
> I might need two reg_sta to satisfy the check of set and clear bus
> protection.
> One is valid for setting case and another is invalid for clearing case,
> e.g. case 2 below
>
> case 1.
> SET: reg_set, reg_sta(valid), mask == ack mask
> CLEAR: reg_clr, reg_sta(valid), mask == ack mask
>
> case 2.
> SET: reg_set, reg_sta(valid), mask == ack mask
> CLEAR: reg_clr, reg_sta(invalid then return), mask == ack mask
>
> so I'd like to keep the original proposal. What do you think?

Ooh, I see. This is quite confusing to be honest... I wonder if it
wouldn't be clearer to have a boolean instead in bus_prot (something
like "clk_no_check", can't find a better name right now).
