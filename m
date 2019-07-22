Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10C8C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B2E620693
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sHedMF5g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbfGVTBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 15:01:00 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42777 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbfGVTBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 15:01:00 -0400
Received: by mail-io1-f66.google.com with SMTP id e20so45966647iob.9;
        Mon, 22 Jul 2019 12:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5TNbEmM0bmFmn/PtMVpfbgadZYUgBrg9u8KfcKSfMvY=;
        b=sHedMF5g4mjzyJo2ODW/m2hldyGrftgzbXVENQmUvXt3UsDI4ko/s0ewJ62m5v56j0
         Rq7uuQZCu+oBdRrMzOUcgpV6n8uVTtSsP7eJWbtsUbC/VGyobvOI/imXhBTqpe9MXyWs
         vUnuEtULRBhWysA1b1k86KbLu9Son1LI37Sa12oTK5cdwi/gCJE+HavMytBLnb1n9Vv0
         uXOnXTiKLudooXS7n+k8zXvB9qg+EVbolF5/KgjLzxOtxrAsGXl005OqyB+M4HncofD9
         aEufMQ6TIOD3Iuz9tv/KseuygVfX32JUyiN7sLk1nrY0N+84PwWX/bPWsSXlKdBzduP/
         RBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5TNbEmM0bmFmn/PtMVpfbgadZYUgBrg9u8KfcKSfMvY=;
        b=JUyMYlNsxDEuLB4MdbqcyvEo9QxnnVN/YoQR1VDwVfxqHbNyGmdST1BJCcT6npf3CX
         fF3Vmr4a530nQR3jkQjuhaDGJ6sDAo5DzT59tfmnT/O5vdQ70QZ7KQytdyl1y0UJemPY
         2BBQdIYPvp7lTbvoHD+dUYOeQnPvx3O8To3E5GVcINYlmabHUJI51tBnJsHnqCZ6dbyb
         McZdUIjsL4p8ExFfl/kn6KbmJMsHywEBbzaAPRLyVfwxdYfwPMYj66/8xi08LnWigbmr
         Zyd/lyXSN/d6sY5q50fKlvpPkdh45/Uwe16c0L8eZ3KIq1P9DI25NzcCfLgow+KGNXJY
         ZDqQ==
X-Gm-Message-State: APjAAAXi6+jZZaC/YBPdIoXfsbd12SggXg6hE10pqQCk7aojonYeXWcx
        gTqJbV8QvGQDoYtOi2RmQOVn5pWlLwKcAj2Jn5k=
X-Google-Smtp-Source: APXvYqx/3kXuMN65MQnHQqozcmp/e0udPLZRabriswa5tWQW7Wk5lmTyneHexQF0KSoP3fMec5C3g6Ql6YHxDCf3vbM=
X-Received: by 2002:a02:7f15:: with SMTP id r21mr76973749jac.120.1563822059347;
 Mon, 22 Jul 2019 12:00:59 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190719081334eucas1p1fd614e56c1ec0dfa654d0bb77f17ba5d@eucas1p1.samsung.com>
 <20190719081212.9249-1-m.szyprowski@samsung.com> <20190719081326.9347-1-m.szyprowski@samsung.com>
In-Reply-To: <20190719081326.9347-1-m.szyprowski@samsung.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Tue, 23 Jul 2019 00:30:48 +0530
Message-ID: <CANAwSgQSQLVy=E3uzDq_sdmBR7Rcg=S1Tfr24o3DozHSP2wKiw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] usb: dwc3: remove generic PHY calibrate() calls
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Linux USB Mailing List <linux-usb@vger.kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jochen Sprickerhof <jochen@sprickerhof.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

On Fri, 19 Jul 2019 at 13:43, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> Calls to USB2 generic PHY calibrate() method has been moved to HCD core,
> which now successfully handles generic PHYs and their calibration after
> every HCD reset. This fixes all the timing issues related to PHY
> calibration done directly from DWC3 driver: incorrect operation after
> system suspend/resume or USB3.0 detection failure when XHCI-plat driver
> compiled as separate module.
>

Tested on my XU3 / XU4 / HC1
Tested-by: Anand Moon <linux.amoon@gmail.com>


> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/usb/dwc3/core.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index c9bb93a2c81e..7dd6d419254d 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -168,7 +168,6 @@ static void __dwc3_set_mode(struct work_struct *work)
>                                 otg_set_vbus(dwc->usb2_phy->otg, true);
>                         phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
>                         phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
> -                       phy_calibrate(dwc->usb2_generic_phy);
>                 }
>                 break;
>         case DWC3_GCTL_PRTCAP_DEVICE:
> @@ -1166,7 +1165,6 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
>                                 dev_err(dev, "failed to initialize host\n");
>                         return ret;
>                 }
> -               phy_calibrate(dwc->usb2_generic_phy);
>                 break;
>         case USB_DR_MODE_OTG:
>                 INIT_WORK(&dwc->drd_work, __dwc3_set_mode);
> --
> 2.17.1
>
