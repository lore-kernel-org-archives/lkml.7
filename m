Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967F7C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 09:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65FFE2067B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 09:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZlN666g+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387714AbfJJJLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 05:11:46 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46696 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733144AbfJJJLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 05:11:45 -0400
Received: by mail-ed1-f65.google.com with SMTP id t3so4745410edw.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 02:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VBMkhodqn4U5kuTJg5v2ifZwnktnXDoyfQB0T+lz2I8=;
        b=ZlN666g+jTCNpilG4QHCpeYoynta7EDdUBxYR6G+XNbiu6uKvC9S4XCYHA8gAWceuk
         j5Me0Yw6RKR9InXvCEPvVeR1f10m2TcGnldLpxmuqVniAE1hwd5Zv1aWCv5zdTolBLqH
         PyhbGks7ZbGwZ5UXPcm4nRFRvLyI+KapSIRV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VBMkhodqn4U5kuTJg5v2ifZwnktnXDoyfQB0T+lz2I8=;
        b=hzNZSqg5+FQ9hoAQz6XoMU7X8YLMt9gsyFj2JkRAIHcmhaU0DCBpcMys9k6AUts8fs
         2GhbR9B49RfxEuh6t1Y33EN9WztYZDv7zWk92U2cAT8UqfEHOOVhMpX1IKD3FrWCn6zF
         MbNzolyZCnmCmzSpV0aLC0cyhnC+ZMNHyBeZYOBm27X0NlN191Un+NHJw9Ta2OyEXHD5
         ABkvwAEQQ08Oa4B/PFcESjQOd6uVZSsRf6/ZZ036YhZ5Lwacw9V4bzYL/P7mbLttCPdV
         mfTvIjHyLiTwgDaTokwItLNBBNiCo7eMmE0bTZ1gBsIow2ZjfVWjhT96Kvs1R0Th2wZK
         68ZQ==
X-Gm-Message-State: APjAAAWNYGfhZU2ATaxV2UFuycyK/ZwmxOt1pEo4KzcTu19/Nn/W/sbE
        uVfIgBzRyK4CM+NigJT7bc6Kur37N2MnWA==
X-Google-Smtp-Source: APXvYqzsphNIQRfBVnPV7U7jHVGo1iZJ/mFkU/XWFV/fsNsoZzDrGmLTawRpBPPLNtCmszaqND2QUw==
X-Received: by 2002:a17:906:264f:: with SMTP id i15mr7111230ejc.333.1570698703783;
        Thu, 10 Oct 2019 02:11:43 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id f15sm609235ejy.82.2019.10.10.02.11.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2019 02:11:42 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id p7so6073445wmp.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 02:11:41 -0700 (PDT)
X-Received: by 2002:a1c:e404:: with SMTP id b4mr7233084wmh.90.1570698701061;
 Thu, 10 Oct 2019 02:11:41 -0700 (PDT)
MIME-Version: 1.0
References: <20191010075004.192818-1-tfiga@chromium.org> <CANMq1KAA+nqcOqiE_g=vA8DC=_t=FqSRtR5kk=1XqSsgZGj+_A@mail.gmail.com>
In-Reply-To: <CANMq1KAA+nqcOqiE_g=vA8DC=_t=FqSRtR5kk=1XqSsgZGj+_A@mail.gmail.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 10 Oct 2019 18:11:27 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DazVnFGmNENnxT_FHed2Jx30hLT29HyEjxY7xeqLnGCg@mail.gmail.com>
Message-ID: <CAAFQd5DazVnFGmNENnxT_FHed2Jx30hLT29HyEjxY7xeqLnGCg@mail.gmail.com>
Subject: Re: [PATCH] usb: mtk-xhci: Set the XHCI_NO_64BIT_SUPPORT quirk
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     linux-usb@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Changqi Hu <Changqi.Hu@mediatek.com>,
        Shik Chen <shik@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 6:08 PM Nicolas Boichat <drinkcat@chromium.org> wrote:
>
> On Thu, Oct 10, 2019 at 3:50 PM Tomasz Figa <tfiga@chromium.org> wrote:
> >
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
>
> Can we add a Fixes: tag for stable backports?
> (after addressing the other comments of course)
>

The problem with Fixes: is that this patch depends on the quirk being
there, but the offending code was merged earlier. Do you know how to
handle such cases?

>
> > ---
> >  drivers/usb/host/xhci-mtk.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
> > index b18a6baef204a..4d101d52cc11b 100644
> > --- a/drivers/usb/host/xhci-mtk.c
> > +++ b/drivers/usb/host/xhci-mtk.c
> > @@ -395,6 +395,11 @@ static void xhci_mtk_quirks(struct device *dev, struct xhci_hcd *xhci)
> >         xhci->quirks |= XHCI_SPURIOUS_SUCCESS;
> >         if (mtk->lpm_support)
> >                 xhci->quirks |= XHCI_LPM_SUPPORT;
> > +       /*
> > +        * MTK host controller does not support 64-bit addressing, despite
> > +        * having the AC64 bit of the HCCPARAMS1 register set.
> > +        */
> > +       xhci->quirks |= XHCI_NO_64BIT_SUPPORT;
> >  }
> >
> >  /* called during probe() after chip reset completes */
> > @@ -488,11 +493,6 @@ static int xhci_mtk_probe(struct platform_device *pdev)
> >                 goto disable_clk;
> >         }
> >
> > -       /* Initialize dma_mask and coherent_dma_mask to 32-bits */
> > -       ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> > -       if (ret)
> > -               goto disable_clk;
> > -
> >         hcd = usb_create_hcd(driver, dev, dev_name(dev));
> >         if (!hcd) {
> >                 ret = -ENOMEM;
> > --
> > 2.23.0.581.g78d2f28ef7-goog
> >
