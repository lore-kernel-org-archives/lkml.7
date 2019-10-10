Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF763C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 09:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B136421920
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 09:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R0EjnTiI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387951AbfJJJAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 05:00:34 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44667 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389367AbfJJJAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 05:00:30 -0400
Received: by mail-ed1-f67.google.com with SMTP id r16so4713055edq.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 02:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M/M543PbwhblZM8pHPCeGHKu1Y2HTPBlq7aWQrvh6aI=;
        b=R0EjnTiI2Cah1wjjJ4cd/+TWE9eya83185lC66F9wz7ceGrmKKis6duKyG0Hrul8kJ
         9jAYQQNAIoxSwQWHHNeir20gkJwMzmf91DIEJZnS08eRM4k/ZQe2qKWcBw4Pi9Ei7YGB
         0bNl3QHzl6Zj9qtiJ+ItLqSFATwYx+uI0a88A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M/M543PbwhblZM8pHPCeGHKu1Y2HTPBlq7aWQrvh6aI=;
        b=tWywAULB/8W+joaNUZSinHxSGvfqMb5p8/X2UQnqG6XlWU7WRKgrG1YQJ+9jy2Y/G/
         E426w/OQeztdqgMmLwvzPLSGOO5ilz6fkUvBEaYhfGrFHU1ju/Zm7uFsLU3YYeFZY2Q5
         x4ykX0437yvDaxmzZo4BEdsQae8SNKuJN6Wt9RYvphSMgbNIAgVGRRkyVg1GWrWWvQz4
         X3dfeGS2zuQjPyzwDTAmwu0hm8OOpdPWy/ZiK/aLoASNv+5yUoHBDJAbC7+3sbqBFwxo
         1Q7MsLR6JMF4zJTLopmgiCJo6NqvEUjTbqqxcBkUhgM42gA4fSkymZADSpwnmI9UxdEF
         vlag==
X-Gm-Message-State: APjAAAXB+wBA4JA0C5qslNId8+y5M6dmXF5a4U/HqmiEkSwS0acPW6SL
        SnalZEKXeYOG6Qfg1rSfZsaxH+eaCGf8zg==
X-Google-Smtp-Source: APXvYqzxty7LNJtpgSgiFED+FqRxzaOURqkdTrb/vJSIEQV3u7UEHJW6Digbgaz2QiHJulIGb1EHDg==
X-Received: by 2002:a17:906:cc90:: with SMTP id oq16mr6915325ejb.322.1570698025967;
        Thu, 10 Oct 2019 02:00:25 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id y25sm592476eju.39.2019.10.10.02.00.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2019 02:00:24 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id v8so6845560wrt.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 02:00:23 -0700 (PDT)
X-Received: by 2002:a5d:540e:: with SMTP id g14mr7746971wrv.177.1570698023302;
 Thu, 10 Oct 2019 02:00:23 -0700 (PDT)
MIME-Version: 1.0
References: <20191010075004.192818-1-tfiga@chromium.org> <1570697118.32135.20.camel@mhfsdcap03>
In-Reply-To: <1570697118.32135.20.camel@mhfsdcap03>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 10 Oct 2019 18:00:09 +0900
X-Gmail-Original-Message-ID: <CAAFQd5AU53=BRUrK_i-0dRYueVoSd3Bg3AtvZUMHgFv3hLuNug@mail.gmail.com>
Message-ID: <CAAFQd5AU53=BRUrK_i-0dRYueVoSd3Bg3AtvZUMHgFv3hLuNug@mail.gmail.com>
Subject: Re: [PATCH] usb: mtk-xhci: Set the XHCI_NO_64BIT_SUPPORT quirk
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     linux-usb@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Changqi Hu <Changqi.Hu@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Shik Chen <shik@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chunfeng,

On Thu, Oct 10, 2019 at 5:45 PM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
>
> Hi, Tomasz,
>
> On Thu, 2019-10-10 at 16:50 +0900, Tomasz Figa wrote:
> > MediaTek XHCI host controller does not support 64-bit addressing despite
> > the AC64 bit of HCCPARAMS1 register being set. The platform-specific
> > glue sets the DMA mask to 32 bits on its own, but it has no effect,
> > because xhci_gen_setup() overrides it according to hardware
> > capabilities.
> >
> > Use the XHCI_NO_64BIT_SUPPORT quirk to tell the XHCI core to force
> > 32-bit DMA mask instead.
> >
> > Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> > ---
> >  drivers/usb/host/xhci-mtk.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
> > index b18a6baef204a..4d101d52cc11b 100644
> > --- a/drivers/usb/host/xhci-mtk.c
> > +++ b/drivers/usb/host/xhci-mtk.c
> > @@ -395,6 +395,11 @@ static void xhci_mtk_quirks(struct device *dev, struct xhci_hcd *xhci)
> >       xhci->quirks |= XHCI_SPURIOUS_SUCCESS;
> >       if (mtk->lpm_support)
> >               xhci->quirks |= XHCI_LPM_SUPPORT;
> > +     /*
> > +      * MTK host controller does not support 64-bit addressing, despite
> > +      * having the AC64 bit of the HCCPARAMS1 register set.
> > +      */
> > +     xhci->quirks |= XHCI_NO_64BIT_SUPPORT;
> Somes SoCs support 64bits in fact, so can't support this quirk, do you
> encounter any issues without this quirk?
>

Thanks for taking a look at this patch.

Yes, on MT8183 the DMA mask ended up being set to 64 bits, but
according to the information I received from MediaTek, the controller
on that SoC only supports 32 bits.

If some SoCs support only 32 bits and some support 64 bits, we may
either need to use different DT compatible string for them or add a DT
property and set the quirk based on that. Right now in upstream we
have:

1) "mediatek,mt8173-xhci", used by:
MT8173

2)"mediatek,mtk-xhci", used by:
MT2712
MT7622
MT8183 (not yet upstream, but I suppose it's on the mailing lists)

Would you be able to check which of the SoCs above report 64 bits but
support only 32? (and so would need this quirk)

Best regards,
Tomasz

> >  }
>
> >
> >  /* called during probe() after chip reset completes */
> > @@ -488,11 +493,6 @@ static int xhci_mtk_probe(struct platform_device *pdev)
> >               goto disable_clk;
> >       }
> >
> > -     /* Initialize dma_mask and coherent_dma_mask to 32-bits */
> > -     ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> > -     if (ret)
> > -             goto disable_clk;
> > -
> >       hcd = usb_create_hcd(driver, dev, dev_name(dev));
> >       if (!hcd) {
> >               ret = -ENOMEM;
>
>
