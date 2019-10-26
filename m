Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA01CA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 17:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94F172070B
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 17:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lmhZG5Wm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbfJZRja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 13:39:30 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44908 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfJZRja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 13:39:30 -0400
Received: by mail-qk1-f193.google.com with SMTP id g21so4749930qkm.11
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2019 10:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WJj+XYLe3cMZIZoQ9vr6L71XNxTz/FYk/4q0duDThfY=;
        b=lmhZG5WmjZSGyG/n8DvvWPUtaIUQTSAcqfXm1lhQkFBllCnZ0iPY0qO+FfncxWVG1O
         iGaup108mV3brmcMFcKNNZG1pEu5uY5d31Q7MY//EU1hh+eyZ1YJmsNnwtuZu+TxM3uk
         uhzDUa/57Q+1Od0c9tEFXNNNfwOEFVHqPLRBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WJj+XYLe3cMZIZoQ9vr6L71XNxTz/FYk/4q0duDThfY=;
        b=K+PmKGhFJtXdPjCUbZ5bwc+idVmffIKbk1+Btxb/a9EdY6lImPkwyOvhfcjzaiIjMk
         28qvmRwmbve5GuTvpSzxb6Bq1LfbZ/jWKm/sJ1Dv+orsN/Ej/2ari9+8CxBGVpaZ09Sg
         WedQRyOSdXbGV7x0DUuX6CQkWy+r/8ALzVOHVjK7d+/Y318EYZYCjEJLtT4qBPiVJOz8
         oOK2Kl77lJWjlXOHN5CpM8JxixZrA5aU9nLxNp/59YXR5ciPDww1FMcvtxf95XZZEoKJ
         KSgHAaPFFD0dkVo2XAnATwbdi8Ff+WwOY10noBH02qNlzN/v8QxPpb/X1DrtXZMZ/ypo
         u2uw==
X-Gm-Message-State: APjAAAVf9KG29C5tyfUqwp+Q/tdyt4drIzBnRRz6e/eRV+RykJbcqN96
        7FIB3lmye0pV6XPVlKLNqyAw+JpsHUxClSEYWeqgGg==
X-Google-Smtp-Source: APXvYqxNNWzFrSsnCjh1NbFwr4AgLKBoBn+uLrUEM4+ByNDY81vMaaOzmML5AYyWCxiqf2lVQlNLxbhZNQL2Jn753dk=
X-Received: by 2002:a37:4dd1:: with SMTP id a200mr8422942qkb.419.1572111568786;
 Sat, 26 Oct 2019 10:39:28 -0700 (PDT)
MIME-Version: 1.0
References: <20191025215428.31607-1-abhishekpandit@chromium.org>
 <20191025215428.31607-4-abhishekpandit@chromium.org> <CAD=FV=Vf64F885me=PUpv34Lb6iZpm1ui30nLHww6T3rmRVJXA@mail.gmail.com>
In-Reply-To: <CAD=FV=Vf64F885me=PUpv34Lb6iZpm1ui30nLHww6T3rmRVJXA@mail.gmail.com>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Sat, 26 Oct 2019 10:39:18 -0700
Message-ID: <CANFp7mX7LNxt5=6h-eMC+o1JtoJ1Mvwo2RLBYMhZ3fN5kyqGqQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: dts: rockchip: Add brcm bluetooth module on uart0
To:     Doug Anderson <dianders@chromium.org>
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

Yes, these shouldn't be for all of Veyron, only Minnie, Mickey and
Speedy -- my mistake. I'll send an updated patch with your
suggestions.

Thanks
Abhishek

On Fri, Oct 25, 2019 at 3:50 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Fri, Oct 25, 2019 at 2:55 PM Abhishek Pandit-Subedi
> <abhishekpandit@chromium.org> wrote:
> >
> > This enables the Broadcom uart bluetooth driver on uart0 and gives it
> > ownership of its gpios. In order to use this, you must enable the
> > following kconfig options:
> >   - CONFIG_BT_HCIUART_BCM
> >   - CONFIG_SERIAL_DEV
> >
> > Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > ---
> >
> >  arch/arm/boot/dts/rk3288-veyron.dtsi | 31 +++++++---------------------
> >  1 file changed, 7 insertions(+), 24 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
> > index 7525e3dd1fc1..8c9f91ba6f57 100644
> > --- a/arch/arm/boot/dts/rk3288-veyron.dtsi
> > +++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
>
> You are changing this for _all_ veryon, not just those veyron devices
> using Broadcom.  I don't think you want to change the marvell-based
> boards.
>
> ...presumably you'll want to make you change only affect minnie,
> speedy, and mickey.
>
>
> > @@ -23,30 +23,6 @@
> >                 reg = <0x0 0x0 0x0 0x80000000>;
> >         };
> >
> > -       bt_activity: bt-activity {
> > -               compatible = "gpio-keys";
> > -               pinctrl-names = "default";
> > -               pinctrl-0 = <&bt_host_wake>;
> > -
> > -               /*
> > -                * HACK: until we have an LPM driver, we'll use an
> > -                * ugly GPIO key to allow Bluetooth to wake from S3.
> > -                * This is expected to only be used by BT modules that
> > -                * use UART for comms.  For BT modules that talk over
> > -                * SDIO we should use a wakeup mechanism related to SDIO.
> > -                *
> > -                * Use KEY_RESERVED here since that will work as a wakeup but
> > -                * doesn't get reported to higher levels (so doesn't confuse
> > -                * Chrome).
> > -                */
> > -               bt-wake {
> > -                       label = "BT Wakeup";
> > -                       gpios = <&gpio4 RK_PD7 GPIO_ACTIVE_HIGH>;
> > -                       linux,code = <KEY_RESERVED>;
> > -                       wakeup-source;
> > -               };
> > -
> > -       };
> >
> >         power_button: power-button {
> >                 compatible = "gpio-keys";
> > @@ -434,6 +410,13 @@
> >         /* Pins don't include flow control by default; add that in */
> >         pinctrl-names = "default";
> >         pinctrl-0 = <&uart0_xfer &uart0_cts &uart0_rts>;
> > +
> > +       bluetooth {
> > +               compatible = "brcm,bcm43540-bt";
>
> You probably need some pinctrl entries here to make sure that things
> are properly configured, like:
>
> pinctrl-names = "default";
> pinctrl-0 = <&bt_host_wake>, <&bt_dev_wake>, <&bt_enable>;
>
> This would require defining bt_dev_wake and bt_enable and removing the
> hacky output-only versions they have now.
>
>
> > +               host-wakeup-gpios       = <&gpio4 RK_PD7 GPIO_ACTIVE_HIGH>;
> > +               shutdown-gpios          = <&gpio4 RK_PD5 GPIO_ACTIVE_LOW>;
>
> Right now gpio4 RK_PD5 is controlled by the "sdio_pwrseq".  Should you
> remove it from there?  Looks like it was a no-op for marvell which
> makes it a little easier.
>
>
> > +               device-wakeup-gpios     = <&gpio4 RK_PD2 GPIO_ACTIVE_HIGH>;
>
> You probably need to stop driving this in the pinctrl hogs for
> Broadcom boards...
>
>
> -Doug
