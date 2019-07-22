Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C69AC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 099B820693
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Thqb/v9o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbfGVTAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 15:00:49 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35002 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbfGVTAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 15:00:49 -0400
Received: by mail-io1-f67.google.com with SMTP id m24so76367816ioo.2;
        Mon, 22 Jul 2019 12:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RBH9NIjlTcz6w4LQP6KUauPzdnEDTuEqG8uCadh2V7Y=;
        b=Thqb/v9opT4RgtSlBn8G7N0zOcK1ag8GBp6HPcrEvHcGc825fInQRAIbtEyY6TOyQX
         OjwvkJJH3hMBlWe2Q4luG2wAvSZSeAC868gukwHrydSCqGXgN8XnBcW/Na1NulFslp6U
         C7VPDptL8vEv95huLfZmv0Kq73HXmz2C/3ixLVx+tQHXrOI9YLTbUHjd+ZO+jn7Uo50T
         yA885eWYoCUP/J7IuSeiWKLF3O1zVPVTjqHqUWMR0YlnDe70o/JQDkjZlBg3hjWva58J
         3+AC2lMMZkERGNFgv9t90jr9E9Xor1A9g378FxeRbRlZTqWLNvGoXDRLlrvlHR2WhRwG
         f0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RBH9NIjlTcz6w4LQP6KUauPzdnEDTuEqG8uCadh2V7Y=;
        b=hQ8Xfeot23yyGTGw0Es1htsru7QSnAg00GGIkhlm9Byoe0BGPYgHo5OzTKcmMwW/lr
         29m6QEIvwNdlI0ziv+LtZ+4oKE8uYcDTJ4a77JKjPWHczfBtBCQh4UZd/qNSgnpf2wXR
         LtXOxvrsepbYDP2VDbWd7VbebvaJUaSyZYa3fTZ8pNji4qJ8dUoc0r4wmq6L0ciA1Wu3
         rfMa7jFtFP56T5Fc3Ca+Gzfg5u/YH/J35x97RzBoEIQ2+ZWj3sRjTmAnm04RT40waAOe
         3gPTUy1VGBGWZVGEQ7DVrMIq5MZEqaRbZG6UEd6SeNgvdCCkHZOcp0LcbeHR61791HS8
         46Kg==
X-Gm-Message-State: APjAAAXWm1VIYRjxi2ixl/u/kgm/4CGoQnLPX4+P7paqDfKoLew56zC8
        pKIx4llIiRfCXYcpEYzZRWe1unwEI65XM1/t5IA=
X-Google-Smtp-Source: APXvYqx0OklHPUoU4sLmJG1e2HuxNjh0YNPtvpHXVRBFrFvEF0pCtsqnsKShS1f8DVX91bEIxTnI/dP1zeP1s2AQF0w=
X-Received: by 2002:a6b:b3c1:: with SMTP id c184mr20876106iof.222.1563822047914;
 Mon, 22 Jul 2019 12:00:47 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190719081322eucas1p1f3114c43ca3c53b60766edf1846347cc@eucas1p1.samsung.com>
 <20190719081212.9249-1-m.szyprowski@samsung.com> <20190719081316.9298-1-m.szyprowski@samsung.com>
In-Reply-To: <20190719081316.9298-1-m.szyprowski@samsung.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Tue, 23 Jul 2019 00:30:37 +0530
Message-ID: <CANAwSgR3kdZsDn-x9FwynAPtVEf4ci0BfiGPr1NzJ-a1n5B_Ng@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] usb: core: phy: add support for PHY calibration
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
> Some PHYs (for example Exynos5 USB3.0 DRD PHY) require calibration to be
> done after every USB HCD reset. Generic PHY framework has been already
> extended with phy_calibrate() function in commit 36914111e682 ("drivers:
> phy: add calibrate method"). This patch adds support for it to generic
> PHY handling code in USB HCD core.
>

Tested on my XU3 / XU4 / HC1
Tested-by: Anand Moon <linux.amoon@gmail.com>


> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/usb/core/hcd.c |  7 +++++++
>  drivers/usb/core/phy.c | 21 +++++++++++++++++++++
>  drivers/usb/core/phy.h |  1 +
>  3 files changed, 29 insertions(+)
>
> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index 88533938ce19..b89936c1df23 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -2291,6 +2291,9 @@ int hcd_bus_resume(struct usb_device *rhdev, pm_message_t msg)
>         hcd->state = HC_STATE_RESUMING;
>         status = hcd->driver->bus_resume(hcd);
>         clear_bit(HCD_FLAG_WAKEUP_PENDING, &hcd->flags);
> +       if (status == 0)
> +               status = usb_phy_roothub_calibrate(hcd->phy_roothub);
> +
>         if (status == 0) {
>                 struct usb_device *udev;
>                 int port1;
> @@ -2864,6 +2867,10 @@ int usb_add_hcd(struct usb_hcd *hcd,
>         }
>         hcd->rh_pollable = 1;
>
> +       retval = usb_phy_roothub_calibrate(hcd->phy_roothub);
> +       if (retval)
> +               goto err_hcd_driver_setup;
> +
>         /* NOTE: root hub and controller capabilities may not be the same */
>         if (device_can_wakeup(hcd->self.controller)
>                         && device_can_wakeup(&hcd->self.root_hub->dev))
> diff --git a/drivers/usb/core/phy.c b/drivers/usb/core/phy.c
> index 7580493b867a..fb1588e7c282 100644
> --- a/drivers/usb/core/phy.c
> +++ b/drivers/usb/core/phy.c
> @@ -151,6 +151,27 @@ int usb_phy_roothub_set_mode(struct usb_phy_roothub *phy_roothub,
>  }
>  EXPORT_SYMBOL_GPL(usb_phy_roothub_set_mode);
>
> +int usb_phy_roothub_calibrate(struct usb_phy_roothub *phy_roothub)
> +{
> +       struct usb_phy_roothub *roothub_entry;
> +       struct list_head *head;
> +       int err;
> +
> +       if (!phy_roothub)
> +               return 0;
> +
> +       head = &phy_roothub->list;
> +
> +       list_for_each_entry(roothub_entry, head, list) {
> +               err = phy_calibrate(roothub_entry->phy);
> +               if (err)
> +                       return err;
> +       }
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(usb_phy_roothub_calibrate);
> +
>  int usb_phy_roothub_power_on(struct usb_phy_roothub *phy_roothub)
>  {
>         struct usb_phy_roothub *roothub_entry;
> diff --git a/drivers/usb/core/phy.h b/drivers/usb/core/phy.h
> index dad564e2d2d4..20a267cd986b 100644
> --- a/drivers/usb/core/phy.h
> +++ b/drivers/usb/core/phy.h
> @@ -18,6 +18,7 @@ int usb_phy_roothub_exit(struct usb_phy_roothub *phy_roothub);
>
>  int usb_phy_roothub_set_mode(struct usb_phy_roothub *phy_roothub,
>                              enum phy_mode mode);
> +int usb_phy_roothub_calibrate(struct usb_phy_roothub *phy_roothub);
>  int usb_phy_roothub_power_on(struct usb_phy_roothub *phy_roothub);
>  void usb_phy_roothub_power_off(struct usb_phy_roothub *phy_roothub);
>
> --
> 2.17.1
>
