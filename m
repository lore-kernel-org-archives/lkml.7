Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E86C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 271C320684
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 19:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ulhd5qz+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbfFLTM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 15:12:28 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37380 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbfFLTM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 15:12:28 -0400
Received: by mail-oi1-f194.google.com with SMTP id t76so12532099oih.4;
        Wed, 12 Jun 2019 12:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sfLPcL25crERXrHmndKdN43HIkrSYCz0GOmOHCLrbTE=;
        b=ulhd5qz+prqvRTlbEb33O83a8dJZJItyzAOFrAUu3qDrKHWht7BK1Pz0cTuQ3rlOot
         2oxjZoPmXhooSS9W7VtVDWGm1BFzamAwNbSSfjM/pXF04rZ4meJ8D10Dq6X9o86cXgho
         mc4iWqGCqZX/6AWPmo5M4+dnUBaHr685eYyUmxN/pQzfPI1qXJqqlG9EiE6ynSEJOmbb
         WKm73I+W83G1gtEckWP4i0LOeq/CZ8kegVEBEvQeCH0dtHAVCVYGcM4cYLzfZIyGI75b
         2yPqbQPEtDTGqt2i9ZMpliCmi4PWVK0DWXL+iuP9yfoUszCtj9oyO/1tqJctfeyjc1Il
         vkkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sfLPcL25crERXrHmndKdN43HIkrSYCz0GOmOHCLrbTE=;
        b=o/nd9SShCNgWootFhu7x80Eo99CpCWnyPdM47ezIoSjOvcMTWGO1lc8aI0yEvxFiqZ
         qwkPp8t8A6oSpETOuNvuGtD+iZC2o3xzhK7rYnDF5ZLkywA0p0EPzGw41eIkrjG/k7qf
         QYdAuZUibetQvoRenAXQKYN2RrejSS0fHEJvn3t2R3i8bjg6c2uRCTWdR7gquE4V5JGB
         DK2uafAJds4z7ZBE0JolKDG4SqMHYeOK4pIyzZVud4eemqwPXZ8UpHcFdn9jZ2lxy5If
         u7PLMTj4cTKDRF8jIKrAoN2rikfC7hpWg+beaG6ksSC75oRUELtZzNdwu5kcUd3TjiMb
         czGA==
X-Gm-Message-State: APjAAAUmDV2MvQTV2O+dmc3XbAR92QSEYQLQotSFmlCiMqMMpiT30Si6
        h/KiRhOdM69W9PG1Zah6cwgcWsD/BizCTOxvJLA=
X-Google-Smtp-Source: APXvYqy1dUlZ1GjSxaAhR2GBYxG+eBb73qatzfmqC3RzvvJ0mVsraiypMKNRkXEumiF39w8vn4DIrw2Km7vMogL4Qho=
X-Received: by 2002:aca:4ad2:: with SMTP id x201mr501939oia.129.1560366747250;
 Wed, 12 Jun 2019 12:12:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190611135842.8396-1-narmstrong@baylibre.com>
 <CAFBinCAkwjf9oDV6AGPi2PzzQ2KNTXXDHW6FTfN3kXpDT6cFpg@mail.gmail.com> <8950adde-0942-5f04-0ce6-922a9886c440@baylibre.com>
In-Reply-To: <8950adde-0942-5f04-0ce6-922a9886c440@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 12 Jun 2019 21:12:16 +0200
Message-ID: <CAFBinCBaBBv1buJ=U022GyHN+UJdfA+DC0t7wkSEt5aqvjdG-g@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc3: meson-g12a: Add support for IRQ based OTG switching
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     balbi@kernel.org, linux-amlogic@lists.infradead.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Wed, Jun 12, 2019 at 5:13 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
[...]
> >> @@ -436,6 +452,19 @@ static int dwc3_meson_g12a_probe(struct platform_device *pdev)
> >>         /* Get dr_mode */
> >>         priv->otg_mode = usb_get_dr_mode(dev);
> >>
> >> +       if (priv->otg_mode == USB_DR_MODE_OTG) {
> >> +               /* Ack irq before registering */
> >> +               regmap_update_bits(priv->regmap, USB_R5,
> >> +                                  USB_R5_ID_DIG_IRQ, 0);
> > I assume that either the IRQ line is:
> > - always enabled
> > - enabled when (USB_R5_ID_DIG_EN_0 | USB_R5_ID_DIG_EN_1 |
> > USB_R5_ID_DIG_TH_MASK) are set (which we already do in
> > dwc3_meson_g12a_usb_init)
>
> Can't say... I suspect the (USB_R5_ID_DIG_EN_0 | USB_R5_ID_DIG_EN_1 |
> > USB_R5_ID_DIG_TH_MASK) enables the detection.
> The regmap_update_bits(USB_R5_ID_DIG_IRQ) is only here to make sure the "current"
> irq event is masked, whatever the previous init.
>
> Or I misunderstood question ?
that perfectly answers my question - thank you!

> >
> >> +               irq = platform_get_irq(pdev, 0);
> > do we need to check the IRQ before trying to request it?
> > drivers/gpu/drm/meson/meson_dw_hdmi.c and drivers/usb/dwc3/host.c for
> > example error out if irq number is lower than 0
>
> No, devm_request_threaded_irq() will fail if -1 is given, I've using this scheme
> for a while now !
OK, it wasn't obvious to me when I looked at devm_request_threaded_irq.
thank you for clarifying this


Martin
