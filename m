Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC12C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 10:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D97BE21D56
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 10:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qzjl5XP3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387637AbfJJKJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 06:09:26 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43487 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfJJKJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 06:09:26 -0400
Received: by mail-ed1-f68.google.com with SMTP id r9so4904248edl.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 03:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vBN/g7icYkS/AmLkTr95uIthk9ZmG2qQFolljRp0WMk=;
        b=Qzjl5XP3gY1S8P95T06xre3Rfh0XgcTj0Hb5LBLMatyyGelv6QhZqxTNAwYwagYrM0
         PDIgesmF0xt/RYeXsachoBoIxdRO/Vzs0AeoZQen9rM9IJZwjBY5UAG/3FN4W9dFqMxa
         y7RW8ty64z8J96LC/ZWehDgzeKJROAjwMFe1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vBN/g7icYkS/AmLkTr95uIthk9ZmG2qQFolljRp0WMk=;
        b=JaWVFO/0nbTSkGBwAhel4VADqWwnCcRrjqA/tucADXXABYxgiZYn0mVIDDOthmoLhM
         54xl1rmJ82AgWWVQ+SdPgHPHHxa+c77sJypChTDb0DAl+Za3bqPaP/UleHz7gcvbNxzp
         sQA1r74PxXfQHaLPCmV7n8YGjrTFvrooHW0d7gYrwftjejK9vWGKsDWG7qLpmIGs2gd+
         j/pNBbVXbzOC/GsP7omhb3MKEwiUiBEuCqBUwEC22ibZgJIb8uPFCZHauhM2Vk7zvf1X
         TaSr7QvsiOcUbC6gay/kmZT9A7qaiyBVhk9Ua4vvBTWle8BKY5XxXCCpDISuCPKd57AO
         +8kg==
X-Gm-Message-State: APjAAAXucT8c4V5n/y1g/TG3xT49C/N+BMQArwmvYKlMwgU9Hev2yxU2
        Y2hhXHSZMeEZxHOlecDf0mAb8XojYMKnYQ==
X-Google-Smtp-Source: APXvYqx63cjYN75xGFxQTYEsyYsZue7YjMXmYMQcPOF7YmivchyZQdxVWzkQ6H0OtuEvgz0aDOn8Eg==
X-Received: by 2002:aa7:d6cd:: with SMTP id x13mr7321774edr.272.1570702162178;
        Thu, 10 Oct 2019 03:09:22 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id v6sm655314eja.90.2019.10.10.03.09.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2019 03:09:20 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id p14so7131521wro.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 03:09:19 -0700 (PDT)
X-Received: by 2002:adf:fc42:: with SMTP id e2mr8275718wrs.100.1570702158960;
 Thu, 10 Oct 2019 03:09:18 -0700 (PDT)
MIME-Version: 1.0
References: <20191010075004.192818-1-tfiga@chromium.org> <CANMq1KAA+nqcOqiE_g=vA8DC=_t=FqSRtR5kk=1XqSsgZGj+_A@mail.gmail.com>
 <CAAFQd5DazVnFGmNENnxT_FHed2Jx30hLT29HyEjxY7xeqLnGCg@mail.gmail.com> <CANMq1KA7pKqJDhFvkuBfEWtr81NUhyRpUE9ZZeTNCCc5Fphoyw@mail.gmail.com>
In-Reply-To: <CANMq1KA7pKqJDhFvkuBfEWtr81NUhyRpUE9ZZeTNCCc5Fphoyw@mail.gmail.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 10 Oct 2019 19:09:06 +0900
X-Gmail-Original-Message-ID: <CAAFQd5AZjiMuwaMTjy_1ftop+=E6_G7OGAs0+tD5SdJeW0AOLA@mail.gmail.com>
Message-ID: <CAAFQd5AZjiMuwaMTjy_1ftop+=E6_G7OGAs0+tD5SdJeW0AOLA@mail.gmail.com>
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

On Thu, Oct 10, 2019 at 6:37 PM Nicolas Boichat <drinkcat@chromium.org> wrote:
>
> On Thu, Oct 10, 2019 at 5:11 PM Tomasz Figa <tfiga@chromium.org> wrote:
> >
> > On Thu, Oct 10, 2019 at 6:08 PM Nicolas Boichat <drinkcat@chromium.org> wrote:
> > >
> > > On Thu, Oct 10, 2019 at 3:50 PM Tomasz Figa <tfiga@chromium.org> wrote:
> > > >
> > > > MediaTek XHCI host controller does not support 64-bit addressing despite
> > > > the AC64 bit of HCCPARAMS1 register being set. The platform-specific
> > > > glue sets the DMA mask to 32 bits on its own, but it has no effect,
> > > > because xhci_gen_setup() overrides it according to hardware
> > > > capabilities.
> > > >
> > > > Use the XHCI_NO_64BIT_SUPPORT quirk to tell the XHCI core to force
> > > > 32-bit DMA mask instead.
> > > >
> > > > Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> > >
> > > Can we add a Fixes: tag for stable backports?
> > > (after addressing the other comments of course)
> > >
> >
> > The problem with Fixes: is that this patch depends on the quirk being
> > there, but the offending code was merged earlier. Do you know how to
> > handle such cases?
>
> Oh, interesting. I think this is documented here:
> https://github.com/torvalds/linux/blob/master/Documentation/process/stable-kernel-rules.rst
>
> Something like this:
> Cc: <stable@vger.kernel.org> # 3.3.x: a1f84a3: sched: Check for idle
> Cc: <stable@vger.kernel.org> # 3.3.x
>
> (Where 3.3.x is the first release that contains the commit indicated
> in the Fixes tag)
>
> Try that, worst case you'll get automated emails from stable
> maintainers asking you how to fix the issue.
>

Oh, great, thanks a lot!

Best regards,
Tomasz

> >
> > >
> > > > ---
> > > >  drivers/usb/host/xhci-mtk.c | 10 +++++-----
> > > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
> > > > index b18a6baef204a..4d101d52cc11b 100644
> > > > --- a/drivers/usb/host/xhci-mtk.c
> > > > +++ b/drivers/usb/host/xhci-mtk.c
> > > > @@ -395,6 +395,11 @@ static void xhci_mtk_quirks(struct device *dev, struct xhci_hcd *xhci)
> > > >         xhci->quirks |= XHCI_SPURIOUS_SUCCESS;
> > > >         if (mtk->lpm_support)
> > > >                 xhci->quirks |= XHCI_LPM_SUPPORT;
> > > > +       /*
> > > > +        * MTK host controller does not support 64-bit addressing, despite
> > > > +        * having the AC64 bit of the HCCPARAMS1 register set.
> > > > +        */
> > > > +       xhci->quirks |= XHCI_NO_64BIT_SUPPORT;
> > > >  }
> > > >
> > > >  /* called during probe() after chip reset completes */
> > > > @@ -488,11 +493,6 @@ static int xhci_mtk_probe(struct platform_device *pdev)
> > > >                 goto disable_clk;
> > > >         }
> > > >
> > > > -       /* Initialize dma_mask and coherent_dma_mask to 32-bits */
> > > > -       ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> > > > -       if (ret)
> > > > -               goto disable_clk;
> > > > -
> > > >         hcd = usb_create_hcd(driver, dev, dev_name(dev));
> > > >         if (!hcd) {
> > > >                 ret = -ENOMEM;
> > > > --
> > > > 2.23.0.581.g78d2f28ef7-goog
> > > >
