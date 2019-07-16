Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5210EC7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 17:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277AC2064B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 17:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="beLR9Kqx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388308AbfGPRdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 13:33:07 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40849 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbfGPRdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 13:33:06 -0400
Received: by mail-ed1-f65.google.com with SMTP id k8so21157338eds.7;
        Tue, 16 Jul 2019 10:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VusHyKqORprEv2W//SvnJpVjgoQ3gK1EQUfEfAz65B8=;
        b=beLR9KqxrUn2W2IAXTQVNVySNva+SG+DRTOOUHWbXQ6UUNaq91k8yBcEmlmQG6QEgF
         8lwvuyNeUbiWScXZRy43O9UK7fQjTQ/DTauibpfQDT9GM3ZlQGtTi1eWmWUtcALl8Vu9
         9NpfziUw1B6HxiSgRV94h52j+SlCikfk8LBiG4+H6L72p8aYrx2OUhtNVoAxVLJVgCgj
         YFNE+j1SwyBi1hCz8mrJ5v8zs/knuxdr9L6fbVfu8s+2ONagdqw9pP0VrKsrO2sFSa5V
         w1DTOyq5W4gUK/oZ8QyesOX8/XHufhwO2GVrHfVLQUVvmFlrV61UurzCqM+J5blvdh6G
         QE5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VusHyKqORprEv2W//SvnJpVjgoQ3gK1EQUfEfAz65B8=;
        b=ULhMWwcFzI+5EAbcvhaplV20luBs8WM7L0s58FbqsnsNe3v+BOXQfByfwEz1xPK/Nf
         t4dFoT4H4PBq8vPAgOAjbQyyQkmCpscDIVLWlBYN/l1ibCP9bc9aNFq+QRXN+5t8nSSC
         4UnlCUKTO5PB2+IZOH5GOFtdBhMGsrVY1wb76lYm4PoJ0WfkkTQrpNwOE2BCzoNLrtph
         28XxB2AG186y9tDFNIlTWLF1fXZ8yPxa8S/cnFY7YjIXhykI9vrZirTr0TZT3We6SpqD
         YgF1gK370qDcq6MjJ7y2M5H/wuSsN91tm11UJiVGOf6PCsJZ6whXGE4WDHZFabOi71Ej
         hpKg==
X-Gm-Message-State: APjAAAVM6hMU7SXQkg4r4W6riBM1wawkpVZAS3lJalpjX1TvcuJHYdzE
        tjPO1UQ+DmCR1vh5gw489MtoGyLfg/TP2qYSaAg=
X-Google-Smtp-Source: APXvYqznJXXfoPYn9fLxTqvrrV+JpPmw+sOCBa0zE+htMxOwE1xbHQ925eoXBGNcEhJ85Ulss+Sst8IPlgPWaUQ91CA=
X-Received: by 2002:a50:ec0e:: with SMTP id g14mr30109771edr.210.1563298384806;
 Tue, 16 Jul 2019 10:33:04 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190627071745eucas1p1c171dcafd92fe51c99dc102949de6c99@eucas1p1.samsung.com>
 <20190627071726.30467-1-m.szyprowski@samsung.com> <20190627071726.30467-4-m.szyprowski@samsung.com>
In-Reply-To: <20190627071726.30467-4-m.szyprowski@samsung.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Tue, 16 Jul 2019 23:02:54 +0530
Message-ID: <CANAwSgT+D_WNFuNdXhxRsQg16Hprn+Gb6TaQGvQM0a3bCerO=A@mail.gmail.com>
Subject: Re: [PATCH 3/3] usb: dwc3: Remove generic PHY calibrate() calls
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

On Thu, 27 Jun 2019 at 12:47, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> Calls to USB2 generic PHY calibrate() method were added by commit
> d8c80bb3b55b ("phy: exynos5-usbdrd: Calibrate LOS levels for
> exynos5420/5800"), but it turned out that the mentioned patch worked only
> by the pure luck and fixed only one use case. To fix the issues with PHY
> calibration it has been moved to XHCI HCD driver, what allows to perform
> calibration in the proper time window. This patch removes those calls
> from DWC3 driver, as they are no longer needed there.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Please add my tested on XU4 / XU3 using linux next-20190716
Tested-by: Anand Moon <linux.amoon@gmail.com>

Best Regards
-Anand

> ---
>  drivers/usb/dwc3/core.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index baa029ceede9..f62e8442c614 100644
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
