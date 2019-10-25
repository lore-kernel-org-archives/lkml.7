Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC545CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 22:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7563521872
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 22:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NMVL0nKx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfJYWuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 18:50:35 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:40776 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbfJYWue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 18:50:34 -0400
Received: by mail-il1-f196.google.com with SMTP id d83so3189655ilk.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 15:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tKLlAY4Xw7xSeIaP4a35tzIajquRX72GBLi2rGXctCA=;
        b=NMVL0nKxTd83P4SmTdQ4y6M3dnl6xh2afGk90De61SMHV1pSozOqiNjC43vJR7j3Bp
         UoXkubWBdfT9AhAfBJcTwA2vdWaZqH2mHy9WbJahWI9acAnfjWQU3JTQQoD+Ib7VYXkl
         rWqfJx9yBDt8jEwMGmsJ9PSt962tlyDtUiXH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tKLlAY4Xw7xSeIaP4a35tzIajquRX72GBLi2rGXctCA=;
        b=r0dX0hVtg7HXbuTDMDnIIBtvQSk77TL8T465uRRVhhoE+PGvL8fPSPYYFS73hzNiob
         7z28LV9DAzHqA55tHCzSCv59xV1jULBf6J+A9oy121WoZRrfDRCLD6FlwqcY3jvpgskH
         CHTOBJXEyiR5zlAk1JPUhq/qb+jK2SgvQxehxFEYpaN8qeJBCymKozhZniy48QSo8T8Q
         oRf/0B/g3OksLJXZ0tdBBaSotk3RDHCZP17bH2UHdiHM+qo6x8fLQEQ1TrZJrhHhp8Qn
         ziwRl6OZ5I/n8QQmni77wD7yOi8dXwoJILJ2d41bMmEu30wVY3vKyIUCz/hc/7BYWAWn
         hGRA==
X-Gm-Message-State: APjAAAWX8iDK3Mjw9X7tpyLjoQphXz10AmDXEMKHjdRPNrIXKZ5thY7W
        W8YcKvIe7LkpfxqYw7rhCxEkBGdKysY=
X-Google-Smtp-Source: APXvYqyj8/5g5i9+4iTEAJxrPvf/DfQstPsPnd83wO4KgvCzhOvE+ztTWdOLOKQrZkkGF3n3crCYgA==
X-Received: by 2002:a92:3559:: with SMTP id c86mr7185081ila.201.1572043833312;
        Fri, 25 Oct 2019 15:50:33 -0700 (PDT)
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com. [209.85.166.179])
        by smtp.gmail.com with ESMTPSA id n2sm423902ion.25.2019.10.25.15.50.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2019 15:50:30 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id y5so3193108ilb.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 15:50:29 -0700 (PDT)
X-Received: by 2002:a05:6e02:792:: with SMTP id q18mr6756233ils.58.1572043829241;
 Fri, 25 Oct 2019 15:50:29 -0700 (PDT)
MIME-Version: 1.0
References: <20191025215428.31607-1-abhishekpandit@chromium.org> <20191025215428.31607-4-abhishekpandit@chromium.org>
In-Reply-To: <20191025215428.31607-4-abhishekpandit@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 25 Oct 2019 15:50:17 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vf64F885me=PUpv34Lb6iZpm1ui30nLHww6T3rmRVJXA@mail.gmail.com>
Message-ID: <CAD=FV=Vf64F885me=PUpv34Lb6iZpm1ui30nLHww6T3rmRVJXA@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: dts: rockchip: Add brcm bluetooth module on uart0
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Oct 25, 2019 at 2:55 PM Abhishek Pandit-Subedi
<abhishekpandit@chromium.org> wrote:
>
> This enables the Broadcom uart bluetooth driver on uart0 and gives it
> ownership of its gpios. In order to use this, you must enable the
> following kconfig options:
>   - CONFIG_BT_HCIUART_BCM
>   - CONFIG_SERIAL_DEV
>
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
>
>  arch/arm/boot/dts/rk3288-veyron.dtsi | 31 +++++++---------------------
>  1 file changed, 7 insertions(+), 24 deletions(-)
>
> diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
> index 7525e3dd1fc1..8c9f91ba6f57 100644
> --- a/arch/arm/boot/dts/rk3288-veyron.dtsi
> +++ b/arch/arm/boot/dts/rk3288-veyron.dtsi

You are changing this for _all_ veryon, not just those veyron devices
using Broadcom.  I don't think you want to change the marvell-based
boards.

...presumably you'll want to make you change only affect minnie,
speedy, and mickey.


> @@ -23,30 +23,6 @@
>                 reg = <0x0 0x0 0x0 0x80000000>;
>         };
>
> -       bt_activity: bt-activity {
> -               compatible = "gpio-keys";
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&bt_host_wake>;
> -
> -               /*
> -                * HACK: until we have an LPM driver, we'll use an
> -                * ugly GPIO key to allow Bluetooth to wake from S3.
> -                * This is expected to only be used by BT modules that
> -                * use UART for comms.  For BT modules that talk over
> -                * SDIO we should use a wakeup mechanism related to SDIO.
> -                *
> -                * Use KEY_RESERVED here since that will work as a wakeup but
> -                * doesn't get reported to higher levels (so doesn't confuse
> -                * Chrome).
> -                */
> -               bt-wake {
> -                       label = "BT Wakeup";
> -                       gpios = <&gpio4 RK_PD7 GPIO_ACTIVE_HIGH>;
> -                       linux,code = <KEY_RESERVED>;
> -                       wakeup-source;
> -               };
> -
> -       };
>
>         power_button: power-button {
>                 compatible = "gpio-keys";
> @@ -434,6 +410,13 @@
>         /* Pins don't include flow control by default; add that in */
>         pinctrl-names = "default";
>         pinctrl-0 = <&uart0_xfer &uart0_cts &uart0_rts>;
> +
> +       bluetooth {
> +               compatible = "brcm,bcm43540-bt";

You probably need some pinctrl entries here to make sure that things
are properly configured, like:

pinctrl-names = "default";
pinctrl-0 = <&bt_host_wake>, <&bt_dev_wake>, <&bt_enable>;

This would require defining bt_dev_wake and bt_enable and removing the
hacky output-only versions they have now.


> +               host-wakeup-gpios       = <&gpio4 RK_PD7 GPIO_ACTIVE_HIGH>;
> +               shutdown-gpios          = <&gpio4 RK_PD5 GPIO_ACTIVE_LOW>;

Right now gpio4 RK_PD5 is controlled by the "sdio_pwrseq".  Should you
remove it from there?  Looks like it was a no-op for marvell which
makes it a little easier.


> +               device-wakeup-gpios     = <&gpio4 RK_PD2 GPIO_ACTIVE_HIGH>;

You probably need to stop driving this in the pinctrl hogs for
Broadcom boards...


-Doug
