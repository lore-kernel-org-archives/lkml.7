Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F917C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 09:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57F982067B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 09:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aXFXLXf9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387412AbfJJJIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 05:08:11 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43400 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733144AbfJJJIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 05:08:11 -0400
Received: by mail-qk1-f195.google.com with SMTP id h126so4886737qke.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 02:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xx/5ivC8+wB4MKu4yR0Ppryr6BtLEmc7x2YuwNcfbiU=;
        b=aXFXLXf9WNQKvFcjlU5MlohqPWQ9c1GEapMUp8kn9Ji0Nf0Y2DalUZ21YIV5w9Yoek
         jS5WJkBJ73QscZEwUM1J3bb+pqYpmN6gNG+8hziyOILEc/Cv2klTVlREuWhXT94Mgm7+
         7xvF6ObloyQdvyA9Vj0umU7uNASrYs6sHJAp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xx/5ivC8+wB4MKu4yR0Ppryr6BtLEmc7x2YuwNcfbiU=;
        b=pNPMUOqvWBC7BdMcL5X5p6Ccbzv2cxj+4Cd+nXfOZdLggWVy4zDH6SNUyCxPhQ/Dhr
         Du7YLjiI9qpPUejLcYE17f4EEn0uvcyqoEMh2f5LS0tt2ItJwAHHrZgSgrkHsKtitEIg
         9mFo3pnpytZonkILqF27Qpz0B+VA97PdLUzSG5wWs4CxcIK3HW+fiDTDiW7ZodyMsc8z
         +VtruJ/un/G3rQFJBDQkCDQrzrIy2eQSruRO2FeNM/DGq6VkR2khxxWy6wYWdxUStZ5G
         z6t1hR0EbS/nKeh92ZdeI1N9NgHWLY+LBhDxy61ag/v9BZfdyB/LPpg47JrZXi8eecx+
         uI3Q==
X-Gm-Message-State: APjAAAUWZssxaSj1cTCSeO340UmuDBvlHYeBfEFYqIISojEsNg9DjXdz
        CdXaJLC0dP48HYjlw71WnLy0CobrTpW5d4c8N48UPQ==
X-Google-Smtp-Source: APXvYqzwoJTTh6/AyzHZ9HDk0OjkJqyS/iSBZyH2/vPu+Dl7wuQU45eTBfY0lkl/AHWiFgvhaZ9+YLGWn+ZXBdZQ++A=
X-Received: by 2002:a37:342:: with SMTP id 63mr8915746qkd.144.1570698489815;
 Thu, 10 Oct 2019 02:08:09 -0700 (PDT)
MIME-Version: 1.0
References: <20191010075004.192818-1-tfiga@chromium.org>
In-Reply-To: <20191010075004.192818-1-tfiga@chromium.org>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Thu, 10 Oct 2019 17:07:58 +0800
Message-ID: <CANMq1KAA+nqcOqiE_g=vA8DC=_t=FqSRtR5kk=1XqSsgZGj+_A@mail.gmail.com>
Subject: Re: [PATCH] usb: mtk-xhci: Set the XHCI_NO_64BIT_SUPPORT quirk
To:     Tomasz Figa <tfiga@chromium.org>
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

On Thu, Oct 10, 2019 at 3:50 PM Tomasz Figa <tfiga@chromium.org> wrote:
>
> MediaTek XHCI host controller does not support 64-bit addressing despite
> the AC64 bit of HCCPARAMS1 register being set. The platform-specific
> glue sets the DMA mask to 32 bits on its own, but it has no effect,
> because xhci_gen_setup() overrides it according to hardware
> capabilities.
>
> Use the XHCI_NO_64BIT_SUPPORT quirk to tell the XHCI core to force
> 32-bit DMA mask instead.
>
> Signed-off-by: Tomasz Figa <tfiga@chromium.org>

Can we add a Fixes: tag for stable backports?
(after addressing the other comments of course)


> ---
>  drivers/usb/host/xhci-mtk.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
> index b18a6baef204a..4d101d52cc11b 100644
> --- a/drivers/usb/host/xhci-mtk.c
> +++ b/drivers/usb/host/xhci-mtk.c
> @@ -395,6 +395,11 @@ static void xhci_mtk_quirks(struct device *dev, struct xhci_hcd *xhci)
>         xhci->quirks |= XHCI_SPURIOUS_SUCCESS;
>         if (mtk->lpm_support)
>                 xhci->quirks |= XHCI_LPM_SUPPORT;
> +       /*
> +        * MTK host controller does not support 64-bit addressing, despite
> +        * having the AC64 bit of the HCCPARAMS1 register set.
> +        */
> +       xhci->quirks |= XHCI_NO_64BIT_SUPPORT;
>  }
>
>  /* called during probe() after chip reset completes */
> @@ -488,11 +493,6 @@ static int xhci_mtk_probe(struct platform_device *pdev)
>                 goto disable_clk;
>         }
>
> -       /* Initialize dma_mask and coherent_dma_mask to 32-bits */
> -       ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> -       if (ret)
> -               goto disable_clk;
> -
>         hcd = usb_create_hcd(driver, dev, dev_name(dev));
>         if (!hcd) {
>                 ret = -ENOMEM;
> --
> 2.23.0.581.g78d2f28ef7-goog
>
